test.int_vector <- function()
  {
    n <- length(K$size);
    v <- vector_R2csdp(K$size);
    ret <- .Call("test_int_vector",
                 as.integer(n),
                 as.integer(v));
    vv <- vector_csdp2R(ret);
    checkEquals(K$size,vv);
  }

test.double_vector <- function()
  {
    n <- length(b);
    v <- vector_R2csdp(b);
    ret <- .Call("test_double_vector",
                 as.integer(n),
                 as.double(v));
    vv <- vector_csdp2R(ret);
    checkEquals(b,vv);
  }

test.blkmatrix <- function()
  {
    CC <- blkmatrix_R2csdp(C,prob.info);
    ret <- .Call("test_blkmatrix",
                 CC);
    CCC <- blkmatrix_csdp2R(ret,prob.info);
    checkEquals(C,CCC);
  }

test.constraints <- function()
  {
    AA <- constraints_R2csdp(A,prob.info);
    ret <- .Call("test_constraints",
                 as.integer(length(stmA)),
                 AA);
    AAA <- constraints_csdp2R(ret,prob.info);
    checkEquals(stmA,AAA);
  }
