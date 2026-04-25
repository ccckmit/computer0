#include "verilog_qm.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

ModuleInfo *get_module_info(ASTNode *module) {
    if (!module || module->type != AST_MODULE) return NULL;

    ModuleInfo *info = calloc(1, sizeof(ModuleInfo));
    if (!info) return NULL;

    size_t input_cap = 16, output_cap = 16;
    info->input_names = malloc(input_cap * sizeof(char *));
    info->output_names = malloc(output_cap * sizeof(char *));

    ASTNode *port = module->module.ports;
    while (port) {
        if (port->type == AST_PORT_INPUT) {
            if (info->input_count >= input_cap) {
                input_cap *= 2;
                info->input_names = realloc(info->input_names, input_cap * sizeof(char *));
            }
            info->input_names[info->input_count++] = strdup(port->port.name);
        } else if (port->type == AST_PORT_OUTPUT) {
            if (info->output_count >= output_cap) {
                output_cap *= 2;
                info->output_names = realloc(info->output_names, output_cap * sizeof(char *));
            }
            info->output_names[info->output_count++] = strdup(port->port.name);
        }
        port = port->next;
    }

    return info;
}

void module_info_free(ModuleInfo *info) {
    if (!info) return;
    for (size_t i = 0; i < info->input_count; i++) free(info->input_names[i]);
    for (size_t i = 0; i < info->output_count; i++) free(info->output_names[i]);
    free(info->input_names);
    free(info->output_names);
    free(info);
}

static bool is_operator_node(ASTNodeType type) {
    return type == AST_BINARY_OP || type == AST_UNARY_OP || type == AST_UNARY_REDUCE;
}

static int get_var_index(LogicFunction *func, const char *name) {
    for (size_t i = 0; i < func->var_count; i++) {
        if (strcmp(func->var_names[i], name) == 0) {
            return (int)i;
        }
    }
    return -1;
}

static bool eval_binary_op(OperatorType op, bool left, bool right) {
    switch (op) {
        case OP_AND: return left && right;
        case OP_OR: return left || right;
        case OP_XOR: return left != right;
        case OP_LAND: return left && right;
        case OP_LOR: return left || right;
        case OP_EQ: return left == right;
        case OP_NEQ: return left != right;
        default: return false;
    }
}

static bool eval_unary_op(OperatorType op, bool val) {
    switch (op) {
        case OP_NOT: return !val;
        case OP_NEG: return !val;
        default: return val;
    }
}

static bool eval_identifier(ASTNode *node, uint32_t input_values, LogicFunction *func) {
    if (!node || node->type != AST_IDENTIFIER) return false;
    int idx = get_var_index(func, node->identifier.name);
    if (idx < 0) return false;
    return (input_values >> idx) & 1;
}

static bool eval_number(ASTNode *node) {
    if (!node || node->type != AST_NUMBER) return false;
    return node->number.value != 0;
}

bool evaluate_expression(ASTNode *expr, uint32_t input_values, LogicFunction *func) {
    if (!expr) return false;

    switch (expr->type) {
        case AST_IDENTIFIER:
            return eval_identifier(expr, input_values, func);

        case AST_NUMBER:
            return eval_number(expr);

        case AST_BINARY_OP:
            return eval_binary_op(
                expr->binary_op.op,
                evaluate_expression(expr->binary_op.left, input_values, func),
                evaluate_expression(expr->binary_op.right, input_values, func)
            );

        case AST_UNARY_OP:
            return eval_unary_op(
                expr->unary_op.op,
                evaluate_expression(expr->unary_op.operand, input_values, func)
            );

        default:
            return false;
    }
}

static ASTNode *find_assign_by_lhs(ASTNode *body, const char *lhs_name) {
    ASTNode *current = body;
    while (current) {
        if (current->type == AST_ASSIGN && current->assign.lhs &&
            strcmp(current->assign.lhs, lhs_name) == 0) {
            return current;
        }

        if (current->type == AST_MODULE && current->module.body) {
            ASTNode *found = find_assign_by_lhs(current->module.body, lhs_name);
            if (found) return found;
        }

        if (current->next) {
            current = current->next;
        } else if (current->type == AST_ASSIGN || current->type == AST_WIRE) {
            current = NULL;
        } else {
            current = current->next;
        }
    }
    return NULL;
}

LogicFunction *extract_logic_function(ASTNode *module) {
    if (!module || module->type != AST_MODULE) return NULL;

    LogicFunction *func = calloc(1, sizeof(LogicFunction));
    if (!func) return NULL;

    ModuleInfo *info = get_module_info(module);
    func->var_count = info->input_count;
    func->var_names = info->input_names;
    func->n_vars = (uint32_t)info->input_count;

    func->input_names = info->input_names;
    func->output_names = info->output_names;

    size_t output_cap = 16;
    func->minterms = malloc(output_cap * sizeof(uint32_t));
    func->minterm_count = 0;

    ASTNode *body = module->module.body;
    ASTNode *assign = body;

    if (info->output_count > 0) {
        const char *output_name = info->output_names[0];
        while (assign) {
            if (assign->type == AST_ASSIGN && assign->assign.lhs &&
                strcmp(assign->assign.lhs, output_name) == 0) {
                break;
            }
            assign = (ASTNode *)assign->module.next;
        }

        if (assign && assign->type == AST_ASSIGN) {
            uint32_t max_combos = 1u << func->n_vars;
            for (uint32_t v = 0; v < max_combos; v++) {
                bool result = evaluate_expression(assign->assign.rhs, v, func);
                if (result) {
                    if (func->minterm_count >= output_cap) {
                        output_cap *= 2;
                        func->minterms = realloc(func->minterms, output_cap * sizeof(uint32_t));
                    }
                    func->minterms[func->minterm_count++] = v;
                }
            }
        }
    }

    free(info);
    return func;
}

void logic_function_free(LogicFunction *func) {
    if (!func) return;
    for (size_t i = 0; i < func->var_count; i++) {
        free(func->var_names[i]);
    }
    free(func->var_names);
    free(func->minterms);
    free(func);
}

char *logic_to_verilog(LogicFunction *input_func, QMOutput *qm_out, ModuleInfo *info) {
    static char buf[8192];
    buf[0] = '\0';

    snprintf(buf, sizeof(buf), "// Simplified module\n");
    snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf),
             "// Inputs: ");
    for (size_t i = 0; i < input_func->var_count; i++) {
        if (i > 0) snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), ", ");
        snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), "%s", input_func->var_names[i]);
    }
    snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), "\n");

    if (info && info->output_count > 0) {
        snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf),
                 "// Output: %s\n", info->output_names[0]);
    }

    snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), "// Minterms: ");
    for (size_t i = 0; i < input_func->minterm_count; i++) {
        if (i > 0) snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), ", ");
        snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), "%u", input_func->minterms[i]);
    }
    snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), "\n\n");

    snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), "module simplified(");

    for (size_t i = 0; i < input_func->var_count; i++) {
        if (i > 0) snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), ", ");
        snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), "input %s", input_func->var_names[i]);
    }
    if (info && info->output_count > 0) {
        snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), ", output %s", info->output_names[0]);
    }
    snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), ");\n\n");

    if (info && info->output_count > 0) {
        snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), "assign %s = ", info->output_names[0]);
        for (size_t i = 0; i < qm_out->count; i++) {
            if (i > 0) snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), " | ");
            uint32_t mask = qm_out->terms[i] >> 16;
            uint32_t value = qm_out->terms[i] & 0xFFFF;

            bool first = true;
            for (size_t bit = 0; bit < input_func->var_count; bit++) {
                if (mask & (1u << bit)) continue;
                if (!first) snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), " & ");
                first = false;

                if (value & (1u << bit)) {
                    snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), "%s", input_func->var_names[bit]);
                } else {
                    snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), "~%s", input_func->var_names[bit]);
                }
            }
        }
        snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), ";\n");
    }

    snprintf(buf + strlen(buf), sizeof(buf) - strlen(buf), "endmodule\n");
    return buf;
}