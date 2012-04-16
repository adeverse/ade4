"cailliez" <- function (distmat, print = FALSE, tol = 1e-07, cor.zero = TRUE) {
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
    lambda <- eigen(m1, only.values = TRUE)$values
    c <- max(Re(lambda)[Im(lambda) < tol])
    if (print) 
        cat(paste("Cailliez constant =", round(c, digits = 5), "\n"))
    if(cor.zero){
      distmat[distmat > tol] <- distmat[distmat > tol] + c
      distmat <- as.dist(distmat)
    } else {      
      distmat <- as.dist(distmat + c)
    }
    attr(distmat, "call") <- match.call()
    attr(distmat, "method") <- "Cailliez"
    return(distmat)
}
