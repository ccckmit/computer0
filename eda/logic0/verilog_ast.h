#ifndef VERILOG_AST_H
#define VERILOG_AST_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef enum {
    AST_MODULE,
    AST_PORT_INPUT,
    AST_PORT_OUTPUT,
    AST_WIRE,
    AST_REG,
    AST_ASSIGN,
    AST_BINARY_OP,
    AST_UNARY_OP,
    AST_IDENTIFIER,
    AST_NUMBER,
    AST_CONCAT,
    AST_UNARY_REDUCE
} ASTNodeType;

typedef enum {
    OP_AND,
    OP_OR,
    OP_XOR,
    OP_NAND,
    OP_NOR,
    OP_XNOR,
    OP_NOT,
    OP_BUF,
    OP_NEG,
    OP_LAND,
    OP_LOR,
    OP_EQ,
    OP_NEQ,
    OP_LT,
    OP_GT,
    OP_LE,
    OP_GE,
    OP_ADD,
    OP_SUB,
    OP_MUL,
    OP_DIV,
    OP_MOD,
    OP_POW,
    OP_SHL,
    OP_SHR,
    REDUCE_AND,
    REDUCE_OR,
    REDUCE_XOR,
    REDUCE_NAND,
    REDUCE_NOR,
    REDUCE_XNOR
} OperatorType;

typedef struct ASTNode {
    ASTNodeType type;
    char *name;
    int line;
    int col;
    struct ASTNode *next;

    union {
        struct {
            char *module_name;
            struct ASTNode *ports;
            struct ASTNode *body;
        } module;

        struct {
            char *name;
            int width;
        } port;

        struct {
            char *name;
            int width;
        } wire;

        struct {
            char *lhs;
            struct ASTNode *rhs;
        } assign;

        struct {
            OperatorType op;
            struct ASTNode *left;
            struct ASTNode *right;
        } binary_op;

        struct {
            OperatorType op;
            struct ASTNode *operand;
        } unary_op;

        struct {
            char *name;
        } identifier;

        struct {
            unsigned int value;
            int width;
        } number;

        struct {
            struct ASTNode *list;
        } concat;

        struct {
            OperatorType op;
            char *name;
        } unary_reduce;
    };
} ASTNode;

typedef struct {
    char *name;
    ASTNode *root;
} VerilogAST;

void ast_free(ASTNode *node);
void ast_print(ASTNode *node, int indent);
VerilogAST *verilog_ast_create(void);
void verilog_ast_free(VerilogAST *ast);

#endif