test.emptyK <- function()
  {
    K <- list()
    checkException(csdp(C,A,b,K=K),silent=TRUE)
    checkException(csdp(stmC,stmA,b,K=K),silent=TRUE)
    checkException(csdp(MatC,MatA,b,K=K),silent=TRUE)
  }

test.badKslot <- function()
  {
    K <- list(junk=1)
    checkException(csdp(C,A,b,K=K),silent=TRUE)
    checkException(csdp(stmC,stmA,b,K=K),silent=TRUE)
    checkException(csdp(MatC,MatA,b,K=K),silent=TRUE)
  }

test.nCblocks <- function()
  {
    C <- C[-1]
    checkException(csdp(C,A,b,K),silent=TRUE)
    checkException(csdp(coerce_blkmat(C),stmA,b,K),silent=TRUE)
    checkException(csdp(coerce_blkmat(C,cfun=function(x) as(x,"dsTMatrix")),MatA,b,K),silent=TRUE)
  }

test.nAconstr <- function()
  {
    A <- A[-1]
    checkException(csdp(C,A,b,K),silent=TRUE)
    checkException(csdp(stmC,coerce_const(A),b,K),silent=TRUE)
    checkException(csdp(MatC,coerce_const(A,cfun=function(x) as(x,"dsTMatrix")),b,K),silent=TRUE)
  }

test.bLength <- function()
  {
    checkException(csdp(C,A,b[1],K),silent=TRUE)
    checkException(csdp(stmC,stmA,b[1],K),silent=TRUE)
    checkException(csdp(MatC,MatA,b[1],K),silent=TRUE)
  }

test.matSizeC <- function()
  {
    C <- C[c(2,1,3)]
    checkException(csdp(C,A,b,K),silent=TRUE)
    checkException(csdp(coerce_blkmat(C),stmA,b,K),silent=TRUE)
    checkException(csdp(coerce_blkmat(C,cfun=function(x) as(x,"dsTMatrix")),MatA,b,K),silent=TRUE)
  }

test.vecSizeC <- function()
  {
    tmpC <- C
    tmpC[[3]] <- c(0)
    checkException(csdp(tmpC,A,b,K),silent=TRUE)
    checkException(csdp(coerce_blkmat(tmpC),stmA,b,K),silent=TRUE)
    checkException(csdp(coerce_blkmat(tmpC,cfun=function(x) as(x,"dsTMatrix")),MatA,b,K),silent=TRUE)
  }

test.nAblocks1 <- function()
  {
    tmpA <- A
    tmpA[[1]] <- tmpA[[1]][-3]
    checkException(csdp(C,tmpA,b,K),silent=TRUE)
    checkException(csdp(stmC,coerce_const(tmpA),b,K),silent=TRUE)
    checkException(csdp(MatC,coerce_const(tmpA,cfun=function(x) as(x,"dsTMatrix")),b,K),silent=TRUE)
  }

test.nAblocks2 <- function()
  {
    tmpA <- A
    tmpA[[2]] <- tmpA[[2]][-3]
    checkException(csdp(C,tmpA,b,K),silent=TRUE)
    checkException(csdp(stmC,coerce_const(tmpA),b,K),silent=TRUE)
    checkException(csdp(MatC,coerce_const(tmpA,cfun=function(x) as(x,"dsTMatrix")),b,K),silent=TRUE)
  }

test.matSizeA1 <- function()
  {
    tmpA <- A
    tmpA[[1]] <- tmpA[[1]][c(2,1,3)]
    checkException(csdp(C,tmpA,b,K),silent=TRUE)
    checkException(csdp(C,coerce_const(tmpA),b,K),silent=TRUE)
    checkException(csdp(C,coerce_const(tmpA,cfun=function(x) as(x,"dsTMatrix")),b,K),silent=TRUE)
  }

test.matSizeA2 <- function()
  {
    tmpA <- A
    tmpA[[2]] <- tmpA[[2]][c(2,1,3)]
    checkException(csdp(C,tmpA,b,K),silent=TRUE)
    checkException(csdp(C,coerce_const(tmpA),b,K),silent=TRUE)
    checkException(csdp(C,coerce_const(tmpA,cfun=function(x) as(x,"dsTMatrix")),b,K),silent=TRUE)
  }

test.vecSizeA1 <- function()
  {
    tmpA <- A
    tmpA[[1]][[3]] <- tmpA[[1]][[3]][1]
    checkException(csdp(C,tmpA,b,K),silent=TRUE)
    checkException(csdp(C,coerce_const(tmpA),b,K),silent=TRUE)
    checkException(csdp(C,coerce_const(tmpA,cfun=function(x) as(x,"dsTMatrix")),b,K),silent=TRUE)
  }

test.vecSizeA2 <- function()
  {
    tmpA <- A
    tmpA[[2]][[3]] <- tmpA[[2]][[3]][1]
    checkException(csdp(C,tmpA,b,K),silent=TRUE)
    checkException(csdp(C,coerce_const(tmpA),b,K),silent=TRUE)
    checkException(csdp(C,coerce_const(tmpA,cfun=function(x) as(x,"dsTMatrix")),b,K),silent=TRUE)
  }

