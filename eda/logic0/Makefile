CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -pedantic -g
LDFLAGS =

TARGET = verilog_qm
SRCS = main.c verilog_lexer.c verilog_parser.c verilog_qm.c qm.c
OBJS = $(SRCS:.c=.o)

.PHONY: all clean test

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

verilog_lexer.o: verilog_lexer.c verilog_lexer.h
verilog_parser.o: verilog_parser.c verilog_parser.h verilog_lexer.h verilog_ast.h
verilog_qm.o: verilog_qm.c verilog_qm.h verilog_ast.h qm.h
qm.o: qm.c qm.h
main.o: main.c verilog_parser.h verilog_qm.h qm.h

clean:
	rm -f $(TARGET) $(OBJS)

test: $(TARGET)
	./test.sh