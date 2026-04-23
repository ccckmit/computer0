# ssl0

Minimalist SSL framework in C.

## Build & Test

- No Makefile/build system; compilation via `gcc -I include` in shell scripts
- Run all tests: `./test.sh` (runs `*_test.sh` scripts)
- Run single test: `./<module>_test.sh` (e.g., `./ssl_test.sh`)
- Each `*_test.sh` script compiles and runs its test from scratch

## Structure

- Source: `src/`, Headers: `include/`, Tests: `test/`
- `https/` contains an HTTP server (`httpd_ssl0`) using ssl0
- Entry points: `src/ssl.c`, `src/ssl_socket.c`

## Running HTTPS Server

```bash
./https_server.sh  # builds and runs on port 8443
```

## Notes

- Tests in `test/` are git-tracked (not in `.gitignore`)
- Some scripts output Chinese text