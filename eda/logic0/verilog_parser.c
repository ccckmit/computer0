#include "verilog_parser.h"
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

Parser *parser_create(Lexer *lexer) {
    Parser *parser = (Parser *)malloc(sizeof(Parser));
    parser->lexer = lexer;
    parser->current = NULL;
    parser->previous = NULL;
    parser->had_error = false;
    parser->error_msg[0] = '\0';

    lexer_tokenize(lexer);
    parser->current = lexer->head;
    return parser;
}

void parser_free(Parser *parser) {
    (void)parser;
}

void parser_advance(Parser *parser) {
    parser->previous = parser->current;
    if (parser->current) {
        parser->current = parser->current->next;
    }
}

bool parser_check(Parser *parser, TokenType type) {
    if (!parser->current || parser->current->type == TOKEN_EOF) {
        return false;
    }
    return parser->current->type == type;
}

bool parser_match(Parser *parser, TokenType type) {
    if (parser_check(parser, type)) {
        parser_advance(parser);
        return true;
    }
    return false;
}

bool parser_match_any(Parser *parser, int count, ...) {
    va_list args;
    va_start(args, count);
    for (int i = 0; i < count; i++) {
        TokenType type = va_arg(args, TokenType);
        if (parser_check(parser, type)) {
            parser_advance(parser);
            va_end(args);
            return true;
        }
    }
    va_end(args);
    return false;
}

ASTNode *parser_expect(Parser *parser, TokenType type, const char *message) {
    if (parser_check(parser, type)) {
        ASTNode *node = (ASTNode *)malloc(sizeof(ASTNode));
        memset(node, 0, sizeof(ASTNode));
        node->type = AST_IDENTIFIER;
        node->name = strdup(parser->current->lexeme);
        node->line = parser->current->line;
        node->col = parser->current->col;
        parser_advance(parser);
        return node;
    }

    parser->had_error = true;
    if (message) {
        snprintf(parser->error_msg, sizeof(parser->error_msg),
                 "Error at %d:%d: expected %s, got %s",
                 parser->current->line, parser->current->col,
                 message, parser->current->lexeme);
    }
    return NULL;
}

void parser_sync(Parser *parser) {
    while (parser->current && parser->current->type != TOKEN_EOF) {
        if (parser->previous && parser->previous->type == TOKEN_SEMICOLON) {
            return;
        }

        if (parser_match_any(parser, 4, TOKEN_MODULE, TOKEN_INPUT, TOKEN_OUTPUT, TOKEN_WIRE)) {
            return;
        }

        parser_advance(parser);
    }
}

static ASTNode *make_ast_node(ASTNodeType type) {
    ASTNode *node = (ASTNode *)malloc(sizeof(ASTNode));
    memset(node, 0, sizeof(ASTNode));
    node->type = type;
    return node;
}

static void parser_error(Parser *parser, const char *message) {
    parser->had_error = true;
    snprintf(parser->error_msg, sizeof(parser->error_msg),
             "Error at %d:%d: %s",
             parser->current->line, parser->current->col, message);
}

static ASTNode *parse_port_list(Parser *parser) {
    ASTNode *head = NULL;
    ASTNode *tail = NULL;

    while (parser_check(parser, TOKEN_IDENTIFIER)) {
        ASTNode *port = make_ast_node(AST_PORT_INPUT);
        port->identifier.name = strdup(parser->current->lexeme);
        port->line = parser->current->line;
        port->col = parser->current->col;
        parser_advance(parser);

        if (!head) {
            head = port;
        } else {
            tail->next = port;
        }
        tail = port;

        if (!parser_match(parser, TOKEN_COMMA)) {
            break;
        }
    }

    return head;
}

static ASTNode *parse_port_declaration(Parser *parser, TokenType port_type) {
    int width = 1;
    bool has_width = false;

    if (parser_match(parser, TOKEN_LBRACKET)) {
        has_width = true;
        if (parser_check(parser, TOKEN_NUMBER)) {
            width = parser->current->value + 1;
        }
        parser_advance(parser);
        parser_expect(parser, TOKEN_RBRACKET, "]");
    }

    ASTNodeType node_type = (port_type == TOKEN_INPUT) ? AST_PORT_INPUT :
                            (port_type == TOKEN_OUTPUT) ? AST_PORT_OUTPUT : AST_PORT_INPUT;

    ASTNode *port = make_ast_node(node_type);
    port->port.width = width;
    port->line = parser->previous ? parser->previous->line : 0;
    port->col = parser->previous ? parser->previous->col : 0;

    if (parser_check(parser, TOKEN_IDENTIFIER)) {
        port->port.name = strdup(parser->current->lexeme);
        parser_advance(parser);
    }

    return port;
}

static ASTNode *parse_wire_declaration(Parser *parser) {
    ASTNode *wire = make_ast_node(AST_WIRE);
    wire->wire.width = 1;
    wire->line = parser->previous ? parser->previous->line : 0;
    wire->col = parser->previous ? parser->previous->col : 0;

    if (parser_match(parser, TOKEN_LBRACKET)) {
        if (parser_check(parser, TOKEN_NUMBER)) {
            wire->wire.width = parser->current->value + 1;
        }
        parser_advance(parser);
        parser_expect(parser, TOKEN_RBRACKET, "]");
    }

    if (parser_check(parser, TOKEN_IDENTIFIER)) {
        wire->wire.name = strdup(parser->current->lexeme);
        parser_advance(parser);
    }

    return wire;
}

static ASTNode *parse_unary_operator(Parser *parser) {
    if (parser_match(parser, TOKEN_EXCLAIM)) return make_ast_node(AST_UNARY_OP);
    if (parser_match(parser, TOKEN_TILDE)) return make_ast_node(AST_UNARY_OP);
    if (parser_match(parser, TOKEN_MINUS)) return make_ast_node(AST_UNARY_OP);
    if (parser_match(parser, TOKEN_PLUS)) return make_ast_node(AST_UNARY_OP);
    if (parser_match(parser, TOKEN_AMPERSAND)) return make_ast_node(AST_UNARY_REDUCE);
    if (parser_match(parser, TOKEN_PIPE)) return make_ast_node(AST_UNARY_REDUCE);
    if (parser_match(parser, TOKEN_CARET)) return make_ast_node(AST_UNARY_REDUCE);
    if (parser_match(parser, TOKEN_NAND)) return make_ast_node(AST_UNARY_REDUCE);
    if (parser_match(parser, TOKEN_NOR)) return make_ast_node(AST_UNARY_REDUCE);
    return NULL;
}

ASTNode *parse_primary_expression(Parser *parser) {
    if (parser_match(parser, TOKEN_LPAREN)) {
        ASTNode *expr = parse_expression(parser);
        parser_expect(parser, TOKEN_RPAREN, ")");
        return expr;
    }

    if (parser_check(parser, TOKEN_NUMBER)) {
        ASTNode *num = make_ast_node(AST_NUMBER);
        num->number.value = parser->current->value;
        num->number.width = 32;
        parser_advance(parser);
        return num;
    }

    if (parser_check(parser, TOKEN_IDENTIFIER)) {
        ASTNode *ident = make_ast_node(AST_IDENTIFIER);
        ident->identifier.name = strdup(parser->current->lexeme);
        ident->line = parser->current->line;
        ident->col = parser->current->col;
        parser_advance(parser);
        return ident;
    }

    parser_error(parser, "Expected expression");
    return NULL;
}

static OperatorType token_to_operator(TokenType type) {
    switch (type) {
        case TOKEN_AMPERSAND: return OP_AND;
        case TOKEN_PIPE: return OP_OR;
        case TOKEN_CARET: return OP_XOR;
        case TOKEN_EXCLAIM:
        case TOKEN_TILDE: return OP_NOT;
        case TOKEN_LAND: return OP_LAND;
        case TOKEN_LOR: return OP_LOR;
        case TOKEN_EQ: return OP_EQ;
        case TOKEN_NEQ: return OP_NEQ;
        case TOKEN_LT: return OP_LT;
        case TOKEN_GT: return OP_GT;
        case TOKEN_LE: return OP_LE;
        case TOKEN_GE: return OP_GE;
        case TOKEN_PLUS: return OP_ADD;
        case TOKEN_MINUS: return OP_SUB;
        case TOKEN_STAR: return OP_MUL;
        case TOKEN_SLASH: return OP_DIV;
        case TOKEN_PERCENT: return OP_MOD;
        case TOKEN_SHL: return OP_SHL;
        case TOKEN_SHR: return OP_SHR;
        default: return OP_AND;
    }
}

ASTNode *parse_unary_expression(Parser *parser) {
    if (parser_match_any(parser, 4, TOKEN_EXCLAIM, TOKEN_TILDE, TOKEN_MINUS, TOKEN_PLUS)) {
        TokenType op = parser->previous->type;
        ASTNode *operand = parse_unary_expression(parser);
        ASTNode *node = make_ast_node(AST_UNARY_OP);
        node->unary_op.op = (op == TOKEN_EXCLAIM || op == TOKEN_TILDE) ? OP_NOT : (op == TOKEN_MINUS ? OP_NEG : OP_BUF);
        node->unary_op.operand = operand;
        return node;
    }

    return parse_postfix_expression(parser);
}

ASTNode *parse_postfix_expression(Parser *parser) {
    ASTNode *expr = parse_primary_expression(parser);

    while (parser_match(parser, TOKEN_LBRACKET)) {
        ASTNode *index = parse_expression(parser);
        parser_expect(parser, TOKEN_RBRACKET, "]");

        ASTNode *binop = make_ast_node(AST_BINARY_OP);
        binop->binary_op.op = OP_SHR;
        binop->binary_op.left = expr;
        binop->binary_op.right = index;
        expr = binop;
    }

    return expr;
}

ASTNode *parse_multiplicative_expression(Parser *parser) {
    ASTNode *left = parse_unary_expression(parser);

    while (parser_match_any(parser, 3, TOKEN_STAR, TOKEN_SLASH, TOKEN_PERCENT)) {
        TokenType op = parser->previous->type;
        ASTNode *right = parse_unary_expression(parser);
        ASTNode *node = make_ast_node(AST_BINARY_OP);
        node->binary_op.op = token_to_operator(op);
        node->binary_op.left = left;
        node->binary_op.right = right;
        left = node;
    }

    return left;
}

ASTNode *parse_additive_expression(Parser *parser) {
    ASTNode *left = parse_multiplicative_expression(parser);

    while (parser_match_any(parser, 2, TOKEN_PLUS, TOKEN_MINUS)) {
        TokenType op = parser->previous->type;
        ASTNode *right = parse_multiplicative_expression(parser);
        ASTNode *node = make_ast_node(AST_BINARY_OP);
        node->binary_op.op = token_to_operator(op);
        node->binary_op.left = left;
        node->binary_op.right = right;
        left = node;
    }

    return left;
}

ASTNode *parse_shift_expression(Parser *parser) {
    ASTNode *left = parse_additive_expression(parser);

    while (parser_match_any(parser, 2, TOKEN_SHL, TOKEN_SHR)) {
        TokenType op = parser->previous->type;
        ASTNode *right = parse_additive_expression(parser);
        ASTNode *node = make_ast_node(AST_BINARY_OP);
        node->binary_op.op = token_to_operator(op);
        node->binary_op.left = left;
        node->binary_op.right = right;
        left = node;
    }

    return left;
}

ASTNode *parse_relational_expression(Parser *parser) {
    ASTNode *left = parse_shift_expression(parser);

    while (parser_match_any(parser, 4, TOKEN_LT, TOKEN_GT, TOKEN_LE, TOKEN_GE)) {
        TokenType op = parser->previous->type;
        ASTNode *right = parse_shift_expression(parser);
        ASTNode *node = make_ast_node(AST_BINARY_OP);
        node->binary_op.op = token_to_operator(op);
        node->binary_op.left = left;
        node->binary_op.right = right;
        left = node;
    }

    return left;
}

ASTNode *parse_equality_expression(Parser *parser) {
    ASTNode *left = parse_relational_expression(parser);

    while (parser_match_any(parser, 2, TOKEN_EQ, TOKEN_NEQ)) {
        TokenType op = parser->previous->type;
        ASTNode *right = parse_relational_expression(parser);
        ASTNode *node = make_ast_node(AST_BINARY_OP);
        node->binary_op.op = token_to_operator(op);
        node->binary_op.left = left;
        node->binary_op.right = right;
        left = node;
    }

    return left;
}

ASTNode *parse_bitwise_and_expression(Parser *parser) {
    ASTNode *left = parse_equality_expression(parser);

    while (parser_match(parser, TOKEN_AMPERSAND)) {
        ASTNode *right = parse_equality_expression(parser);
        ASTNode *node = make_ast_node(AST_BINARY_OP);
        node->binary_op.op = OP_AND;
        node->binary_op.left = left;
        node->binary_op.right = right;
        left = node;
    }

    return left;
}

ASTNode *parse_bitwise_xor_expression(Parser *parser) {
    ASTNode *left = parse_bitwise_and_expression(parser);

    while (parser_match(parser, TOKEN_CARET)) {
        ASTNode *right = parse_bitwise_and_expression(parser);
        ASTNode *node = make_ast_node(AST_BINARY_OP);
        node->binary_op.op = OP_XOR;
        node->binary_op.left = left;
        node->binary_op.right = right;
        left = node;
    }

    return left;
}

ASTNode *parse_bitwise_or_expression(Parser *parser) {
    ASTNode *left = parse_bitwise_xor_expression(parser);

    while (parser_match(parser, TOKEN_PIPE)) {
        ASTNode *right = parse_bitwise_xor_expression(parser);
        ASTNode *node = make_ast_node(AST_BINARY_OP);
        node->binary_op.op = OP_OR;
        node->binary_op.left = left;
        node->binary_op.right = right;
        left = node;
    }

    return left;
}

ASTNode *parse_logical_and_expression(Parser *parser) {
    ASTNode *left = parse_bitwise_or_expression(parser);

    while (parser_match(parser, TOKEN_LAND)) {
        ASTNode *right = parse_bitwise_or_expression(parser);
        ASTNode *node = make_ast_node(AST_BINARY_OP);
        node->binary_op.op = OP_LAND;
        node->binary_op.left = left;
        node->binary_op.right = right;
        left = node;
    }

    return left;
}

ASTNode *parse_logical_or_expression(Parser *parser) {
    ASTNode *left = parse_logical_and_expression(parser);

    while (parser_match(parser, TOKEN_LOR)) {
        ASTNode *right = parse_logical_and_expression(parser);
        ASTNode *node = make_ast_node(AST_BINARY_OP);
        node->binary_op.op = OP_LOR;
        node->binary_op.left = left;
        node->binary_op.right = right;
        left = node;
    }

    return left;
}

ASTNode *parse_expression(Parser *parser) {
    return parse_logical_or_expression(parser);
}

ASTNode *parse_assignment_expression(Parser *parser) {
    if (parser_check(parser, TOKEN_IDENTIFIER)) {
        ASTNode *lhs = make_ast_node(AST_IDENTIFIER);
        lhs->identifier.name = strdup(parser->current->lexeme);
        parser_advance(parser);

        if (parser_match(parser, TOKEN_EQUAL)) {
            ASTNode *rhs = parse_expression(parser);
            ASTNode *assign = make_ast_node(AST_ASSIGN);
            assign->assign.lhs = strdup(lhs->identifier.name);
            assign->assign.rhs = rhs;
            ast_free(lhs);
            return assign;
        }
    }
    return parse_expression(parser);
}

static ASTNode *parse_module_body(Parser *parser) {
    ASTNode *head = NULL;
    ASTNode *tail = NULL;

    while (!parser_check(parser, TOKEN_ENDMODULE) && parser->current->type != TOKEN_EOF) {
        ASTNode *item = NULL;

        if (parser_match(parser, TOKEN_INPUT)) {
            item = parse_port_declaration(parser, TOKEN_INPUT);
            while (parser_match(parser, TOKEN_COMMA)) {
                ASTNode *next = parse_port_declaration(parser, TOKEN_INPUT);
                if (!head) {
                    head = item;
                } else {
                    tail->port.next = item;
                }
                tail = item;
                item = next;
            }
        } else if (parser_match(parser, TOKEN_OUTPUT)) {
            item = parse_port_declaration(parser, TOKEN_OUTPUT);
            while (parser_match(parser, TOKEN_COMMA)) {
                ASTNode *next = parse_port_declaration(parser, TOKEN_OUTPUT);
                if (!head) {
                    head = item;
                } else {
                    tail->port.next = item;
                }
                tail = item;
                item = next;
            }
        } else if (parser_match(parser, TOKEN_WIRE)) {
            item = parse_wire_declaration(parser);
        } else if (parser_match(parser, TOKEN_ASSIGN)) {
            ASTNode *lhs = NULL;
            if (parser_check(parser, TOKEN_IDENTIFIER)) {
                lhs = make_ast_node(AST_IDENTIFIER);
                lhs->identifier.name = strdup(parser->current->lexeme);
                parser_advance(parser);
            }
            parser_expect(parser, TOKEN_EQUAL, "=");
            ASTNode *rhs = parse_expression(parser);
            parser_expect(parser, TOKEN_SEMICOLON, ";");

            item = make_ast_node(AST_ASSIGN);
            if (lhs) {
                item->assign.lhs = lhs->identifier.name;
                ast_free(lhs);
            } else {
                item->assign.lhs = NULL;
            }
            item->assign.rhs = rhs;
        } else {
            parser_advance(parser);
            continue;
        }

        if (item) {
            if (!head) {
                head = item;
            } else {
                tail->next = item;
            }
            tail = item;
        }

        if (parser_match(parser, TOKEN_SEMICOLON)) {
        }
    }

    return head;
}

ASTNode *parser_parse_module(Parser *parser) {
    ASTNode *module = make_ast_node(AST_MODULE);
    module->line = parser->previous ? parser->previous->line : 0;
    module->col = parser->previous ? parser->previous->col : 0;

    if (parser_check(parser, TOKEN_IDENTIFIER)) {
        module->module.module_name = strdup(parser->current->lexeme);
        parser_advance(parser);
    }

    module->module.ports = parse_port_list(parser);
    parser_expect(parser, TOKEN_SEMICOLON, ";");
    module->module.body = parse_module_body(parser);

    parser_expect(parser, TOKEN_ENDMODULE, "endmodule");

    return module;
}

ASTNode *parser_parse(Parser *parser) {
    if (parser_check(parser, TOKEN_MODULE)) {
        return parser_parse_module(parser);
    }

    if (parser_check(parser, TOKEN_EOF)) {
        return NULL;
    }

    parser_error(parser, "Expected module declaration");
    return NULL;
}

VerilogAST *verilog_parse(const char *source) {
    Lexer *lexer = lexer_create(source);
    Parser *parser = parser_create(lexer);

    ASTNode *root = parser_parse(parser);

    if (parser->had_error) {
        fprintf(stderr, "%s\n", parser->error_msg);
    }

    VerilogAST *ast = (VerilogAST *)malloc(sizeof(VerilogAST));
    ast->name = root ? strdup(root->module.module_name) : NULL;
    ast->root = root;

    lexer_free(lexer);
    free(parser);

    return ast;
}

void ast_free(ASTNode *node) {
    if (!node) return;

    switch (node->type) {
        case AST_MODULE:
            if (node->module.module_name) free(node->module.module_name);
            ast_free(node->module.ports);
            ast_free(node->module.body);
            break;
        case AST_PORT_INPUT:
        case AST_PORT_OUTPUT:
            if (node->port.name) free(node->port.name);
            break;
        case AST_WIRE:
            if (node->wire.name) free(node->wire.name);
            break;
        case AST_ASSIGN:
            if (node->assign.lhs) free(node->assign.lhs);
            ast_free(node->assign.rhs);
            break;
        case AST_BINARY_OP:
            ast_free(node->binary_op.left);
            ast_free(node->binary_op.right);
            break;
        case AST_UNARY_OP:
            ast_free(node->unary_op.operand);
            break;
        case AST_IDENTIFIER:
            if (node->identifier.name) free(node->identifier.name);
            break;
        case AST_NUMBER:
            break;
        case AST_CONCAT:
            ast_free(node->concat.list);
            break;
case AST_UNARY_REDUCE:
        break;
    }

    ast_free(node->next);
    free(node);
}

void ast_print(ASTNode *node, int indent) {
    if (!node) return;

    for (int i = 0; i < indent; i++) printf("  ");

    switch (node->type) {
        case AST_MODULE:
            printf("Module: %s\n", node->module.module_name);
            if (node->module.ports) {
                for (int i = 0; i < indent + 1; i++) printf("  ");
                printf("Ports:\n");
                ast_print(node->module.ports, indent + 2);
            }
            if (node->module.body) {
                for (int i = 0; i < indent + 1; i++) printf("  ");
                printf("Body:\n");
                ast_print(node->module.body, indent + 2);
            }
            break;
case AST_PORT_INPUT:
        printf("Input: %s [%d]\n", node->port.name, node->port.width);
        if (node->next) ast_print(node->next, indent);
        break;
    case AST_PORT_OUTPUT:
        printf("Output: %s [%d]\n", node->port.name, node->port.width);
        if (node->next) ast_print(node->next, indent);
        break;
    case AST_WIRE:
        printf("Wire: %s [%d]\n", node->wire.name, node->wire.width);
        if (node->next) ast_print(node->next, indent);
        break;
        case AST_ASSIGN:
            printf("Assign: %s =\n", node->assign.lhs ? node->assign.lhs : "(implicit)");
            ast_print(node->assign.rhs, indent + 1);
            break;
        case AST_BINARY_OP:
            printf("Binary Op: %d\n", node->binary_op.op);
            ast_print(node->binary_op.left, indent + 1);
            ast_print(node->binary_op.right, indent + 1);
            break;
        case AST_UNARY_OP:
            printf("Unary Op: %d\n", node->unary_op.op);
            ast_print(node->unary_op.operand, indent + 1);
            break;
        case AST_IDENTIFIER:
            printf("Ident: %s\n", node->identifier.name);
            break;
        case AST_NUMBER:
            printf("Number: %u\n", node->number.value);
            break;
        case AST_CONCAT:
            printf("Concat:\n");
            ast_print(node->concat.list, indent + 1);
            break;
        case AST_UNARY_REDUCE:
            printf("Reduce Op: %d %s\n", node->unary_reduce.op, node->unary_reduce.name);
            break;
    }

    if (node->next) ast_print(node->next, indent);
}

void verilog_ast_free(VerilogAST *ast) {
    if (ast) {
        if (ast->name) free(ast->name);
        ast_free(ast->root);
        free(ast);
    }
}