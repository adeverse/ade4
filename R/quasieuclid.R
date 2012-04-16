"quasieuclid" <- function (distmat) {
    if (is.euclid(distmat)) {
        warning("Euclidean distance found : no correction need")
        return(distmat)
    }
    res <- as.matrix(distmat)
    n <- ncol(res)
    delta <- -0.5 * bicenter.wt(res * res)
    eig <- eigen(delta, symmetric = TRUE)
    ncompo <- sum(eig$value > 0)
    tabnew <- eig$vectors[, 1:ncompo] * rep(sqrt(eig$values[1:ncompo]), 
        rep(n, ncompo))
    res <- dist(tabnew)
    attributes(res) <- attributes(distmat)
    attr(res, "call") <- match.call()
    return(res)
}
