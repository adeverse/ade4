"dudi.acm" <- function (df, row.w = rep(1, nrow(df)), scannf = TRUE, nf = 2) {
    if (!all(unlist(lapply(df, is.factor)))) 
        stop("All variables must be factors")
    df <- as.data.frame(df)
    X <- acm.disjonctif(df)
    lig <- nrow(X)
    col <- ncol(X)
    var <- ncol(df)
    if (length(row.w) != lig) 
        stop("Non convenient row weights")
    if (any(row.w < 0)) 
        stop("row weight < 0")
    row.w <- row.w/sum(row.w)
    col.w <- apply(X, 2, function(x) sum(x*row.w))
    if (any(col.w == 0)) 
        stop("One category with null weight")
    X <- t(t(X)/col.w) - 1
    col.w <- col.w/var
    X <- as.dudi(data.frame(X), col.w, row.w, scannf = scannf, 
        nf = nf, call = match.call(), type = "acm")
    rcor <- matrix(0, ncol(df), X$nf)
    rcor <- row(rcor) + 0 + (0+1i) * col(rcor)
    floc <- function(x) {
        i <- Re(x)
        j <- Im(x)
        x <- X$l1[, j] * X$lw
        qual <- df[, i]
        poicla <- unlist(tapply(X$lw, qual, sum))
        z <- unlist(tapply(x, qual, sum))/poicla
        return(sum(poicla * z * z))
    }
    rcor <- apply(rcor, c(1, 2), floc)
    rcor <- data.frame(rcor)
    row.names(rcor) <- names(df)
    names(rcor) <- names(X$l1)
    X$cr <- rcor
    return(X)
}

"boxplot.acm" <- function (x, xax = 1, ...) {
    # correction d'un bug par P. Cornillon 29/10/2004
    if (!inherits(x, "acm")) 
        stop("Object of class 'acm' expected")
    if ((xax < 1) || (xax > x$nf)) 
        stop("non convenient axe number")
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    oritab <- eval.parent(as.list(x$call)[[2]])
    nvar <- ncol(oritab)
    if (nvar <= 7) 
        sco.boxplot(x$l1[, xax], oritab[, 1:nvar], clabel = 1)
    else if (nvar <= 14) {
        par(mfrow = c(1, 2))
        sco.boxplot(x$l1[, xax], oritab[, 1:(nvar%/%2)], clabel = 1.3)
        sco.boxplot(x$l1[, xax], oritab[, (nvar%/%2 + 1):nvar], 
            clabel = 1.3)
    }
    else {
        par(mfrow = c(1, 3))
        if ((a0 <- nvar%/%3) < nvar/3) 
            a0 <- a0 + 1
        sco.boxplot(x$l1[, xax], oritab[, 1:a0], clabel = 1.6)
        sco.boxplot(x$l1[, xax], oritab[, (a0 + 1):(2 * a0)], 
            clabel = 1.6)
        sco.boxplot(x$l1[, xax], oritab[, (2 * a0 + 1):nvar], 
            clabel = 1.6)
    }
}

"acm.burt" <- function (df1, df2, counts = rep(1, nrow(df1))) {
    if (!all(unlist(lapply(df1, is.factor)))) 
        stop("All variables must be factors")
    if (!all(unlist(lapply(df2, is.factor)))) 
        stop("All variables must be factors")
    if (nrow(df1) != nrow(df2)) 
        stop("non convenient row numbers")
    if (length(counts) != nrow(df2)) 
        stop("non convenient row numbers")
    g1 <- acm.disjonctif(df1)
    g1 <- g1 * counts
    g2 <- acm.disjonctif(df2)
    burt <- as.matrix(t(g1)) %*% as.matrix(g2)
    burt <- data.frame(burt)
    names(burt) <- names(g2)
    row.names(burt) <- names(g1)
    return(burt)
} 

"acm.disjonctif" <- function (df) {
    acm.util.df <- function(i) {
        cl <- df[,i]
        cha <- names(df)[i] 
        n <- length(cl)
        cl <- as.factor(cl)
        x <- matrix(0, n, length(levels(cl)))
        x[(1:n) + n * (unclass(cl) - 1)] <- 1
        dimnames(x) <- list(row.names(df), paste(cha,levels(cl),sep="."))
        return(x)
    }
    G <- lapply(1:ncol(df), acm.util.df)
    G <- data.frame (G, check.names = FALSE)
    return(G)
}


fac2disj<- function(fac, drop = FALSE) {
  ## Returns the disjunctive table corrseponding to a factor
  n <- length(fac)
  fac <- as.factor(fac)
  if(drop)
    fac <- factor(fac)
  x <- matrix(0, n, nlevels(fac))
  x[(1:n) + n * (unclass(fac) - 1)] <- 1
  dimnames(x) <- list(names(fac), as.character(levels(fac)))
  return(data.frame(x, check.names = FALSE))
}
