"statis" <- function (X, scannf = TRUE, nf = 3, tol = 1e-07) {
    if (!inherits(X, "ktab")) 
        stop("object 'ktab' expected")
    lw <- X$lw
    nlig <- length(lw)
    cw <- X$cw
    ncol <- length(cw)
    blo <- X$blo
    ntab <- length(X$blo)
    indicablo <- X$TC[, 1]
    tab.names <- tab.names(X)
    auxinames <- ktab.util.names(X)
    statis <- list()
    sep <- list()
    lwsqrt <- sqrt(lw)
    for (k in 1:ntab) {
        ak <- sqrt(cw[indicablo == k])
        wk <- as.matrix(X[[k]]) * lwsqrt
        wk <- t(t(wk) * ak)
        wk <- wk %*% t(wk)
        sep[[k]] <- wk
    }
    ############## calcul des RV ###########
   sep <- matrix(unlist(sep), nlig * nlig, ntab)
    RV <- t(sep) %*% sep
    ak <- sqrt(diag(RV))
    RV <- sweep(RV, 1, ak, "/")
    RV <- sweep(RV, 2, ak, "/")
    dimnames(RV) <- list(tab.names, tab.names)
    statis$RV <- RV
    ############## diagonalisation de la matrice des RV ###########
   eig1 <- La.eigen(RV, sym = TRUE)
    statis$RV.eig <- eig1$values
    if (any(eig1$vectors[, 1] < 0)) 
        eig1$vectors[, 1] <- -eig1$vectors[, 1]
    tabw <- eig1$vectors[, 1]
    statis$RV.tabw <- tabw
    w <- t(t(eig1$vectors) * sqrt(eig1$values))
    w <- as.data.frame(w)
    row.names(w) <- tab.names
    names(w) <- paste("S", 1:ncol(w), sep = "")
    statis$RV.coo <- w[, 1:min(4, ncol(w))]
    ############## combinaison des opérateurs d'inertie normés ###########
    sep <- t(t(sep)/ak)
    C.ro <- apply(t(sep) * tabw, 2, sum)
    C.ro <- matrix(unlist(C.ro), nlig, nlig)
    ############## diagonalisation du compromis ###########
   eig1 <- La.eigen(C.ro, sym = TRUE)
    eig <- eig1$values
    rank <- sum((eig/eig[1]) > tol)
    if (scannf) {
        barplot(eig[1:rank])
        cat("Select the number of axes: ")
        nf <- as.integer(readLines(n = 1))
    }
    if (nf <= 0) 
        nf <- 2
    if (nf > rank) 
        nf <- rank
    statis$C.eig <- eig[1:rank]
    statis$C.nf <- nf
    statis$C.rank <- rank
    wref <- eig1$vectors[, 1:nf]
    wref <- wref/lwsqrt
    w <- data.frame(t(t(wref) * sqrt(eig[1:nf])))
    row.names(w) <- row.names(X)
    names(w) <- paste("C", 1:nf, sep = "")
    statis$C.li <- w
    w <- as.matrix(X[[1]])
    for (k in 2:ntab) {
        w <- cbind(w, as.matrix(X[[k]]))
    }
    w <- w * lw
    w <- t(w) %*% wref
    w <- data.frame(w, row.names = auxinames$col)
    names(w) <- paste("C", 1:nf, sep = "")
    statis$C.Co <- w
    sepanL1 <- sepan(X, nf = 4)$L1
    w <- matrix(0, ntab * 4, nf)
    i1 <- 0
    i2 <- 0
    for (k in 1:ntab) {
        i1 <- i2 + 1
        i2 <- i2 + 4
        tab <- as.matrix(sepanL1[X$TL[, 1] == k, ])
        tab <- t(tab * lw) %*% wref
        for (i in 1:min(nf, 4)) {
            if (tab[i, i] < 0) {
                for (j in 1:nf) tab[i, j] <- -tab[i, j]
            }
        }
        w[i1:i2, ] <- tab
    }
    w <- data.frame(w, row.names = auxinames$tab)
    names(w) <- paste("C", 1:nf, sep = "")
    statis$C.T4 <- w
    w <- as.matrix(statis$C.li) * lwsqrt
    w <- w %*% t(w)
    w <- w/sqrt(sum(w * w))
    w <- as.vector(unlist(w))
    sep <- sep * unlist(w)
    w <- apply(sep, 2, sum)
    statis$cos2 <- w
    statis$tab.names <- tab.names
    statis$TL <- X$TL
    statis$TC <- X$TC
    statis$T4 <- X$T4
    class(statis) <- "statis"
    return(statis)
}

"plot.statis" <- function (x, xax = 1, yax = 2, option = 1:4, ...) {
    if (!inherits(x, "statis")) 
        stop("Object of type 'statis' expected")
    nf <- x$C.nf
    if (xax > nf) 
        stop("Non convenient xax")
    if (yax > nf) 
        stop("Non convenient yax")
    opar <- par(mar = par("mar"), mfrow = par("mfrow"), xpd = par("xpd"))
    on.exit(par(opar))
    mfrow <- n2mfrow(length(option))
    par(mfrow = mfrow)
    for (j in option) {
        if (j == 1) {
            coolig <- x$RV.coo[, c(1, 2)]
            s.corcircle(coolig, label = x$tab.names, 
                cgrid = 0, sub = "Interstructure", csub = 1.5, 
                possub = "topleft", full = TRUE)
            l0 <- length(x$RV.eig)
            add.scatter.eig(x$RV.eig, l0, 1, 2, posi = "bottom", 
                ratio = 1/4)
        }
        if (j == 2) {
            coolig <- x$C.li[, c(xax, yax)]
            s.label(coolig, sub = "Compromise", csub = 1.5, 
                possub = "topleft", )
            add.scatter.eig(x$C.eig, x$C.nf, xax, yax, 
                posi = "bottom", ratio = 1/4)
        }
        if (j == 4) {
            cooax <- x$C.T4[x$T4[, 2] == 1, ]
            s.corcircle(cooax, xax, yax, full = TRUE, sub = "Component projection", 
                possub = "topright", csub = 1.5)
            add.scatter.eig(x$C.eig, x$C.nf, xax, yax, 
                posi = "bottom", ratio = 1/5)
        }
        if (j == 3) {
            plot(x$RV.tabw, x$cos2, xlab = "Tables weights", 
                ylab = "Cos 2")
            scatterutil.grid(0)
            title(main = "Typological value")
            par(xpd = TRUE)
            scatterutil.eti(x$RV.tabw, x$cos2, label = x$tab.names, 
                clabel = 1)
        }
    }
}

"print.statis" <- function (x, ...) {
    cat("STATIS Analysis\n")
    cat("class:")
    cat(class(x), "\n")
    cat("table number:", length(x$RV.tabw), "\n")
    cat("row number:", nrow(x$C.li), "  total column number:", 
        nrow(x$C.Co), "\n")
    cat("\n     **** Interstructure ****\n")
    cat("\neigen values: ")
    l0 <- length(x$RV.eig)
    cat(signif(x$RV.eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
    cat(" $RV       matrix      ", nrow(x$RV), "    ", ncol(x$RV), "    RV coefficients\n")
    cat(" $RV.eig   vector      ", length(x$RV.eig), "      eigenvalues\n")
    cat(" $RV.coo   data.frame  ", nrow(x$RV.coo), "    ", ncol(x$RV.coo), 
        "   array scores\n")
    cat(" $tab.names    vector      ", length(x$tab.names), "       array names\n")
    cat(" $RV.tabw  vector      ", length(x$RV.tabw), "     array weigths\n")
    cat("\nRV coefficient\n")
    w <- x$RV
    w[row(w) < col(w)] <- NA
    print(w, na = "")
    cat("\n      **** Compromise ****\n")
    cat("\neigen values: ")
    l0 <- length(x$C.eig)
    cat(signif(x$C.eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
    cat("\n $nf:", x$C.nf, "axis-components saved")
    cat("\n $rank: ")
    cat(x$C.rank, "\n")
    sumry <- array("", c(6, 4), list(rep("", 6), c("data.frame", 
        "nrow", "ncol", "content")))
    sumry[1, ] <- c("$C.li", nrow(x$C.li), ncol(x$C.li), "row coordinates")
    sumry[2, ] <- c("$C.Co", nrow(x$C.Co), ncol(x$C.Co), "column coordinates")
    sumry[3, ] <- c("$T4", nrow(x$T4), ncol(x$T4), "principal vectors (each table)")
    sumry[4, ] <- c("$TL", nrow(x$TL), ncol(x$TL), "factors (not used)")
    sumry[5, ] <- c("$TC", nrow(x$TC), ncol(x$TC), "factors for Co")
    sumry[6, ] <- c("$T4", nrow(x$T4), ncol(x$T4), "factors for T4")
    class(sumry) <- "table"
    print(sumry)
    cat("\n")
}
