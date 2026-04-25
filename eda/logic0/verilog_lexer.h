#ifndef VERILOG_LEXER_H
#define VERILOG_LEXER_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef enum {
    TOKEN_EOF,
    TOKEN_IDENTIFIER,
    TOKEN_NUMBER,
    TOKEN_STRING,

    TOKEN_MODULE,
    TOKEN_ENDMODULE,
    TOKEN_INPUT,
    TOKEN_OUTPUT,
    TOKEN_INOUT,
    TOKEN_WIRE,
    TOKEN_REG,
    TOKEN_ASSIGN,

    TOKEN_LPAREN,
    TOKEN_RPAREN,
    TOKEN_LBRACKET,
    TOKEN_RBRACKET,
    TOKEN_LBRACE,
    TOKEN_RBRACE,

    TOKEN_COMMA,
    TOKEN_SEMICOLON,
    TOKEN_COLON,
    TOKEN_DOT,
    TOKEN_EQUAL,
    TOKEN_AT,

    TOKEN_PLUS,
    TOKEN_MINUS,
    TOKEN_STAR,
    TOKEN_SLASH,
    TOKEN_PERCENT,

    TOKEN_AMPERSAND,
    TOKEN_PIPE,
    TOKEN_CARET,
    TOKEN_TILDE,
    TOKEN_EXCLAIM,

    TOKEN_LAND,
    TOKEN_LOR,
    TOKEN_NAND,
    TOKEN_NOR,
    TOKEN_XNOR,

    TOKEN_EQ,
    TOKEN_NEQ,
    TOKEN_LT,
    TOKEN_GT,
    TOKEN_LE,
    TOKEN_GE,

    TOKEN_SHL,
    TOKEN_SHR,

    TOKEN_QUESTION,
    TOKEN_POUND,

    TOKEN_NEWLINE,
    TOKEN_SPACE,
    TOKEN_COMMENT,
    TOKEN_ERROR
} TokenType;

typedef struct Token {
    TokenType type;
    char *lexeme;
    int value;
    int width;
    int line;
    int col;
    struct Token *next;
} Token;

typedef struct {
    const char *source;
    size_t length;
    size_t pos;
    int line;
    int col;
    Token *head;
    Token *tail;
} Lexer;

Lexer *lexer_create(const char *source);
void lexer_free(Lexer *lexer);
void lexer_tokenize(Lexer *lexer);
void lexer_print_tokens(Lexer *lexer);

bool is_keyword(const char *str);
TokenType keyword_to_token(const char *str);

#endif