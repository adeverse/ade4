"mcoa" <- function (X, option = c("inertia", "lambda1", "uniform", "internal"),
    scannf = TRUE, nf = 3, tol = 1e-07) 
{
    if (!inherits(X, "ktab")) 
        stop("object 'ktab' expected")
    option <- option[1]
    if (option == "internal") {
        if (is.null(X$tabw)) {
            warning("Internal weights not found: uniform weigths are used")
            option <- "uniform"
        }
    }
    lw <- X$lw
    nlig <- length(lw)
    cw <- X$cw
    ncol <- length(cw)
    nbloc <- length(X$blo)
    indicablo <- X$TC[, 1]
    veclev <- levels(X$TC[,1])
    Xsepan <- sepan(X, nf = 4)
    rank.fac <- factor(rep(1:nbloc, Xsepan$rank))
    tabw <- NULL
    auxinames <- ktab.util.names(X)
    if (option == "lambda1") {
        for (i in 1:nbloc) tabw <- c(tabw, 1/Xsepan$Eig[rank.fac == i][1])
    }
    else if (option == "inertia") {
        for (i in 1:nbloc) tabw <- c(tabw, 1/sum(Xsepan$Eig[rank.fac == i]))
    }
    else if (option == "uniform") {
        tabw <- rep(1, nbloc)
    }
    else if (option == "internal") 
        tabw <- X$tabw
    else stop("Unknown option")
    for (i in 1:nbloc) X[[i]] <- X[[i]] * sqrt(tabw[i])
    Xsepan <- sepan(X, nf = 4)
    normaliserparbloc <- function(scorcol) {
        for (i in 1:nbloc) {
            w1 <- scorcol[indicablo == veclev[i]]
            w2 <- sqrt(sum(w1 * w1))
            if (w2 > tol) 
                w1 <- w1/w2
            scorcol[indicablo == veclev[i]] <- w1
        }
        return(scorcol)
    }
    recalculer <- function(tab, scorcol) {
        for (k in 1:nbloc) {
            soustabk <- tab[, indicablo == veclev[k]]
            uk <- scorcol[indicablo == veclev[k]]
            soustabk.hat <- t(apply(soustabk, 1, function(x) sum(x * 
                uk) * uk))
            soustabk <- soustabk - soustabk.hat
            tab[, indicablo == veclev[k]] <- soustabk
        }
        return(tab)
    }
    tab <- as.matrix(X[[1]])
    for (i in 2:nbloc) {
        tab <- cbind(tab, X[[i]])
    }
    names(tab) <- auxinames$col
    tab <- tab * sqrt(lw)
    tab <- t(t(tab) * sqrt(cw))
    compogene <- list()
    uknorme <- list()
    valsing <- NULL
    nfprovi <- min(c(20, nlig, ncol))
    for (i in 1:nfprovi) {
        af <- svd(tab)
        w <- af$u[, 1]
        w <- w/sqrt(lw)
        compogene[[i]] <- w
        w <- af$v[, 1]
        w <- normaliserparbloc(w)
        tab <- recalculer(tab, w)
        w <- w/sqrt(cw)
        uknorme[[i]] <- w
        w <- af$d[1]
        valsing <- c(valsing, w)
    }
    pseudoeig <- valsing^2
    if (scannf) {
        barplot(pseudoeig)
        cat("Select the number of axes: ")
        nf <- as.integer(readLines(n = 1))
    }
    if (nf <= 0) 
        nf <- 2
    acom <- list()
    acom$pseudoeig <- pseudoeig
    w <- matrix(0, nbloc, nf)
    for (i in 1:nbloc) {
        w1 <- Xsepan$Eig[rank.fac == i]
        r0 <- Xsepan$rank[i]
        if (r0 > nf) 
            r0 <- nf
        w[i, 1:r0] <- w1[1:r0]
    }
    w <- data.frame(w)
    row.names(w) <- Xsepan$tab.names
    names(w) <- paste("lam", 1:nf, sep = "")
    acom$lambda <- w
    w <- matrix(0, nlig, nf)
    for (j in 1:nf) w[, j] <- compogene[[j]]
    w <- data.frame(w)
    names(w) <- paste("SynVar", 1:nf, sep = "")
    row.names(w) <- row.names(X)
    acom$SynVar <- w
    w <- matrix(0, ncol, nf)
    for (j in 1:nf) w[, j] <- uknorme[[j]]
    w <- data.frame(w)
    names(w) <- paste("Axis", 1:nf, sep = "")
    row.names(w) <- auxinames$col
    acom$axis <- w
    w <- matrix(0, nlig * nbloc, nf)
    covar <- matrix(0, nbloc, nf)
    i1 <- 0
    i2 <- 0
    for (k in 1:nbloc) {
        i1 <- i2 + 1
        i2 <- i2 + nlig
        urk <- as.matrix(acom$axis[indicablo == veclev[k], ])
        tab <- as.matrix(X[[k]])
        urk <- urk * cw[indicablo == veclev[k]]
        urk <- tab %*% urk
        w[i1:i2, ] <- urk
        urk <- urk * acom$SynVar * lw
        covar[k, ] <- apply(urk, 2, sum)
    }
    w <- data.frame(w, row.names = auxinames$row)
    names(w) <- paste("Axis", 1:nf, sep = "")
    acom$Tli <- w
    covar <- data.frame(covar)
    row.names(covar) <- tab.names(X)
    names(covar) <- paste("cov2", 1:nf, sep = "")
    acom$cov2 <- covar^2
    w <- matrix(0, nlig * nbloc, nf)
    i1 <- 0
    i2 <- 0
    for (k in 1:nbloc) {
        i1 <- i2 + 1
        i2 <- i2 + nlig
        tab <- acom$Tli[i1:i2, ]
        tab <- as.matrix(sweep(tab, 2, sqrt(colSums((tab*sqrt(lw))^2)), "/"))
        w[i1:i2, ] <- tab
    }
    w <- data.frame(w, row.names = auxinames$row)
    names(w) <- paste("Axis", 1:nf, sep = "")
    acom$Tl1 <- w
    w <- matrix(0, ncol, nf)
    i1 <- 0
    i2 <- 0
    for (k in 1:nbloc) {
        i1 <- i2 + 1
        i2 <- i2 + ncol(X[[k]])
        urk <- as.matrix(acom$SynVar)
        tab <- as.matrix(X[[k]])
        urk <- urk * lw
        w[i1:i2, ] <- t(tab) %*% urk
    }
    w <- data.frame(w, row.names = auxinames$col)
    names(w) <- paste("SV", 1:nf, sep = "")
    acom$Tco <- w
    var.names <- NULL
    w <- matrix(0, nbloc * 4, nf)
    i1 <- 0
    i2 <- 0
    for (k in 1:nbloc) {
        i1 <- i2 + 1
        i2 <- i2 + 4
        urk <- as.matrix(acom$axis[indicablo == veclev[k], ])
        tab <- as.matrix(Xsepan$C1[indicablo == veclev[k], ])
        urk <- urk * cw[indicablo == veclev[k]]
        tab <- t(tab) %*% urk
        for (i in 1:min(nf, 4)) {
            if (tab[i, i] < 0) {
                for (j in 1:nf) tab[i, j] <- -tab[i, j]
            }
        }
        w[i1:i2, ] <- tab
        var.names <- c(var.names, paste(Xsepan$tab.names[k], 
            ".a", 1:4, sep = ""))
    }
    w <- data.frame(w, row.names = auxinames$tab)
    names(w) <- paste("Axis", 1:nf, sep = "")
    acom$Tax <- w
    acom$nf <- nf
    acom$TL <- X$TL
    acom$TC <- X$TC
    acom$T4 <- X$T4
    class(acom) <- "mcoa"
    acom$call <- match.call()
    return(acom)
}

"plot.mcoa" <- function (x, xax = 1, yax = 2, eig.bottom = TRUE, ...) {
    if (!inherits(x, "mcoa")) 
        stop("Object of type 'mcoa' expected")
    nf <- x$nf
    if (xax > nf) 
        stop("Non convenient xax")
    if (yax > nf) 
        stop("Non convenient yax")
    opar <- par(mar = par("mar"), mfrow = par("mfrow"), xpd = par("xpd"))
    on.exit(par(opar))
    par(mfrow = c(2, 2))
    coolig <- x$SynVar[, c(xax, yax)]
    for (k in 2:nrow(x$cov2)) {
        coolig <- rbind.data.frame(coolig, x$SynVar[, c(xax, 
            yax)])
    }
    names(coolig) <- names(x$Tl1)[c(xax, yax)]
    row.names(coolig) <- row.names(x$Tl1)
    s.match(x$Tl1[, c(xax, yax)], coolig, clabel = 0, 
        sub = "Row projection", csub = 1.5, edge = FALSE)
    s.label(x$SynVar[, c(xax, yax)], add.plot = TRUE)
    coocol <- x$Tco[, c(xax, yax)]
    s.arrow(coocol, sub = "Col projection", csub = 1.5)
    valpr <- function(x) {
        opar <- par(mar = par("mar"))
        on.exit(par(opar))
        born <- par("usr")
        w <- x$pseudoeig
        col <- rep(grey(1), length(w))
        col[1:nf] <- grey(0.8)
        col[c(xax, yax)] <- grey(0)
        l0 <- length(w)
        xx <- seq(born[1], born[1] + (born[2] - born[1]) * l0/60, 
            le = l0 + 1)
        w <- w/max(w)
        w <- w * (born[4] - born[3])/4
        par(mar = c(0.1, 0.1, 0.1, 0.1))
        if (eig.bottom) 
            m3 <- born[3]
        else m3 <- born[4] - w[1]
        w <- m3 + w
        rect(xx[1], m3, xx[l0 + 1], w[1], col = grey(1))
        for (i in 1:l0) rect(xx[i], m3, xx[i + 1], w[i], col = col[i])
    }
    s.corcircle(x$Tax[x$T4[, 2] == 1, ], fullcircle = FALSE, 
        sub = "First axis projection", possub = "topright", csub = 1.5)
    valpr(x)
    plot(x$cov2[, c(xax, yax)])
    scatterutil.grid(0)
    title(main = "Pseudo-eigen values")
    par(xpd = TRUE)
    scatterutil.eti(x$cov2[, xax], x$cov2[, yax], label = row.names(x$cov2), 
        clabel = 1)
}

"print.mcoa" <- function (x, ...) {
    if (!inherits(x, "mcoa")) 
        stop("non convenient data")
    cat("Multiple Co-inertia Analysis\n")
    cat(paste("list of class", class(x)))
    l0 <- length(x$pseudoeig)
    cat("\n\n$pseudoeig:", l0, "pseudo eigen values\n")
    cat(signif(x$pseudoeig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
    cat("\n$call: ")
    print(x$call)
    cat("\n$nf:", x$nf, "axis saved\n\n")
    sumry <- array("", c(11, 4), list(1:11, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$SynVar", nrow(x$SynVar), ncol(x$SynVar), 
        "synthetic scores")
    sumry[2, ] <- c("$axis", nrow(x$axis), ncol(x$axis), 
        "co-inertia axis")
    sumry[3, ] <- c("$Tli", nrow(x$Tli), ncol(x$Tli), "co-inertia coordinates")
    sumry[4, ] <- c("$Tl1", nrow(x$Tl1), ncol(x$Tl1), "co-inertia normed scores")
    sumry[5, ] <- c("$Tax", nrow(x$Tax), ncol(x$Tax), "inertia axes onto co-inertia axis")
    sumry[6, ] <- c("$Tco", nrow(x$Tco), ncol(x$Tco), "columns onto synthetic scores")
    sumry[7, ] <- c("$TL", nrow(x$TL), ncol(x$TL), "factors for Tli Tl1")
    sumry[8, ] <- c("$TC", nrow(x$TC), ncol(x$TC), "factors for Tco")
    sumry[9, ] <- c("$T4", nrow(x$T4), ncol(x$T4), "factors for Tax")
    sumry[10, ] <- c("$lambda", nrow(x$lambda), ncol(x$lambda), 
        "eigen values (separate analysis)")
    sumry[11, ] <- c("$cov2", nrow(x$cov2), ncol(x$cov2), 
        "pseudo eigen values (synthetic analysis)")
    
    print(sumry, quote = FALSE)
    cat("other elements: ")
    if (length(names(x)) > 14) 
        cat(names(x)[15:(length(x))], "\n")
    else cat("NULL\n")
}

"summary.mcoa" <- function (object, ...) {
    if (!inherits(object, "mcoa")) 
        stop("non convenient data")
    cat("Multiple Co-inertia Analysis\n")
    appel <- as.list(object$call)
    X <- eval.parent(appel$X)
    lw <- sqrt(X$lw)
    cw <- X$cw
    ncol <- length(cw)
    nbloc <- length(X$blo)
    nf <- object$nf
    for (i in 1:nbloc) {
        cat("Array number", i, names(X)[[i]], "Rows", nrow(X[[i]]), 
            "Cols", ncol(X[[i]]), "\n")
        eigval <- unlist(object$lambda[i, ])
        eigval <- zapsmall(eigval)
        eigvalplus <- zapsmall(cumsum(eigval))
        w <- object$Tli[object$TL[, 1] == levels(object$TL[,1])[i], ]
        w <- w * lw
        varproj <- zapsmall(apply(w * w, 2, sum))
        varprojplus <- zapsmall(cumsum(varproj))
        w1 <- object$SynVar
        w1 <- w1 * lw
        cos2 <- apply(w * w1, 2, sum)
        cos2 <- cos2^2/varproj
        cos2[is.infinite(cos2)] <- NA
        cos2 <- zapsmall(cos2)
        sumry <- array("", c(nf, 6), list(1:nf, c("Iner", "Iner+", 
            "Var", "Var+", "cos2", "cov2")))
        sumry[, 1] <- round(eigval, digits = 3)
        sumry[, 2] <- round(eigvalplus, digits = 3)
        sumry[, 3] <- round(varproj, digits = 3)
        sumry[, 4] <- round(varprojplus, digits = 3)
        sumry[, 5] <- round(cos2, digits = 3)
        sumry[, 6] <- round(object$cov2[i, ], digits = 3)
        
        print(sumry, quote = FALSE)
        cat("\n")
    }
}
