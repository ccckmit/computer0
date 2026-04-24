set -x

# ffmpeg -i test.m4a test.mp3

gcc audio.c -o audio -I$(brew --prefix)/include -L$(brew --prefix)/lib -lmp3lame -lm
# gcc audio.c -o audio -lmp3lame -lm

# 1. 查看 MP3 資訊
./audio test.mp3

# 2. 真實轉換為 WAV
./audio test.mp3 -o test.wav

# 3. 檢查轉換出來的 WAV 資訊
./audio test.wav

# 4. 轉換回 mp3
./audio test.wav -o test2.mp3
