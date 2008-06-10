"quasieuclid" <- function (distmat) {
    if (is.euclid(distmat)) {
        warning("Euclidean distance found : no correction need")
        return(distmat)
    }
    distmat <- as.matrix(distmat)
    n <- ncol(distmat)
    delta <- -0.5 * bicenter.wt(distmat * distmat)
    eig <- eigen(delta, sym = TRUE)
    ncompo <- sum(eig$value > 0)
    tabnew <- eig$vectors[, 1:ncompo] * rep(sqrt(eig$values[1:ncompo]), 
        rep(n, ncompo))
    distmat <- dist.quant(tabnew, 1)
    attr(distmat, "call") <- match.call()
    return(distmat)
}
