"lingoes" <- function (distmat, print = FALSE) {
    if (is.euclid(distmat)) {
        warning("Euclidean distance found : no correction need")
        return(distmat)
    }
    distmat <- as.matrix(distmat)
    n <- ncol(distmat)
    delta <- -0.5 * bicenter.wt(distmat * distmat)
    lambda <- eigen(delta, sym = TRUE)$values
    lder <- lambda[ncol(distmat)]
    distmat <- sqrt(distmat * distmat + 2 * abs(lder))
    if (print) 
        cat("Lingoes constant =", round(abs(lder), dig = 6), 
            "\n")
    distmat <- as.dist(distmat)
    attr(distmat, "call") <- match.call()
    attr(distmat, "method") <- "Lingoes"
    return(distmat)
}
