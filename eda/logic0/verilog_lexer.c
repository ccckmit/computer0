#include "verilog_lexer.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define LexerTokenQueue Lexer

static bool is_identifier_start(char c) {
    return isalpha(c) || c == '_' || c == '$';
}

static bool is_identifier_char(char c) {
    return isalnum(c) || c == '_' || c == '$';
}

static void lexer_append_token(Lexer *lexer, Token *tok) {
    tok->next = NULL;
    if (!lexer->head) {
        lexer->head = tok;
        lexer->tail = tok;
    } else {
        lexer->tail->next = tok;
        lexer->tail = tok;
    }
}

static Token *lexer_make_token(Lexer *lexer, TokenType type, const char *lexeme) {
    Token *tok = (Token *)malloc(sizeof(Token));
    tok->type = type;
    tok->lexeme = strdup(lexeme);
    tok->value = 0;
    tok->width = 0;
    tok->line = lexer->line;
    tok->col = lexer->col;
    tok->next = NULL;
    return tok;
}

static void lexer_advance(Lexer *lexer) {
    if (lexer->pos < lexer->length) {
        if (lexer->source[lexer->pos] == '\n') {
            lexer->line++;
            lexer->col = 1;
        } else {
            lexer->col++;
        }
        lexer->pos++;
    }
}

static char lexer_peek(Lexer *lexer) {
    if (lexer->pos < lexer->length) {
        return lexer->source[lexer->pos];
    }
    return '\0';
}

static char lexer_peek_next(Lexer *lexer) {
    if (lexer->pos + 1 < lexer->length) {
        return lexer->source[lexer->pos + 1];
    }
    return '\0';
}

static bool lexer_match(Lexer *lexer, char expected) {
    if (lexer_peek(lexer) == expected) {
        lexer_advance(lexer);
        return true;
    }
    return false;
}

static void skip_whitespace_and_comments(Lexer *lexer) {
    while (lexer->pos < lexer->length) {
        char c = lexer_peek(lexer);

        if (c == '/') {
            if (lexer_peek_next(lexer) == '/') {
                while (lexer->pos < lexer->length && lexer_peek(lexer) != '\n') {
                    lexer_advance(lexer);
                }
                continue;
            } else if (lexer_peek_next(lexer) == '*') {
                lexer_advance(lexer);
                lexer_advance(lexer);
                while (lexer->pos < lexer->length) {
                    if (lexer_peek(lexer) == '*' && lexer_peek_next(lexer) == '/') {
                        lexer_advance(lexer);
                        lexer_advance(lexer);
                        break;
                    }
                    lexer_advance(lexer);
                }
                continue;
            }
        }

        if (c == ' ' || c == '\t' || c == '\r' || c == '\n') {
            lexer_advance(lexer);
            continue;
        }

        break;
    }
}

bool is_keyword(const char *str) {
    static const char *keywords[] = {
        "module", "endmodule",
        "input", "output", "inout",
        "wire", "reg",
        "assign",
        "not", "and", "or", "xor", "nand", "nor", "xnor",
        "buf",
        "posedge", "negedge",
        "always", "assign",
        "begin", "end",
        "if", "else",
        "case", "endcase",
        "default",
        "signed", "unsigned",
        NULL
    };

    for (int i = 0; keywords[i]; i++) {
        if (strcmp(str, keywords[i]) == 0) {
            return true;
        }
    }
    return false;
}

TokenType keyword_to_token(const char *str) {
    if (strcmp(str, "module") == 0) return TOKEN_MODULE;
    if (strcmp(str, "endmodule") == 0) return TOKEN_ENDMODULE;
    if (strcmp(str, "input") == 0) return TOKEN_INPUT;
    if (strcmp(str, "output") == 0) return TOKEN_OUTPUT;
    if (strcmp(str, "inout") == 0) return TOKEN_INOUT;
    if (strcmp(str, "wire") == 0) return TOKEN_WIRE;
    if (strcmp(str, "reg") == 0) return TOKEN_REG;
    if (strcmp(str, "assign") == 0) return TOKEN_ASSIGN;
    if (strcmp(str, "not") == 0) return TOKEN_EXCLAIM;
    if (strcmp(str, "and") == 0) return TOKEN_AMPERSAND;
    if (strcmp(str, "or") == 0) return TOKEN_PIPE;
    if (strcmp(str, "xor") == 0) return TOKEN_CARET;
    return TOKEN_IDENTIFIER;
}

static void read_identifier(Lexer *lexer, Token **out_tok) {
    size_t start = lexer->pos;
    int start_col = lexer->col;

    while (lexer->pos < lexer->length && is_identifier_char(lexer_peek(lexer))) {
        lexer_advance(lexer);
    }

    size_t len = lexer->pos - start;
    char *lexeme = (char *)malloc(len + 1);
    strncpy(lexeme, &lexer->source[start], len);
    lexeme[len] = '\0';

    Token *tok = lexer_make_token(lexer, TOKEN_IDENTIFIER, lexeme);
    tok->col = start_col;

    if (is_keyword(lexeme)) {
        tok->type = keyword_to_token(lexeme);
    }

    free(lexeme);
    *out_tok = tok;
}

static void read_number(Lexer *lexer, Token **out_tok) {
    size_t start = lexer->pos;
    int start_col = lexer->col;
    int width = 0;
    bool has_width = false;
    unsigned int value = 0;

    if (lexer_peek(lexer) == '\'') {
        lexer_advance(lexer);

        if (toupper(lexer_peek(lexer)) == 'B') {
            lexer_advance(lexer);
            has_width = true;
            while (lexer_peek(lexer) == '0' || lexer_peek(lexer) == '1' || lexer_peek(lexer) == 'x' || lexer_peek(lexer) == 'z') {
                char c = lexer_peek(lexer);
                value = (value << 1) | ((c == '1') ? 1 : (c == 'x' || c == 'z') ? 0 : 0);
                lexer_advance(lexer);
            }
        } else if (toupper(lexer_peek(lexer)) == 'D') {
            lexer_advance(lexer);
            has_width = true;
            while (isdigit(lexer_peek(lexer))) {
                value = value * 10 + (lexer_peek(lexer) - '0');
                lexer_advance(lexer);
            }
        } else if (toupper(lexer_peek(lexer)) == 'H') {
            lexer_advance(lexer);
            has_width = true;
            while (isxdigit(lexer_peek(lexer))) {
                char c = lexer_peek(lexer);
                value = (value << 4) + (isdigit(c) ? c - '0' : toupper(c) - 'A' + 10);
                lexer_advance(lexer);
            }
        } else if (toupper(lexer_peek(lexer)) == 'O') {
            lexer_advance(lexer);
            has_width = true;
            while (lexer_peek(lexer) >= '0' && lexer_peek(lexer) <= '7') {
                value = (value << 3) + (lexer_peek(lexer) - '0');
                lexer_advance(lexer);
            }
        } else if (isdigit(lexer_peek(lexer))) {
            has_width = true;
            while (isdigit(lexer_peek(lexer))) {
                value = value * 10 + (lexer_peek(lexer) - '0');
                lexer_advance(lexer);
            }
        }
    } else {
        while (isdigit(lexer_peek(lexer))) {
            value = value * 10 + (lexer_peek(lexer) - '0');
            lexer_advance(lexer);
        }
    }

    size_t len = lexer->pos - start;
    char *lexeme = (char *)malloc(len + 1);
    strncpy(lexeme, &lexer->source[start], len);
    lexeme[len] = '\0';

    Token *tok = lexer_make_token(lexer, TOKEN_NUMBER, lexeme);
    tok->col = start_col;
    tok->value = value;
    tok->width = has_width ? width : 32;

    free(lexeme);
    *out_tok = tok;
}

void lexer_tokenize(Lexer *lexer) {
    while (lexer->pos < lexer->length) {
        skip_whitespace_and_comments(lexer);

        if (lexer->pos >= lexer->length) break;

        Token *tok = NULL;
        char c = lexer_peek(lexer);
        int start_col = lexer->col;

        switch (c) {
        case '(':
            tok = lexer_make_token(lexer, TOKEN_LPAREN, "(");
            lexer_advance(lexer);
            break;
        case ')':
            tok = lexer_make_token(lexer, TOKEN_RPAREN, ")");
            lexer_advance(lexer);
            break;
        case '[':
            tok = lexer_make_token(lexer, TOKEN_LBRACKET, "[");
            lexer_advance(lexer);
            break;
        case ']':
            tok = lexer_make_token(lexer, TOKEN_RBRACKET, "]");
            lexer_advance(lexer);
            break;
        case '{':
            tok = lexer_make_token(lexer, TOKEN_LBRACE, "{");
            lexer_advance(lexer);
            break;
        case '}':
            tok = lexer_make_token(lexer, TOKEN_RBRACE, "}");
            lexer_advance(lexer);
            break;
        case ',':
            tok = lexer_make_token(lexer, TOKEN_COMMA, ",");
            lexer_advance(lexer);
            break;
        case ';':
            tok = lexer_make_token(lexer, TOKEN_SEMICOLON, ";");
            lexer_advance(lexer);
            break;
        case ':':
            tok = lexer_make_token(lexer, TOKEN_COLON, ":");
            lexer_advance(lexer);
            break;
        case '.':
            tok = lexer_make_token(lexer, TOKEN_DOT, ".");
            lexer_advance(lexer);
            break;
        case '@':
            tok = lexer_make_token(lexer, TOKEN_AT, "@");
            lexer_advance(lexer);
            break;
        case '#':
            tok = lexer_make_token(lexer, TOKEN_POUND, "#");
            lexer_advance(lexer);
            break;
        case '?':
            tok = lexer_make_token(lexer, TOKEN_QUESTION, "?");
            lexer_advance(lexer);
            break;
        case '+':
            tok = lexer_make_token(lexer, TOKEN_PLUS, "+");
            lexer_advance(lexer);
            break;
        case '-':
            tok = lexer_make_token(lexer, TOKEN_MINUS, "-");
            lexer_advance(lexer);
            break;
        case '*':
            tok = lexer_make_token(lexer, TOKEN_STAR, "*");
            lexer_advance(lexer);
            break;
        case '/':
            tok = lexer_make_token(lexer, TOKEN_SLASH, "/");
            lexer_advance(lexer);
            break;
        case '%':
            tok = lexer_make_token(lexer, TOKEN_PERCENT, "%");
            lexer_advance(lexer);
            break;
        case '^':
            tok = lexer_make_token(lexer, TOKEN_CARET, "^");
            lexer_advance(lexer);
            break;
        case '~':
            tok = lexer_make_token(lexer, TOKEN_TILDE, "~");
            lexer_advance(lexer);
            break;
        case '!':
            tok = lexer_make_token(lexer, TOKEN_EXCLAIM, "!");
            lexer_advance(lexer);
            break;
        case '=':
            if (lexer_peek_next(lexer) == '=') {
                tok = lexer_make_token(lexer, TOKEN_EQ, "==");
                lexer_advance(lexer);
                lexer_advance(lexer);
            } else {
                tok = lexer_make_token(lexer, TOKEN_EQUAL, "=");
                lexer_advance(lexer);
            }
            break;
        case '<':
            if (lexer_peek_next(lexer) == '=') {
                tok = lexer_make_token(lexer, TOKEN_LE, "<=");
                lexer_advance(lexer);
                lexer_advance(lexer);
            } else if (lexer_peek_next(lexer) == '<') {
                tok = lexer_make_token(lexer, TOKEN_SHL, "<<");
                lexer_advance(lexer);
                lexer_advance(lexer);
            } else if (lexer_peek_next(lexer) == '>') {
                tok = lexer_make_token(lexer, TOKEN_NEQ, "<>");
                lexer_advance(lexer);
                lexer_advance(lexer);
            } else {
                tok = lexer_make_token(lexer, TOKEN_LT, "<");
                lexer_advance(lexer);
            }
            break;
        case '>':
            if (lexer_peek_next(lexer) == '=') {
                tok = lexer_make_token(lexer, TOKEN_GE, ">=");
                lexer_advance(lexer);
                lexer_advance(lexer);
            } else if (lexer_peek_next(lexer) == '>') {
                tok = lexer_make_token(lexer, TOKEN_SHR, ">>");
                lexer_advance(lexer);
                lexer_advance(lexer);
            } else {
                tok = lexer_make_token(lexer, TOKEN_GT, ">");
                lexer_advance(lexer);
            }
            break;
        case '&':
            if (lexer_peek_next(lexer) == '&') {
                tok = lexer_make_token(lexer, TOKEN_LAND, "&&");
                lexer_advance(lexer);
                lexer_advance(lexer);
            } else if (lexer_peek_next(lexer) == '&') {
                tok = lexer_make_token(lexer, TOKEN_LAND, "&&");
                lexer_advance(lexer);
                lexer_advance(lexer);
            } else {
                tok = lexer_make_token(lexer, TOKEN_AMPERSAND, "&");
                lexer_advance(lexer);
            }
            break;
        case '|':
            if (lexer_peek_next(lexer) == '|') {
                tok = lexer_make_token(lexer, TOKEN_LOR, "||");
                lexer_advance(lexer);
                lexer_advance(lexer);
            } else {
                tok = lexer_make_token(lexer, TOKEN_PIPE, "|");
                lexer_advance(lexer);
            }
            break;
        case '\'':
            read_number(lexer, &tok);
            break;
        default:
            if (isdigit(c)) {
                read_number(lexer, &tok);
            } else if (is_identifier_start(c)) {
                read_identifier(lexer, &tok);
            } else {
                tok = lexer_make_token(lexer, TOKEN_ERROR, &lexer->source[lexer->pos]);
                lexer_advance(lexer);
            }
            break;
        }

        if (tok) {
            tok->col = start_col;
            lexer_append_token(lexer, tok);
        }
    }

    Token *eof = lexer_make_token(lexer, TOKEN_EOF, "EOF");
    lexer_append_token(lexer, eof);
}

Lexer *lexer_create(const char *source) {
    Lexer *lexer = (Lexer *)malloc(sizeof(Lexer));
    lexer->source = source;
    lexer->length = strlen(source);
    lexer->pos = 0;
    lexer->line = 1;
    lexer->col = 1;
    lexer->head = NULL;
    lexer->tail = NULL;
    return lexer;
}

void lexer_free(Lexer *lexer) {
    Token *current = lexer->head;
    while (current) {
        Token *next = current->next;
        free(current->lexeme);
        free(current);
        current = next;
    }
    free(lexer);
}

void lexer_print_tokens(Lexer *lexer) {
    Token *tok = lexer->head;
    while (tok) {
        printf("[%d:%d] %s", tok->line, tok->col,
               tok->type == TOKEN_IDENTIFIER ? "IDENT" :
               tok->type == TOKEN_NUMBER ? "NUMBER" :
               tok->type == TOKEN_EOF ? "EOF" :
               tok->lexeme);
        if (tok->type == TOKEN_NUMBER) {
            printf("(%d)", tok->value);
        }
        printf("\n");
        tok = tok->next;
    }
}