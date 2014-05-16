wca <- function (x, ...) UseMethod("wca")

"wca.dudi" <- function (x, fac, scannf = TRUE, nf = 2, ...) {
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
    tabw <- unlist(tapply(x$lw, fac, sum))
    tabw <- tabw/sum(tabw)
    tabwit <- x$tab - tabmoy[fac, ]
    res <- as.dudi(tabwit, x$cw, x$lw, scannf = scannf, nf = nf, 
        call = match.call(), type = "wit")
    res$ratio <- sum(res$eig)/sum(x$eig)
    U <- as.matrix(res$c1) * unlist(res$cw)
    U <- data.frame(as.matrix(x$tab) %*% U)
    row.names(U) <- row.names(x$tab)
    names(U) <- names(res$li)
    res$ls <- U
    U <- as.matrix(res$c1) * unlist(res$cw)
    U <- data.frame(t(as.matrix(x$c1)) %*% U)
    row.names(U) <- names(x$li)
    names(U) <- names(res$li)
    res$as <- U
    res$tabw <- tabw
    res$fac <- fac
    class(res) <- c("within", "dudi")
    return(res)
}

"within" <- function (dudi, fac, scannf = TRUE, nf = 2) {
  .Deprecated("wca", "ade4", "To avoid some name conflicts, the 'within' function is now deprecated. Please use 'wca' instead")
  res <- wca(x=dudi, fac=fac, scannf = scannf, nf = nf)
  res$call <- match.call()
  return(res)
}

"plot.within" <- function (x, xax = 1, yax = 2, ...) {
    if (!inherits(x, "within")) 
        stop("Use only with 'within' objects")
    if ((x$nf == 1) || (xax == yax)) {
        return(invisible())
    }
    if (xax > x$nf) 
        stop("Non convenient xax")
    if (yax > x$nf) 
        stop("Non convenient yax")
    fac <- x$fac
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), 
        respect = TRUE)
    par(mar = c(0.2, 0.2, 0.2, 0.2))
    s.arrow(x$c1, xax = xax, yax = yax, sub = "Canonical weights", 
        csub = 2, clabel = 1.25)
    s.arrow(x$co, xax = xax, yax = yax, sub = "Variables", 
        csub = 2, clabel = 1.25)
    scatterutil.eigen(x$eig, wsel = c(xax, yax))
    s.class(x$ls, fac, xax = xax, yax = yax, sub = "Scores and classes", 
        csub = 2, clabel = 1.5, cpoint = 2)
    s.corcircle(x$as, xax = xax, yax = yax, sub = "Inertia axes", 
        csub = 2, cgrid = 0, clabel = 1.25)
    s.class(x$li, fac, xax = xax, yax = yax, axesell = FALSE, 
        clabel = 0, cstar = 0, sub = "Common centring", csub = 2)
}

"print.within" <- function (x, ...) {
    if (!inherits(x, "within")) 
        stop("to be used with 'within' object")
    cat("Within analysis\n")
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
    sumry <- array("", c(5, 4), list(1:5, c("vector", "length", 
        "mode", "content")))
    sumry[1, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), "row weigths")
    sumry[3, ] <- c("$cw", length(x$cw), mode(x$cw), "col weigths")
    sumry[4, ] <- c("$tabw", length(x$tabw), mode(x$tabw), "class weigths")
    sumry[5, ] <- c("$fac", length(x$fac), mode(x$fac), "factor for grouping")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(7, 4), list(1:7, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "array class-variables")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "row coordinates")
    sumry[3, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "row normed scores")
    sumry[4, ] <- c("$co", nrow(x$co), ncol(x$co), "column coordinates")
    sumry[5, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "column normed scores")
    sumry[6, ] <- c("$ls", nrow(x$ls), ncol(x$ls), "supplementary row coordinates")
    sumry[7, ] <- c("$as", nrow(x$as), ncol(x$as), "inertia axis onto within axis")
    
    print(sumry, quote = FALSE)
    cat("\n")
}


summary.within <- function(object, ...){
    thetitle <- "Within-class analysis"
    cat(thetitle)
    cat("\n\n")
    NextMethod()
    appel <- as.list(object$call)
    dudi <- eval.parent(appel$x)
    cat(paste("Total unconstrained inertia (", deparse(appel$x), 
              "): ", sep = ""))
    cat(signif(sum(dudi$eig), 4))
    cat("\n\n")
    cat(paste("Inertia of", deparse(appel$x), "independent of", 
              deparse(appel$fac), "(%): "))
    cat(signif(object$ratio * 100, 4))
    cat("\n\n")
}
