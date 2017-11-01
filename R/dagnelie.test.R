dagnelie.test <- function(x)
{
    epsilon <- sqrt(.Machine$double.eps)
    X <- as.matrix(x)
    n <- nrow(X)
    p <- ncol(X)
    dim <- c(n, p)
    names(dim) <- c("n", "p")
    
    # Centre the data matrix by columns
    x.cent <- scale(X, center = TRUE, scale = FALSE)
    rank.x <- qr(cov(X))$rank
    if (n < (rank.x + 2))
        stop("n =",
            n,
            ", rank =",
            rank.x,
            ", hence n<(rank+2). The test requires n>(rank+1)")
    
    # Compute inverse of the dispersion matrix
    if (rank.x == p) {
        invS <- solve(cov(X))             # Use normal inverse
    } else {
        invS <- ginv(cov(X))
    }   # Use generalized inverse if rank.x < p
    
    # Mahalanobis distances between the objects and the multidimensional mean
    # vector of all objects (Legendre & Legendre 2012, eq. 4.54 p. 193) 
    # Calculation simplified for centred data; it only uses a row vector of
    # centred data
    D <- as.vector(rep(0, n))
    for (i in 1:n) {
        temp <- x.cent[i,]
        D[i] <- sqrt(t(temp) %*% invS %*% temp)
    }
    if ((max(D) - min(D)) < epsilon) {
        warning("All D values are equal. A valid Dagnelie test cannot be computed")
        return(list(
            dim = dim,
            rank = rank.x,
            D = D
        ))
    }
    
    # Shapiro-Wilk test on vector D
    multinorm <- shapiro.test(D)
    
    # Warning messages
    if (p == 1) {
        warning("Test too liberal for univariate data")
    } else {
        if (n < 3 * p) {
            warning("Test too liberal, n < 3*p")
        } else {
            warning("Test too liberal, n > 8*p")
        }
        if (p == 2) {
            if (n < 6)
                warning("Test too liberal, p = 2, n < 6")
            if (n > 13)
                warning("Test too liberal, p = 2, n > 13")
        }
    }
    
    out <- list(
        Shapiro.Wilk = multinorm,
        dim = dim,
        rank = rank.x,
        D = D
    )
    
    return(out)
}
