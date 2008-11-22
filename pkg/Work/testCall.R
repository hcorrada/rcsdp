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
b <- c(1,2)
K <- list(s=c(2,3),l=2)

test.csdp <- function()
  {
    checkEquals(csdp(C,A,b,K),0)
  }
