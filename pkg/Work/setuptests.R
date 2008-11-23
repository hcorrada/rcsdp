pkg.dir <- file.path("..")
src.files <- list.files(file.path(pkg.dir,"R"),pattern=".*\\.R$")
invisible(lapply(src.files,function(filenm) source(file.path(pkg.dir,"R",filenm))))
dyn.load(file.path(pkg.dir,"src","Rcsdp.so"))


library(Matrix)

# functions for coercing test data
coerce_mat <- function(mat,cfun=as.simple_triplet_sym_matrix) if (is.null(dim(mat))) mat else cfun(mat)
coerce_blkmat <- function(Aij,cfun=as.simple_triplet_sym_matrix) lapply(Aij,coerce_mat,cfun=cfun)
coerce_const <- function(Ai,cfun=as.simple_triplet_sym_matrix) lapply(Ai,coerce_blkmat,cfun=cfun)

C <- list(matrix(c(2,1,
                   1,2),2,2,byrow=TRUE),
          matrix(c(3,0,1,
                   0,2,0,
                   1,0,3),3,3,byrow=TRUE),
          c(0,0))
A <- list(list(matrix(c(3,1,
                        1,3),2,2,byrow=TRUE),
               matrix(0,3,3),
               c(1,0)),
          list(matrix(0,2,2),
               matrix(c(3,0,1,
                        0,4,0,
                        1,0,5),3,3,byrow=TRUE),
               c(0,1)))

stmC <- list(simple_triplet_sym_matrix(c(1,2,2),c(1,1,2),c(2,1,2)),
             simple_triplet_sym_matrix(c(1,3,2,3),c(1,1,2,3),c(3,1,2,3)),
             c(0,0))
stmA <- list(
             list(simple_triplet_sym_matrix(c(1,2,2),c(1,1,2),c(3,1,3)),
                  .simple_triplet_zero_sym_matrix(3),
                  c(1,0)),
             list(.simple_triplet_zero_sym_matrix(2),
                  simple_triplet_sym_matrix(c(1,3,2,3),c(1,1,2,3),c(3,1,4,5)),
                  c(0,1))
             )

MatC <- coerce_blkmat(C,cfun=function(x) as(x,"dsTMatrix"))
MatA <- coerce_const(A,cfun=function(x) as(x,"dsTMatrix"))

probC <- list(nblocks=3,
              blocks=list(
                list(blocksize=2,
                     blockcategory=1,
                     data=c(2,1,1,2)),
                list(blocksize=3,
                     blockcategory=1,
                     data=c(3,0,1,0,2,0,1,0,3)),
                list(blocksize=2,
                     blockcategory=2,
                     data=c(0,0,0))));
              
probA <- list(
              list(list(iindices=c(0,1,2,2),
                        jindices=c(0,1,1,2),
                        entries=c(0,3,1,3),
                        blocknum=1,
                        blocksize=2,
                        constraintnum=1,
                        numentries=3),
                   list(iindices=c(0,1),
                        jindices=c(0,1),
                        entries=c(0,1),
                        blocknum=3,
                        blocksize=2,
                        constraintnum=1,
                        numentries=1)),
              list(list(iindices=c(0,1,3,2,3),
                        jindices=c(0,1,1,2,3),
                        entries=c(0,3,1,4,5),
                        blocknum=2,
                        blocksize=3,
                        constraintnum=2,
                        numentries=4),
                   list(iindices=c(0,2),
                        jindices=c(0,2),
                        entries=c(0,1),
                        blocknum=3,
                        blocksize=2,
                        constraintnum=2,
                        numentries=1))
              )
b <- c(1,2)
probb <- c(0,1,2)

test.prob.data <- structure(list(C=probC,A=probA,b=probb),class="csdpData")

K <- list(type=c("s","s","l"),
          size=c(2,3,2))

m <- length(b);
prob.info <- get.prob.info(K,m);

Z <- list(matrix(c(0.25,-0.25,
                   -0.25,0.25),2,2,byrow=TRUE),
          matrix(c(0,0,0,
                   0,2,0,
                   0,0,2),3,3,byrow=TRUE),
          c(0.75,1))

X <- list(matrix(c(0.125,0.125,
                   0.125,0.125),2,2,byrow=TRUE),
          matrix(c(0.667,0,0,
                   0,0,0,
                   0,0,0),3,3,byrow=TRUE),
          c(0,0))

y <- c(0.75,1)

Matcfun <- function(x) as(x,"dsTMatrix")
