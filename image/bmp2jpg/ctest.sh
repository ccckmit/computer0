set -x
gcc -O2 -o bmp2jpg bmp2jpg.c -lm
./bmp2jpg img/test.bmp img/test.jpg          # 預設 quality=75
# ./bmp2jpg input.bmp output.jpg 90       # 高品質
# ./bmp2jpg input.bmp output.jpg 50       # 較小檔案