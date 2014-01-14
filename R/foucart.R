"foucart" <- function (X, scannf = TRUE, nf = 2) {
    if (!is.list(X)) 
        stop("X is not a list")
    nblo <- length(X)
    if (!all(unlist(lapply(X, is.data.frame)))) 
        stop("a component of X is not a data.frame")
    # vérification que chaque tableau de la liste a les 
    # mêmes dimensions
    blocks <- unlist(lapply(X, ncol))
    if (length(unique(blocks)) != 1) 
        stop("non equal col numbers among array")
    blocks <- unlist(lapply(X, nrow))
    if (length(unique(blocks)) != 1) 
        stop("non equal row numbers among array")
    r.n <- row.names(X[[1]])
    for (i in 1:nblo) {
        r.new <- row.names(X[[i]])
        if (any(r.new != r.n)) 
            stop("non equal row.names among array")
    }
    # vérification que chaque tableau de la liste a les 
    # mêmes noms
    unique.col.names <- names(X[[1]])
    for (i in 1:nblo) {
        c.new <- names(X[[i]])
        if (any(c.new != unique.col.names)) 
            stop
        ("non equal col.names among array")
    }
    # vérification que chaque tableau de la liste supporte 
    # une analyse des correspondances
    for (i in 1:nblo) {
        if (any(X[[i]] < 0)) 
            stop(paste("negative entries in data.frame", i))
        if (sum(X[[i]]) <= 0) 
            stop(paste("Non convenient sum in data.frame", i))
    }
    X <- ktab.list.df(X)
    auxinames <- ktab.util.names(X)
    blocks <- X$blo
    nblo <- length(blocks)
    tnames <- tab.names(X)
    tabm <- X[[1]]/sum(X[[1]])
    for (k in 2:nblo) tabm <- tabm + X[[k]]/sum(X[[k]])
    tabm <- tabm/nblo
    row.names(tabm) <- row.names(X)
    names(tabm) <- unique.col.names
    fouc <- dudi.coa(tabm, scannf = scannf, nf = nf)
    fouc$call <- match.call()
    class(fouc) <- c("foucart", "coa", "dudi")
    cooli <- suprow(fouc, X[[1]])$lisup
    for (k in 2:nblo) {
        cooli <- rbind(cooli, suprow(fouc, X[[k]])$lisup)
    }
    row.names(cooli) <- auxinames$row
    fouc$Tli <- cooli
    cooco <- supcol(fouc, X[[1]])$cosup
    for (k in 2:nblo) {
        cooco <- rbind(cooco, supcol(fouc, X[[k]])$cosup)
    }
    row.names(cooco) <- auxinames$col
    fouc$Tco <- cooco
    fouc$TL <- X$TL
    fouc$TC <- X$TC
    fouc$blocks <- blocks
    fouc$tab.names <- tnames
    fouc$call <- match.call()
    return(fouc)
}

"kplot.foucart" <- function (object, xax = 1, yax = 2, mfrow = NULL, which.tab = 1:length(object$blo),
    clab.r = 1, clab.c = 1.25, csub = 2, possub = "bottomright", ...) 
{
    if (!inherits(object, "foucart")) 
        stop("Object of type 'foucart' expected")
    opar <- par(ask = par("ask"), mfrow = par("mfrow"), mar = par("mar"))
    on.exit(par(opar))
    if (is.null(mfrow)) 
        mfrow <- n2mfrow(length(which.tab))
    par(mfrow = mfrow)
    nblo <- length(object$blo)
    if (length(which.tab) > prod(mfrow)) 
        par(ask = TRUE)
    rank.fac <- factor(rep(1:nblo, object$rank))
    nf <- ncol(object$li)
    coolig <- object$Tli[, c(xax, yax)]
    coocol <- object$Tco[, c(xax, yax)]
    names(coocol) <- names(coolig)
    cootot <- rbind.data.frame(coocol, coolig)
    if (clab.r > 0) 
        cpoi <- 0
    else cpoi <- 2
    for (ianal in which.tab) {
        coolig <- object$Tli[object$TL[, 1] == levels(object$TL[,1])[ianal], c(xax, yax)]
        coocol <- object$Tco[object$TC[, 1] == levels(object$TC[,1])[ianal], c(xax, yax)]
        s.label(cootot, clab = 0, cpoi = 0, sub = object$tab.names[ianal], 
            csub = csub, possub = possub)
        s.label(coolig, clab = clab.r, cpoi = cpoi, add.p = TRUE)
        s.label(coocol, clab = clab.c, add.p = TRUE)
    }
}

"plot.foucart" <- function (x, xax = 1, yax = 2, clab = 1, csub = 2, possub = "bottomright", ...) {
    if (!inherits(x, "foucart")) 
        stop("Object of type 'foucart' expected")
    opar <- par(ask = par("ask"), mfrow = par("mfrow"), mar = par("mar"))
    on.exit(par(opar))
    par(mfrow = c(2, 2))
    cootot <- x$li[, c(xax, yax)]
    auxi <- x$li[, c(xax, yax)]
    names(auxi) <- names(cootot)
    cootot <- rbind.data.frame(cootot, auxi)
    auxi <- x$Tli[, c(xax, yax)]
    names(auxi) <- names(cootot)
    cootot <- rbind.data.frame(cootot, auxi)
    auxi <- x$Tco[, c(xax, yax)]
    names(auxi) <- names(cootot)
    cootot <- rbind.data.frame(cootot, auxi)
    s.label(cootot, clabel = 0, cpoint = 0, sub = "Rows (Base)", 
        csub = csub, possub = possub)
    s.label(x$li, xax, yax, clabel = clab, add.plot = TRUE)
    s.label(cootot, clabel = 0, cpoint = 0, sub = "Columns (Base)", 
        csub = csub, possub = possub)
    s.label(x$co, xax, yax, clabel = clab, add.plot = TRUE)
    s.label(cootot, clabel = 0, cpoint = 0, sub = "Rows", csub = csub, 
        possub = possub)
    s.class(x$Tli, x$TL[, 2], xax = xax, yax = yax, 
        axesell = FALSE, clabel = clab, add.plot = TRUE)
    s.label(cootot, clabel = 0, cpoint = 0, sub = "Columns", 
        csub = csub, possub = possub)
    s.class(x$Tco, x$TC[, 2], xax = xax, yax = yax, 
        axesell = FALSE, clabel = clab, add.plot = TRUE)
}

"print.foucart" <- function (x, ...) {
    cat("Foucart's  COA\n")
    cat("class: ")
    cat(class(x))
    cat("\n$call: ")
    print(x$call)
    cat("table  number:", length(x$blo), "\n")
    cat("\n$nf:", x$nf, "axis-components saved")
    cat("\n$rank: ")
    cat(x$rank)
    cat("\neigen values: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
    cat("blo    vector      ", length(x$blo), "     blocks\n")
    sumry <- array("", c(3, 4), list(rep("", 3), c("vector", 
        "length", "mode", "content")))
    sumry[1, ] <- c("$cw", length(x$cw), mode(x$cw), "column weights")
    sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), "row weights")
    sumry[3, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(5, 4), list(rep("", 5), c("data.frame", 
        "nrow", "ncol", "content")))
    sumry[1, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "modified array")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "row coordinates")
    sumry[3, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "row normed scores")
    sumry[4, ] <- c("$co", nrow(x$co), ncol(x$co), "column coordinates")
    sumry[5, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "column normed scores")
    
    print(sumry, quote = FALSE)
    cat("\n     **** Intrastructure ****\n\n")
    sumry <- array("", c(4, 4), list(rep("", 4), c("data.frame", 
        "nrow", "ncol", "content")))
    sumry[1, ] <- c("$Tli", nrow(x$Tli), ncol(x$Tli), "row coordinates (each table)")
    sumry[2, ] <- c("$Tco", nrow(x$Tco), ncol(x$Tco), "col coordinates (each table)")
    sumry[3, ] <- c("$TL", nrow(x$TL), ncol(x$TL), "factors for Tli")
    sumry[4, ] <- c("$TC", nrow(x$TC), ncol(x$TC), "factors for Tco")
    
    print(sumry, quote = FALSE)
    cat("\n")
}
