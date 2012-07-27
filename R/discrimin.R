"discrimin" <- function (dudi, fac, scannf = TRUE, nf = 2) {
    if (!inherits(dudi, "dudi")) 
        stop("Object of class dudi expected")
    if (!is.factor(fac)) 
        stop("factor expected")
    lig <- nrow(dudi$tab)
    if (length(fac) != lig) 
        stop("Non convenient dimension")
    rank <- dudi$rank
    dudi <- redo.dudi(dudi, rank)
    deminorm <- as.matrix(dudi$c1) * dudi$cw
    deminorm <- t(t(deminorm)/sqrt(dudi$eig))
    cla.w <- tapply(dudi$lw, fac, sum)
    mean.w <- function(x) {
        z <- x * dudi$lw
        z <- tapply(z, fac, sum)/cla.w
        return(z)
    }
    tabmoy <- apply(dudi$l1, 2, mean.w)
    tabmoy <- data.frame(tabmoy)
    row.names(tabmoy) <- levels(fac)
    cla.w <- cla.w/sum(cla.w)
    X <- as.dudi(tabmoy, rep(1, rank), as.vector(cla.w), scannf = scannf, 
        nf = nf, call = match.call(), type = "dis")
    res <- list()
    res$eig <- X$eig
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
    res$cp <- data.frame(res$cp)
    row.names(res$cp) <- names(dudi$l1)
    names(res$cp) <- names(res$fa)
    res$call <- match.call()
    class(res) <- "discrimin"
    return(res)
}

"plot.discrimin" <- function (x, xax = 1, yax = 2, ...) {
    if (!inherits(x, "discrimin")) 
        stop("Use only with 'discrimin' objects")
    if ((x$nf == 1) || (xax == yax)) {
        if (inherits(x, "coadisc")) {
            appel <- as.list(x$call)
            df <- eval.parent(appel$df)
            fac <- eval.parent(appel$fac)
            lig <- nrow(df)
            if (length(fac) != lig) 
                stop("Non convenient dimension")
            lig.w <- apply(df, 1, sum)
            lig.w <- lig.w/sum(lig.w)
            cla.w <- as.vector(tapply(lig.w, fac, sum))
            mean.w <- function(x) {
                z <- x * lig.w
                z <- tapply(z, fac, sum)/cla.w
                return(z)
            }
            w <- apply(df, 2, mean.w)
            w <- data.frame(t(w))
            sco.distri(x$fa[, xax], w, clabel = 1, xlim = NULL, 
                grid = TRUE, cgrid = 1, include.origin = TRUE, origin = 0, 
                sub = NULL, csub = 1)
            return(invisible())
        }
        appel <- as.list(x$call)
        dudi <- eval.parent(appel$dudi)
        fac <- eval.parent(appel$fac)
        lig <- nrow(dudi$tab)
        if (length(fac) != lig) 
            stop("Non convenient dimension")
        sco.quant(x$li[, 1], dudi$tab, fac = fac)
        return(invisible())
    }
    if (xax > x$nf) 
        stop("Non convenient xax")
    if (yax > x$nf) 
        stop("Non convenient yax")
    fac <- eval.parent(as.list(x$call)$fac)
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), 
        respect = TRUE)
    par(mar = c(0.2, 0.2, 0.2, 0.2))
    s.arrow(x$fa, xax = xax, yax = yax, sub = "Canonical weights", 
        csub = 2, clabel = 1.25)
    s.corcircle(x$va, xax = xax, yax = yax, sub = "Cos(variates,canonical variates)", 
        csub = 2, cgrid = 0, clabel = 1.25)
    scatterutil.eigen(x$eig, wsel = c(xax, yax))
    s.class(x$li, fac, xax = xax, yax = yax, sub = "Scores and classes", 
        csub = 2, clabel = 1.5)
    s.corcircle(x$cp, xax = xax, yax = yax, sub = "Cos(components,canonical variates)", 
        csub = 2, cgrid = 0, clabel = 1.25)
    s.label(x$gc, xax = xax, yax = yax, sub = "Class scores", 
        csub = 2, clabel = 1.25)
}

"print.discrimin" <- function (x, ...) {
    if (!inherits(x, "discrimin")) 
        stop("to be used with 'discrimin' object")
    cat("Discriminant analysis\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$nf (axis saved) :", x$nf)
    cat("\n\neigen values: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n\n")
    else cat("\n\n")
    sumry <- array("", c(5, 4), list(1:5, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$fa", nrow(x$fa), ncol(x$fa), "loadings / canonical weights")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "canonical scores")
    sumry[3, ] <- c("$va", nrow(x$va), ncol(x$va), "cos(variables, canonical scores)")
    sumry[4, ] <- c("$cp", nrow(x$cp), ncol(x$cp), "cos(components, canonical scores)")
    sumry[5, ] <- c("$gc", nrow(x$gc), ncol(x$gc), "class scores")
    
    print(sumry, quote = FALSE)
    cat("\n")
}
