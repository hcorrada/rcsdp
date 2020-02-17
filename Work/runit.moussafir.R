test.ok <- function() {
C <- list(matrix(c(0.0, 0.0,
                   0.0, 1.0), 2, 2, byrow=TRUE))

A <- list(list(matrix(c(1.0, 0.0,
                        0.0, 0.0), 2, 2, byrow=TRUE)))

A1 <- list(list(matrix(c(1.0, 0.0,
                         0.0, 1.0), 2, 2, byrow=TRUE)))

b <- c(1.)

K <- list(type="s", size=2)

sol <- csdp(C, A1, b, K)
checkTrue(!is.null(sol))
}

test.error <- function() {
C <- list(matrix(c(0.0, 0.0,
                   0.0, 1.0), 2, 2, byrow=TRUE))

A <- list(list(matrix(c(1.0, 0.0,
                        0.0, 0.0), 2, 2, byrow=TRUE)))

A1 <- list(list(matrix(c(1.0, 0.0,
                         0.0, 1.0), 2, 2, byrow=TRUE)))

b <- c(1.)

K <- list(type="s", size=2)

sol <- csdp(C, A, b, K)
checkTrue(!is.null(sol))
}

