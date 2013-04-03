test.ex1 <- function()
  {
    status <- writesdpa(C,A,b,K,file="tmp.dat-s")
    cat("status:",status,"\n");
    checkEquals(status,0);
    
    ret <- readsdpa(file="tmp.dat-s")
    unlink("tmp.dat-s")
    checkEquals(C,ret$C)
    checkEquals(stmA,ret$A)
    checkEquals(b,ret$b)
    checkEquals(K,ret$K)
  }

test.stm.ex1 <- function()
  {
    writesdpa(C=stmC,A=stmA,b,K,file="tmp.dat-s")
    ret <- readsdpa(file="tmp.dat-s")
    unlink("tmp.dat-s")
    checkEquals(C,ret$C)
    checkEquals(stmA,ret$A)
    checkEquals(b,ret$b)
    checkEquals(K,ret$K)
  }

test.Mat.ex1 <- function()
  {
    writesdpa(coerce_blkmat(C,cfun=Matcfun),A=coerce_const(A,cfun=Matcfun),b,K,file="tmp.dat-s")
    ret <- readsdpa(file="tmp.dat-s")
    unlink("tmp.dat-s")
    checkEquals(C,ret$C)
    checkEquals(stmA,ret$A)
    checkEquals(b,ret$b)
    checkEquals(K,ret$K)
  }

test.sol.ex1 <- function()
  {
    sol <- csdp(C,A,b,K)
    writesdpa.sol(sol$X,sol$Z,sol$y,K,file="tmp.sol")
    res <- readsdpa.sol(K,C,length(b),file="tmp.sol")
    unlink("tmp.sol")
    checkEquals(sol$X,res$X,tolerance=1e-6);
    checkEquals(sol$y,res$y,tolerance=1e-6);
    checkEquals(sol$Z,res$Z,tolerance=1e-6);
  }

test.theta <- function()
  {
    prob <- readsdpa(file=file.path("..","src","Csdp","test","theta1.dat-s"))
    cat("Read problem\n")
    sol <- csdp(prob$C,prob$A,prob$b,prob$K)
    cat("Solved problem\n");
    checkEquals(sol$pobj,23,tolerance=1e-6)
    checkEquals(sol$dobj,23,tolerance=1e-6)
  }
