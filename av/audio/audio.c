#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

// 引入 minimp3 (負責解碼)
#define MINIMP3_IMPLEMENTATION
#include "minimp3.h"

// 引入 LAME (負責編碼)
#include <lame/lame.h>

// WAV 標頭結構體 (44 bytes)
#pragma pack(push, 1)
typedef struct {
    char riff[4];
    uint32_t overall_size;
    char wave[4];
    char fmt_chunk_marker[4];
    uint32_t length_of_fmt;
    uint16_t format_type;
    uint16_t channels;
    uint32_t sample_rate;
    uint32_t byterate;
    uint16_t block_align;
    uint16_t bits_per_sample;
    char data_chunk_header[4];
    uint32_t data_size;
} WAVHeader;
#pragma pack(pop)

// 檢查副檔名
int is_ext(const char *filename, const char *ext) {
    const char *dot = strrchr(filename, '.');
    if (!dot || dot == filename) return 0;
    return strcasecmp(dot, ext) == 0;
}

// 1. 印出 WAV 資訊
void print_wav_info(const char *filename) {
    FILE *file = fopen(filename, "rb");
    if (!file) { printf("無法開啟檔案\n"); return; }

    WAVHeader header;
    if (fread(&header, sizeof(WAVHeader), 1, file) == 1 && strncmp(header.riff, "RIFF", 4) == 0) {
        printf("=== WAV 檔案資訊 ===\n");
        printf("檔案名稱: %s\n", filename);
        printf("聲道數量: %d\n", header.channels);
        printf("取 樣 率: %d Hz\n", header.sample_rate);
        printf("位元深度: %d bits\n", header.bits_per_sample);
        printf("====================\n");
    } else {
        printf("格式錯誤。\n");
    }
    fclose(file);
}

// 2. 印出 MP3 資訊 (使用 minimp3)
void print_mp3_info(const char *filename) {
    FILE *f = fopen(filename, "rb");
    if (!f) { printf("無法開啟檔案\n"); return; }
    
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    unsigned char *buf = malloc(size);
    fread(buf, 1, size, f);
    fclose(f);

    mp3dec_t mp3d;
    mp3dec_init(&mp3d);
    mp3dec_frame_info_t info;
    short pcm[MINIMP3_MAX_SAMPLES_PER_FRAME];
    
    mp3dec_decode_frame(&mp3d, buf, size, pcm, &info);

    if (info.frame_bytes > 0) {
        printf("=== MP3 檔案資訊 ===\n");
        printf("檔案名稱: %s\n", filename);
        printf("位 元 率: %d kbps\n", info.bitrate_kbps);
        printf("取 樣 率: %d Hz\n", info.hz);
        printf("聲 道 數: %d\n", info.channels);
        printf("====================\n");
    }
    free(buf);
}

// 3. MP3 轉 WAV (使用 minimp3 解碼)
void mp3_to_wav(const char *in_file, const char *out_file) {
    printf("開始解碼: %s -> %s\n", in_file, out_file);
    
    FILE *f_in = fopen(in_file, "rb");
    if (!f_in) return;
    fseek(f_in, 0, SEEK_END);
    long size = ftell(f_in);
    fseek(f_in, 0, SEEK_SET);
    unsigned char *buf = malloc(size);
    fread(buf, 1, size, f_in);
    fclose(f_in);

    FILE *f_out = fopen(out_file, "wb");
    WAVHeader wav_hdr = {0};
    fwrite(&wav_hdr, sizeof(WAVHeader), 1, f_out);

    mp3dec_t mp3d;
    mp3dec_init(&mp3d);
    mp3dec_frame_info_t info;
    short pcm[MINIMP3_MAX_SAMPLES_PER_FRAME];

    unsigned char *ptr = buf;
    long bytes_left = size;
    long total_samples = 0;
    int sample_rate = 0, channels = 0;

    while (bytes_left > 0) {
        int samples = mp3dec_decode_frame(&mp3d, ptr, bytes_left, pcm, &info);
        if (info.frame_bytes == 0) break;
        if (samples > 0) {
            if (sample_rate == 0) sample_rate = info.hz;
            if (channels == 0) channels = info.channels;
            fwrite(pcm, sizeof(short), samples * info.channels, f_out);
            total_samples += samples;
        }
        ptr += info.frame_bytes;
        bytes_left -= info.frame_bytes;
    }

    if (total_samples > 0) {
        memcpy(wav_hdr.riff, "RIFF", 4);
        memcpy(wav_hdr.wave, "WAVE", 4);
        memcpy(wav_hdr.fmt_chunk_marker, "fmt ", 4);
        wav_hdr.length_of_fmt = 16;
        wav_hdr.format_type = 1;
        wav_hdr.channels = channels;
        wav_hdr.sample_rate = sample_rate;
        wav_hdr.bits_per_sample = 16;
        wav_hdr.byterate = sample_rate * channels * 2;
        wav_hdr.block_align = channels * 2;
        memcpy(wav_hdr.data_chunk_header, "data", 4);
        wav_hdr.data_size = total_samples * channels * 2;
        wav_hdr.overall_size = wav_hdr.data_size + 36;

        fseek(f_out, 0, SEEK_SET);
        fwrite(&wav_hdr, sizeof(WAVHeader), 1, f_out);
        printf("轉換成功！\n");
    }
    fclose(f_out);
    free(buf);
}

// 4. WAV 轉 MP3 (真實實作：使用 LAME 編碼)
void wav_to_mp3(const char *in_file, const char *out_file) {
    printf("開始壓縮: %s -> %s\n", in_file, out_file);

    FILE *wav = fopen(in_file, "rb");
    if (!wav) { printf("無法開啟 WAV 檔案\n"); return; }
    
    WAVHeader header;
    fread(&header, sizeof(WAVHeader), 1, wav);
    if (strncmp(header.riff, "RIFF", 4) != 0) {
        printf("非標準 WAV 檔案。\n");
        fclose(wav);
        return;
    }

    FILE *mp3 = fopen(out_file, "wb");
    if (!mp3) { printf("無法建立 MP3 檔案\n"); fclose(wav); return; }

    // 初始化 LAME 編碼器
    lame_t lame = lame_init();
    lame_set_in_samplerate(lame, header.sample_rate);
    lame_set_num_channels(lame, header.channels);
    lame_set_VBR(lame, vbr_default); // 啟用 VBR (可變位元率) 獲取好音質
    lame_init_params(lame);

    const int PCM_SIZE = 8192;
    const int MP3_SIZE = 8192;
    short pcm_buffer[PCM_SIZE * 2];
    unsigned char mp3_buffer[MP3_SIZE];

    int read, write;
    
    // 讀取 PCM 並壓縮成 MP3
    do {
        // 從 WAV 讀取 PCM 資料
        read = fread(pcm_buffer, sizeof(short) * header.channels, PCM_SIZE, wav);
        if (read == 0) {
            // 讀取完畢，清除 LAME 緩衝區
            write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
        } else {
            // 編碼 PCM
            if (header.channels == 1) { // 單聲道
                write = lame_encode_buffer(lame, pcm_buffer, NULL, read, mp3_buffer, MP3_SIZE);
            } else { // 立體聲交錯資料
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            }
        }
        // 將壓縮後的 MP3 寫入檔案
        if (write > 0) {
            fwrite(mp3_buffer, 1, write, mp3);
        }
    } while (read != 0);

    // 清理資源
    lame_close(lame);
    fclose(mp3);
    fclose(wav);
    printf("轉換成功！\n");
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("用法:\n");
        printf("  %s <file.wav>            # 印出 WAV 資訊\n", argv[0]);
        printf("  %s <file.mp3>            # 印出 MP3 資訊\n", argv[0]);
        printf("  %s <in.wav> -o <out.mp3> # 轉換 WAV 至 MP3\n", argv[0]);
        printf("  %s <in.mp3> -o <out.wav> # 轉換 MP3 至 WAV\n", argv[0]);
        return 1;
    }

    if (argc == 2) {
        if (is_ext(argv[1], ".wav")) print_wav_info(argv[1]);
        else if (is_ext(argv[1], ".mp3")) print_mp3_info(argv[1]);
        else printf("請提供 .wav 或 .mp3 檔案。\n");
    } 
    else if (argc == 4 && strcmp(argv[2], "-o") == 0) {
        if (is_ext(argv[1], ".mp3") && is_ext(argv[3], ".wav")) {
            mp3_to_wav(argv[1], argv[3]);
        } else if (is_ext(argv[1], ".wav") && is_ext(argv[3], ".mp3")) {
            wav_to_mp3(argv[1], argv[3]);
        } else {
            printf("僅支援 MP3 轉 WAV 或 WAV 轉 MP3。\n");
        }
    } else {
        printf("參數錯誤。\n");
    }

    return 0;
}