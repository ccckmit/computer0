#include "qm.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

static bool differs_by_one_bit(uint32_t a, uint32_t b) {
    uint32_t diff = a ^ b;
    return diff && (diff & (diff - 1)) == 0;
}

static uint32_t get_diff_bit(uint32_t a, uint32_t b) {
    return a ^ b;
}

static int count_ones(uint32_t x) {
    int cnt = 0;
    while (x) {
        cnt += x & 1;
        x >>= 1;
    }
    return cnt;
}

static uint64_t get_covered_minterms(uint32_t mask, uint32_t value, uint32_t n_vars) {
    uint64_t covered = 0;
    uint32_t max = 1u << n_vars;

    for (uint32_t k = 0; k < max; k++) {
        if ((k & ~mask) == value) {
            covered |= (1ULL << k);
        }
    }
    return covered;
}

static QMImplicant *find_prime_implicants(uint32_t *minterms, size_t n_minterms, uint32_t n_vars, size_t *out_count) {
    size_t capacity = 64;
    size_t count = 0;
    QMImplicant *prims = malloc(capacity * sizeof(QMImplicant));

    for (size_t i = 0; i < n_minterms; i++) {
        QMImplicant p;
        p.mask = 0;
        p.value = minterms[i];
        p.n_vars = n_vars;
        p.covered = 1ULL << minterms[i];
        prims[count++] = p;
    }

    bool changed = true;
    while (changed) {
        changed = false;

        for (size_t i = 0; i < count; i++) {
            for (size_t j = i + 1; j < count; j++) {
                if (prims[i].mask != prims[j].mask) continue;
                if (!differs_by_one_bit(prims[i].value, prims[j].value)) continue;

                uint32_t diff = get_diff_bit(prims[i].value, prims[j].value);
                uint32_t new_mask = prims[i].mask | diff;
                uint32_t new_value = prims[i].value & ~diff;

                bool exists = false;
                for (size_t k = 0; k < count; k++) {
                    if (prims[k].mask == new_mask && prims[k].value == new_value) {
                        exists = true;
                        break;
                    }
                }

                if (!exists) {
                    if (count >= capacity) {
                        capacity *= 2;
                        prims = realloc(prims, capacity * sizeof(QMImplicant));
                    }

                    QMImplicant new_p;
                    new_p.mask = new_mask;
                    new_p.value = new_value;
                    new_p.n_vars = n_vars;
                    new_p.covered = prims[i].covered | prims[j].covered;
                    prims[count++] = new_p;
                    prims[i].covered = 0;
                    prims[j].covered = 0;
                    changed = true;
                }
            }
        }
    }

    size_t new_count = 0;
    for (size_t i = 0; i < count; i++) {
        if (prims[i].covered != 0) {
            prims[new_count++] = prims[i];
        }
    }

    *out_count = new_count;
    return prims;
}

static uint64_t *build_col_covered(QMImplicant *prims, size_t n_prims, uint32_t *minterms, size_t n_minterms, size_t *out_n_cols) {
    *out_n_cols = n_minterms;
    uint64_t *col_covered = malloc(n_minterms * sizeof(uint64_t));

    for (size_t i = 0; i < n_minterms; i++) {
        uint64_t mask = 1ULL << minterms[i];
        col_covered[i] = 0;
        for (size_t j = 0; j < n_prims; j++) {
            if (prims[j].covered & mask) {
                col_covered[i] |= (1ULL << j);
            }
        }
    }
    return col_covered;
}

static uint64_t find_essential_pis(QMImplicant *prims, size_t n_prims, uint64_t *col_covered, size_t n_cols, uint64_t *remaining_cols) {
    uint64_t essential = 0;
    bool changed = true;

    while (changed) {
        changed = false;
        for (size_t col = 0; col < n_cols; col++) {
            if (!(*remaining_cols & (1ULL << col))) continue;

            uint64_t possible = col_covered[col] & ~essential;
            if (possible == 0) continue;

            if ((possible & (possible - 1)) == 0) {
                uint32_t idx = __builtin_ctzll(possible);
                uint64_t pi_mask = 1ULL << idx;
                if (!(essential & pi_mask)) {
                    essential |= pi_mask;
                    for (size_t c = 0; c < n_cols; c++) {
                        if (col_covered[c] & pi_mask) {
                            *remaining_cols &= ~(1ULL << c);
                        }
                    }
                    changed = true;
                }
            }
        }
    }

    return essential;
}

static uint64_t greedy_select(QMImplicant *prims, size_t n_prims, uint64_t *col_covered, size_t n_cols, uint64_t remaining_cols) {
    uint64_t selected = 0;

    while (remaining_cols) {
        uint64_t best_pi = 0;
        int best_cover = -1;

        for (size_t i = 0; i < n_prims; i++) {
            uint64_t pi_mask = 1ULL << i;
            if (selected & pi_mask) continue;

            int cover = 0;
            uint64_t temp = remaining_cols;
            while (temp) {
                size_t col = __builtin_ctzll(temp);
                if (col_covered[col] & pi_mask) {
                    cover++;
                }
                temp &= temp - 1;
            }

            if (cover > best_cover) {
                best_cover = cover;
                best_pi = pi_mask;
            }
        }

        if (best_pi == 0 || best_cover <= 0) break;
        selected |= best_pi;

        uint32_t idx = __builtin_ctzll(best_pi);
        for (size_t c = 0; c < n_cols; c++) {
            if (remaining_cols & (1ULL << c)) {
                if (col_covered[c] & best_pi) {
                    remaining_cols &= ~(1ULL << c);
                }
            }
        }
    }

    return selected;
}

QMOutput *qm_simplify(QMInput *input) {
    if (input->count == 0) {
        QMOutput *out = malloc(sizeof(QMOutput));
        out->terms = NULL;
        out->count = 0;
        return out;
    }

    size_t n_prims = 0;
    QMImplicant *prims = find_prime_implicants(input->minterms, input->count, input->n_vars, &n_prims);

    if (n_prims == 0) {
        QMOutput *out = malloc(sizeof(QMOutput));
        out->terms = NULL;
        out->count = 0;
        return out;
    }

    size_t n_cols;
    uint64_t *col_covered = build_col_covered(prims, n_prims, input->minterms, input->count, &n_cols);

    uint64_t remaining_cols = 0;
    for (size_t i = 0; i < n_cols; i++) {
        remaining_cols |= (1ULL << i);
    }

    uint64_t essential = find_essential_pis(prims, n_prims, col_covered, n_cols, &remaining_cols);
    uint64_t selected = essential | greedy_select(prims, n_prims, col_covered, n_cols, remaining_cols);

    size_t result_count = 0;
    uint32_t *results = malloc(n_prims * sizeof(uint32_t));

    for (size_t i = 0; i < n_prims; i++) {
        if (selected & (1ULL << i)) {
            results[result_count++] = (prims[i].mask << 16) | prims[i].value;
        }
    }

    QMOutput *out = malloc(sizeof(QMOutput));
    out->terms = results;
    out->count = result_count;

    free(col_covered);
    free(prims);

    return out;
}

void qm_free_output(QMOutput *output) {
    if (output) {
        free(output->terms);
        free(output);
    }
}

char *qm_implicant_to_string(uint32_t mask, uint32_t value, uint32_t n_vars) {
    static char buf[64];
    int len = 0;

    uint32_t m = mask & ((1u << n_vars) - 1);
    uint32_t v = value & ((1u << n_vars) - 1);

    for (int i = n_vars - 1; i >= 0; i--) {
        if (m & (1u << i)) {
            buf[len++] = '-';
        } else if (v & (1u << i)) {
            buf[len++] = '1';
        } else {
            buf[len++] = '0';
        }
    }
    buf[len] = '\0';
    return buf;
}

char *qm_output_to_string(QMOutput *output, uint32_t n_vars) {
    static char buf[4096];
    buf[0] = '\0';

    for (size_t i = 0; i < output->count; i++) {
        if (i > 0) strcat(buf, " + ");
        uint32_t mask = output->terms[i] >> 16;
        uint32_t value = output->terms[i] & 0xFFFF;
        strcat(buf, qm_implicant_to_string(mask, value, n_vars));
    }
    return buf;
}