"mfa" <- function (X, option = c("lambda1", "inertia", "uniform", "internal"),
    scannf = TRUE, nf = 3) 
{
    if (!inherits(X, "ktab")) 
        stop("object 'ktab' expected")
    if (option[1] == "internal") {
        if (is.null(X$tabw)) {
            warning("Internal weights not found: uniform weigths are used")
            option <- "uniform"
        }
    }
    lw <- X$lw
    cw <- X$cw
    sepan <- sepan(X, nf = 4)
    nbloc <- length(sepan$blo)
    indicablo <- factor(rep(1:nbloc, sepan$blo))
    rank.fac <- factor(rep(1:nbloc, sepan$rank))
    ncw <- NULL
    tab.names <- names(X)[1:nbloc]
    auxinames <- ktab.util.names(X)
    option <- match.arg(option)
    if (option == "lambda1") {
        for (i in 1:nbloc) {
            ncw <- c(ncw, rep(1/sepan$Eig[rank.fac == i][1], 
                sepan$blo[i]))
        }
    }
    else if (option == "inertia") {
        for (i in 1:nbloc) {
            ncw <- c(ncw, rep(1/sum(sepan$Eig[rank.fac == i]), 
                sepan$blo[i]))
        }
    }
    else if (option == "uniform") 
        ncw <- rep(1, sum(sepan$blo))
    else if (option == "internal") 
        ncw <- rep(X$tabw, sepan$blo)
  
    ncw <- cw * ncw
    tab <- X[[1]]
    for (i in 2:nbloc) {
        tab <- cbind.data.frame(tab, X[[i]])
    }
    names(tab) <- auxinames$col
    anaco <- as.dudi(tab, col.w = ncw, row.w = lw, nf = nf, scannf = scannf, 
        call = match.call(), type = "mfa")
    nf <- anaco$nf
    afm <- list()
    afm$tab.names <- names(X)[1:nbloc]
    afm$blo <- X$blo
    afm$TL <- X$TL
    afm$TC <- X$TC
    afm$T4 <- X$T4
    afm$tab <- anaco$tab
    afm$eig <- anaco$eig
    afm$rank <- anaco$rank
    afm$li <- anaco$li
    afm$l1 <- anaco$l1
    afm$nf <- anaco$nf
    afm$lw <- anaco$lw
    afm$cw <- anaco$cw
    afm$co <- anaco$co
    afm$c1 <- anaco$c1
    projiner <- function(xk, qk, d, z) {
        w7 <- t(as.matrix(xk) * d) %*% as.matrix(z)
        iner <- apply(w7 * w7 * qk, 2, sum)
        return(iner)
    }
    link <- matrix(0, nbloc, nf)
    for (k in 1:nbloc) {
        xk <- X[[k]]
        q <- ncw[indicablo == k]
        link[k, ] <- projiner(xk, q, lw, anaco$l1)
    }
    link <- as.data.frame(link)
    names(link) <- paste("Comp", 1:nf, sep = "")
    row.names(link) <- tab.names
    afm$link <- link
    w <- matrix(0, nbloc * 4, nf)
    i1 <- 0
    i2 <- 0
    matl1 <- as.matrix(afm$l1)
    for (k in 1:nbloc) {
        i1 <- i2 + 1
        i2 <- i2 + 4
        tab <- as.matrix(sepan$L1[sepan$TL[, 1] == levels(sepan$TL[,1])[k], ])
        if (ncol(tab) > 4) 
            tab <- tab[, 1:4]
        if (ncol(tab) < 4) 
            tab <- cbind(tab, matrix(0, nrow(tab), 4 - ncol(tab)))
        tab <- t(tab * lw) %*% matl1
        for (i in 1:min(nf, 4)) {
            if (tab[i, i] < 0) {
                for (j in 1:nf) tab[i, j] <- -tab[i, j]
            }
        }
        w[i1:i2, ] <- tab
    }
    w <- data.frame(w)
    names(w) <- paste("Comp", 1:nf, sep = "")
    row.names(w) <- auxinames$tab
    afm$T4comp <- w
    w <- matrix(0, nrow(sepan$TL), ncol = nf)
    i1 <- 0
    i2 <- 0
    for (k in 1:nbloc) {
        i1 <- i2 + 1
        i2 <- i2 + length(lw)
        qk <- ncw[indicablo == k]
        xk <- as.matrix(X[[k]])
        w[i1:i2, ] <- (xk %*% (qk * t(xk))) %*% (matl1 * lw)
    }
    w <- data.frame(w)
    row.names(w) <- auxinames$row
    names(w) <- paste("Fac", 1:nf, sep = "")
    afm$lisup <- w
    afm$tabw <- X$tabw
    afm$call <- match.call()
    class(afm) <- c("mfa", "list")
    return(afm)
}


"plot.mfa" <- function (x, xax = 1, yax = 2, option.plot = 1:4, ...) {
    if (!inherits(x, "mfa")) 
        stop("Object of type 'mfa' expected")
    nf <- x$nf
    if (xax > nf) 
        stop("Non convenient xax")
    if (yax > nf) 
        stop("Non convenient yax")
    opar <- par(mar = par("mar"), mfrow = par("mfrow"), xpd = par("xpd"))
    on.exit(par(opar))
    mfrow <- n2mfrow(length(option.plot))
    par(mfrow = mfrow)
    for (j in option.plot) {
        if (j == 1) {
            coolig <- x$lisup[, c(xax, yax)]
            s.class(coolig, fac = as.factor(x$TL[, 2]), 
                label = row.names(x$li), cellipse = 0, sub = "Row projection", 
                csub = 1.5)
            add.scatter.eig(x$eig, x$nf, xax, yax, posi = "topleft", 
                ratio = 1/5)
        }
        if (j == 2) {
            coocol <- x$co[, c(xax, yax)]
            s.arrow(coocol, sub = "Col projection", csub = 1.5)
            add.scatter.eig(x$eig, x$nf, xax, yax, posi = "topleft", 
                ratio = 1/5)
        }
        if (j == 3) {
            s.corcircle(x$T4comp[x$T4[, 2] == levels(x$T4[,2])[1], ], 
                fullcircle = FALSE, sub = "Component projection", possub = "topright", 
                csub = 1.5)
            add.scatter.eig(x$eig, x$nf, xax, yax, posi = "bottomleft", 
                ratio = 1/5)
        }
        if (j == 4) {
            plot(x$link[, c(xax, yax)])
            scatterutil.grid(0)
            title(main = "Link")
            par(xpd = TRUE)
            scatterutil.eti(x$link[, xax], x$link[, yax], 
                label = row.names(x$link), clabel = 1)
        }
        if (j == 5) {
            scatterutil.eigen(x$eig, wsel = 1:x$nf, sub = "Eigen values", 
                csub = 2, possub = "topright")
        }
    }
}


"print.mfa" <- function (x, ...) {
    if (!inherits(x, "mfa")) 
        stop("non convenient data")
    cat("Multiple Factorial Analysis\n")
    cat(paste("list of class", class(x)))
    cat("\n$call: ")
    print(x$call)
    cat("$nf:", x$nf, "axis-components saved\n\n")
    sumry <- array("", c(6, 4), list(1:6, c("vector", "length", 
        "mode", "content")))
    sumry[1, ] <- c("$tab.names", length(x$tab.names), mode(x$tab.names), 
        "tab names")
    sumry[2, ] <- c("$blo", length(x$blo), mode(x$blo), "column number")
    sumry[3, ] <- c("$rank", length(x$rank), mode(x$rank), 
        "tab rank")
    sumry[4, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    sumry[5, ] <- c("$lw", length(x$lw), mode(x$lw), "row weights")
    sumry[6, ] <- c("$tabw", length(x$tabw), mode(x$tabw), 
        "array weights")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(11, 4), list(1:11, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "modified array")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "row coordinates")
    sumry[3, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "row normed scores")
    sumry[4, ] <- c("$co", nrow(x$co), ncol(x$co), "column coordinates")
    sumry[5, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "column normed scores")
    sumry[6, ] <- c("$lisup", nrow(x$lisup), ncol(x$lisup), 
        "row coordinates from each table")
    sumry[7, ] <- c("$TL", nrow(x$TL), ncol(x$TL), "factors for li l1")
    sumry[8, ] <- c("$TC", nrow(x$TC), ncol(x$TC), "factors for co c1")
    sumry[9, ] <- c("$T4", nrow(x$T4), ncol(x$T4), "factors for T4comp")
    sumry[10, ] <- c("$T4comp", nrow(x$T4comp), ncol(x$T4comp), 
        "component projection")
    sumry[11, ] <- c("$link", nrow(x$link), ncol(x$link), 
        "link array-total")
    
    print(sumry, quote = FALSE)
    cat("other elements: ")
    if (length(names(x)) > 19) 
        cat(names(x)[20:(length(mfa))], "\n")
    else cat("NULL\n")
}

"summary.mfa" <- function (object, ...) {
    if (!inherits(object, "mfa")) 
        stop("non convenient data")
    cat("Multiple Factorial Analysis\n")
    cat("rows:", nrow(object$tab), "columns:", ncol(object$tab))
    l0 <- length(object$eig)
    cat("\n\n$eig:", l0, "eigen values\n")
    cat(signif(object$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
}
