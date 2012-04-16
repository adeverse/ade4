"dudi.pco" <- function (d, row.w = "uniform", scannf = TRUE, nf = 2, full = FALSE,
    tol = 1e-07) 
{
    if (!inherits(d, "dist")) 
        stop("Distance matrix expected")
    if (full) 
        scannf <- FALSE
    distmat <- as.matrix(d)
    n <- ncol(distmat)
    rownames <- attr(d, "Labels")
    if (any(is.na(d))) 
        stop("missing value in d")
    if (is.null(rownames)) 
        rownames <- as.character(1:n)
    if (any(row.w == "uniform")) {
        row.w <- rep(1, n)
    }
    else {
        if (length(row.w) != n) 
            stop("Non convenient length(row.w)")
        if (any(row.w < 0)) 
            stop("Non convenient row.w (p<0)")
        if (any(row.w == 0)) 
            stop("Non convenient row.w (p=0)")
    }
    row.w <- row.w/sum(row.w)
    delta <- -0.5 * bicenter.wt(distmat * distmat, row.wt = row.w, 
        col.wt = row.w)
    wsqrt <- sqrt(row.w)
    delta <- delta * wsqrt
    delta <- t(t(delta) * wsqrt)
    eig <- eigen(delta, symmetric = TRUE)
    lambda <- eig$values
    w0 <- lambda[n]/lambda[1]
    if (w0 < -tol) 
        warning("Non euclidean distance")
    r <- sum(lambda > (lambda[1] * tol))
    if (scannf) {
        if (exists("ade4TkGUIFlag")) {
            nf <- ade4TkGUI::chooseaxes(lambda, length(lambda))
        } else {
            barplot(lambda)
            cat("Select the number of axes: ")
            nf <- as.integer(readLines(n = 1))
        }
    }
    if (nf <= 0) 
        nf <- 2
    if (nf > r) 
        nf <- r
    if (full) 
        nf <- r
    res <- list()
    res$eig <- lambda[1:r]
# valeurs propres variances des coordonnees
    res$rank <- r
# rang de la representation euclidienne
    res$nf <- nf
# nombre de facteurs conserves
    res$cw <- rep(1, r)
# poids des colonnes unitaires
    w <- t(t(eig$vectors[, 1:r]) * sqrt(lambda[1:r]))/wsqrt
    w <- data.frame(w)
    names(w) <- paste("A", 1:r, sep = "")
    row.names(w) <- rownames
    res$tab <- w
# res$tab contient la representation euclidienne globale
# tous les scores de variance lambda superieure a tol*(la plus grande)
    res$li <- data.frame(w[, 1:nf])
    names(res$li) <- names(res$tab)[1:nf]
# res$li contient la representation euclidienne 
# les nf premiers scores conserves
# cas particulier d'un tableau de coordonnees dont on fait l'ACP
    w <- t(t(eig$vectors[, 1:nf])/wsqrt)
    w <- data.frame(w)
    names(w) <- paste("RS", 1:nf, sep = "")
    row.names(w) <- rownames
    res$l1 <- w
# res$l1 contient les scores normes  
# pour la ponderation des individus
# Cette pco admet une ponderation de centrage arbitraire
# plus generale que cmdscale
    w <- data.frame(diag(1, r))
    row.names(w) <- names(res$tab)
    res$c1 <- data.frame(w[, 1:nf])
    names(res$c1) <- paste("CS", (1:nf), sep = "")
# res$c1 contient le debut de la base canonique
# cas particulier d'un tableau de coordonnees dont on fait l'ACP
    w <- data.frame(matrix(0, r, nf))
    w[1:nf, 1:nf] <- diag(sqrt(lambda[1:nf]),nrow=nf)
    names(w) <- paste("Comp", (1:nf), sep = "")
    row.names(w) <- names(res$tab)
    res$co <- w
# res$co indique que la variable est le composante * la norme
    res$lw <- row.w
# re$lw est le poids des lignes introduits si non uniforme
    res$call <- match.call()
    class(res) <- c("pco", "dudi")
    return(res)
}

"scatter.pco" <- function (x, xax = 1, yax = 2, clab.row = 1, posieig = "top",
    sub = NULL, csub = 2, ...) 
{
    if (!inherits(x, "pco")) 
        stop("Object of class 'pco' expected")
    opar <- par(mar = par("mar"))
    on.exit(par(opar))
    coolig <- x$li[, c(xax, yax)]
    s.label(coolig, clabel = clab.row, sub=sub, csub=csub)
    add.scatter.eig(x$eig, x$nf, xax, yax, posi = posieig, ratio = 1/4)
}
