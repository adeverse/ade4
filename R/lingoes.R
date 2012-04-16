"lingoes" <- function (distmat, print = FALSE, tol = 1e-07, cor.zero = TRUE) {
    if (is.euclid(distmat)) {
        warning("Euclidean distance found : no correction need")
        return(distmat)
    }
    distmat <- as.matrix(distmat)
    delta <- -0.5 * bicenter.wt(distmat * distmat)
    lambda <- eigen(delta, symmetric = TRUE, only.values = TRUE)$values
    lder <- lambda[ncol(distmat)]
    if(cor.zero){
      distmat <- distmat * distmat
      distmat[distmat > tol] <- sqrt(distmat[distmat > tol] + 2 * abs(lder))
    } else {      
      distmat <- sqrt(distmat * distmat + 2 * abs(lder))
    }
    
    if (print) 
        cat("Lingoes constant =", round(abs(lder), digits = 6), 
            "\n")
    distmat <- as.dist(distmat)
    attr(distmat, "call") <- match.call()
    attr(distmat, "method") <- "Lingoes"
    return(distmat)
}
