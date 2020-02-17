#include <R.h>
#include <Rinternals.h>
#include <declarations.h>

SEXP int_vector_csdp2R(int, int*);
SEXP double_vector_csdp2R(int, double*);
int *int_vector_R2csdp(int, SEXP);
double *double_vector_R2csdp(int, SEXP);
struct blockmatrix blkmatrix_R2csdp(SEXP);
SEXP blkmatrix_csdp2R(struct blockmatrix);
SEXP constraints_csdp2R(int, struct constraintmatrix *);
struct constraintmatrix *constraints_R2csdp(SEXP);

SEXP test_int_vector(SEXP v)
{
  int *vv;
  vv = int_vector_R2csdp(v);
  return int_vector_csdp2R(vv);
}
