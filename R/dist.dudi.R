"dist.dudi" <- function (dudi, amongrow = TRUE) {
    if (!inherits(dudi, "dudi")) 
        stop("Object of class 'dudi' expected")
    if (amongrow) {
        x <- t(t(dudi$tab) * sqrt(dudi$cw))
        x <- x %*% t(x)
        y <- diag(x)
        x <- (-2) * x + y
        x <- t(t(x) + y)
        x <- (x + t(x))/2
        diag(x) <- 0
        x <- as.dist(sqrt(abs(x)))
        attr(x, "Labels") <- row.names(dudi$tab)
        attr(x, "method") <- "DUDI"
        return(x)
    }
    else {
        x <- as.matrix(dudi$tab) * sqrt(dudi$lw)
        x <- t(x) %*% x
        y <- diag(x)
        x <- (-2) * x + y
        x <- t(t(x) + y)
        x <- (x + t(x))/2
        diag(x) <- 0
        x <- as.dist(sqrt(abs(x)))
        attr(x, "Labels") <- names(dudi$tab)
        attr(x, "method") <- "DUDI"
        return(x)
    }
}
