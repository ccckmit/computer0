#ifndef VERILOG_PARSER_H
#define VERILOG_PARSER_H

#include "verilog_lexer.h"
#include "verilog_ast.h"

typedef struct {
    Lexer *lexer;
    Token *current;
    Token *previous;
    bool had_error;
    char error_msg[256];
} Parser;

Parser *parser_create(Lexer *lexer);
void parser_free(Parser *parser);
ASTNode *parser_parse(Parser *parser);
ASTNode *parser_parse_module(Parser *parser);
bool parser_check(Parser *parser, TokenType type);
bool parser_match(Parser *parser, TokenType type);
bool parser_match_any(Parser *parser, int count, ...);
ASTNode *parser_expect(Parser *parser, TokenType type, const char *message);
void parser_advance(Parser *parser);
void parser_sync(Parser *parser);

ASTNode *parse_expression(Parser *parser);
ASTNode *parse_assignment_expression(Parser *parser);
ASTNode *parse_logical_or_expression(Parser *parser);
ASTNode *parse_logical_and_expression(Parser *parser);
ASTNode *parse_bitwise_or_expression(Parser *parser);
ASTNode *parse_bitwise_nor_expression(Parser *parser);
ASTNode *parse_bitwise_xor_expression(Parser *parser);
ASTNode *parse_bitwise_xnor_expression(Parser *parser);
ASTNode *parse_bitwise_and_expression(Parser *parser);
ASTNode *parse_bitwise_nand_expression(Parser *parser);
ASTNode *parse_equality_expression(Parser *parser);
ASTNode *parse_relational_expression(Parser *parser);
ASTNode *parse_shift_expression(Parser *parser);
ASTNode *parse_additive_expression(Parser *parser);
ASTNode *parse_multiplicative_expression(Parser *parser);
ASTNode *parse_unary_expression(Parser *parser);
ASTNode *parse_postfix_expression(Parser *parser);
ASTNode *parse_primary_expression(Parser *parser);

VerilogAST *verilog_parse(const char *source);

#endif