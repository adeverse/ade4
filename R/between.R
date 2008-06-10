"between" <- function (dudi, fac, scannf = TRUE, nf = 2) {
    if (!inherits(dudi, "dudi")) 
        stop("Object of class dudi expected")
    if (!is.factor(fac)) 
        stop("factor expected")
    lig <- nrow(dudi$tab)
    if (length(fac) != lig) 
        stop("Non convenient dimension")
    cla.w <- tapply(dudi$lw, fac, sum)
    mean.w <- function(x, w, fac, cla.w) {
        z <- x * w
        z <- tapply(z, fac, sum)/cla.w
        return(z)
    }
    tabmoy <- apply(dudi$tab, 2, mean.w, w = dudi$lw, fac = fac, 
        cla.w = cla.w)
    tabmoy <- data.frame(tabmoy)
    row.names(tabmoy) <- levels(fac)
    names(tabmoy) <- names(dudi$tab)
    X <- as.dudi(tabmoy, dudi$cw, as.vector(cla.w), scannf = scannf, 
        nf = nf, call = match.call(), type = "bet")
    X$ratio <- sum(X$eig)/sum(dudi$eig)
    U <- as.matrix(X$c1) * unlist(X$cw)
    U <- data.frame(as.matrix(dudi$tab) %*% U)
    row.names(U) <- row.names(dudi$tab)
    names(U) <- names(X$c1)
    X$ls <- U
    U <- as.matrix(X$c1) * unlist(X$cw)
    U <- data.frame(t(as.matrix(dudi$c1)) %*% U)
    row.names(U) <- names(dudi$li)
    names(U) <- names(X$li)
    X$as <- U
    class(X) <- c("between", "dudi")
    return(X)
}

"plot.between" <- function (x, xax = 1, yax = 2, ...) {
    bet <- x
    if (!inherits(bet, "between")) 
        stop("Use only with 'between' objects")
    if ((bet$nf == 1) || (xax == yax)) {
        appel <- as.list(bet$call)
        dudi <- eval(appel$dudi, sys.frame(0))
        fac <- eval(appel$fac, sys.frame(0))
        lig <- nrow(dudi$tab)
        if (length(fac) != lig) 
            stop("Non convenient dimension")
        sco.quant(bet$ls[, 1], dudi$tab, fac = fac)
        return(invisible())
    }
    if (xax > bet$nf) 
        stop("Non convenient xax")
    if (yax > bet$nf) 
        stop("Non convenient yax")
    fac <- eval(as.list(bet$call)$fac, sys.frame(0))
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), 
        respect = TRUE)
    par(mar = c(0.2, 0.2, 0.2, 0.2))
    s.arrow(bet$c1, xax = xax, yax = yax, sub = "Canonical weights", 
        csub = 2, clab = 1.25)
    s.arrow(bet$co, xax = xax, yax = yax, sub = "Variables", 
        csub = 2, cgrid = 0, clab = 1.25)
    scatterutil.eigen(bet$eig, wsel = c(xax, yax))
    s.class(bet$ls, fac, xax = xax, yax = yax, sub = "Scores and classes", 
        csub = 2, clab = 1.25)
    s.corcircle(bet$as, xax = xax, yax = yax, sub = "Inertia axes", 
        csub = 2, cgrid = 0, clab = 1.25)
    s.label(bet$li, xax = xax, yax = yax, sub = "Classes", 
        csub = 2, clab = 1.25)
}

"print.between" <- function (x, ...) {
    if (!inherits(x, "between")) 
        stop("to be used with 'between' object")
    cat("Between analysis\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$nf (axis saved) :", x$nf)
    cat("\n$rank: ", x$rank)
    cat("\n$ratio: ", x$ratio)
    cat("\n\neigen values: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n\n")
    else cat("\n\n")
    sumry <- array("", c(3, 4), list(1:3, c("vector", "length", 
        "mode", "content")))
    sumry[1, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), "group weigths")
    sumry[3, ] <- c("$cw", length(x$cw), mode(x$cw), "col weigths")
    class(sumry) <- "table"
    print(sumry)
    cat("\n")
    sumry <- array("", c(7, 4), list(1:7, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "array class-variables")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "class coordinates")
    sumry[3, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "class normed scores")
    sumry[4, ] <- c("$co", nrow(x$co), ncol(x$co), "column coordinates")
    sumry[5, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "column normed scores")
    sumry[6, ] <- c("$ls", nrow(x$ls), ncol(x$ls), "row coordinates")
    sumry[7, ] <- c("$as", nrow(x$as), ncol(x$as), "inertia axis onto between axis")
    class(sumry) <- "table"
    print(sumry)
    cat("\n")
}
