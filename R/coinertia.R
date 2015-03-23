"coinertia" <- function (dudiX, dudiY, scannf = TRUE, nf = 2) {
    normalise.w <- function(X, w) {
        # Correction d'un bug siganle par Sandrine Pavoine le 21/10/2006
        f2 <- function(v) sqrt(sum(v * v * w))
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
    if (nf > dudiX$rank) 
        nf <- dudiX$rank
    if (nf > dudiY$rank) 
        nf <- dudiY$rank
    if ((lig1<col1) & (lig1<col2)) {
        tol <- 1e-07
        w1 <- t(dudiX$tab)*dudiX$cw
        w1 <- as.matrix(dudiX$tab)%*%w1
        w1 <- dudiX$lw*w1
        w2 <- t(dudiY$tab)*dudiY$cw
        w2 <- as.matrix(dudiY$tab)%*%w2
        w2 <- dudiY$lw*w2
        w1 <- w1%*%w2
        w1 <- eigen(w1)
        # correction d'un bug signale par E. Prestat - juillet 2012
        # Dans le cas d'une matrice non symetrique, eigen renvoie
        # parfois des elements propres complexes possedant une partie
        # imaginaire tres petite ou nulle.
        w1$values <- Re(w1$values)
        w1$vectors <- Re(w1$vectors)
        res <- list(tab = tabcoiner, cw = dudiX$cw, lw = dudiY$cw)
        rank <- sum((w1$values/w1$values[1]) > tol)
        if (scannf) {
            if (exists("ade4TkGUIFlag")) {
                nf <- ade4TkGUI::chooseaxes(w1$values, rank)
            } else {
                barplot(w1$values[1:rank])
                cat("Select the number of axes: ")
                nf <- as.integer(readLines(n = 1))
            }
        }
        if (nf <= 0) 
            nf <- 2
        if (nf > rank) 
            nf <- rank
        res$eig <- w1$values[1:rank]
        res$rank <- rank
        res$nf <- nf
        w1 <- w1$vectors[,1:nf]
        U <- t(dudiY$tab)%*%w1
        U <- normalise.w(U, dudiY$cw)
        res$l1 <- U
        res$l1 <- as.data.frame(res$l1)
        names(res$l1) <- paste("RS", (1:nf), sep = "")
        row.names(res$l1) <- names(dudiY$tab)
        U <- t(t(U)*sqrt(res$eig[1:nf]))
        res$li <- U
        res$li <- as.data.frame(res$li)
        names(res$li) <- paste("Axis", (1:nf), sep = "")
        row.names(res$li) <- names(dudiY$tab)
        U <- as.matrix(dudiY$tab)
        U <- U*dudiY$lw
        U <- U%*%(as.matrix(res$l1)*dudiY$cw)
        U <- t(dudiX$tab)%*%U
        res$co <- U
        res$co <- as.data.frame(res$co)
        names(res$co) <- paste("Comp", (1:nf), sep = "")
        row.names(res$co) <- names(dudiX$tab)
        U <- t(t(U)/sqrt(res$eig[1:nf]))
        res$c1 <- U
        res$c1 <- as.data.frame(res$c1)
        names(res$c1) <- paste("CS", (1:nf), sep = "")
        row.names(res$c1) <- names(dudiX$tab)

        U <- as.matrix(res$c1) * dudiX$cw
        U <- data.frame(as.matrix(dudiX$tab) %*% U)
        row.names(U) <- row.names(dudiX$tab)
        names(U) <- paste("AxcX", (1:res$nf), sep = "")
        res$lX <- U
        U <- normalise.w(U, dudiX$lw)
        names(U) <- paste("NorS", (1:res$nf), sep = "")
        res$mX <- U
        U <- as.matrix(res$l1) * dudiY$cw
        U <- data.frame(as.matrix(dudiY$tab) %*% U)
        row.names(U) <- row.names(dudiY$tab)
        names(U) <- paste("AxcY", (1:res$nf), sep = "")
        res$lY <- U
        U <- normalise.w(U, dudiY$lw)
        names(U) <- paste("NorS", (1:res$nf), sep = "")
        res$mY <- U
        U <- as.matrix(res$c1) * dudiX$cw
        U <- data.frame(t(as.matrix(dudiX$c1)) %*% U)
        row.names(U) <- paste("Ax", (1:dudiX$nf), sep = "")
        names(U) <- paste("AxcX", (1:res$nf), sep = "")
        res$aX <- U
        U <- as.matrix(res$l1) * dudiY$cw
        U <- data.frame(t(as.matrix(dudiY$c1)) %*% U)
        row.names(U) <- paste("Ax", (1:dudiY$nf), sep = "")
        names(U) <- paste("AxcY", (1:res$nf), sep = "")
        res$aY <- U
        res$call <- match.call()
        class(res) <- c("coinertia", "dudi")
    } else {
        res <- as.dudi(tabcoiner, dudiX$cw, dudiY$cw, scannf = scannf, 
            nf = nf, call = match.call(), type = "coinertia")
        U <- as.matrix(res$c1) * unlist(res$cw)
        U <- data.frame(as.matrix(dudiX$tab) %*% U)
        row.names(U) <- row.names(dudiX$tab)
        names(U) <- paste("AxcX", (1:res$nf), sep = "")
        res$lX <- U
        U <- normalise.w(U, dudiX$lw)
        names(U) <- paste("NorS", (1:res$nf), sep = "")
        res$mX <- U
        U <- as.matrix(res$l1) * unlist(res$lw)
        U <- data.frame(as.matrix(dudiY$tab) %*% U)
        row.names(U) <- row.names(dudiY$tab)
        names(U) <- paste("AxcY", (1:res$nf), sep = "")
        res$lY <- U
        U <- normalise.w(U, dudiY$lw)
        names(U) <- paste("NorS", (1:res$nf), sep = "")
        res$mY <- U
        U <- as.matrix(res$c1) * unlist(res$cw)
        U <- data.frame(t(as.matrix(dudiX$c1)) %*% U)
        row.names(U) <- paste("Ax", (1:dudiX$nf), sep = "")
        names(U) <- paste("AxcX", (1:res$nf), sep = "")
        res$aX <- U
        U <- as.matrix(res$l1) * unlist(res$lw)
        U <- data.frame(t(as.matrix(dudiY$c1)) %*% U)
        row.names(U) <- paste("Ax", (1:dudiY$nf), sep = "")
        names(U) <- paste("AxcY", (1:res$nf), sep = "")
        res$aY <- U
    }
    RV <- sum(res$eig)/sqrt(sum(dudiX$eig^2))/sqrt(sum(dudiY$eig^2))
    res$RV <- RV
    return(res)
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
    layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), 
        respect = TRUE)
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    s.corcircle(x$aX, xax, yax, sub = "X axes", csub = 2, 
        clabel = 1.25)
    s.corcircle(x$aY, xax, yax, sub = "Y axes", csub = 2, 
        clabel = 1.25)
    scatterutil.eigen(x$eig, wsel = c(xax, yax))
    s.match(x$mX, x$mY, xax, yax, clabel = 1.5)
    s.arrow(x$l1, xax = xax, yax = yax, sub = "Y Canonical weights", 
        csub = 2, clabel = 1.25)
    s.arrow(x$c1, xax = xax, yax = yax, sub = "X Canonical weights", 
        csub = 2, clabel = 1.25)
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
    cat("\n\neigenvalues: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n\n")
    else cat("\n\n")
    sumry <- array("", c(3, 4), list(1:3, c("vector", "length", 
        "mode", "content")))
    sumry[1, ] <- c("$eig", length(x$eig), mode(x$eig), "Eigenvalues")
    sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), paste("Row weigths (for", x$call[[3]], "cols)"))
    sumry[3, ] <- c("$cw", length(x$cw), mode(x$cw), paste("Col weigths (for", x$call[[2]], "cols)"))
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(11, 4), list(1:11, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$tab", nrow(x$tab), ncol(x$tab), paste("Crossed Table (CT): cols(", x$call[[3]], ") x cols(", x$call[[2]], ")", sep=""))
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), paste("CT row scores (cols of ", x$call[[3]], ")", sep=""))
    sumry[3, ] <- c("$l1", nrow(x$l1), ncol(x$l1), paste("Principal components (loadings for ", x$call[[3]], " cols)", sep=""))
    sumry[4, ] <- c("$co", nrow(x$co), ncol(x$co), paste("CT col scores (cols of ", x$call[[2]], ")", sep=""))
    sumry[5, ] <- c("$c1", nrow(x$c1), ncol(x$c1), paste("Principal axes (loadings for ", x$call[[2]], ")", sep=""))
    sumry[6, ] <- c("$lX", nrow(x$lX), ncol(x$lX), paste("Row scores (rows of ", x$call[[2]], " cols)", sep=""))
    sumry[7, ] <- c("$mX", nrow(x$mX), ncol(x$mX), paste("Normed row scores (rows of ", x$call[[2]], ")", sep=""))
    sumry[8, ] <- c("$lY", nrow(x$lY), ncol(x$lY), paste("Row scores (rows of ", x$call[[3]], ")", sep=""))
    sumry[9, ] <- c("$mY", nrow(x$mY), ncol(x$mY), paste("Normed row scores (rows of ", x$call[[3]], ")", sep=""))
    sumry[10, ] <- c("$aX", nrow(x$aX), ncol(x$aX), paste("Corr ", x$call[[2]], " axes / coinertia axes", sep=""))
    sumry[11, ] <- c("$aY", nrow(x$aY), ncol(x$aY), paste("Corr ", x$call[[3]], " axes / coinertia axes", sep=""))
    
    print(sumry, quote = FALSE)
    cat("\n")
    cat(paste("CT rows = cols of ", x$call[[3]], " (", nrow(x$li), ") / CT cols = cols of ", x$call[[2]], " (", nrow(x$co),")", sep=""))
    cat("\n")
}

"summary.coinertia" <- function (object, ...) {
    if (!inherits(object, "coinertia")) 
        stop("to be used with 'coinertia' object")

    thetitle <- "Coinertia analysis" 
    cat(thetitle)
    cat("\n\n")
    NextMethod()

    appel <- as.list(object$call)
    dudiX <- eval.parent(appel$dudiX)
    dudiY <- eval.parent(appel$dudiY)
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
    res <- list(EigDec = U)
    cat("Eigenvalues decomposition:\n")
    print(U)
    cat(paste("\nInertia & coinertia X (", deparse(appel$dudiX),"):\n", sep=""))
    inertia <- cumsum(sdX^2)
    max <- cumsum(dudiX$eig[1:object$nf])
    ratio <- inertia/max
    U <- cbind.data.frame(inertia, max, ratio)
    row.names(U) <- util(object$nf)
    res$InerX <- U
    print(U)
    cat(paste("\nInertia & coinertia Y (", deparse(appel$dudiY),"):\n", sep=""))
    inertia <- cumsum(sdY^2)
    max <- cumsum(dudiY$eig[1:object$nf])
    ratio <- inertia/max
    U <- cbind.data.frame(inertia, max, ratio)
    row.names(U) <- util(object$nf)
    res$InerY <- U
    print(U)
    RV <- sum(object$eig)/sqrt(sum(dudiX$eig^2))/sqrt(sum(dudiY$eig^2))
    cat("\nRV:\n", RV, "\n")
    res$RV <- RV
    invisible(res)
}
