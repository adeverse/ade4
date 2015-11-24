dpcoa <- function (df, dis = NULL, scannf = TRUE, nf = 2, full = FALSE, tol = 1e-07, RaoDecomp = TRUE) 
{
    if (!inherits(df, "data.frame")) 
        stop("df is not a data.frame")
    if (any(df < 0)) 
        stop("Negative value in df")
    if (any(rowSums(df) < tol)) 
        stop("Remove empty samples")
    nesp <- ncol(df)
    nrel <- nrow(df)
    if (!is.null(dis)) {
        if (!inherits(dis, "dist")) 
            stop("dis is not an object 'dist'")
        n1 <- attr(dis, "Size")
        if (nesp != n1) 
            stop("Non convenient dimensions")
        if (!is.euclid(dis)) 
            stop("an Euclidean matrix is needed")
    }
    if (is.null(dis)) {
        dis <- (matrix(1, nesp, nesp) - diag(rep(1, nesp))) * sqrt(2)
        rownames(dis) <- colnames(dis) <- names(df)
        dis <- as.dist(dis)
    }
    if (is.null(attr(dis, "Labels"))) 
        attr(dis, "Labels") <- names(df)
    
    d <- as.matrix(dis)
    d <- (d^2) / 2
    
    w.samples <- rowSums(df)/sum(df)
    w.esp <- colSums(df)/sum(df) 
    dfp <- as.matrix(sweep(df, 1, rowSums(df), "/"))

    ## Eigenanalysis
    pco1 <- dudi.pco(dis, row.w = w.esp, full = TRUE)
    wrel <- data.frame(dfp %*% as.matrix(pco1$li))
    row.names(wrel) <- rownames(df)
    res <- as.dudi(wrel, rep(1, ncol(wrel)), w.samples, scannf = scannf, nf = nf, call = match.call(), type = "dpcoa", tol = tol, full = full)
    ## lw was w2
    ## li was l2
    w <- as.matrix(pco1$li) %*% as.matrix(res$c1)
    w <- data.frame(w)
    row.names(w) <- names(df)
    res$dls <- w ## was l1
    res$dw <- w.esp ## was w1
    res$co <- res$l1 <- NULL
    
    ## Returns some infomation related to Rao Entropy
    if(RaoDecomp){
        res$RaoDiv <- apply(dfp, 1, function(x) sum(d * outer(x, x)))
        
        fun1 <- function(x) {
            w <- -sum(d * outer (x, x))
            return(sqrt(w))
        }
        dnew <- matrix(0, nrel, nrel)
        idx <- dfp[col(dnew)[col(dnew) < row(dnew)], ] - dfp[row(dnew)[col(dnew) < row(dnew)], ]
        dnew <- apply(idx, 1, fun1)
        attr(dnew, "Size") <- nrel
        attr(dnew, "Labels") <- rownames(df)
        attr(dnew, "Diag") <- TRUE
        attr(dnew, "Upper") <- FALSE
        attr(dnew, "method") <- "dis"
        attr(dnew, "call") <- match.call()
        class(dnew) <- "dist"
        res$RaoDis <- dnew
        
        Bdiv <- crossprod(w.samples, (as.matrix(dnew)^2)/2) %*% w.samples
        Tdiv <- crossprod(w.esp, d) %*% (w.esp)
        Wdiv <- Tdiv - Bdiv
        divdec <- data.frame(c(Bdiv, Wdiv, Tdiv))
        names(divdec) <- "Diversity"
        rownames(divdec) <- c("Between-samples diversity", "Within-samples diversity", "Total diversity")
        res$RaoDecodiv <- divdec
    }

    class(res) <- "dpcoa"
    return(res)
}



plot.dpcoa <- function(x, xax = 1, yax = 2, ...) {
    if (!inherits(x, "dpcoa"))
        stop("Object of type 'dpcoa' expected")
    nf <- x$nf
    if (xax > nf)
        stop("Non convenient xax")
    if (yax > nf)
        stop("Non convenient yax")
    opar <- par(no.readonly = TRUE)
    on.exit (par(opar))
    par(mfrow = c(2,2))
    s.corcircle(x$c1[, c(xax, yax)], cgrid = 0, 
                sub = "Principal axes", csub = 1.5, possub = "topleft", fullcircle = TRUE)
    add.scatter.eig(x$eig, length(x$eig), xax, yax, posi = "bottomleft", ratio = 1/4)
    X <- as.list(x$call)[[2]]
    X <- eval.parent(X)
    s.distri(x$dls[, c(xax, yax)], t(X), cellipse = 1, cstar = 0,
             sub = "Categories & Collections", possub = "bottomleft", csub = 1.5)
    s.label(x$dls[, c(xax, yax)], sub = "Categories", possub = "bottomleft", csub = 1.5)
    if(!is.null(x$RaoDiv))
        s.value(x$li[, c(xax, yax)], x$RaoDiv, sub = "Rao Divcs")
    else
        s.label(x$li[, c(xax, yax)], sub = "Collections", possub = "bottomleft", csub = 1.5)
    
}

summary.dpcoa <- function(object, ...){
    summary.dudi(dpcoa, ...)
}


print.dpcoa <- function (x, ...) 
{
    if (!inherits(x, "dpcoa")) 
        stop("to be used with 'dpcoa' object")
    cat("Double principal coordinate analysis\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$nf (axis saved) :", x$nf)
    cat("\n$rank: ", x$rank)
    cat("\n\neigen values: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n\n")
    else cat("\n\n")

    nr <- ifelse(!is.null(x$RaoDecomp), 4, 3)
    sumry <- array("", c(nr, 4), list(1:nr, c("vector", "length", 
                                              "mode", "content")))
    sumry[1, ] <- c("$dw", length(x$dw), mode(x$dw), "category weights")
    sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), "collection weights")
    sumry[3, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    if(nr == 4)
        sumry[4, ] <- c("$RaoDiv", length(x$RaoDiv), mode(x$RaoDiv), 
                        "diversity coefficients within collections")
    print(sumry, quote = FALSE)
    cat("\n")
    
    if(!is.null(x$RaoDecomp)){
        sumry <- array("", c(1, 3), list(1:1, c("dist", "Size", "content")))
        sumry[1, ] <- c("$RaoDis", attributes(x$RaoDis)$Size, "distances among collections")
        print(sumry, quote = FALSE)
        cat("\n")
    }
    
    sumry <- array("", c(nr, 4), list(1:nr, c("data.frame", "nrow", 
                                              "ncol", "content")))
    sumry[1, ] <- c("$dls", nrow(x$dls), ncol(x$dls), "coordinates of the categories")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "coordinates of the collections")
    sumry[3, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "scores of the principal axes of the categories")
    if(nr == 4)
        sumry[4, ] <- c("$RaoDecodiv", 3, 1, "decomposition of diversity")
    print(sumry, quote = FALSE)
}
