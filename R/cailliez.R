"cailliez" <- function (distmat, print = FALSE) {
    if (is.euclid(distmat)) {
        warning("Euclidean distance found : no correction need")
        return(distmat)
    }
    distmat <- as.matrix(distmat)
    size <- ncol(distmat)
    m1 <- matrix(0, size, size)
    m1 <- rbind(m1, -diag(size))
    m2 <- -bicenter.wt(distmat * distmat)
    m2 <- rbind(m2, 2 * bicenter.wt(distmat))
    m1 <- cbind(m1, m2)
    lambda <- eigen(m1, only = TRUE)$values
    c <- max(Re(lambda)[Im(lambda) < 1e-08])
    if (print) 
        cat(paste("Cailliez constant =", round(c, dig = 5), "\n"))
    distmat <- as.dist(distmat + c)
    attr(distmat, "call") <- match.call()
    attr(distmat, "method") <- "Cailliez"
    return(distmat)
}
