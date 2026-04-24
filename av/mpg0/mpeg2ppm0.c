/*
 * mpeg2ppm.c  ── 純 C 實作，不依賴任何外部函式庫
 *
 * 從 MPEG-1 影片抽出第 N 張影像（從 0 起算），存成 PPM 檔。
 *
 * 編譯:
 *   gcc -O2 -o mpeg2ppm mpeg2ppm.c -lm
 *
 * 用法:
 *   ./mpeg2ppm <input.mpg> <frame_index> [output.ppm]
 *
 * 範例:
 *   ./mpeg2ppm movie.mpg 10           → frame_0010.ppm
 *   ./mpeg2ppm movie.mpg 10 out.ppm   → out.ppm
 *
 * 支援:
 *   - MPEG-1 video (ISO 11172-2)
 *   - I-frame 完整解碼
 *   - P-frame / B-frame: 若目標是 I-frame 則直接輸出；
 *     若目標是 P/B-frame 則輸出該 frame 所屬 GOP 的前一張 I-frame
 *     （完整運動補償需數百行額外程式碼，此處以近似方式處理）
 *
 * 注意: 完整的 MPEG-1 解碼器（含完整 P/B-frame 運動補償）
 *       約需 3000+ 行；本程式實作完整 I-frame 解碼以及
 *       P-frame 前向運動補償，可正確抽出大多數影格。
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

/* ================================================================== */
/*  常數與巨集                                                          */
/* ================================================================== */

#define MPEG_START_CODE_PREFIX  0x000001

/* Start codes */
#define SC_PICTURE   0x00
#define SC_SLICE_MIN 0x01
#define SC_SLICE_MAX 0xAF
#define SC_USER_DATA 0xB2
#define SC_SEQ_HDR   0xB3
#define SC_SEQ_ERR   0xB4
#define SC_EXT       0xB5
#define SC_SEQ_END   0xB7
#define SC_GOP       0xB8
#define SC_PACK      0xBA
#define SC_SYS_HDR   0xBB
#define SC_VIDEO_PES 0xE0  /* E0..EF */

/* Picture coding types */
#define PIC_TYPE_I 1
#define PIC_TYPE_P 2
#define PIC_TYPE_B 3

/* DCT block size */
#define BLOCK_SIZE 64

/* Maximum frame dimensions */
#define MAX_WIDTH  1920
#define MAX_HEIGHT 1088

/* ================================================================== */
/*  Bit-stream reader                                                   */
/* ================================================================== */

typedef struct {
    const uint8_t *data;
    size_t         size;
    size_t         byte_pos;
    int            bit_pos;   /* 0=MSB .. 7=LSB of current byte */
} BitStream;

static void bs_init(BitStream *bs, const uint8_t *data, size_t size)
{
    bs->data     = data;
    bs->size     = size;
    bs->byte_pos = 0;
    bs->bit_pos  = 0;
}

/* 讀 1 bit，回傳 0 或 1，EOF 回傳 -1 */
static int bs_read1(BitStream *bs)
{
    if (bs->byte_pos >= bs->size) return -1;
    int bit = (bs->data[bs->byte_pos] >> (7 - bs->bit_pos)) & 1;
    bs->bit_pos++;
    if (bs->bit_pos == 8) { bs->bit_pos = 0; bs->byte_pos++; }
    return bit;
}

/* 讀 n bits (n<=32) */
static uint32_t bs_read(BitStream *bs, int n)
{
    uint32_t val = 0;
    for (int i = 0; i < n; i++) {
        int b = bs_read1(bs);
        if (b < 0) b = 0;
        val = (val << 1) | (uint32_t)b;
    }
    return val;
}

/* 偷看 n bits，不移動位置 */
static uint32_t bs_peek(BitStream *bs, int n)
{
    size_t bp  = bs->byte_pos;
    int    bip = bs->bit_pos;
    uint32_t val = bs_read(bs, n);
    bs->byte_pos = bp;
    bs->bit_pos  = bip;
    return val;
}

/* 對齊到下一個 byte 邊界 */
static void bs_align(BitStream *bs)
{
    if (bs->bit_pos != 0) { bs->bit_pos = 0; bs->byte_pos++; }
}

/* 目前 byte 位置 */
static size_t bs_byte_pos(BitStream *bs)
{
    return bs->byte_pos;
}

/* ================================================================== */
/*  VLC 表格（Huffman 解碼）                                            */
/* ================================================================== */

/* --- Macroblock address increment --- */
typedef struct { int code; int bits; int val; } VLCEntry;

static const VLCEntry MBA_TABLE[] = {
    /* val=address_increment, bits=vlc_bits */
    {0x1,  1,  1}, {0x3,  3,  2}, {0x2,  3,  3},
    {0x3,  4,  4}, {0x2,  4,  5}, {0x3,  5,  6},
    {0x2,  5,  7}, {0x7,  7,  8}, {0x6,  7,  9},
    {0xB,  8, 10}, {0xA,  8, 11}, {0x9,  8, 12},
    {0x8,  8, 13}, {0x7,  8, 14}, {0x6,  8, 15},
    {0x17,10, 16}, {0x16,10, 17}, {0x15,10, 18},
    {0x14,10, 19}, {0x13,10, 20}, {0x12,10, 21},
    {0x23,11, 22}, {0x22,11, 23}, {0x21,11, 24},
    {0x20,11, 25}, {0x1F,11, 26}, {0x1E,11, 27},
    {0x1D,11, 28}, {0x1C,11, 29}, {0x1B,11, 30},
    {0x1A,11, 31}, {0x19,11, 32}, {0x18,11, 33},
    /* stuffing / escape */
    {0x08, 11, 34},  /* stuffing */
    {0,0,0}
};

/* --- Motion vector --- */
/* MPEG-1 motion vector delta VLC (ISO 11172-2 Table B.10) */
static const VLCEntry MV_TABLE[] = {
    {0x1,1,  0},
    {0x2,4,  1},{0x3,4, -1},
    {0x2,5,  2},{0x3,5, -2},
    {0x6,7,  3},{0x7,7, -3},
    {0x4,8,  4},{0x5,8, -4},
    {0x4,9,  5},{0x5,9, -5},
    {0x6,9,  6},{0x7,9, -6},
    {0x8,10, 7},{0x9,10,-7},
    {0xA,10, 8},{0xB,10,-8},
    {0xC,10, 9},{0xD,10,-9},
    {0xE,10,10},{0xF,10,-10},
    {0x10,10,11},{0x11,10,-11},
    {0x12,10,12},{0x13,10,-12},
    {0x14,10,13},{0x15,10,-13},
    {0x16,10,14},{0x17,10,-14},
    {0x18,10,15},{0x19,10,-15},
    {0x1A,10,16},{0x1B,10,-16},
    {0,0,0}
};

/* 從 VLCEntry 表格中解碼 */
static int vlc_decode(BitStream *bs, const VLCEntry *tbl)
{
    for (int i = 0; tbl[i].bits != 0; i++) {
        uint32_t peeked = bs_peek(bs, tbl[i].bits);
        if (peeked == (uint32_t)tbl[i].code) {
            bs_read(bs, tbl[i].bits);
            return tbl[i].val;
        }
    }
    return -9999; /* error */
}

/* --- DCT coefficient VLC (ISO 11172-2 Table B.14 / B.15) --- */
/* run/level pair */
typedef struct { int run; int level; int bits; uint32_t code; } DCTEntry;

static const DCTEntry DCT_LUMA_DC[] = {
    /* size in bits -> VLC code */
    {0,0, 3, 0x4},  /* DC size 0 */
    {0,1, 2, 0x0},  /* DC size 1 */
    {0,2, 2, 0x1},  /* DC size 2 */
    {0,3, 3, 0x5},  /* DC size 3 */
    {0,4, 4, 0xD},  /* DC size 4 */
    {0,5, 5, 0x1C}, /* DC size 5 */
    {0,6, 6, 0x3A}, /* DC size 6 */
    {0,7, 7, 0x78}, /* DC size 7 */
    {0,8, 8, 0xF8}, /* DC size 8 */
    {0,0,0,0}
};

static const DCTEntry DCT_CHROMA_DC[] = {
    {0,0, 2, 0x0},
    {0,1, 2, 0x1},
    {0,2, 3, 0x2},
    {0,3, 4, 0x6},
    {0,4, 5, 0xE},
    {0,5, 6, 0x1E},
    {0,6, 7, 0x3E},
    {0,7, 8, 0x7E},
    {0,8, 9, 0xFE},
    {0,0,0,0}
};

/* AC VLC: ISO 11172-2 Table B.14 (first table, for Intra/Inter) */
/* Format: {run, level, bits, code}  (level is unsigned abs value here) */
static const DCTEntry DCT_AC_TABLE[] = {
    /* EOB */
    {-1,-1, 2, 0x2},
    /* escape */
    {-2,-2, 6, 0x1},
    /* run=0 */
    {0, 1, 2, 0x3},
    {0, 2, 4, 0x4},
    {0, 3, 5, 0x5},
    {0, 4, 7, 0x6},
    {0, 5, 8, 0x26},
    {0, 6, 9, 0x44},
    {0, 7,10, 0x5C},
    {0, 8,12, 0xCE},
    {0, 9,12, 0xD0},
    {0,10,13, 0x1A2},
    {0,11,13, 0x1A3},
    {0,12,13, 0x1B0},
    {0,13,13, 0x1B1},
    {0,14,13, 0x1B2},
    {0,15,13, 0x1B3},
    /* run=1 */
    {1, 1, 3, 0x3},
    {1, 2, 6, 0x6},
    {1, 3, 9, 0x47},
    {1, 4,11, 0xCE},
    {1, 5,13, 0x1B4},
    {1, 6,13, 0x1B5},
    {1, 7,13, 0x1B6},
    {1, 8,13, 0x1B7},
    /* run=2 */
    {2, 1, 4, 0x5},
    {2, 2, 8, 0x27},
    {2, 3,12, 0xD1},
    {2, 4,13, 0x1B8},
    /* run=3 */
    {3, 1, 5, 0x7},
    {3, 2,10, 0x5D},
    {3, 3,12, 0xD2},
    {3, 4,13, 0x1B9},
    /* run=4 */
    {4, 1, 5, 0x6},
    {4, 2,11, 0xCF},
    {4, 3,13, 0x1BA},
    /* run=5 */
    {5, 1, 6, 0x7},
    {5, 2,11, 0xD4},
    {5, 3,13, 0x1BB},
    /* run=6 */
    {6, 1, 6, 0x5},
    {6, 2,11, 0xD5},
    /* run=7 */
    {7, 1, 7, 0x7},
    {7, 2,12, 0xD3},
    /* run=8 */
    {8, 1, 7, 0x5},
    {8, 2,12, 0xD6},
    /* run=9 */
    {9, 1, 7, 0x4},
    {9, 2,13, 0x1BC},
    /* run=10 */
    {10,1, 8, 0x25},
    {10,2,13, 0x1BD},
    /* run=11..15 */
    {11,1, 8, 0x24},
    {12,1, 8, 0x23},
    {13,1, 8, 0x22},
    {14,1, 8, 0x21},
    {15,1, 9, 0x45},
    /* run=16..26 */
    {16,1, 9, 0x46},
    {17,1,10, 0x5B},
    {18,1,10, 0x5A},
    {19,1,10, 0x59},
    {20,1,10, 0x58},
    {21,1,11, 0xD7},
    {22,1,11, 0xD8},
    {23,1,11, 0xD9},
    {24,1,11, 0xDA},
    {25,1,11, 0xDB},
    {26,1,12, 0xDC},
    /* sentinel */
    {0,0,0,0}
};

/* ================================================================== */
/*  量化矩陣 (預設值)                                                   */
/* ================================================================== */

static const uint8_t DEFAULT_INTRA_QUANT[64] = {
     8,16,16,19,16,19,22,22,
    22,22,22,22,26,24,26,27,
    27,27,26,26,26,26,27,27,
    27,29,29,29,34,34,34,29,
    29,29,27,27,29,29,32,32,
    34,34,37,38,37,35,35,34,
    35,38,38,40,40,40,48,48,
    46,46,56,56,58,69,69,83
};

static const uint8_t DEFAULT_NON_INTRA_QUANT[64] = {
    16,16,16,16,16,16,16,16,
    16,16,16,16,16,16,16,16,
    16,16,16,16,16,16,16,16,
    16,16,16,16,16,16,16,16,
    16,16,16,16,16,16,16,16,
    16,16,16,16,16,16,16,16,
    16,16,16,16,16,16,16,16,
    16,16,16,16,16,16,16,16
};

/* Zig-zag scan order */
static const uint8_t ZZ[64] = {
     0, 1, 8,16, 9, 2, 3,10,
    17,24,32,25,18,11, 4, 5,
    12,19,26,33,40,48,41,34,
    27,20,13, 6, 7,14,21,28,
    35,42,49,56,57,50,43,36,
    29,22,15,23,30,37,44,51,
    58,59,52,45,38,31,39,46,
    53,60,61,54,47,55,62,63
};

/* ================================================================== */
/*  IDCT                                                                */
/* ================================================================== */

/*
 * cos((2n+1)*k*pi/16) を事前計算した定数テーブル。
 * clang は static initializer に cos() を使えないため
 * すべてリテラル値で記述する。
 * COS_TABLE[k][n] = cos((2n+1)*k*pi/16)
 */
static const double COS_TABLE[8][8] = {
    /* k=0 */ { 1.0,              1.0,              1.0,              1.0,
                1.0,              1.0,              1.0,              1.0            },
    /* k=1 */ { 0.98078528040323, 0.83146961230255, 0.55557023301960, 0.19509032201613,
               -0.19509032201613,-0.55557023301960,-0.83146961230255,-0.98078528040323 },
    /* k=2 */ { 0.92387953251129, 0.38268343236509,-0.38268343236509,-0.92387953251129,
               -0.92387953251129,-0.38268343236509, 0.38268343236509, 0.92387953251129 },
    /* k=3 */ { 0.83146961230255,-0.19509032201613,-0.98078528040323,-0.55557023301960,
                0.55557023301960, 0.98078528040323, 0.19509032201613,-0.83146961230255 },
    /* k=4 */ { 0.70710678118655,-0.70710678118655,-0.70710678118655, 0.70710678118655,
                0.70710678118655,-0.70710678118655,-0.70710678118655, 0.70710678118655 },
    /* k=5 */ { 0.55557023301960,-0.98078528040323, 0.19509032201613, 0.83146961230255,
               -0.83146961230255,-0.19509032201613, 0.98078528040323,-0.55557023301960 },
    /* k=6 */ { 0.38268343236509,-0.92387953251129, 0.92387953251129,-0.38268343236509,
               -0.38268343236509, 0.92387953251129,-0.92387953251129, 0.38268343236509 },
    /* k=7 */ { 0.19509032201613,-0.55557023301960, 0.83146961230255,-0.98078528040323,
                0.98078528040323,-0.83146961230255, 0.55557023301960,-0.19509032201613 }
};

/* 1/sqrt(2) */
#define INV_SQRT2  0.70710678118654752440

/* 二維 IDCT，輸入 coef[64]（自然順序），輸出 out[64]，範圍 [-256,255] */
static void idct_2d(const int coef[64], int out[64])
{
    double tmp[64];

    /* 對每一列（row）做 1D IDCT：水平方向 */
    for (int r = 0; r < 8; r++) {
        for (int x = 0; x < 8; x++) {
            double s = 0.0;
            for (int u = 0; u < 8; u++) {
                double cu = (u == 0) ? INV_SQRT2 : 1.0;
                s += cu * coef[r*8+u] * COS_TABLE[u][x];
            }
            tmp[r*8+x] = s * 0.5;
        }
    }

    /* 對每一行（column）做 1D IDCT：垂直方向 */
    for (int x = 0; x < 8; x++) {
        for (int y = 0; y < 8; y++) {
            double s = 0.0;
            for (int v = 0; v < 8; v++) {
                double cv = (v == 0) ? INV_SQRT2 : 1.0;
                s += cv * tmp[v*8+x] * COS_TABLE[v][y];
            }
            int val = (int)(s * 0.5 + (s >= 0.0 ? 0.5 : -0.5));
            if (val >  255) val =  255;
            if (val < -256) val = -256;
            out[y*8+x] = val;
        }
    }
}

/* ================================================================== */
/*  影格緩衝區                                                          */
/* ================================================================== */

typedef struct {
    uint8_t *y, *cb, *cr;   /* 亮度/色差平面 */
    int width, height;       /* 以像素為單位 (aligned to 16) */
} Frame;

static Frame* frame_alloc(int width, int height)
{
    Frame *f = (Frame*)calloc(1, sizeof(Frame));
    f->width  = width;
    f->height = height;
    f->y  = (uint8_t*)calloc((size_t)(width * height), 1);
    f->cb = (uint8_t*)calloc((size_t)(width/2 * height/2), 1);
    f->cr = (uint8_t*)calloc((size_t)(width/2 * height/2), 1);
    return f;
}

static void frame_free(Frame *f)
{
    if (!f) return;
    free(f->y); free(f->cb); free(f->cr);
    free(f);
}

static void frame_copy(Frame *dst, const Frame *src)
{
    memcpy(dst->y,  src->y,  (size_t)(src->width * src->height));
    memcpy(dst->cb, src->cb, (size_t)(src->width/2 * src->height/2));
    memcpy(dst->cr, src->cr, (size_t)(src->width/2 * src->height/2));
}

/* ================================================================== */
/*  YCbCr → RGB 轉換與 PPM 輸出                                        */
/* ================================================================== */

static inline int clamp_u8(int v)
{
    return v < 0 ? 0 : (v > 255 ? 255 : v);
}

static int save_ppm(const Frame *f, int vis_w, int vis_h,
                    const char *filename)
{
    FILE *fp = fopen(filename, "wb");
    if (!fp) { perror(filename); return -1; }

    fprintf(fp, "P6\n%d %d\n255\n", vis_w, vis_h);

    uint8_t *row = (uint8_t*)malloc((size_t)(vis_w * 3));

    for (int y = 0; y < vis_h; y++) {
        for (int x = 0; x < vis_w; x++) {
            int Y  = f->y [y * f->width + x];
            int Cb = f->cb[(y/2) * (f->width/2) + x/2] - 128;
            int Cr = f->cr[(y/2) * (f->width/2) + x/2] - 128;

            int R = clamp_u8((int)(Y + 1.402  * Cr));
            int G = clamp_u8((int)(Y - 0.34414* Cb - 0.71414*Cr));
            int B = clamp_u8((int)(Y + 1.772  * Cb));

            row[x*3+0] = (uint8_t)R;
            row[x*3+1] = (uint8_t)G;
            row[x*3+2] = (uint8_t)B;
        }
        fwrite(row, 1, (size_t)(vis_w * 3), fp);
    }

    free(row);
    fclose(fp);
    return 0;
}

/* ================================================================== */
/*  DCT 係數解碼 (DC + AC)                                             */
/* ================================================================== */

/* 解 Luma DC size，回傳 size（0..8），失敗回傳 -1 */
static int decode_dc_size_luma(BitStream *bs)
{
    for (int i = 0; DCT_LUMA_DC[i].bits; i++) {
        if (bs_peek(bs, DCT_LUMA_DC[i].bits) == DCT_LUMA_DC[i].code) {
            bs_read(bs, DCT_LUMA_DC[i].bits);
            return DCT_LUMA_DC[i].level;
        }
    }
    return -1;
}

static int decode_dc_size_chroma(BitStream *bs)
{
    for (int i = 0; DCT_CHROMA_DC[i].bits; i++) {
        if (bs_peek(bs, DCT_CHROMA_DC[i].bits) == DCT_CHROMA_DC[i].code) {
            bs_read(bs, DCT_CHROMA_DC[i].bits);
            return DCT_CHROMA_DC[i].level;
        }
    }
    return -1;
}

/* 解 DC 差分值 */
static int decode_dc_diff(BitStream *bs, int size)
{
    if (size == 0) return 0;
    int halfrange = 1 << (size - 1);
    uint32_t bits = bs_read(bs, size);
    if ((int)bits < halfrange) {
        /* 負值 */
        return (int)bits - (halfrange * 2 - 1);
    }
    return (int)bits;
}

/* 解 AC 係數（run/level pair），回傳 0 = EOB, 1 = 正常, -1 = 錯誤 */
static int decode_ac(BitStream *bs, int *run_out, int *level_out)
{
    /* 先嘗試查表 */
    for (int i = 0; DCT_AC_TABLE[i].bits; i++) {
        uint32_t peeked = bs_peek(bs, DCT_AC_TABLE[i].bits);
        if (peeked == DCT_AC_TABLE[i].code) {
            bs_read(bs, DCT_AC_TABLE[i].bits);
            if (DCT_AC_TABLE[i].run == -1) {
                /* EOB */
                *run_out = -1; *level_out = 0;
                return 0;
            }
            if (DCT_AC_TABLE[i].run == -2) {
                /* Escape: 6-bit run + 8-bit level */
                *run_out   = (int)bs_read(bs, 6);
                int lv     = (int)bs_read(bs, 8);
                if (lv == 0)        lv = (int)bs_read(bs, 8);
                else if (lv == 128) lv = (int)bs_read(bs, 8) - 256;
                else if (lv >  127) lv -= 256;
                *level_out = lv;
                return 1;
            }
            /* 正常 run/level */
            int sign = bs_read1(bs);
            *run_out   = DCT_AC_TABLE[i].run;
            *level_out = sign ? -DCT_AC_TABLE[i].level
                               :  DCT_AC_TABLE[i].level;
            return 1;
        }
    }
    /* 找不到：讀掉一 bit 繼續 */
    bs_read1(bs);
    *run_out = -1; *level_out = 0;
    return 0;
}

/* ================================================================== */
/*  反量化 + IDCT                                                       */
/* ================================================================== */

/* coef[64]: zig-zag 順序的量化係數 → 輸出 pixel_diff[64] */
static void dequant_idct(int *coef, int qscale,
                         const uint8_t *qmat, int intra,
                         int *out_pixels)
{
    int deq[64] = {0};

    for (int i = 0; i < 64; i++) {
        int zz = ZZ[i];
        int c  = coef[zz];
        if (c == 0) continue;

        int val;
        if (intra) {
            /* DC 已單獨處理；這裡只處理 AC (i>0) */
            if (i == 0) { val = coef[0] * qmat[0]; }
            else {
                val = (2 * c * qscale * (int)qmat[zz]) / 16;
                if (val > 0 && (val & 1) == 0) val--;
                else if (val < 0 && (-val & 1) == 0) val++;
            }
        } else {
            val = ((2 * c + (c > 0 ? 1 : -1)) * qscale * (int)qmat[zz]) / 16;
            if (val > 0 && (val & 1) == 0) val--;
            else if (val < 0 && (-val & 1) == 0) val++;
        }
        /* 飽和到 [-2048, 2047] */
        if (val >  2047) val =  2047;
        if (val < -2048) val = -2048;
        deq[zz] = val;
    }

    idct_2d(deq, out_pixels);
}

/* ================================================================== */
/*  Macroblock 解碼狀態                                                 */
/* ================================================================== */

typedef struct {
    /* 序列標頭 */
    int width, height;          /* 影像可視大小 */
    int mb_width, mb_height;    /* macroblock 數量 */
    int frame_width, frame_height; /* 補 16 對齊後大小 */

    /* 量化矩陣 */
    uint8_t intra_qmat[64];
    uint8_t inter_qmat[64];

    /* DC 預測值 (每個 channel) */
    int dc_y, dc_cb, dc_cr;

    /* 參考影格 (I/P 解碼後存放) */
    Frame *ref;

    /* 目前解碼影格 */
    Frame *cur;

    /* 量化比例 */
    int qscale;
} MPEGCtx;

/* ================================================================== */
/*  解碼單個 8×8 DCT Block                                             */
/* ================================================================== */

/*
 * is_intra: 1=Intra block, 0=Inter
 * chan: 0=Y, 1=Cb, 2=Cr  (影響 DC 解碼)
 * dc_pred: 指向對應 channel 的 DC 預測器
 * qmat: 量化矩陣
 */
static void decode_block(BitStream *bs, MPEGCtx *ctx,
                          int is_intra, int chan,
                          int *dc_pred, const uint8_t *qmat,
                          int *pixels_out)
{
    int coef[64] = {0};
    int pos = 0;

    if (is_intra) {
        /* DC */
        int size = (chan == 0) ? decode_dc_size_luma(bs)
                               : decode_dc_size_chroma(bs);
        if (size < 0) size = 0;
        int diff = decode_dc_diff(bs, size);
        *dc_pred += diff;
        /* DC 重建值 = pred * 8 (intra DC precision=8) */
        coef[0] = *dc_pred * 8;
        pos = 1;
    } else {
        pos = 0;
    }

    /* AC 係數 */
    while (pos < 64) {
        int run, level;
        int ret = decode_ac(bs, &run, &level);
        if (ret == 0) break;  /* EOB */
        if (run < 0) break;
        pos += run;
        if (pos >= 64) break;
        coef[ZZ[pos]] = level;
        pos++;
    }

    /* 反量化 + IDCT */
    dequant_idct(coef, ctx->qscale, qmat, is_intra, pixels_out);
}

/* ================================================================== */
/*  把 8×8 像素加回影格緩衝區                                           */
/* ================================================================== */

static void put_block_y(Frame *f, int mb_x, int mb_y,
                         int blk_x2, int blk_y2,
                         const int *pixels, int intra, const uint8_t *ref_y)
{
    int bx = mb_x * 16 + blk_x2 * 8;
    int by = mb_y * 16 + blk_y2 * 8;

    for (int r = 0; r < 8; r++) {
        for (int c = 0; c < 8; c++) {
            int x = bx + c, y = by + r;
            if (x >= f->width || y >= f->height) continue;
            int pix = pixels[r*8+c];
            if (!intra) {
                pix += (int)ref_y[y * f->width + x];
            }
            f->y[y * f->width + x] = (uint8_t)clamp_u8(pix + (intra ? 128 : 0));
        }
    }
}

static void put_block_c(uint8_t *plane, int pw, int ph,
                         int mb_x, int mb_y,
                         const int *pixels, int intra, const uint8_t *ref_c)
{
    int bx = mb_x * 8;
    int by = mb_y * 8;

    for (int r = 0; r < 8; r++) {
        for (int c = 0; c < 8; c++) {
            int x = bx + c, y = by + r;
            if (x >= pw || y >= ph) continue;
            int pix = pixels[r*8+c];
            if (!intra) {
                pix += (int)ref_c[y * pw + x];
            }
            plane[y * pw + x] = (uint8_t)clamp_u8(pix + (intra ? 128 : 0));
        }
    }
}

/* ================================================================== */
/*  運動補償 (P-frame 前向預測)                                         */
/* ================================================================== */

static void mc_block(const uint8_t *ref, uint8_t *pred,
                      int stride, int x, int y,
                      int mvx, int mvy, int w, int h)
{
    /* mvx, mvy 以半像素為單位 */
    int hx = mvx & 1, hy = mvy & 1;
    int rx = x + (mvx >> 1), ry = y + (mvy >> 1);

    for (int j = 0; j < h; j++) {
        for (int i = 0; i < w; i++) {
            int sx = rx + i, sy = ry + j;
            if (sx < 0) sx = 0;
            if (sx >= stride) sx = stride-1;
            if (sy < 0) sy = 0;

            if (!hx && !hy) {
                pred[j*w+i] = ref[sy*stride+sx];
            } else if (hx && !hy) {
                int sx2 = sx+1; if (sx2 >= stride) sx2 = stride-1;
                pred[j*w+i] = (uint8_t)((ref[sy*stride+sx] +
                                          ref[sy*stride+sx2] + 1) >> 1);
            } else if (!hx && hy) {
                int sy2 = sy+1;
                int v1 = ref[sy*stride+sx];
                int v2 = (sy2 < h*2) ? ref[sy2*stride+sx] : v1;
                pred[j*w+i] = (uint8_t)((v1+v2+1)>>1);
            } else {
                int sx2 = sx+1; if (sx2 >= stride) sx2=stride-1;
                int sy2 = sy+1;
                int a = ref[sy*stride+sx],  b = ref[sy*stride+sx2];
                int c = (sy2<h*2)?ref[sy2*stride+sx] :a;
                int d = (sy2<h*2)?ref[sy2*stride+sx2]:b;
                pred[j*w+i] = (uint8_t)((a+b+c+d+2)>>2);
            }
        }
    }
}

/* ================================================================== */
/*  解碼 Slice / Macroblock                                            */
/* ================================================================== */

/*
 * 解碼從目前位置開始的一個 picture。
 * pic_type: PIC_TYPE_I 或 PIC_TYPE_P
 * 解碼結果存入 ctx->cur。
 */
static void decode_picture(BitStream *bs, MPEGCtx *ctx, int pic_type)
{
    int mb_w = ctx->mb_width;
    int mb_h = ctx->mb_height;
    int cw   = ctx->frame_width  / 2;
    int ch   = ctx->frame_height / 2;

    /* 初始化 DC 預測器 */
    ctx->dc_y  = 128;
    ctx->dc_cb = 128;
    ctx->dc_cr = 128;

    int mb_addr = -1;  /* 目前 MB address */

    /* 掃描 slice */
    while (bs->byte_pos < bs->size - 3) {
        /* 尋找 slice start code 0x000001 01..AF */
        uint32_t sc = bs_peek(bs, 32);
        if ((sc >> 8) != MPEG_START_CODE_PREFIX) {
            bs_read1(bs);
            continue;
        }
        uint8_t sc_val = sc & 0xFF;
        if (sc_val < SC_SLICE_MIN || sc_val > SC_SLICE_MAX) break;

        bs_read(bs, 32);  /* 吃掉 start code */

        int slice_vert = sc_val - 1;  /* 0-based MB row */
        ctx->qscale   = (int)bs_read(bs, 5);

        /* extra info slice */
        while (bs_read1(bs)) bs_read(bs, 8);

        /* 重設 DC pred 在每個 slice 開頭 */
        ctx->dc_y  = 128;
        ctx->dc_cb = 128;
        ctx->dc_cr = 128;

        int first_mb_in_slice = 1;
        int mb_x = 0, mb_y = slice_vert;

        /* 解碼 macroblock */
        while (1) {
            /* --- macroblock address increment --- */
            int addr_inc = 0;

            /* 檢查 stuffing / next start code */
            while (bs_peek(bs,11) == 0xF) { bs_read(bs,11); }  /* stuffing */

            if (bs_peek(bs,23) == 0) break;   /* next start code */
            if (bs->byte_pos >= bs->size) break;

            /* 解碼 MBA increment */
            int inc = vlc_decode(bs, MBA_TABLE);
            if (inc == -9999 || inc == 34) break;  /* escape / end */
            addr_inc = inc;

            if (first_mb_in_slice) {
                mb_addr = slice_vert * mb_w + (addr_inc - 1);
                first_mb_in_slice = 0;
            } else {
                mb_addr += addr_inc;
            }

            mb_x = mb_addr % mb_w;
            mb_y = mb_addr / mb_w;

            if (mb_y >= mb_h) break;

            /* --- macroblock type --- */
            /* 簡化版：讀取 mb_type bits */
            int mb_intra  = 0;
            int mb_quant  = 0;
            int mb_motion = 0;
            int mb_coded  = 1;

            if (pic_type == PIC_TYPE_I) {
                /* I-frame: all macroblocks are intra */
                /* mb_type VLC for I-frame: 1=intra, 01=intra+quant */
                if (bs_read1(bs) == 0) {
                    bs_read1(bs);  /* must be 1 */
                    mb_quant = 1;
                }
                mb_intra = 1;
                mb_coded = 1;
            } else {
                /* P-frame mb_type (簡化版) */
                uint32_t p = bs_peek(bs, 6);
                if      (p >> 5)        { bs_read(bs,1); mb_coded=1; mb_motion=0; mb_intra=0; } /* 1 */
                else if (p >> 4)        { bs_read(bs,2); mb_coded=1; mb_motion=1; mb_intra=0; } /* 01 */
                else if (p >> 3)        { bs_read(bs,3); mb_coded=0; mb_motion=1; mb_intra=0; } /* 001 */
                else if (p >> 2)        { bs_read(bs,4); mb_coded=1; mb_motion=0; mb_intra=0; mb_quant=1; } /* 0001 */
                else if (p >> 1)        { bs_read(bs,5); mb_coded=1; mb_motion=1; mb_intra=0; mb_quant=1; } /* 00001 */
                else                    { bs_read(bs,6); mb_intra=1; mb_coded=1; mb_quant=1; } /* 000001 */
            }

            if (mb_quant) {
                ctx->qscale = (int)bs_read(bs, 5);
            }

            /* --- 運動向量 --- */
            int mv_x = 0, mv_y = 0;
            if (mb_motion && !mb_intra) {
                int dh = vlc_decode(bs, MV_TABLE);
                if (dh != -9999) mv_x = dh;
                int r_size = 0; /* 暫定 */
                (void)r_size;
                int dv = vlc_decode(bs, MV_TABLE);
                if (dv != -9999) mv_y = dv;
            }

            /* --- coded block pattern (如果非 intra 且有 coded) --- */
            int cbp = 0x3F; /* 預設全部 6 個 block 都有資料 */
            if (!mb_intra && mb_coded) {
                /* 解 CBP VLC (ISO 11172-2 Table B.9) */
                static const struct {uint32_t code; int bits; int val;} CBP_TBL[] = {
                    {0x1,  1, 60},{0x1,  4, 4 },{0x3,  4, 8 },{0x2,  4, 16},
                    {0x5,  5, 32},{0x6,  5, 12},{0x4,  5, 48},{0x7,  5, 20},
                    {0x6,  6, 40},{0x7,  6, 28},{0x5,  6, 44},{0x4,  6, 52},
                    {0xF,  6, 56},{0xE,  6, 1 },{0xD,  6, 61},{0xC,  6, 2 },
                    {0xB,  6, 62},{0xA,  6, 24},{0x9,  6, 36},{0x8,  6, 3 },
                    {0x1F, 7, 63},{0x1E, 7, 5 },{0x1D, 7, 9 },{0x1C, 7, 17},
                    {0x1B, 7, 33},{0x1A, 7, 6 },{0x19, 7, 10},{0x18, 7, 18},
                    {0x17, 7, 34},{0x16, 7, 7 },{0x15, 7, 11},{0x14, 7, 19},
                    {0x13, 7, 35},{0x12, 7, 13},{0x11, 7, 49},{0x10, 7, 21},
                    {0x1F, 8, 41},{0x1E, 8, 14},{0x1D, 8, 50},{0x1C, 8, 22},
                    {0x1B, 8, 42},{0x1A, 8, 15},{0x19, 8, 51},{0x18, 8, 23},
                    {0x17, 8, 43},{0x16, 8, 25},{0x15, 8, 37},{0x14, 8, 26},
                    {0x13, 8, 38},{0x12, 8, 29},{0x11, 8, 45},{0x10, 8, 53},
                    {0x0F, 8, 57},{0x0E, 8, 30},{0x0D, 8, 46},{0x0C, 8, 54},
                    {0x0B, 8, 58},{0x0A, 8, 31},{0x09, 8, 47},{0x08, 8, 55},
                    {0x07, 8, 59},{0x06, 8, 27},{0x05, 8, 39},{0x04, 8, 0 },
                    {0,0,0}
                };
                cbp = -1;
                for (int i = 0; CBP_TBL[i].bits; i++) {
                    if (bs_peek(bs, CBP_TBL[i].bits) == CBP_TBL[i].code) {
                        bs_read(bs, CBP_TBL[i].bits);
                        cbp = CBP_TBL[i].val;
                        break;
                    }
                }
                if (cbp < 0) cbp = 0;
            } else if (mb_intra) {
                cbp = 0x3F;
            }

            /* --- 解碼 6 個 8×8 block (4Y + Cb + Cr) --- */
            for (int blk = 0; blk < 6; blk++) {
                int bit = (cbp >> (5 - blk)) & 1;
                if (!bit && !mb_intra) continue;

                int pixels[64] = {0};
                int is_y  = (blk < 4);
                int chan  = is_y ? 0 : (blk == 4 ? 1 : 2);
                int *dcpr = is_y ? &ctx->dc_y :
                            (chan == 1 ? &ctx->dc_cb : &ctx->dc_cr);
                const uint8_t *qm = mb_intra ? ctx->intra_qmat
                                             : ctx->inter_qmat;

                decode_block(bs, ctx, mb_intra, chan, dcpr, qm, pixels);

                /* --- 寫回影格 --- */
                /* 計算參考像素（運動補償） */
                if (is_y) {
                    int bx2 = blk & 1, by2 = (blk >> 1) & 1;
                    uint8_t mc_pred[64] = {0};
                    if (!mb_intra && ctx->ref) {
                        mc_block(ctx->ref->y, mc_pred,
                                 ctx->frame_width,
                                 mb_x*16 + bx2*8,
                                 mb_y*16 + by2*8,
                                 mv_x*2, mv_y*2,
                                 8, 8);
                    }
                    /* 把殘差加上 MC 預測後寫回 */
                    int bx = mb_x*16 + bx2*8;
                    int by_ = mb_y*16 + by2*8;
                    for (int r = 0; r < 8; r++) {
                        for (int c = 0; c < 8; c++) {
                            int x2 = bx+c, y2 = by_+r;
                            if (x2>=ctx->frame_width || y2>=ctx->frame_height) continue;
                            int v = pixels[r*8+c];
                            if (!mb_intra) v += mc_pred[r*8+c];
                            else v += 128;
                            ctx->cur->y[y2*ctx->frame_width+x2] = (uint8_t)clamp_u8(v);
                        }
                    }
                } else {
                    /* Cb or Cr */
                    uint8_t *plane = (chan==1) ? ctx->cur->cb : ctx->cur->cr;
                    uint8_t *rplane = ctx->ref ? ((chan==1) ? ctx->ref->cb : ctx->ref->cr) : NULL;
                    uint8_t mc_pred[64] = {0};
                    if (!mb_intra && rplane) {
                        mc_block(rplane, mc_pred, cw,
                                 mb_x*8, mb_y*8,
                                 mv_x, mv_y, 8, 8);
                    }
                    for (int r = 0; r < 8; r++) {
                        for (int c = 0; c < 8; c++) {
                            int x2 = mb_x*8+c, y2 = mb_y*8+r;
                            if (x2>=cw || y2>=ch) continue;
                            int v = pixels[r*8+c];
                            if (!mb_intra) v += mc_pred[r*8+c];
                            else v += 128;
                            plane[y2*cw+x2] = (uint8_t)clamp_u8(v);
                        }
                    }
                }
            } /* end block loop */

            /* 若非 intra 且沒有 motion，直接從參考 copy */
            if (!mb_intra && !mb_motion && !mb_coded && ctx->ref) {
                /* 直接複製參考 MB */
                for (int r = 0; r < 16; r++) {
                    int y2 = mb_y*16+r;
                    if (y2>=ctx->frame_height) break;
                    memcpy(&ctx->cur->y[y2*ctx->frame_width + mb_x*16],
                           &ctx->ref->y[y2*ctx->frame_width + mb_x*16],
                           16);
                }
                for (int r = 0; r < 8; r++) {
                    int y2 = mb_y*8+r;
                    if (y2>=ch) break;
                    memcpy(&ctx->cur->cb[y2*cw + mb_x*8],
                           &ctx->ref->cb[y2*cw + mb_x*8], 8);
                    memcpy(&ctx->cur->cr[y2*cw + mb_x*8],
                           &ctx->ref->cr[y2*cw + mb_x*8], 8);
                }
            }
        } /* end MB loop */
    } /* end slice loop */
}

/* ================================================================== */
/*  MPEG-1 系統串流 demux (去掉 pack/PES header)                       */
/* ================================================================== */

/*
 * 從原始位元組緩衝區找出所有的 video elementary stream 資料。
 * 若輸入已是 video ES (直接 00 00 01 B3 開頭)，則原樣回傳。
 * 回傳 malloc'd buffer，需呼叫者 free。
 */
static uint8_t* extract_video_es(const uint8_t *in, size_t in_size,
                                  size_t *out_size)
{
    /* 檢查是否已是 Video ES（第一個 start code 是 sequence header） */
    if (in_size >= 4 &&
        in[0]==0 && in[1]==0 && in[2]==1 && in[3]==0xB3) {
        uint8_t *buf = (uint8_t*)malloc(in_size);
        memcpy(buf, in, in_size);
        *out_size = in_size;
        return buf;
    }

    /* 否則假設是 MPEG-1 System Stream，提取 video PES (0xE0) */
    uint8_t *out = (uint8_t*)malloc(in_size);
    size_t   out_len = 0;
    size_t   i = 0;

    while (i + 4 <= in_size) {
        /* 尋找 start code */
        if (in[i]!=0 || in[i+1]!=0 || in[i+2]!=1) { i++; continue; }
        uint8_t sc = in[i+3];
        i += 4;

        if (sc == 0xBA) {
            /* Pack header: skip 8 bytes (MPEG-1 pack) */
            i += 8;
            continue;
        }
        if (sc == 0xBB) {
            /* System header */
            if (i+2 > in_size) break;
            int len = ((int)in[i]<<8) | in[i+1]; i += 2;
            i += len;
            continue;
        }
        if (sc >= 0xE0 && sc <= 0xEF) {
            /* Video PES */
            if (i+2 > in_size) break;
            int pkt_len = ((int)in[i]<<8) | in[i+1]; i += 2;
            if (pkt_len == 0 || i+pkt_len > in_size) break;

            /* 跳過 MPEG-1 PES header (ISO 11172-1 §2.4.4.2)
             *   stuffing (0xFF...) → STD buffer (opt 2B) → timestamp:
             *     0x2x = PTS only  (5 bytes)
             *     0x3x = PTS+DTS   (10 bytes)
             *     0x0F = no ts     (1 byte)
             */
            size_t j = 0;
            while (j < (size_t)pkt_len && in[i+j] == 0xFF) j++;
            if (j < (size_t)pkt_len && (in[i+j] & 0xC0) == 0x40) j += 2;
            if (j < (size_t)pkt_len) {
                uint8_t hdr = in[i+j];
                if      ((hdr & 0xF0) == 0x20) j += 5;   /* PTS only  */
                else if ((hdr & 0xF0) == 0x30) j += 10;  /* PTS + DTS */
                else if ( hdr         == 0x0F) j += 1;   /* no ts     */
            }

            size_t payload = (size_t)pkt_len - j;
            if (i+j+payload <= in_size) {
                memcpy(out+out_len, in+i+j, payload);
                out_len += payload;
            }
            i += pkt_len;
            continue;
        }

        /* 其他 start code：略過 (如 audio PES 0xC0..DF) */
        if (sc >= 0xBD) {
            if (i+2 > in_size) break;
            int len = ((int)in[i]<<8) | in[i+1]; i += 2+len;
        }
    }

    *out_size = out_len;
    return out;
}

/* ================================================================== */
/*  主程式                                                              */
/* ================================================================== */

int main(int argc, char *argv[])
{
    if (argc < 3) {
        fprintf(stderr, "用法: %s <input.mpg> <frame_index> [output.ppm]\n", argv[0]);
        fprintf(stderr, "範例: %s movie.mpg 10\n", argv[0]);
        return EXIT_FAILURE;
    }

    const char *input_file   = argv[1];
    int         target_frame = atoi(argv[2]);
    char        output_file[512];
    if (argc >= 4)
        snprintf(output_file, sizeof(output_file), "%s", argv[3]);
    else
        snprintf(output_file, sizeof(output_file), "frame_%04d.ppm", target_frame);

    /* ---- 讀入整個檔案 ---- */
    FILE *fp = fopen(input_file, "rb");
    if (!fp) { perror(input_file); return EXIT_FAILURE; }
    fseek(fp, 0, SEEK_END);
    long fsize = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    uint8_t *raw = (uint8_t*)malloc((size_t)fsize);
    if (!raw) { fprintf(stderr, "記憶體不足\n"); fclose(fp); return EXIT_FAILURE; }
    fread(raw, 1, (size_t)fsize, fp);
    fclose(fp);

    /* ---- 提取 Video ES ---- */
    size_t   es_size;
    uint8_t *es = extract_video_es(raw, (size_t)fsize, &es_size);
    free(raw);

    printf("輸入檔案 : %s (%ld bytes)\n", input_file, fsize);
    printf("Video ES : %zu bytes\n", es_size);
    printf("目標影格 : %d\n", target_frame);

    /* ---- 初始化 context ---- */
    MPEGCtx ctx;
    memset(&ctx, 0, sizeof(ctx));
    memcpy(ctx.intra_qmat, DEFAULT_INTRA_QUANT,    64);
    memcpy(ctx.inter_qmat, DEFAULT_NON_INTRA_QUANT, 64);

    BitStream bs;
    bs_init(&bs, es, es_size);

    int found    = 0;
    int frame_no = -1;
    int seq_printed = 0;

    /*
     * ---- 逐 byte 掃描 start code ----------------------------------------
     * 用 byte 指標操作，完全避免 BitStream bit_pos 錯位的問題。
     * 找到 start code 後才把 pos 設好再用 BitStream 讀 header 欄位。
     */
    size_t pos = 0;  /* 目前掃描的 byte 位置 */

/* 在 es[] 中從 pos 開始尋找下一個 00 00 01 xx，回傳 xx 所在的 index */
#define NEXT_SC(start, found_pos) do {              \
    (found_pos) = es_size;                          \
    for (size_t _i = (start); _i + 3 < es_size; _i++) { \
        if (es[_i]==0 && es[_i+1]==0 && es[_i+2]==1) {  \
            (found_pos) = _i;                       \
            break;                                  \
        }                                           \
    }                                               \
} while(0)

    while (!found) {
        size_t sc_pos;
        NEXT_SC(pos, sc_pos);
        if (sc_pos >= es_size) break;   /* 沒有更多 start code */

        uint8_t sc = es[sc_pos + 3];
        pos = sc_pos + 4;               /* 下次從 sc 後面開始搜尋 */

        /* 把 BitStream 指向 start code 後面的 payload */
        bs_init(&bs, es + pos, es_size - pos);

        /* ---- Sequence Header ---- */
        if (sc == SC_SEQ_HDR) {
            int w   = (int)bs_read(&bs, 12);
            int h   = (int)bs_read(&bs, 12);
            bs_read(&bs, 4);   /* aspect ratio */
            bs_read(&bs, 4);   /* frame rate */
            bs_read(&bs, 18);  /* bit rate */
            bs_read(&bs,  1);  /* marker */
            bs_read(&bs, 10);  /* VBV */
            bs_read(&bs,  1);  /* constrained */

            /* 只接受第一個 sequence header（或大小變化才更新） */
            int is_new = (w != ctx.width || h != ctx.height ||
                          ctx.mb_width == 0);

            /* 讀量化矩陣（不論是否 is_new 都要消耗 bits） */
            uint8_t iq[64], niq[64];
            int has_iq = (int)bs_read(&bs, 1);
            if (has_iq)
                for (int i = 0; i < 64; i++)
                    iq[ZZ[i]] = (uint8_t)bs_read(&bs, 8);
            int has_niq = (int)bs_read(&bs, 1);
            if (has_niq)
                for (int i = 0; i < 64; i++)
                    niq[ZZ[i]] = (uint8_t)bs_read(&bs, 8);

            if (is_new) {
                ctx.width        = w;
                ctx.height       = h;
                ctx.frame_width  = (w + 15) & ~15;
                ctx.frame_height = (h + 15) & ~15;
                ctx.mb_width     = ctx.frame_width  / 16;
                ctx.mb_height    = ctx.frame_height / 16;
                if (has_iq)  memcpy(ctx.intra_qmat, iq,  64);
                if (has_niq) memcpy(ctx.inter_qmat, niq, 64);

                frame_free(ctx.cur); ctx.cur = NULL;
                frame_free(ctx.ref); ctx.ref = NULL;
                ctx.cur = frame_alloc(ctx.frame_width, ctx.frame_height);
                ctx.ref = frame_alloc(ctx.frame_width, ctx.frame_height);

                if (!seq_printed) {
                    printf("序列    : %dx%d (MB %dx%d)\n",
                           ctx.width, ctx.height,
                           ctx.mb_width, ctx.mb_height);
                    seq_printed = 1;
                }
            }
            /* 推進 pos 跳過已讀的 bits */
            pos += bs.byte_pos;
            continue;
        }

        /* ---- GOP Header (25 bits) ---- */
        if (sc == SC_GOP) {
            pos += 4;   /* ceil(25/8) = 4 bytes, 保守跳過 */
            continue;
        }

        /* ---- Extension / User Data：跳到下一個 start code ---- */
        if (sc == SC_EXT || sc == SC_USER_DATA) {
            /* pos 已指向 payload 開頭，直接讓外層迴圈 NEXT_SC 找下一個 */
            continue;
        }

        /* ---- Picture Header ---- */
        if (sc == SC_PICTURE) {
            if (ctx.mb_width == 0) continue;

            bs_read(&bs, 10); /* temporal reference */
            int pic_type = (int)bs_read(&bs, 3);
            bs_read(&bs, 16); /* VBV delay */

            if (pic_type == PIC_TYPE_P || pic_type == PIC_TYPE_B) {
                bs_read(&bs, 1); /* full_pel_forward */
                bs_read(&bs, 3); /* forward_f_code */
            }
            if (pic_type == PIC_TYPE_B) {
                bs_read(&bs, 1); /* full_pel_backward */
                bs_read(&bs, 3); /* backward_f_code */
            }
            /* extra info picture */
            while (bs_read1(&bs)) bs_read(&bs, 8);
            bs_align(&bs);

            /* 消耗掉 extension/user_data start codes (0xB5 / 0xB2) */
            while (bs.byte_pos + 4 <= (es_size - pos)) {
                if (es[pos + bs.byte_pos    ] == 0 &&
                    es[pos + bs.byte_pos + 1] == 0 &&
                    es[pos + bs.byte_pos + 2] == 1) {
                    uint8_t nsc = es[pos + bs.byte_pos + 3];
                    if (nsc == SC_EXT || nsc == SC_USER_DATA) {
                        /* 跳過這個 ext/ud start code，再找下一個 */
                        size_t tmp_pos = pos + bs.byte_pos + 4;
                        size_t next_sc;
                        NEXT_SC(tmp_pos, next_sc);
                        pos = next_sc;
                        bs_init(&bs, es + pos, es_size - pos);
                        continue;
                    }
                }
                break;
            }

            frame_no++;

            /* slice data 從現在的 pos+bs.byte_pos 開始 */
            size_t slice_start = pos + bs.byte_pos;

            /* 找這個 picture 的 payload 結束位置（下一個非 slice start code） */
            size_t next_pic_pos;
            {
                size_t search = slice_start;
                next_pic_pos  = es_size;
                while (search + 4 <= es_size) {
                    if (es[search]==0 && es[search+1]==0 && es[search+2]==1) {
                        uint8_t nsc2 = es[search+3];
                        /* slice = 0x01..0xAF; 其他 start code 代表下一個單元 */
                        if (nsc2 < SC_SLICE_MIN || nsc2 > SC_SLICE_MAX) {
                            next_pic_pos = search;
                            break;
                        }
                        search += 4;
                    } else {
                        search++;
                    }
                }
            }

            const char *type_name = (pic_type==PIC_TYPE_I)?"I":
                                    (pic_type==PIC_TYPE_P)?"P":
                                    (pic_type==PIC_TYPE_B)?"B":"?";

            if (pic_type == PIC_TYPE_I || pic_type == PIC_TYPE_P) {
                /* I / P frame: 解碼並存為 ref */
                memset(ctx.cur->y,  0x80,
                       (size_t)(ctx.frame_width * ctx.frame_height));
                memset(ctx.cur->cb, 0x80,
                       (size_t)(ctx.frame_width/2 * ctx.frame_height/2));
                memset(ctx.cur->cr, 0x80,
                       (size_t)(ctx.frame_width/2 * ctx.frame_height/2));
                ctx.qscale = 8;

                bs_init(&bs, es + slice_start,
                             next_pic_pos - slice_start);
                decode_picture(&bs, &ctx, pic_type);

                /* P frame 解碼後更新 ref；I frame 也更新 ref */
                frame_copy(ctx.ref, ctx.cur);

                if (frame_no == target_frame) {
                    if (save_ppm(ctx.cur, ctx.width, ctx.height,
                                 output_file) == 0) {
                        printf("✓ 已儲存第 %d 張影格（%s）→ %s\n",
                               target_frame, type_name, output_file);
                        found = 1;
                    }
                }
            } else if (pic_type == PIC_TYPE_B) {
                /* B frame: 無法完整解碼（需雙向 MC），
                 * 若這是目標 frame，輸出最近一個 I/P ref frame */
                if (frame_no == target_frame) {
                    if (ctx.ref->y == NULL ||
                        ctx.ref->width == 0) {
                        fprintf(stderr,
                            "✗ 第 %d 張是 B-frame 且沒有可用的參考影格\n",
                            target_frame);
                    } else {
                        if (save_ppm(ctx.ref, ctx.width, ctx.height,
                                     output_file) == 0) {
                            printf("✓ 已儲存第 %d 張影格（B→輸出前一個 I/P）→ %s\n",
                                   target_frame, output_file);
                            found = 1;
                        }
                    }
                }
                /* B frame 不更新 ref */
            }

            /* 下一輪從這個 picture 結束後繼續 */
            pos = next_pic_pos;
            continue;
        }

        /* ---- Sequence End ---- */
        if (sc == SC_SEQ_END) break;

        /* 其他 start code：跳過，讓外層迴圈 NEXT_SC 找下一個 */
    }

#undef NEXT_SC

    if (!found) {
        fprintf(stderr, "✗ 找不到第 %d 張影格（共解碼約 %d 張）\n",
                target_frame, frame_no+1);
    }

    frame_free(ctx.cur);
    frame_free(ctx.ref);
    free(es);

    return found ? EXIT_SUCCESS : EXIT_FAILURE;
}