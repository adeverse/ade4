"coinertia" <- function (dudiX, dudiY, scannf = TRUE, nf = 2) {
    normalise.w <- function(X, w) {
        f2 <- function(v) sqrt(sum(v * v * w)/sum(w))
        norm <- apply(X, 2, f2)
        X <- sweep(X, 2, norm, "/")
        return(X)
    }
    if (!inherits(dudiX, "dudi")) 
        stop("Object of class dudi expected")
    lig1 <- nrow(dudiX$tab)
    col1 <- ncol(dudiX$tab)
    if (!inherits(dudiY, "dudi")) 
        stop("Object of class dudi expected")
    lig2 <- nrow(dudiY$tab)
    col2 <- ncol(dudiY$tab)
    if (lig1 != lig2) 
        stop("Non equal row numbers")
    if (any((dudiX$lw - dudiY$lw)^2 > 1e-07)) 
        stop("Non equal row weights")
    tabcoiner <- t(as.matrix(dudiY$tab)) %*% (as.matrix(dudiX$tab) * 
        dudiX$lw)
    tabcoiner <- data.frame(tabcoiner)
    names(tabcoiner) <- names(dudiX$tab)
    row.names(tabcoiner) <- names(dudiY$tab)
    if (nf > dudiX$nf) 
        nf <- dudiX$nf
    if (nf > dudiY$nf) 
        nf <- dudiY$nf
    coi <- as.dudi(tabcoiner, dudiX$cw, dudiY$cw, scannf = scannf, 
        nf = nf, call = match.call(), type = "coinertia")
    U <- as.matrix(coi$c1) * unlist(coi$cw)
    U <- data.frame(as.matrix(dudiX$tab) %*% U)
    row.names(U) <- row.names(dudiX$tab)
    names(U) <- paste("AxcX", (1:coi$nf), sep = "")
    coi$lX <- U
    U <- normalise.w(U, dudiX$lw)
    names(U) <- paste("NorS", (1:coi$nf), sep = "")
    coi$mX <- U
    U <- as.matrix(coi$l1) * unlist(coi$lw)
    U <- data.frame(as.matrix(dudiY$tab) %*% U)
    row.names(U) <- row.names(dudiY$tab)
    names(U) <- paste("AxcY", (1:coi$nf), sep = "")
    coi$lY <- U
    U <- normalise.w(U, dudiY$lw)
    names(U) <- paste("NorS", (1:coi$nf), sep = "")
    coi$mY <- U
    U <- as.matrix(coi$c1) * unlist(coi$cw)
    U <- data.frame(t(as.matrix(dudiX$c1)) %*% U)
    row.names(U) <- paste("Ax", (1:dudiX$nf), sep = "")
    names(U) <- paste("AxcX", (1:coi$nf), sep = "")
    coi$aX <- U
    U <- as.matrix(coi$l1) * unlist(coi$lw)
    U <- data.frame(t(as.matrix(dudiY$c1)) %*% U)
    row.names(U) <- paste("Ax", (1:dudiY$nf), sep = "")
    names(U) <- paste("AxcY", (1:coi$nf), sep = "")
    coi$aY <- U
    RV <- sum(coi$eig)/sqrt(sum(dudiX$eig^2))/sqrt(sum(dudiY$eig^2))
    coi$RV <- RV
    return(coi)
}

"plot.coinertia" <- function (x, xax = 1, yax = 2, ...) {
    if (!inherits(x, "coinertia")) 
        stop("Use only with 'coinertia' objects")
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
    nf <- layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), 
        respect = TRUE)
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    s.corcircle(x$aX, xax, yax, sub = "X axes", csub = 2, 
        clab = 1.25)
    s.corcircle(x$aY, xax, yax, sub = "Y axes", csub = 2, 
        clab = 1.25)
    scatterutil.eigen(x$eig, wsel = c(xax, yax))
    s.match(x$mX, x$mY, xax, yax, clab = 1.5)
    s.arrow(x$l1, xax = xax, yax = yax, sub = "Y Canonical weights", 
        csub = 2, clab = 1.25)
    s.arrow(x$c1, xax = xax, yax = yax, sub = "X Canonical weights", 
        csub = 2, clab = 1.25)
}

"print.coinertia" <- function (x, ...) {
    if (!inherits(x, "coinertia")) 
        stop("to be used with 'coinertia' object")
    cat("Coinertia analysis\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$rank (rank)     :", x$rank)
    cat("\n$nf (axis saved) :", x$nf)
    cat("\n$RV (RV coeff)   :", x$RV)
    cat("\n\neigen values: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n\n")
    else cat("\n\n")
    sumry <- array("", c(3, 4), list(1:3, c("vector", "length", 
        "mode", "content")))
    sumry[1, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), "row weigths (crossed array)")
    sumry[3, ] <- c("$cw", length(x$cw), mode(x$cw), "col weigths (crossed array)")
    class(sumry) <- "table"
    print(sumry)
    cat("\n")
    sumry <- array("", c(11, 4), list(1:11, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "crossed array (CA)")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "Y col = CA row: coordinates")
    sumry[3, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "Y col = CA row: normed scores")
    sumry[4, ] <- c("$co", nrow(x$co), ncol(x$co), "X col = CA column: coordinates")
    sumry[5, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "X col = CA column: normed scores")
    sumry[6, ] <- c("$lX", nrow(x$lX), ncol(x$lX), "row coordinates (X)")
    sumry[7, ] <- c("$mX", nrow(x$mX), ncol(x$mX), "normed row scores (X)")
    sumry[8, ] <- c("$lY", nrow(x$lY), ncol(x$lY), "row coordinates (Y)")
    sumry[9, ] <- c("$mY", nrow(x$mY), ncol(x$mY), "normed row scores (Y)")
    sumry[10, ] <- c("$aX", nrow(x$aX), ncol(x$aX), "axis onto co-inertia axis (X)")
    sumry[11, ] <- c("$aY", nrow(x$aX), ncol(x$aX), "axis onto co-inertia axis (Y)")
    class(sumry) <- "table"
    print(sumry)
    cat("\n")
}

"summary.coinertia" <- function (object, ...) {
    if (!inherits(object, "coinertia")) 
        stop("to be used with 'coinertia' object")
    appel <- as.list(object$call)
    dudiX <- eval(appel$dudiX, sys.frame(0))
    dudiY <- eval(appel$dudiY, sys.frame(0))
    norm.w <- function(X, w) {
        f2 <- function(v) sqrt(sum(v * v * w)/sum(w))
        norm <- apply(X, 2, f2)
        return(norm)
    }
    util <- function(n) {
        x <- "1"
        for (i in 2:n) x[i] <- paste(x[i - 1], i, sep = "")
        return(x)
    }
    eig <- object$eig[1:object$nf]
    covar <- sqrt(eig)
    sdX <- norm.w(object$lX, dudiX$lw)
    sdY <- norm.w(object$lY, dudiX$lw)
    corr <- covar/sdX/sdY
    U <- cbind.data.frame(eig, covar, sdX, sdY, corr)
    row.names(U) <- as.character(1:object$nf)
    cat("\nEigenvalues decomposition:\n")
    print(U)
    cat("\nInertia & coinertia X:\n")
    inertia <- cumsum(sdX^2)
    max <- cumsum(dudiX$eig[1:object$nf])
    ratio <- inertia/max
    U <- cbind.data.frame(inertia, max, ratio)
    row.names(U) <- util(object$nf)
    print(U)
    cat("\nInertia & coinertia Y:\n")
    inertia <- cumsum(sdY^2)
    max <- cumsum(dudiY$eig[1:object$nf])
    ratio <- inertia/max
    U <- cbind.data.frame(inertia, max, ratio)
    row.names(U) <- util(object$nf)
    print(U)
    RV <- sum(object$eig)/sqrt(sum(dudiX$eig^2))/sqrt(sum(dudiY$eig^2))
    cat("\nRV:\n", RV, "\n")
}
