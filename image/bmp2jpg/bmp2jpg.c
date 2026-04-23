/*
 * bmp2jpg.c  —  BMP → JPEG converter, pure C, zero external dependencies
 *
 * Usage:  ./bmp2jpg  input.bmp  output.jpg  [quality]
 *   quality : 1-100  (default 75)
 *
 * Supports : 24-bit and 32-bit uncompressed BMP files.
 *
 * JPEG encoding:
 *   (1) RGB -> YCbCr (ITU-R BT.601 / JFIF), level shift -128
 *   (2) 8x8 Forward DCT (reference definition)
 *   (3) Scalar quantisation (IJG tables, quality-scaled)
 *   (4) Zigzag scan, DPCM for DC, RLE for AC
 *   (5) Huffman coding with the correct IJG standard tables
 *
 * Compile:  gcc -O2 -o bmp2jpg bmp2jpg.c -lm
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>

/* ── BMP headers (packed) ── */
#pragma pack(push, 1)
typedef struct {
    uint16_t bfType;
    uint32_t bfSize;
    uint16_t bfReserved1, bfReserved2;
    uint32_t bfOffBits;
} BmpFileHdr;

typedef struct {
    uint32_t biSize;
    int32_t  biWidth, biHeight;
    uint16_t biPlanes, biBitCount;
    uint32_t biCompression, biSizeImage;
    int32_t  biXPelsPerMeter, biYPelsPerMeter;
    uint32_t biClrUsed, biClrImportant;
} BmpInfoHdr;
#pragma pack(pop)

typedef struct { int w, h; uint8_t *rgb; } Image;

/* ════════════════════════════════════════════════════════
 *  Standard JPEG Huffman tables  (JPEG Annex K / IJG)
 * ════════════════════════════════════════════════════════ */

static const uint8_t DC_LUM_BITS[17]  = {0, 0,1,5,1,1,1,1,1,1,0,0,0,0,0,0,0};
static const uint8_t DC_LUM_VALS[12]  = {0,1,2,3,4,5,6,7,8,9,10,11};

static const uint8_t DC_CHR_BITS[17]  = {0, 0,3,1,1,1,1,1,1,1,1,1,0,0,0,0,0};
static const uint8_t DC_CHR_VALS[12]  = {0,1,2,3,4,5,6,7,8,9,10,11};

static const uint8_t AC_LUM_BITS[17]  = {0, 0,2,1,3,3,2,4,3,5,5,4,4,0,0,1,125};
static const uint8_t AC_LUM_VALS[162] = {
    0x01,0x02,0x03,0x00,0x04,0x11,0x05,0x12,
    0x21,0x31,0x41,0x06,0x13,0x51,0x61,0x07,
    0x22,0x71,0x14,0x32,0x81,0x91,0xA1,0x08,
    0x23,0x42,0xB1,0xC1,0x15,0x52,0xD1,0xF0,
    0x24,0x33,0x62,0x72,0x82,0x09,0x0A,0x16,
    0x17,0x18,0x19,0x1A,0x25,0x26,0x27,0x28,
    0x29,0x2A,0x34,0x35,0x36,0x37,0x38,0x39,
    0x3A,0x43,0x44,0x45,0x46,0x47,0x48,0x49,
    0x4A,0x53,0x54,0x55,0x56,0x57,0x58,0x59,
    0x5A,0x63,0x64,0x65,0x66,0x67,0x68,0x69,
    0x6A,0x73,0x74,0x75,0x76,0x77,0x78,0x79,
    0x7A,0x83,0x84,0x85,0x86,0x87,0x88,0x89,
    0x8A,0x92,0x93,0x94,0x95,0x96,0x97,0x98,
    0x99,0x9A,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,
    0xA8,0xA9,0xAA,0xB2,0xB3,0xB4,0xB5,0xB6,
    0xB7,0xB8,0xB9,0xBA,0xC2,0xC3,0xC4,0xC5,
    0xC6,0xC7,0xC8,0xC9,0xCA,0xD2,0xD3,0xD4,
    0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xE1,0xE2,
    0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,
    0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,
    0xF9,0xFA
};

static const uint8_t AC_CHR_BITS[17]  = {0, 0,2,1,2,4,4,3,4,7,5,4,4,0,1,2,119};
static const uint8_t AC_CHR_VALS[162] = {
    0x00,0x01,0x02,0x03,0x11,0x04,0x05,0x21,
    0x31,0x06,0x12,0x41,0x51,0x07,0x61,0x71,
    0x13,0x22,0x32,0x81,0x08,0x14,0x42,0x91,
    0xA1,0xB1,0xC1,0x09,0x23,0x33,0x52,0xF0,
    0x15,0x62,0x72,0xD1,0x0A,0x16,0x24,0x34,
    0xE1,0x25,0xF1,0x17,0x18,0x19,0x1A,0x26,
    0x27,0x28,0x29,0x2A,0x35,0x36,0x37,0x38,
    0x39,0x3A,0x43,0x44,0x45,0x46,0x47,0x48,
    0x49,0x4A,0x53,0x54,0x55,0x56,0x57,0x58,
    0x59,0x5A,0x63,0x64,0x65,0x66,0x67,0x68,
    0x69,0x6A,0x73,0x74,0x75,0x76,0x77,0x78,
    0x79,0x7A,0x82,0x83,0x84,0x85,0x86,0x87,
    0x88,0x89,0x8A,0x92,0x93,0x94,0x95,0x96,
    0x97,0x98,0x99,0x9A,0xA2,0xA3,0xA4,0xA5,
    0xA6,0xA7,0xA8,0xA9,0xAA,0xB2,0xB3,0xB4,
    0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xC2,0xC3,
    0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xD2,
    0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,
    0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,
    0xEA,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,
    0xF9,0xFA
};

/* ── Standard IJG quantisation tables ── */
static const uint8_t BASE_LUM_QT[64] = {
    16,11,10,16, 24, 40, 51, 61,
    12,12,14,19, 26, 58, 60, 55,
    14,13,16,24, 40, 57, 69, 56,
    14,17,22,29, 51, 87, 80, 62,
    18,22,37,56, 68,109,103, 77,
    24,35,55,64, 81,104,113, 92,
    49,64,78,87,103,121,120,101,
    72,92,95,98,112,100,103, 99
};
static const uint8_t BASE_CHR_QT[64] = {
    17,18,24,47,99,99,99,99,
    18,21,26,66,99,99,99,99,
    24,26,56,99,99,99,99,99,
    47,66,99,99,99,99,99,99,
    99,99,99,99,99,99,99,99,
    99,99,99,99,99,99,99,99,
    99,99,99,99,99,99,99,99,
    99,99,99,99,99,99,99,99
};

/* Zigzag scan: position k -> linear index (row*8+col) in the 8x8 block */
static const int ZIGZAG[64] = {
     0, 1, 8,16, 9, 2, 3,10,
    17,24,32,25,18,11, 4, 5,
    12,19,26,33,40,48,41,34,
    27,20,13, 6, 7,14,21,28,
    35,42,49,56,57,50,43,36,
    29,22,15,23,30,37,44,51,
    58,59,52,45,38,31,39,46,
    53,60,61,54,47,55,62,63
};

/* ── Huffman table ── */
typedef struct { uint32_t code[256]; int size[256]; } HuffTab;

static void build_huff(HuffTab *ht, const uint8_t *bits,
                        const uint8_t *vals, int nvals)
{
    memset(ht, 0, sizeof *ht);
    uint32_t code = 0;
    int idx = 0;
    for (int len = 1; len <= 16 && idx < nvals; len++) {
        for (int k = 0; k < (int)bits[len] && idx < nvals; k++, idx++) {
            ht->code[vals[idx]] = code++;
            ht->size[vals[idx]] = len;
        }
        code <<= 1;
    }
}

/* ── Bit-stream writer with 0xFF byte stuffing ── */
typedef struct { FILE *fp; uint8_t buf; int fill; } BitBuf;

static void bb_init(BitBuf *b, FILE *fp) { b->fp=fp; b->buf=0; b->fill=0; }

static void bb_emit(BitBuf *b, uint8_t byte) {
    fputc(byte, b->fp);
    if (byte == 0xFF) fputc(0x00, b->fp);
}

static void bb_write(BitBuf *b, uint32_t bits, int n) {
    for (int i = n-1; i >= 0; i--) {
        b->buf = (uint8_t)((b->buf << 1) | ((bits >> i) & 1));
        if (++b->fill == 8) { bb_emit(b, b->buf); b->buf=0; b->fill=0; }
    }
}

static void bb_flush(BitBuf *b) {
    if (b->fill > 0) {
        b->buf <<= (8 - b->fill);
        bb_emit(b, b->buf);
        b->buf=0; b->fill=0;
    }
}

/* ── Forward DCT (reference definition, correct) ── */
static void fdct(const float in[8][8], float out[8][8]) {
    static const double PI        = 3.14159265358979323846;
    static const double INV_SQRT2 = 0.70710678118654752440;
    for (int u = 0; u < 8; u++) {
        double cu = (u == 0) ? INV_SQRT2 : 1.0;
        for (int v = 0; v < 8; v++) {
            double cv = (v == 0) ? INV_SQRT2 : 1.0;
            double s  = 0.0;
            for (int x = 0; x < 8; x++)
                for (int y = 0; y < 8; y++)
                    s += in[x][y]
                       * cos((2*x+1)*u*PI/16.0)
                       * cos((2*y+1)*v*PI/16.0);
            out[u][v] = (float)(0.25 * cu * cv * s);
        }
    }
}

/* ── Encode one 8x8 block ── */
static void encode_block(BitBuf *bb, const float blk[8][8],
                          int *prev_dc, const uint8_t *qt,
                          const HuffTab *dc_ht, const HuffTab *ac_ht)
{
    float F[8][8];
    fdct(blk, F);

    int coeff[64];
    for (int k = 0; k < 64; k++) {
        int zz = ZIGZAG[k];
        coeff[k] = (int)roundf(F[zz/8][zz%8] / (float)qt[k]);
    }

    /* DC coefficient */
    int diff = coeff[0] - *prev_dc;
    *prev_dc = coeff[0];
    int absd = diff < 0 ? -diff : diff;
    int cat  = 0;
    while ((1 << cat) <= absd) cat++;
    bb_write(bb, dc_ht->code[cat], dc_ht->size[cat]);
    if (cat > 0) {
        bb_write(bb, (uint32_t)(diff >= 0 ? diff : diff+(1<<cat)-1), cat);
    }

    /* AC coefficients */
    int run = 0;
    for (int k = 1; k < 64; k++) {
        int ac = coeff[k];
        if (ac == 0) {
            if (++run == 16) {
                bb_write(bb, ac_ht->code[0xF0], ac_ht->size[0xF0]); /* ZRL */
                run = 0;
            }
        } else {
            int absa = ac < 0 ? -ac : ac;
            int size = 0;
            while ((1 << size) <= absa) size++;
            int sym  = (run << 4) | size;
            bb_write(bb, ac_ht->code[sym], ac_ht->size[sym]);
            bb_write(bb, (uint32_t)(ac >= 0 ? ac : ac+(1<<size)-1), size);
            run = 0;
        }
    }
    if (run > 0)
        bb_write(bb, ac_ht->code[0x00], ac_ht->size[0x00]); /* EOB */
}

/* ── JPEG marker helpers ── */
static void put16(FILE *fp, uint16_t v) { fputc(v>>8,fp); fputc(v&0xFF,fp); }

static void write_APP0(FILE *fp) {
    put16(fp,0xFFE0); put16(fp,16);
    fputs("JFIF",fp); fputc(0,fp);
    put16(fp,0x0101); fputc(0,fp);
    put16(fp,1); put16(fp,1);
    fputc(0,fp); fputc(0,fp);
}

static void write_DQT(FILE *fp, const uint8_t *qt, int id) {
    put16(fp,0xFFDB); put16(fp,2+1+64);
    fputc((uint8_t)id,fp); fwrite(qt,1,64,fp);
}

static void write_SOF0(FILE *fp, int w, int h) {
    put16(fp,0xFFC0); put16(fp,2+1+2+2+1+9);
    fputc(8,fp); put16(fp,(uint16_t)h); put16(fp,(uint16_t)w); fputc(3,fp);
    fputc(1,fp); fputc(0x11,fp); fputc(0,fp);
    fputc(2,fp); fputc(0x11,fp); fputc(1,fp);
    fputc(3,fp); fputc(0x11,fp); fputc(1,fp);
}

static void write_DHT(FILE *fp, const uint8_t *bits, const uint8_t *vals,
                       int nvals, int tc, int id) {
    put16(fp,0xFFC4); put16(fp,(uint16_t)(2+1+16+nvals));
    fputc((uint8_t)((tc<<4)|id),fp);
    fwrite(bits+1,1,16,fp); fwrite(vals,1,nvals,fp);
}

static void write_SOS(FILE *fp) {
    put16(fp,0xFFDA); put16(fp,2+1+6+3);
    fputc(3,fp);
    fputc(1,fp); fputc(0x00,fp);
    fputc(2,fp); fputc(0x11,fp);
    fputc(3,fp); fputc(0x11,fp);
    fputc(0,fp); fputc(63,fp); fputc(0,fp);
}

/* ── Scale quantisation table by quality ── */
static void scale_qt(uint8_t *out, const uint8_t *base, int q) {
    if (q < 1) q=1; else if (q>100) q=100;
    int s = (q < 50) ? (5000/q) : (200-2*q);
    for (int i=0;i<64;i++) {
        int v = ((int)base[i]*s+50)/100;
        out[i] = (uint8_t)(v<1?1:(v>255?255:v));
    }
}

static int count_vals(const uint8_t *bits) {
    int n=0; for(int i=1;i<=16;i++) n+=bits[i]; return n;
}

/* ── BMP loader ── */
static Image *load_bmp(const char *path) {
    FILE *fp = fopen(path,"rb");
    if (!fp) { perror(path); return NULL; }

    BmpFileHdr fh; BmpInfoHdr ih;
    if (fread(&fh,sizeof fh,1,fp)!=1 || fread(&ih,sizeof ih,1,fp)!=1) {
        fprintf(stderr,"Cannot read BMP headers\n"); fclose(fp); return NULL;
    }
    if (fh.bfType != 0x4D42) {
        fprintf(stderr,"Not a BMP file\n"); fclose(fp); return NULL;
    }
    if (ih.biBitCount!=24 && ih.biBitCount!=32) {
        fprintf(stderr,"Only 24-bit/32-bit BMP supported\n"); fclose(fp); return NULL;
    }
    if (ih.biCompression!=0) {
        fprintf(stderr,"Compressed BMP not supported\n"); fclose(fp); return NULL;
    }

    int w    = ih.biWidth;
    int h    = abs(ih.biHeight);
    int flip = (ih.biHeight > 0);
    int bpp  = ih.biBitCount/8;
    int row  = (w*bpp+3)&~3;

    Image *img = (Image*)malloc(sizeof *img);
    if (!img) { fclose(fp); return NULL; }
    img->w=w; img->h=h;
    img->rgb = (uint8_t*)malloc((size_t)w*h*3);
    uint8_t *rowbuf = (uint8_t*)malloc(row);
    if (!img->rgb || !rowbuf) {
        free(img->rgb); free(rowbuf); free(img); fclose(fp); return NULL;
    }

    fseek(fp,(long)fh.bfOffBits,SEEK_SET);
    for (int y=0; y<h; y++) {
        if (fread(rowbuf,1,(size_t)row,fp)!=(size_t)row) {
            fprintf(stderr,"Truncated BMP data\n");
            free(rowbuf); free(img->rgb); free(img); fclose(fp); return NULL;
        }
        int dy = flip ? (h-1-y) : y;
        uint8_t *dst = img->rgb + dy*w*3;
        for (int x=0; x<w; x++) {
            dst[x*3+0] = rowbuf[x*bpp+2]; /* R */
            dst[x*3+1] = rowbuf[x*bpp+1]; /* G */
            dst[x*3+2] = rowbuf[x*bpp+0]; /* B */
        }
    }
    free(rowbuf); fclose(fp);
    return img;
}

/* ── JPEG saver ── */
static int save_jpeg(const Image *img, const char *path, int quality) {
    FILE *fp = fopen(path,"wb");
    if (!fp) { perror(path); return -1; }

    uint8_t lum_qt[64], chr_qt[64];
    scale_qt(lum_qt, BASE_LUM_QT, quality);
    scale_qt(chr_qt, BASE_CHR_QT, quality);

    int nDCL=count_vals(DC_LUM_BITS), nDCC=count_vals(DC_CHR_BITS);
    int nACL=count_vals(AC_LUM_BITS), nACC=count_vals(AC_CHR_BITS);

    HuffTab ht_dcL, ht_dcC, ht_acL, ht_acC;
    build_huff(&ht_dcL, DC_LUM_BITS, DC_LUM_VALS, nDCL);
    build_huff(&ht_dcC, DC_CHR_BITS, DC_CHR_VALS, nDCC);
    build_huff(&ht_acL, AC_LUM_BITS, AC_LUM_VALS, nACL);
    build_huff(&ht_acC, AC_CHR_BITS, AC_CHR_VALS, nACC);

    put16(fp,0xFFD8);   /* SOI */
    write_APP0(fp);
    write_DQT(fp, lum_qt, 0);
    write_DQT(fp, chr_qt, 1);
    write_SOF0(fp, img->w, img->h);
    write_DHT(fp, DC_LUM_BITS, DC_LUM_VALS, nDCL, 0, 0);
    write_DHT(fp, DC_CHR_BITS, DC_CHR_VALS, nDCC, 0, 1);
    write_DHT(fp, AC_LUM_BITS, AC_LUM_VALS, nACL, 1, 0);
    write_DHT(fp, AC_CHR_BITS, AC_CHR_VALS, nACC, 1, 1);
    write_SOS(fp);

    BitBuf bb; bb_init(&bb,fp);
    int dc_Y=0, dc_Cb=0, dc_Cr=0;
    int W=img->w, H=img->h;
    int PW=(W+7)&~7, PH=(H+7)&~7;

    for (int by=0; by<PH; by+=8) {
        for (int bx=0; bx<PW; bx+=8) {
            float Y[8][8], Cb[8][8], Cr[8][8];
            for (int dy=0; dy<8; dy++) {
                int py = by+dy; if (py>=H) py=H-1;
                for (int dx=0; dx<8; dx++) {
                    int px = bx+dx; if (px>=W) px=W-1;
                    float R = img->rgb[(py*W+px)*3+0];
                    float G = img->rgb[(py*W+px)*3+1];
                    float B = img->rgb[(py*W+px)*3+2];
                    Y [dy][dx] =  0.29900f*R + 0.58700f*G + 0.11400f*B - 128.0f;
                    Cb[dy][dx] = -0.16874f*R - 0.33126f*G + 0.50000f*B;
                    Cr[dy][dx] =  0.50000f*R - 0.41869f*G - 0.08131f*B;
                }
            }
            encode_block(&bb,  Y, &dc_Y,  lum_qt, &ht_dcL, &ht_acL);
            encode_block(&bb, Cb, &dc_Cb, chr_qt, &ht_dcC, &ht_acC);
            encode_block(&bb, Cr, &dc_Cr, chr_qt, &ht_dcC, &ht_acC);
        }
    }
    bb_flush(&bb);
    put16(fp,0xFFD9);   /* EOI */
    fclose(fp);
    return 0;
}

/* ── main ── */
int main(int argc, char *argv[]) {
    if (argc < 3) {
        fprintf(stderr,"Usage: %s  input.bmp  output.jpg  [quality 1-100]\n", argv[0]);
        return 1;
    }
    int q = (argc >= 4) ? atoi(argv[3]) : 75;
    if (q<1||q>100) { fprintf(stderr,"Quality must be 1-100\n"); return 1; }

    printf("Loading  : %s\n", argv[1]);
    Image *img = load_bmp(argv[1]);
    if (!img) return 1;
    printf("Size     : %d x %d\n", img->w, img->h);
    printf("Saving   : %s  (quality=%d)\n", argv[2], q);

    int rc = save_jpeg(img, argv[2], q);
    printf(rc==0 ? "Done.\n" : "Error writing JPEG.\n");
    free(img->rgb); free(img);
    return rc;
}