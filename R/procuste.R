"procuste" <- function (dfX, dfY, scale = TRUE, nf = 4, tol = 1e-07) {
    dfX <- data.frame(dfX)
    dfY <- data.frame(dfY)
    if (!is.data.frame(dfX)) 
        stop("data.frame expected")
    if (!is.data.frame(dfY)) 
        stop("data.frame expected")
    if (nrow(dfY) != nrow(dfX)) 
        stop("Row numbers are different")
    if (any(row.names(dfY) != row.names(dfX))) 
        stop("row names are different")
    
    X <- scale(dfX, scale = FALSE)
    Y <- scale(dfY, scale = FALSE)

    if (scale) {
        X <- X/sqrt(sum(apply(X, 2, function(x) sum(x^2))))
        Y <- Y/sqrt(sum(apply(Y, 2, function(x) sum(x^2))))
    }
    
    X <-as.matrix(X)
    Y <- as.matrix(Y)
    PS <- t(X) %*% Y
    svd1 <- svd(PS)
    rank <- sum((svd1$d/svd1$d[1]) > tol)
    if (nf > rank) 
        nf <- rank
    u <- svd1$u[, 1:nf]
    v <- svd1$v[, 1:nf]
    scorX <- X %*% u
    scorY <- Y %*% v
    rotX <- X %*% u %*% t(v)
    rotY <- Y %*% v %*% t(u)
    res <- list()
    X <- data.frame(X)
    row.names(X) <- row.names(dfX)
    names(X) <- names(dfX)
    Y <- data.frame(Y)
    row.names(Y) <- row.names(dfY)
    names(Y) <- names(dfY)
    res$d <- svd1$d
    res$rank <- rank
    res$nf <- nf
    u <- data.frame(u)
    row.names(u) <- names(dfX)
    names(u) <- paste("ax", 1:nf, sep = "")
    v <- data.frame(v)
    row.names(v) <- names(dfY)
    names(v) <- paste("ax", 1:nf, sep = "")
    scorX <- data.frame(scorX)
    row.names(scorX) <- row.names(dfX)
    names(scorX) <- paste("ax", 1:nf, sep = "")
    scorY <- data.frame(scorY)
    row.names(scorY) <- row.names(dfX)
    names(scorY) <- paste("ax", 1:nf, sep = "")
    if ((nf ==  ncol(dfX)) & (nf == ncol(dfY))) {
        rotX <- data.frame(rotX)
        row.names(rotX) <- row.names(dfX)
        names(rotX) <- names(dfY)
        rotY <- data.frame(rotY)
        row.names(rotY) <- row.names(dfX)
        names(rotY) <- names(dfX)
        res$rotX <- rotX
        res$rotY <- rotY
    }
    res$tabX <- X
    res$tabY <- Y
    res$loadX <- u
    res$loadY <- v
    res$scorX <- scorX
    res$scorY <- scorY
    res$call <- match.call()
    class(res) <- "procuste"
    return(res)
}

"plot.procuste" <- function (x, xax = 1, yax = 2, ...) {
    if (!inherits(x, "procuste")) 
        stop("Use only with 'procuste' objects")
    if (x$nf == 1) {
        warnings("One axis only : not yet implemented")
        return(invisible())
    }
    if (xax > x$nf) 
        stop("Non convenient xax")
    if (yax > x$nf) 
        stop("Non convenient yax")
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), 
        respect = TRUE)
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    s.arrow(x$loadX, xax, yax, sub = "X loadings", csub = 2, 
        clabel = 1.25)
    s.arrow(x$loadY, xax, yax, sub = "Y loadings", csub = 2, 
        clabel = 1.25)
    scatterutil.eigen(x$d^2, wsel = c(xax, yax))
    s.match(x$scorX, x$scorY, xax, yax, clabel = 1.5, sub = "Row scores (X -> Y)", 
        csub = 2)
    s.label(x$scorX, xax = xax, yax = yax, sub = "X row scores", 
        csub = 2, clabel = 1.25)
    s.label(x$scorY, xax = xax, yax = yax, sub = "Y row scores", 
        csub = 2, clabel = 1.25)
}

"print.procuste" <- function (x, ...) {
    cat("Procustes rotation\n")
    cat("call: ")
    print(x$call)
    cat(paste("class:", class(x)))
    cat(paste("\nrank:", x$rank))
    cat(paste("\naxis number:", x$nf))
    cat("\nSingular value decomposition: ")
    l0 <- length(x$d)
    cat(signif(x$d, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
    cat("tabX   data.frame  ", nrow(x$tabX), "  ", ncol(x$tabX), 
        "   scaled table X\n")
    cat("tabY   data.frame  ", nrow(x$tabY), "  ", ncol(x$tabY), 
        "   scaled table Y\n")
    cat("scorX  data.frame  ", nrow(x$scorX), " ", ncol(x$scorX), 
        "   X row scores\n")
    cat("scorY  data.frame  ", nrow(x$scorY), " ", ncol(x$scorY), 
        "   Y row scores\n")
    cat("loadX  data.frame  ", nrow(x$loadX), " ", ncol(x$loadX), 
        "   X loadings\n")
    cat("loadY  data.frame  ", nrow(x$loadY), " ", ncol(x$loadY), 
        "   Y loadings\n")
    if (length(names(x)) > 12) {
        cat("other elements: ")
        cat(names(x)[11:(length(x))], "\n")
    }
}


"randtest.procuste" <- function(xtest, nrepet = 999, ...) {
    if(!inherits(xtest,"procuste"))
    stop("Object of class 'procuste' expected")

    
    lig <- nrow(xtest$tabX)
    c1 <- ncol(xtest$tabX)
    c2 <- ncol(xtest$tabY)
    isim <- testprocuste(nrepet, lig, c1, c2, as.matrix(xtest$tabX), as.matrix(xtest$tabY))
    obs <- isim[1]
    return(as.randtest(isim[-1], obs, call = match.call()))
}
