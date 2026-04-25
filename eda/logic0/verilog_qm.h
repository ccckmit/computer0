#ifndef VERILOG_QM_H
#define VERILOG_QM_H

#include "verilog_ast.h"
#include "qm.h"
#include <stdbool.h>

typedef struct {
    char **var_names;
    size_t var_count;
    uint32_t *minterms;
    size_t minterm_count;
    uint32_t n_vars;
} LogicFunction;

LogicFunction *extract_logic_function(ASTNode *module);
void logic_function_free(LogicFunction *func);

typedef struct {
    char **input_names;
    size_t input_count;
    char **output_names;
    size_t output_count;
} ModuleInfo;

ModuleInfo *get_module_info(ASTNode *module);
void module_info_free(ModuleInfo *info);

bool evaluate_expression(ASTNode *expr, uint32_t input_values, LogicFunction *func);

char *logic_to_verilog(LogicFunction *input_func, QMOutput *qm_out, ModuleInfo *info);

#endif