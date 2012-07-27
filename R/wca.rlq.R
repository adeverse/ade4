"wca.rlq" <- function (x, fac, scannf = TRUE, nf = 2, ...) 
{
    if (!inherits(x, "rlq")) 
        stop("Object of class rlq expected")
    if (!is.factor(fac)) 
        stop("factor expected")
    appel <- as.list(x$call)    
    dudiR <- eval.parent(appel$dudiR)
    dudiL <- eval.parent(appel$dudiL)
    dudiQ <- eval.parent(appel$dudiQ)
    ligR <- nrow(dudiR$tab)
    if (length(fac) != ligR) 
        stop("Non convenient dimension")
    cla.w <- tapply(dudiR$lw, fac, sum)
    mean.w <- function(x, w, fac, cla.w) {
        z <- x * w
        z <- tapply(z, fac, sum)/cla.w
        return(z)
    }
    tabmoyR <- apply(dudiR$tab, 2, mean.w, w = dudiR$lw, fac = fac, 
        cla.w = cla.w)
    tabmoyR <- data.frame(tabmoyR)
    tabwitR <- dudiR$tab - tabmoyR[fac, ]
    
    tabmoyL <- apply(dudiL$tab, 2, mean.w, w = dudiL$lw, fac = fac, 
        cla.w = cla.w)
    tabmoyL <- data.frame(tabmoyL)    
    tabwitL <- dudiL$tab - tabmoyL[fac, ]
    
    dudiwitR <- as.dudi(tabwitR, dudiR$cw, dudiR$lw, scannf = FALSE, 
        nf = nf, call = match.call(), type = "wit")
    dudiwitL <- as.dudi(tabwitL, dudiL$cw, dudiL$lw, scannf = FALSE, 
        nf = nf, call = match.call(), type = "coa")
    
    res <- rlq(dudiwitR, dudiwitL, dudiQ, scannf = scannf, 
        nf = nf)
    res$call <- match.call()

    U <- as.matrix(res$l1) * unlist(res$lw)
    U <- data.frame(as.matrix(dudiR$tab) %*% U)
    row.names(U) <- row.names(dudiR$tab)
    names(U) <- names(res$l1)
    res$lsR <- U
    U <- as.matrix(res$c1) * unlist(res$cw)
    U <- data.frame(t(as.matrix(x$c1)) %*% U)
    row.names(U) <- names(x$c1)
    names(U) <- names(res$c1)
    res$acQ <- U
    
    U <- as.matrix(res$l1) * unlist(res$lw)
    U <- data.frame(t(as.matrix(x$l1)) %*% U)
    row.names(U) <- names(x$l1)
    names(U) <- names(res$l1)
    res$acR <- U
    
    class(res) <- c("witrlq", "dudi")
    return(res)
}

"print.witrlq" <- function (x, ...) 
{
    if (!inherits(x, "witrlq")) 
        stop("to be used with 'witrlq' object")
    cat("Within RLQ analysis\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$rank (rank):", x$rank)
    cat("\n$nf (axis saved):", x$nf)
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
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(14, 4), list(1:14, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "crossed array (CA)")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "R col = CA row: coordinates")
    sumry[3, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "R col = CA row: normed scores")
    sumry[4, ] <- c("$co", nrow(x$co), ncol(x$co), "Q col = CA column: coordinates")
    sumry[5, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "Q col = CA column: normed scores")
    sumry[6, ] <- c("$lR", nrow(x$lR), ncol(x$lR), "row coordinates (R)")
    sumry[7, ] <- c("$lsR", nrow(x$lsR), ncol(x$lsR), "supplementary row coordinates (R)")
    sumry[8, ] <- c("$mR", nrow(x$mR), ncol(x$mR), "normed row scores (R)")
    sumry[9, ] <- c("$lQ", nrow(x$lQ), ncol(x$lQ), "row coordinates (Q)")
    sumry[10, ] <- c("$mQ", nrow(x$mQ), ncol(x$mQ), "normed row scores (Q)")
    sumry[11, ] <- c("$aR", nrow(x$aR), ncol(x$aR), "axes onto within-RLQ axes (R)")
    sumry[12, ] <- c("$aQ", nrow(x$aQ), ncol(x$aQ), "axes onto within-RLQ axes (Q)")
    sumry[13, ] <- c("$acR", nrow(x$acR), ncol(x$acR), "RLQ axes onto within-RLQ axes (R)")
    sumry[14, ] <- c("$acQ", nrow(x$acQ), ncol(x$acQ), "RLQ axes onto within-RLQ axes (Q)")
    
    print(sumry, quote = FALSE)
    cat("\n")
}


"plot.witrlq" <- function (x, xax = 1, yax = 2, ...) 
{
    if (!inherits(x, "witrlq")) 
        stop("Use only with 'witrlq' objects")
    if (x$nf == 1) {
        warnings("One axis only : not yet implemented")
        return(invisible())
    }
    if (xax > x$nf) 
        stop("Non convenient xax")
    if (yax > x$nf) 
        stop("Non convenient yax")
    fac <- eval.parent(as.list(x$call)$fac)
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    layout(matrix(c(1, 1, 3, 1, 1, 4, 2, 2, 5, 2, 2, 6, 8, 8, 
        7), 3, 5), respect = TRUE)
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    s.class(x$lsR[, c(xax, yax)], fac = fac, sub = "R row scores and classes", csub = 2, 
        clabel = 1.25)
    s.label(x$lQ[, c(xax, yax)], sub = "Q row scores", csub = 2, 
        clabel = 1.25)
    s.corcircle(x$aR, xax, yax, sub = "R axes", csub = 2, clabel = 1.25)
    s.arrow(x$l1, xax = xax, yax = yax, sub = "R Canonical weights", 
        csub = 2, clabel = 1.25)
    s.corcircle(x$aQ, xax, yax, sub = "Q axes", csub = 2, clabel = 1.25)
    s.arrow(x$c1, xax = xax, yax = yax, sub = "Q Canonical weights", 
        csub = 2, clabel = 1.25)
    scatterutil.eigen(x$eig, wsel = c(xax, yax))
}

