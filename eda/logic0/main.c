#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "verilog_parser.h"
#include "verilog_qm.h"
#include "qm.h"

static void print_usage(const char *prog) {
    fprintf(stderr, "Usage: %s [options] <verilog_file>\n", prog);
    fprintf(stderr, "Options:\n");
    fprintf(stderr, "  -v <verilog_string>  Verilog code as string (use quotes)\n");
    fprintf(stderr, "  -f <file>           Read Verilog from file\n");
    fprintf(stderr, "  --minterms          Show minterms\n");
    fprintf(stderr, "  --full              Show full details\n");
}

int main(int argc, char *argv[]) {
    bool show_minterms = false;
    bool show_full = false;
    char *verilog_source = NULL;
    char *file_path = NULL;

    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-v") == 0 && i + 1 < argc) {
            verilog_source = argv[++i];
        } else if (strcmp(argv[i], "-f") == 0 && i + 1 < argc) {
            file_path = argv[++i];
        } else if (strcmp(argv[i], "--minterms") == 0) {
            show_minterms = true;
        } else if (strcmp(argv[i], "--full") == 0) {
            show_full = true;
        } else if (strcmp(argv[i], "-h") == 0 || strcmp(argv[i], "--help") == 0) {
            print_usage(argv[0]);
            return 0;
        }
    }

    if (!verilog_source && !file_path) {
        fprintf(stderr, "Error: either -v or -f must be specified\n");
        print_usage(argv[0]);
        return 1;
    }

    if (file_path) {
        FILE *f = fopen(file_path, "r");
        if (!f) {
            fprintf(stderr, "Error: cannot open file %s\n", file_path);
            return 1;
        }

        fseek(f, 0, SEEK_END);
        long len = ftell(f);
        fseek(f, 0, SEEK_SET);

        verilog_source = (char *)malloc(len + 1);
        fread(verilog_source, 1, len, f);
        verilog_source[len] = '\0';
        fclose(f);
    }

    printf("=== Verilog QM Simplifier ===\n\n");
    printf("Input Verilog:\n%s\n\n", verilog_source);

    VerilogAST *ast = verilog_parse(verilog_source);
    if (!ast || !ast->root) {
        fprintf(stderr, "Error: failed to parse Verilog\n");
        if (file_path) free(verilog_source);
        return 1;
    }

    if (show_full) {
        printf("Parsed AST:\n");
        ast_print(ast->root, 0);
        printf("\n");
    }

    ModuleInfo *info = get_module_info(ast->root);
    if (!info) {
        fprintf(stderr, "Error: failed to extract module info\n");
        verilog_ast_free(ast);
        if (file_path) free(verilog_source);
        return 1;
    }

    printf("Module: %s\n", ast->name);
    printf("Inputs (%zu): ", info->input_count);
    for (size_t i = 0; i < info->input_count; i++) {
        if (i > 0) printf(", ");
        printf("%s", info->input_names[i]);
    }
    printf("\n");
    printf("Outputs (%zu): ", info->output_count);
    for (size_t i = 0; i < info->output_count; i++) {
        if (i > 0) printf(", ");
        printf("%s", info->output_names[i]);
    }
    printf("\n\n");

    LogicFunction *func = extract_logic_function(ast->root);
    if (!func) {
        fprintf(stderr, "Error: failed to extract logic function\n");
        module_info_free(info);
        verilog_ast_free(ast);
        if (file_path) free(verilog_source);
        return 1;
    }

    if (show_minterms || show_full) {
        printf("Minterms (%zu): ", func->minterm_count);
        for (size_t i = 0; i < func->minterm_count; i++) {
            if (i > 0) printf(", ");
            printf("%u", func->minterms[i]);
        }
        printf("\n\n");
    }

    if (func->minterm_count == 0) {
        printf("Output: Constant 0\n");
    } else if (func->minterm_count == (size_t)(1u << func->n_vars)) {
        printf("Output: Constant 1\n");
    } else {
        QMInput qm_input;
        qm_input.minterms = func->minterms;
        qm_input.count = (size_t)func->minterm_count;
        qm_input.n_vars = func->n_vars;

        QMOutput *qm_out = qm_simplify(&qm_input);

        printf("Prime Implicants:\n");
        for (size_t i = 0; i < qm_out->count; i++) {
            uint32_t mask = qm_out->terms[i] >> 16;
            uint32_t value = qm_out->terms[i] & 0xFFFF;
            printf("  %s\n", qm_implicant_to_string(mask, value, func->n_vars));
        }
        printf("\n");

        printf("Simplified Expression:\n  ");
        for (size_t i = 0; i < qm_out->count; i++) {
            if (i > 0) printf(" | ");
            uint32_t mask = qm_out->terms[i] >> 16;
            uint32_t value = qm_out->terms[i] & 0xFFFF;

            bool first = true;
            for (size_t bit = 0; bit < func->n_vars; bit++) {
                if (mask & (1u << bit)) continue;
                if (!first) printf(" & ");
                first = false;

                if (value & (1u << bit)) {
                    printf("%s", func->var_names[bit]);
                } else {
                    printf("~%s", func->var_names[bit]);
                }
            }
        }
        printf("\n\n");

        printf("Simplified Verilog:\n");
        char *verilog_out = logic_to_verilog(func, qm_out, info);
        printf("%s", verilog_out);

        qm_free_output(qm_out);
    }

    logic_function_free(func);
    module_info_free(info);
    verilog_ast_free(ast);
    if (file_path) free(verilog_source);

    return 0;
}