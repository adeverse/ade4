"procuste" <- function (df1, df2, scale = TRUE, nf = 4, tol = 1e-07) {
    df1 <- data.frame(df1)
    df2 <- data.frame(df2)
    if (!is.data.frame(df1)) 
        stop("data.frame expected")
    if (!is.data.frame(df2)) 
        stop("data.frame expected")
    l1 <- nrow(df1)
    if (nrow(df2) != l1) 
        stop("Row numbers are different")
    if (any(row.names(df2) != row.names(df1))) 
        stop("row names are different")
    c1 <- ncol(df1)
    c2 <- ncol(df2)
    X <- scale(df1, scale = FALSE)
    Y <- scale(df2, scale = FALSE)
    var1 <- apply(X, 2, function(x) sum(x^2))
    var2 <- apply(Y, 2, function(x) sum(x^2))
    tra1 <- sum(var1)
    tra2 <- sum(var2)
    if (scale) {
        X <- X/sqrt(tra1)
        Y <- Y/sqrt(tra2)
    }
    PS <- t(X) %*% Y
    svd1 <- svd(PS)
    rank <- sum((svd1$d/svd1$d[1]) > tol)
    if (nf > rank) 
        nf <- rank
    u <- svd1$u[, 1:nf]
    v <- svd1$v[, 1:nf]
    scor1 <- X %*% u
    scor2 <- Y %*% v
    rot1 <- X %*% u %*% t(v)
    rot2 <- Y %*% v %*% t(u)
    res <- list()
    X <- data.frame(X)
    row.names(X) <- row.names(df1)
    names(X) <- names(df1)
    Y <- data.frame(Y)
    row.names(Y) <- row.names(df2)
    names(Y) <- names(df2)
    res$d <- svd1$d
    res$rank <- rank
    res$nfact <- nf
    u <- data.frame(u)
    row.names(u) <- names(df1)
    names(u) <- paste("ax", 1:nf, sep = "")
    v <- data.frame(v)
    row.names(v) <- names(df2)
    names(v) <- paste("ax", 1:nf, sep = "")
    scor1 <- data.frame(scor1)
    row.names(scor1) <- row.names(df1)
    names(scor1) <- paste("ax", 1:nf, sep = "")
    scor2 <- data.frame(scor2)
    row.names(scor2) <- row.names(df1)
    names(scor2) <- paste("ax", 1:nf, sep = "")
    if ((nf == c1) & (nf == c2)) {
        rot1 <- data.frame(rot1)
        row.names(rot1) <- row.names(df1)
        names(rot1) <- names(df2)
        rot2 <- data.frame(rot2)
        row.names(rot2) <- row.names(df1)
        names(rot2) <- names(df1)
        res$rot1 <- rot1
        res$rot2 <- rot2
    }
    res$tab1 <- X
    res$tab2 <- Y
    res$load1 <- u
    res$load2 <- v
    res$scor1 <- scor1
    res$scor2 <- scor2
    res$call <- match.call()
    class(res) <- "procuste"
    return(res)
}

"plot.procuste" <- function (x, xax = 1, yax = 2, ...) {
    if (!inherits(x, "procuste")) 
        stop("Use only with 'procuste' objects")
    if (x$nf == 1) {
        warnings("One axis only : not yet implemented")
        return(invisible())
    }
    if (xax > x$nf) 
        stop("Non convenient xax")
    if (yax > x$nf) 
        stop("Non convenient yax")
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    nf <- layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), 
        respect = TRUE)
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    s.arrow(x$load1, xax, yax, sub = "Loadings 1", csub = 2, 
        clab = 1.25)
    s.arrow(x$load2, xax, yax, sub = "Loadings 2", csub = 2, 
        clab = 1.25)
    scatterutil.eigen(x$d^2, wsel = c(xax, yax))
    s.match(x$scor1, x$scor2, xax, yax, clab = 1.5, sub = "Common projection", 
        csub = 2)
    s.label(x$scor1, xax = xax, yax = yax, sub = "Array 1", 
        csub = 2, clab = 1.25)
    s.label(x$scor2, xax = xax, yax = yax, sub = "Array 2", 
        csub = 2, clab = 1.25)
}

"print.procuste" <- function (x, ...) {
    cat("Procustes rotation\n")
    cat("call: ")
    print(x$call)
    cat(paste("class:", class(x)))
    cat(paste("\nrank:", x$rank))
    cat(paste("\naxis number:", x$nfact))
    cat("\nSingular value decomposition: ")
    l0 <- length(x$d)
    cat(signif(x$d, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
    cat("tab1   data.frame  ", nrow(x$tab1), "  ", ncol(x$tab1), 
        "   scaled array 1\n")
    cat("tab2   data.frame  ", nrow(x$tab2), "  ", ncol(x$tab2), 
        "   scaled array 2\n")
    cat("scor1  data.frame  ", nrow(x$scor1), " ", ncol(x$scor1), 
        "   row coordinates 1\n")
    cat("scor2  data.frame  ", nrow(x$scor2), " ", ncol(x$scor2), 
        "   row coordinates 2\n")
    cat("load1  data.frame  ", nrow(x$load1), " ", ncol(x$load1), 
        "   loadings 1\n")
    cat("load2  data.frame  ", nrow(x$load2), " ", ncol(x$load2), 
        "   loadings 2\n")
    if (length(names(x)) > 12) {
        cat("other elements: ")
        cat(names(x)[11:(length(x))], "\n")
    }
}
