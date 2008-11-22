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

test.c <- function()
  {
    checkEquals(stmC,coerce_blkmat(C))
  }

test.a <- function()
  {
    checkEquals(stmA,coerce_const(A))
  }
