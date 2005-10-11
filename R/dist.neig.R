"dist.neig" <- function (neig) {
    if (!inherits(neig, "neig")) 
        stop("Object of class 'neig' expected")
    res <- neig.util.LtoG(neig)
    n <- nrow(res)
    auxi1 <- res
    auxi2 <- res
    for (itour in 2:n) {
        auxi2 <- auxi2 %*% auxi1
        auxi2[res != 0] <- 0
        diag(auxi2) <- 0
        auxi2 <- (auxi2 > 0) * itour
        if (sum(auxi2) == 0) 
            break
        res <- res + auxi2
    }
    return(as.dist(res))
}
