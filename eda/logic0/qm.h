#ifndef QM_H
#define QM_H

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

typedef struct {
    uint32_t *minterms;
    size_t count;
    uint32_t n_vars;
} QMInput;

typedef struct {
    uint32_t *terms;
    size_t count;
} QMOutput;

typedef struct {
    uint32_t mask;
    uint32_t value;
    uint32_t n_vars;
    uint64_t covered;
} QMImplicant;

QMOutput *qm_simplify(QMInput *input);
void qm_free_output(QMOutput *output);
char *qm_implicant_to_string(uint32_t mask, uint32_t value, uint32_t n_vars);
char *qm_output_to_string(QMOutput *output, uint32_t n_vars);

#endif