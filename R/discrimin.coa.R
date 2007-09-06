"discrimin.coa" <- function (df, fac, scannf = TRUE, nf = 2) {
    if (!is.factor(fac)) 
        stop("factor expected")
    lig <- nrow(df)
    if (length(fac) != lig) 
        stop("Non convenient dimension")
    dudi.coarp <- function(df) {
        if (!is.data.frame(df)) 
            stop("data.frame expected")
        if (any(df < 0)) 
            stop("negative entries in table")
        if ((N <- sum(df)) == 0) 
            stop("all frequencies are zero")
        df <- df/N
        row.w <- apply(df, 1, sum)
        col.w <- apply(df, 2, sum)
        if (any(col.w == 0)) 
            stop("null column found in data")
        df <- df/row.w
        df <- sweep(df, 2, col.w)
        X <- as.dudi(df, 1/col.w, row.w, scannf = FALSE, nf = 2, 
            call = match.call(), type = "coarp", full = TRUE)
        X$N <- N
        class(X) <- "dudi"
        return(X)
    }
    dudi <- dudi.coarp(df)
    rank <- dudi$rank
    deminorm <- as.matrix(dudi$c1) * dudi$cw
    deminorm <- t(t(deminorm)/sqrt(dudi$eig))
    cla.w <- as.vector(tapply(dudi$lw, fac, sum))
    mean.w <- function(x) {
        z <- x * dudi$lw
        z <- tapply(z, fac, sum)/cla.w
        return(z)
    }
    tabmoy <- apply(dudi$l1, 2, mean.w)
    tabmoy <- data.frame(tabmoy)
    row.names(tabmoy) <- levels(fac)
    X <- as.dudi(tabmoy, rep(1, rank), cla.w, scannf = scannf, 
        nf = nf, call = match.call(), type = "dis")
    res <- list(eig = X$eig)
    res$nf <- X$nf
    res$fa <- deminorm %*% as.matrix(X$c1)
    res$li <- as.matrix(dudi$tab) %*% res$fa
    w <- scalewt(dudi$tab, dudi$lw)
    res$va <- t(as.matrix(w)) %*% (res$li * dudi$lw)
    res$cp <- t(as.matrix(dudi$l1)) %*% (dudi$lw * res$li)
    res$fa <- data.frame(res$fa)
    row.names(res$fa) <- names(dudi$tab)
    names(res$fa) <- paste("DS", 1:X$nf, sep = "")
    res$li <- data.frame(res$li)
    row.names(res$li) <- row.names(dudi$tab)
    names(res$li) <- names(res$fa)
    w <- apply(res$li, 2, mean.w)
    res$gc <- data.frame(w)
    row.names(res$gc) <- as.character(levels(fac))
    names(res$gc) <- names(res$fa)
    res$va <- data.frame(res$va)
    row.names(res$va) <- names(dudi$tab)
    names(res$va) <- names(res$fa)
    res$cp <- data.frame(res$cp)
    row.names(res$cp) <- names(dudi$l1)
    names(res$cp) <- names(res$fa)
    res$call <- match.call()
    class(res) <- c("coadisc", "discrimin")
    return(res)
}
