#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    unsigned int mask;
    unsigned int value;
    unsigned int n_vars;
    unsigned long long covered;
    bool used;
    bool combined;
} Term;

typedef struct {
    Term *terms;
    size_t count;
    size_t capacity;
} TermList;

static TermList new_term_list(void) {
    TermList list = {0};
    list.capacity = 16;
    list.terms = malloc(list.capacity * sizeof(Term));
    if (!list.terms) {
        perror("malloc");
        exit(1);
    }
    return list;
}

static void term_list_push(TermList *list, Term t) {
    if (list->count >= list->capacity) {
        list->capacity *= 2;
        list->terms = realloc(list->terms, list->capacity * sizeof(Term));
        if (!list->terms) {
            perror("realloc");
            exit(1);
        }
    }
    list->terms[list->count++] = t;
}

static void free_term_list(TermList *list) {
    free(list->terms);
    list->terms = NULL;
    list->count = list->capacity = 0;
}

static int count_ones(unsigned int x) {
    int cnt = 0;
    while (x) {
        cnt += x & 1;
        x >>= 1;
    }
    return cnt;
}

static int differs_by_one_bit(unsigned int a, unsigned int b) {
    unsigned int diff = a ^ b;
    return diff && (diff & (diff - 1)) == 0;
}

static char *term_to_string(Term t) {
    static char buf[64];
    int len = 0;
    unsigned int mask = (1u << t.n_vars) - 1;
    unsigned int m = t.mask & mask;
    unsigned int v = t.value & mask;

    for (int i = t.n_vars - 1; i >= 0; i--) {
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

static unsigned long long minterm_to_covered_mask(int m) {
    return 1ULL << m;
}

static unsigned long long term_get_covered(Term t, unsigned int n_vars) {
    unsigned long long covered = 0;
    unsigned int mask = (1u << n_vars) - 1;
    unsigned int m = t.mask & mask;
    unsigned int v = t.value & mask;

    unsigned int max = 1u << n_vars;
    for (unsigned int k = 0; k < max; k++) {
        if ((k & ~m) == v) {
            covered |= (1ULL << k);
        }
    }
    return covered;
}

static void group_and_combine(int *minterms, size_t n_minterms, TermList *prime_implicants, unsigned int n_vars) {
    if (n_minterms == 0) return;

    TermList current = new_term_list();

    for (size_t i = 0; i < n_minterms; i++) {
        Term t;
        t.mask = 0;
        t.value = (unsigned int)minterms[i];
        t.n_vars = n_vars;
        t.used = false;
        t.combined = false;
        t.covered = minterm_to_covered_mask(minterms[i]);
        term_list_push(&current, t);
    }

    for (unsigned int iter = 0; iter < n_vars; iter++) {
        TermList next = new_term_list();
        bool any_combined = false;

        for (size_t i = 0; i < current.count; i++) {
            for (size_t j = i + 1; j < current.count; j++) {
                if (current.terms[i].combined || current.terms[j].combined) continue;
                if (current.terms[i].used || current.terms[j].used) continue;

                unsigned int m1 = current.terms[i].mask;
                unsigned int v1 = current.terms[i].value;
                unsigned int m2 = current.terms[j].mask;
                unsigned int v2 = current.terms[j].value;

                unsigned int diff_mask = v1 ^ v2;

                if (m1 != m2) continue;
                if (!differs_by_one_bit(v1, v2)) continue;

                unsigned int new_mask = m1 | diff_mask;
                unsigned int new_value = v1 & ~diff_mask;

                bool exists = false;
                for (size_t k = 0; k < next.count; k++) {
                    if (next.terms[k].mask == new_mask && next.terms[k].value == new_value) {
                        exists = true;
                        break;
                    }
                }

                if (!exists) {
                    Term new_term;
                    new_term.mask = new_mask;
                    new_term.value = new_value;
                    new_term.n_vars = n_vars;
                    new_term.used = false;
                    new_term.combined = false;
                    new_term.covered = current.terms[i].covered | current.terms[j].covered;
                    term_list_push(&next, new_term);
                }

                current.terms[i].combined = true;
                current.terms[j].combined = true;
                any_combined = true;
            }
        }

        for (size_t i = 0; i < current.count; i++) {
            if (!current.terms[i].combined) {
                bool is_duplicate = false;
                for (size_t k = 0; k < prime_implicants->count; k++) {
                    if (prime_implicants->terms[k].mask == current.terms[i].mask &&
                        prime_implicants->terms[k].value == current.terms[i].value) {
                        is_duplicate = true;
                        break;
                    }
                }
                if (!is_duplicate) {
                    term_list_push(prime_implicants, current.terms[i]);
                }
            }
        }

        free_term_list(&current);
        current = next;

        if (!any_combined) break;
    }

    for (size_t i = 0; i < current.count; i++) {
        if (!current.terms[i].combined) {
            bool is_duplicate = false;
            for (size_t k = 0; k < prime_implicants->count; k++) {
                if (prime_implicants->terms[k].mask == current.terms[i].mask &&
                    prime_implicants->terms[k].value == current.terms[i].value) {
                    is_duplicate = true;
                    break;
                }
            }
            if (!is_duplicate) {
                term_list_push(prime_implicants, current.terms[i]);
            }
        }
    }

    free_term_list(&current);
}

static void find_prime_implicants(int *minterms, size_t n_minterms, TermList *prime_implicants, unsigned int n_vars) {
    TermList mlist = new_term_list();

    for (size_t i = 0; i < n_minterms; i++) {
        Term t;
        t.mask = 0;
        t.value = (unsigned int)minterms[i];
        t.n_vars = n_vars;
        t.covered = minterm_to_covered_mask(minterms[i]);
        t.used = false;
        t.combined = false;
        term_list_push(&mlist, t);
    }

    group_and_combine(minterms, n_minterms, prime_implicants, n_vars);

    for (size_t i = 0; i < prime_implicants->count; i++) {
        prime_implicants->terms[i].covered = term_get_covered(prime_implicants->terms[i], n_vars);
    }

    free_term_list(&mlist);
}

static unsigned long long *build_col_covered(TermList *prime_implicants, int *minterms, size_t n_minterms, size_t *n_cols) {
    *n_cols = n_minterms;
    unsigned long long *col_covered = malloc(n_minterms * sizeof(unsigned long long));
    for (size_t i = 0; i < n_minterms; i++) {
        unsigned long long mask = 1ULL << (__builtin_ctzll(minterm_to_covered_mask(minterms[i])));
        col_covered[i] = 0;
        for (size_t j = 0; j < prime_implicants->count; j++) {
            if (prime_implicants->terms[j].covered & mask) {
                col_covered[i] |= (1ULL << j);
            }
        }
    }
    return col_covered;
}

static unsigned long long find_essential_pis(
    TermList *prime_implicants,
    unsigned long long *col_covered,
    size_t n_cols,
    unsigned long long *remaining_cols
) {
    unsigned long long essential = 0;
    bool changed = true;

    while (changed) {
        changed = false;
        for (size_t col = 0; col < n_cols; col++) {
            if (!(*remaining_cols & (1ULL << col))) continue;

            unsigned long long possible = col_covered[col] & ~essential;
            if (possible == 0) continue;

            if ((possible & (possible - 1)) == 0) {
                unsigned int idx = __builtin_ctzll(possible);
                unsigned long long pi_mask = 1ULL << idx;
                if (!(essential & pi_mask)) {
                    essential |= pi_mask;
for (size_t c = 0; c < n_cols; c++) {
                if (col_covered[c] & (1ULL << idx)) {
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

static unsigned long long greedy_select(
    TermList *prime_implicants,
    unsigned long long *col_covered,
    size_t n_cols,
    unsigned long long remaining_cols
) {
    unsigned long long selected = 0;

    while (remaining_cols) {
        unsigned long long best_pi = 0;
        int best_cover = -1;

        for (size_t i = 0; i < prime_implicants->count; i++) {
            unsigned long long pi_mask = 1ULL << i;
            if (selected & pi_mask) continue;

int cover = 0;
    unsigned long long temp = remaining_cols;
    while (temp) {
        size_t col = __builtin_ctzll(temp);
        if (col_covered[col] & (1ULL << i)) {
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

        size_t idx = __builtin_ctzll(best_pi);
for (size_t c = 0; c < n_cols; c++) {
        if (remaining_cols & (1ULL << c)) {
            if (col_covered[c] & (1ULL << idx)) {
                remaining_cols &= ~(1ULL << c);
            }
        }
    }
    }

    return selected;
}

static int *parse_minterms(const char *str, size_t *out_count, unsigned int *out_n_vars) {
    size_t capacity = 16;
    size_t count = 0;
    int *minterms = malloc(capacity * sizeof(int));
    if (!minterms) return NULL;

    unsigned int max_m = 0;
    const char *p = str;

    while (*p) {
        while (*p == ' ' || *p == '\t') p++;
        if (!*p || *p == '\n') break;

        char *end;
        long val = strtol(p, &end, 10);
        if (end == p) break;

        if (val < 0 || val >= 64) {
            fprintf(stderr, "Error: minterm %ld out of range (0-63)\n", val);
            free(minterms);
            return NULL;
        }

        if ((unsigned int)val > max_m) max_m = (unsigned int)val;

        if (count >= capacity) {
            capacity *= 2;
            int *new_mt = realloc(minterms, capacity * sizeof(int));
            if (!new_mt) {
                free(minterms);
                return NULL;
            }
            minterms = new_mt;
        }
        minterms[count++] = (int)val;
        p = end;

        while (*p == ' ' || *p == '\t') p++;
        if (*p == ',') p++;
    }

    unsigned int n_vars = 0;
    while ((1u << n_vars) <= max_m) n_vars++;
    if (n_vars < 1) n_vars = 1;

    *out_count = count;
    *out_n_vars = n_vars;
    return minterms;
}

static void print_usage(const char *prog) {
    fprintf(stderr, "Usage: %s <minterms> [n_vars]\n", prog);
    fprintf(stderr, "  minterms: comma-separated list of minterm indices (e.g., 0,1,2,3,5,7)\n");
    fprintf(stderr, "  n_vars:   number of variables (auto-detected if not specified)\n");
    fprintf(stderr, "Example: %s 0,1,2,3,5,7 4\n", prog);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        print_usage(argv[0]);
        return 1;
    }

    size_t n_minterms;
    unsigned int n_vars;
    int *minterms = parse_minterms(argv[1], &n_minterms, &n_vars);

    if (!minterms) {
        print_usage(argv[0]);
        return 1;
    }

    if (argc >= 3) {
        n_vars = (unsigned int)atoi(argv[2]);
        if (n_vars < 1 || n_vars > 16) {
            fprintf(stderr, "Error: n_vars must be between 1 and 16\n");
            free(minterms);
            return 1;
        }
    }

    printf("Input: %zu minterms, %u variables\n", n_minterms, n_vars);
    printf("Minterms: ");
    for (size_t i = 0; i < n_minterms; i++) {
        printf("%d", minterms[i]);
        if (i < n_minterms - 1) printf(", ");
    }
    printf("\n\n");

    TermList prime_implicants = new_term_list();
    find_prime_implicants(minterms, n_minterms, &prime_implicants, n_vars);

    printf("Prime Implicants (%zu):\n", prime_implicants.count);
    for (size_t i = 0; i < prime_implicants.count; i++) {
        printf("  P%zu: %s (covers minterms: ", i, term_to_string(prime_implicants.terms[i]));
        unsigned long long covered = prime_implicants.terms[i].covered;
        bool first = true;
        unsigned long long temp = covered;
        unsigned int max = 1u << n_vars;
        while (temp) {
            unsigned long long lsb = temp & -temp;
            unsigned int m = __builtin_ctzll(lsb);
            if (m < max) {
                if (!first) printf(", ");
                printf("%u", m);
                first = false;
            }
            temp ^= lsb;
        }
        printf(")\n");
    }
    printf("\n");

    size_t n_cols;
    unsigned long long *col_covered = build_col_covered(&prime_implicants, minterms, n_minterms, &n_cols);

    unsigned long long remaining_cols = 0;
    for (size_t i = 0; i < n_cols; i++) {
        remaining_cols |= (1ULL << i);
    }

    unsigned long long essential = find_essential_pis(&prime_implicants, col_covered, n_cols, &remaining_cols);
    unsigned long long selected = essential | greedy_select(&prime_implicants, col_covered, n_cols, remaining_cols);

    printf("Essential Prime Implicants:\n");
    unsigned long long temp_ess = essential;
    bool has_essential = false;
    while (temp_ess) {
        unsigned long long lsb = temp_ess & -temp_ess;
        size_t idx = __builtin_ctzll(lsb);
        printf("  %s\n", term_to_string(prime_implicants.terms[idx]));
        temp_ess ^= lsb;
        has_essential = true;
    }
    if (!has_essential) printf("  (none)\n");
    printf("\n");

    printf("Final Solution:\n  ");
    bool first = true;
    unsigned long long temp_sel = selected;
    while (temp_sel) {
        unsigned long long lsb = temp_sel & -temp_sel;
        size_t idx = __builtin_ctzll(lsb);
        if (!first) printf(" + ");
        printf("%s", term_to_string(prime_implicants.terms[idx]));
        first = false;
        temp_sel ^= lsb;
    }
    printf("\n");

    free(col_covered);
    free_term_list(&prime_implicants);
    free(minterms);

    return 0;
}