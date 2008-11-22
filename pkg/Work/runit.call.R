blktrace <- function(A,B)
  {
    ret <- 0.0;
    nblocks <- length(A)
    for (i in 1:nblocks) {
      if (is.null(dim(A[[i]])))
        ret <- ret + sum(A[[i]]*B[[i]])
      else
        ret <- ret + sum(diag(A[[i]] %*% B[[i]]))
    }
    return(ret)
  }

test.blktrace <- function()
  {
    blk1 <- sum(diag(C[[1]] %*% X[[1]]))
    blk2 <- sum(diag(C[[2]] %*% X[[2]]))
    blk3 <- crossprod(C[[3]],X[[3]])
    checkEquals(sum(c(blk1,blk2,blk3)),blktrace(C,X))
  }

test.prepare.data <- function()
  {
    prob.info <- get.prob.info(K,length(b))
    prob.data <- prepare.data(C,A,b,prob.info)
    checkEquals(prob.data$C,probC)
    checkEquals(prob.data$A,probA)
    checkEquals(prob.data$b,probb)
  }

test.prepare.stm.data <- function()
  {
    prob.info <- get.prob.info(K,length(b))
    prob.data <- prepare.data(stmC,A,b,prob.info)
    checkEquals(prob.data$C,probC)
    checkEquals(prob.data$A,probA)
    checkEquals(prob.data$b,probb)
  }

test.prepare.Matrix.data <- function()
  {
    DEACTIVATED()
    prob.info <- get.prob.info(K,length(b))
    prob.data <- prepare.data(MatC,MatA,b,prob.info)
    checkEquals(prob.data$C,probC)
    checkEquals(tmpA,tmpA2)
    checkEquals(prob.data$b,probb)
  }

test.csdp <- function()
  {
    ret <- csdp(C,A,b,K);
    print(y); print(ret$y)
    checksol(ret);
  }

test.stm.csdp <- function()
  {
    ret <- csdp(stmC,
                stmA,
                b,K)
    checksol(ret)
  }

test.Matrix.csdp <- function()
  {
    DEACTIVATED()
    ret <- csdp(coerce_blkmat(C,cfun=Matcfun),
                coerce_const(A,cfun=Matcfun),
                b,K)
    checksol(ret)
  }


checksol <- function(ret)
  {
    checkEquals(ret$X,X,tolerance=1e-3)
    checkEquals(ret$Z,Z,tolerance=1e-3)
    checkEquals(ret$y,y,tolerance=1e-3)
    checkEquals(ret$pobj,blktrace(C,X),tolerance=1e-3)
    checkEquals(ret$dobj,sum(b*y),tolerance=1e-3)
    checkEquals(ret$status,0)
  }

test.retnames <- function()
  {
    ret <- csdp(C,A,b,K)
    checkEquals(names(ret),c("X","Z","y","pobj","dobj","status"))
  }

test.status <- function()
  {
    ret <- csdp(C,A,b,K)
    checkEquals(ret$status,0)
  }

test.reorder <- function()
  {
    swapblk <- function(blkmat,i,j)
      {
        tmp <- blkmat[[i]]
        blkmat[[i]] <- blkmat[[j]]
        blkmat[[j]] <- tmp
        blkmat
      }
    C <- swapblk(C,2,3)
    A <- lapply(A,swapblk,i=2,j=3)
    K <- list(type=c("s","l","s"),size=c(2,2,3))
    ret <- csdp(C,A,b,K)
    ret$X <- swapblk(ret$X,2,3)
    ret$Z <- swapblk(ret$Z,2,3)
    checksol(ret)
  }

test.control <- function()
  {
    con <- csdp.control(printlevel=3)
    ret <- csdp(C,A,b,K,control=con);
    checksol(ret);
  }
