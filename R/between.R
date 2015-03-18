"bca" <- function (x, ...) UseMethod("bca")

"bca.dudi" <- function (x, fac, scannf = TRUE, nf = 2, ...) {
    if (!inherits(x, "dudi")) 
        stop("Object of class dudi expected")
    if (!is.factor(fac)) 
        stop("factor expected")
    lig <- nrow(x$tab)
    if (length(fac) != lig) 
        stop("Non convenient dimension")
    cla.w <- tapply(x$lw, fac, sum)
    mean.w <- function(x, w, fac, cla.w) {
        z <- x * w
        z <- tapply(z, fac, sum)/cla.w
        return(z)
    }
    tabmoy <- apply(x$tab, 2, mean.w, w = x$lw, fac = fac, 
        cla.w = cla.w)
    tabmoy <- data.frame(tabmoy)
    row.names(tabmoy) <- levels(fac)
    names(tabmoy) <- names(x$tab)
    res <- as.dudi(tabmoy, x$cw, as.vector(cla.w), scannf = scannf, 
        nf = nf, call = match.call(), type = "bet")
    res$ratio <- sum(res$eig)/sum(x$eig)
    U <- as.matrix(res$c1) * unlist(res$cw)
    U <- data.frame(as.matrix(x$tab) %*% U)
    row.names(U) <- row.names(x$tab)
    names(U) <- names(res$c1)
    res$ls <- U
    U <- as.matrix(res$c1) * unlist(res$cw)
    U <- data.frame(t(as.matrix(x$c1)) %*% U)
    row.names(U) <- names(x$li)
    names(U) <- names(res$li)
    res$as <- U
    class(res) <- c("between", "dudi")
    return(res)
}

"between" <- function (dudi, fac, scannf = TRUE, nf = 2) {
  .Deprecated("bca", "ade4", "To avoid some name conflicts, the 'between' function is now deprecated. Please use 'bca' instead")
  res <- bca(x=dudi, fac=fac, scannf = scannf, nf = nf)
  res$call <- match.call()
  return(res)
}


"plot.between" <- function (x, xax = 1, yax = 2, ...) {
    bet <- x
    if (!inherits(bet, "between")) 
        stop("Use only with 'between' objects")
    appel <- as.list(bet$call)
    fac <- eval.parent(appel$fac)
    if ((bet$nf == 1) || (xax == yax)) {
        dudi <- eval.parent(appel$x)
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
    
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), 
        respect = TRUE)
    par(mar = c(0.2, 0.2, 0.2, 0.2))
    s.arrow(bet$c1, xax = xax, yax = yax, sub = "Canonical weights", 
        csub = 2, clabel = 1.25)
    s.arrow(bet$co, xax = xax, yax = yax, sub = "Variables", 
        csub = 2, cgrid = 0, clabel = 1.25)
    scatterutil.eigen(bet$eig, wsel = c(xax, yax))
    s.class(bet$ls, fac, xax = xax, yax = yax, sub = "Scores and classes", 
        csub = 2, clabel = 1.25)
    s.corcircle(bet$as, xax = xax, yax = yax, sub = "Inertia axes", 
        csub = 2, cgrid = 0, clabel = 1.25)
    s.label(bet$li, xax = xax, yax = yax, sub = "Classes", 
        csub = 2, clabel = 1.25)
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
    
    print(sumry, quote = FALSE)
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
    
    print(sumry, quote = FALSE)
    cat("\n")
}


summary.between <- function(object, ...){
    thetitle <- "Between-class analysis"
    cat(thetitle)
    cat("\n\n")
    NextMethod()
    appel <- as.list(object$call)
    dudi <- eval.parent(appel$x)
    cat(paste("Total unconstrained inertia (", deparse(appel$x), 
              "): ", sep = ""))
    cat(signif(sum(dudi$eig), 4))
    cat("\n\n")
    cat(paste("Inertia of", deparse(appel$x), "explained by", 
              deparse(appel$fac), "(%): "))
    cat(signif(object$ratio * 100, 4))
    cat("\n\n")
}
