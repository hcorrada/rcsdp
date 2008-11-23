n <- 8;
iind <- function(n) do.call(c,lapply(1:n,function(i) i:n))
jind <- function(n) rep(1:n,times=n:1)
vals <- function(n) 1:(n*(n+1)/2)
stmA <- structure(list(i=iind(n),
                       j=jind(n),
                       v=vals(n),
                       n=n),class="simple_triplet_sym_matrix")

A <- matrix(0,n,n)
A[cbind(iind(n),jind(n))] <- vals(n)
off.ind <- which(iind(n) != jind(n))
A[cbind(jind(n),iind(n))[off.ind,]] <- vals(n)[off.ind]

a <- as.vector(A)

make.rand.smt <- function(n=100)
  {
    set.seed(1234)
    ind <- sample(vals(n),.1*n)
    structure(list(i=iind(n)[ind],
                   j=jind(n)[ind],
                   v=rnorm(.1*n),n=n),class="simple_triplet_sym_matrix")
  }
randA <- make.rand.smt(n=8)

make.rand.mat <- function(n=100)
  {
    as.matrix(make.rand.smt(n))
  }

test.stm <- function()
  {
    n <- 8
    stmB <- simple_triplet_sym_matrix(iind(n),jind(n),vals(n))
    checkEquals(stmA,stmB)
  }

test.stm.error <- function()
  {
    n <- 8
    checkException(simple_triplet_sym_matrix(jind(n),iind(n),vals(n),check.ind=TRUE),silent=TRUE)
  }

test.as.stm.stm <- function()
  {
    checkEquals(stmA,as.simple_triplet_sym_matrix(stmA))
  }

test.as.stm.matrix <- function()
  {
    stmB <- as.simple_triplet_sym_matrix(A)
    checkEquals(stmA,stmB)
  }

test.as.stm.matrix.check <- function()
  {
    stmB <- as.simple_triplet_sym_matrix(A,check.sym=TRUE)
    checkEquals(stmA,stmB)
  }

test.as.stm.matrix.error <- function()
  {
    checkException(as.simple_triplet_sym_matrix(matrix(rnorm(12),4,3)))
    checkException(as.simple_triplet_sym_matrix(matrix(rnorm(16),4,4),check.sym=TRUE))
  }

test.as.matrix.stm <- function()
  {
    B <- as.matrix(stmA)
    checkEquals(A,B)
  }

test.as.vector.stm <- function()
  {
    b <- as.vector(stmA)
    checkEquals(a,b)
  }


test.as.vector.stm.error <- function()
  {
    checkException(as.simple_triplet_sym_matrix(1:5),silent=TRUE)
  }

test.dim.stm <- function()
  {
    n <- 8
    checkEquals(dim(stmA),c(n,n))
  }

test.random.as.matrix.stm <- function()
  {
    n <- 100
    checkEquals(randA,.simple_triplet_random_sym_matrix(n,seed=1234))
    checkEquals(randA,.simple_triplet_random_sym_matrix(n,occ=.1,seed=1234))
    checkEquals(randA,.simple_triplet_random_sym_matrix(n,nnz=.1*n,seed=1234))
    checkEquals(randA,.simple_triplet_random_matrix(n,seed=1234,mean=0,sd=1))
  }

test.random.as.stm.matrix <- function()
  {
    for (i in 1:100) {
      B <- make.rand.mat()
      checkEquals(B,as.matrix(as.simple_triplet_sym_matrix(B)))
    }
  }

test.random.as.matrix.stm <- function()
  {
    for (i in 1:100) {
      B <- .simple_triplet_random_sym_matrix(100,occ=.3)
      C <- as.simple_triplet_sym_matrix(as.matrix(B))
      checkEquals(B,C)
    }
  }

# test Matrix classes
library(Matrix)

test.dsTMatrix <- function()
  {
    stmB <- as.simple_triplet_sym_matrix(as(A,"dsTMatrix"))
    checkEquals(stmB,stmA)
  }

test.dgeMatrix <- function()
  {
    stmB <- as.simple_triplet_sym_matrix(as(A,"dgeMatrix"))
    checkEquals(stmB,stmA)
  }

test.dsyMatrix <- function()
  {
    stmB <- as.simple_triplet_sym_matrix(as(A,"dsyMatrix"))
    checkEquals(stmB,stmA)
  }

test.dpoMatrix <- function()
  {
    DEACTIVATED()
    stmB <- as.simple_triplet_sym_matrix(as(A,"dpoMatrix"))
    checkEquals(stmB,stmA)
  }

test.dgTMatrix <- function()
  {
    stmB <- as.simple_triplet_sym_matrix(as(A,"dgTMatrix"))
    checkEquals(stmB,stmA)
  }

test.dsCMatrix <- function()
  {
    stmB <- as.simple_triplet_sym_matrix(as(A,"dsCMatrix"))
    checkEquals(stmB,stmA)
  }


