"sepan" <- function (X, nf = 2) {
    if (!inherits(X, "ktab")) 
        stop("object 'ktab' expected")
    complete.dudi <- function(dudi, nf1, nf2) {
        pcolzero <- nf2 - nf1 + 1
        w <- data.frame(matrix(0, nrow(dudi$li), pcolzero))
        names(w) <- paste("Axis", (nf1:nf2), sep = "")
        dudi$li <- cbind.data.frame(dudi$li, w)
        w <- data.frame(matrix(0, nrow(dudi$li), pcolzero))
        names(w) <- paste("RS", (nf1:nf2), sep = "")
        dudi$l1 <- cbind.data.frame(dudi$l1, w)
        w <- data.frame(matrix(0, nrow(dudi$co), pcolzero))
        names(w) <- paste("Comp", (nf1:nf2), sep = "")
        dudi$co <- cbind.data.frame(dudi$co, w)
        w <- data.frame(matrix(0, nrow(dudi$co), pcolzero))
        names(w) <- paste("CS", (nf1:nf2), sep = "")
        dudi$c1 <- cbind.data.frame(dudi$c1, w)
        return(dudi)
    }
    lw <- X$lw
    cw <- X$cw
    blo <- X$blo
    ntab <- length(blo)
    tab <- as.data.frame(X[[1]])
    j1 <- 1
    j2 <- as.numeric(blo[1])
    auxi <- as.dudi(tab, col.w = cw[j1:j2], row.w = lw, nf = nf, 
        scannf = FALSE, call = match.call(), type = "sepan")
    if (auxi$nf < nf) 
        auxi <- complete.dudi(auxi, auxi$nf + 1, nf)
    Eig <- auxi$eig
    Co <- auxi$co
    Li <- auxi$li
    C1 <- auxi$c1
    L1 <- auxi$l1
    row.names(Li) <- paste(row.names(Li), j1, sep = ".")
    row.names(L1) <- paste(row.names(L1), j1, sep = ".")
    row.names(Co) <- paste(row.names(Co), j1, sep = ".")
    row.names(C1) <- paste(row.names(C1), j1, sep = ".")
    rank <- auxi$rank
    for (i in 2:ntab) {
        j1 <- j2 + 1
        j2 <- j2 + as.numeric(blo[i])
        tab <- as.data.frame(X[[i]])
        auxi <- as.dudi(tab, col.w = cw[j1:j2], row.w = lw, nf = nf, 
            scannf = FALSE, call = match.call(), type = "sepan")
        Eig <- c(Eig, auxi$eig)
        row.names(auxi$li) <- paste(row.names(auxi$li), i, sep = ".")
        row.names(auxi$l1) <- paste(row.names(auxi$l1), i, sep = ".")
        row.names(auxi$co) <- paste(row.names(auxi$co), i, sep = ".")
        row.names(auxi$c1) <- paste(row.names(auxi$c1), i, sep = ".")
        if (auxi$nf < nf) 
            auxi <- complete.dudi(auxi, auxi$nf + 1, nf)
        Co <- rbind.data.frame(Co, auxi$co)
        Li <- rbind.data.frame(Li, auxi$li)
        C1 <- rbind.data.frame(C1, auxi$c1)
        L1 <- rbind.data.frame(L1, auxi$l1)
        rank <- c(rank, auxi$rank)
    }
    res <- list()
    res$Li <- Li
    res$L1 <- L1
    res$Co <- Co
    res$C1 <- C1
    res$Eig <- Eig
    res$TL <- X$TL
    res$TC <- X$TC
    res$T4 <- X$T4
    res$blo <- blo
    res$rank <- rank
    res$tab.names <- names(X)[1:ntab]
    res$call <- match.call()
    class(res) <- c("sepan", "list")
    return(res)
} 

"summary.sepan" <- function (object, ...) {
    if (!inherits(object, "sepan")) 
        stop("to be used with 'sepan' object")
    cat("Separate Analyses of a 'ktab' object\n")
    x1 <- object$tab.names
    ntab <- length(x1)
    indica <- factor(rep(1:length(object$blo), object$rank))
    nrow <- nlevels(object$TL[, 2])
    sumry <- array("", c(ntab, 9), list(1:ntab, c("names", "nrow", 
        "ncol", "rank", "lambda1", "lambda2", "lambda3", "lambda4", 
        "")))
    for (k in 1:ntab) {
        eig <- zapsmall(object$Eig[indica == k], digits = 4)
        l0 <- min(length(eig), 4)
        sumry[k, 4 + (1:l0)] <- round(eig[1:l0], digits = 3)
        if (length(eig) > 4) 
            sumry[k, 9] <- "..."
    }
    sumry[, 1] <- x1
    sumry[, 2] <- rep(nrow, ntab)
    sumry[, 3] <- object$blo
    sumry[, 4] <- object$rank
    
    print(sumry, quote = FALSE)
}

"plot.sepan" <- function (x, mfrow = NULL, csub = 2, ...) {
    if (!inherits(x, "sepan")) 
        stop("Object of type 'sepan' expected")
    opar <- par(ask = par("ask"), mfrow = par("mfrow"), mar = par("mar"))
    on.exit(par(opar))
    par(mar = c(0.6, 2.6, 0.6, 0.6))
    nbloc <- length(x$blo)
    if (is.null(mfrow)) 
        mfrow <- n2mfrow(nbloc)
    par(mfrow = mfrow)
    if (nbloc > prod(mfrow)) 
        par(ask = TRUE)
    rank.fac <- factor(rep(1:nbloc, x$rank))
    nf <- ncol(x$Li)
    neig <- max(x$rank)
    maxeig <- max(x$Eig)
    for (ianal in 1:nbloc) {
        w <- x$Eig[rank.fac == ianal]
        scatterutil.eigen(w, xmax = neig, ymax = maxeig, wsel = 1:nf, 
            sub = x$tab.names[ianal], csub = csub, possub = "topright",yaxt="s")
    }
}

"print.sepan" <- function (x, ...) {
    if (!inherits(x, "sepan")) 
        stop("to be used with 'sepan' object")
    cat("class:", class(x), "\n")
    cat("$call: ")
    print(x$call)
    sumry <- array("", c(4, 4), list(1:4, c("vector", "length", 
        "mode", "content")))
    sumry[1, ] <- c("$tab.names", length(x$tab.names), mode(x$tab.names), 
        "tab names")
    sumry[2, ] <- c("$blo", length(x$blo), mode(x$blo), "column number")
    sumry[3, ] <- c("$rank", length(x$rank), mode(x$rank), "tab rank")
    sumry[4, ] <- c("$Eig", length(x$Eig), mode(x$Eig), "All the eigen values")
    
    print(sumry, quote = FALSE)
    sumry <- array("", c(6, 4), list(1:6, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$Li", nrow(x$Li), ncol(x$Li), "row coordinates")
    sumry[2, ] <- c("$L1", nrow(x$L1), ncol(x$L1), "row normed scores")
    sumry[3, ] <- c("$Co", nrow(x$Co), ncol(x$Co), "column coordinates")
    sumry[4, ] <- c("$C1", nrow(x$C1), ncol(x$C1), "column normed coordinates")
    sumry[5, ] <- c("$TL", nrow(x$TL), ncol(x$TL), "factors for Li L1")
    sumry[6, ] <- c("$TC", nrow(x$TC), ncol(x$TC), "factors for Co C1")
    
    print(sumry, quote = FALSE)
}
