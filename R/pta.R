"pta" <- function (X, scannf = TRUE, nf = 2) {
    # 21/08/02 Correction d'un bug suite à message de G. BALENT balent@toulouse.inra.fr
    if (!inherits(X, "ktab")) 
        stop("object 'ktab' expected")
    auxinames <- ktab.util.names(X)
    sepa <- sepan(X, nf = 4)
    blocks <- X$blo
    nblo <- length(blocks)
    tnames <- tab.names(X)
    lw <- X$lw
    lwsqrt <- sqrt(X$lw)
    nl <- length(lw)
    r.n <- row.names(X[[1]])
    for (i in 1:nblo) {
        r.new <- row.names(X[[i]])
        if (any(r.new != r.n)) 
            stop("non equal row.names among array")
    }
    if (length(unique(blocks)) != 1) 
        stop("non equal col numbers among array")
    unique.col.names <- names(X[[1]])
    for (i in 1:nblo) {
        c.new <- names(X[[i]])
        if (any(c.new != unique.col.names)) 
            stop("non equal col.names among array")
    }
    indica <- as.factor(rep(1:nblo, blocks))
    w <- split(X$cw, indica)
    cw <- w[[1]]
    for (i in 1:nblo) {
        col.w.new <- w[[i]]
        if (any(cw != col.w.new)) 
            stop("non equal column weights among array")
    }
    cwsqrt <- sqrt(cw)
    nc <- length(cw)
    atp <- list()
    for (i in 1:nblo) {
        w <- as.matrix(X[[i]]) * lwsqrt
        w <- t(t(w) * cwsqrt)
        atp[[i]] <- w
    }
    atp <- matrix(unlist(atp), nl * nc, nblo)
    RV <- t(atp) %*% atp
    ak <- sqrt(diag(RV))
    RV <- sweep(RV, 1, ak, "/")
    RV <- sweep(RV, 2, ak, "/")
    dimnames(RV) <- list(tnames, tnames)
    atp <- list()
    inter <- eigen(as.matrix(RV))
    if (any(inter$vectors[, 1] < 0)) 
        inter$vectors[, 1] <- -inter$vectors[, 1]
    is <- inter$vectors[, (1:min(c(nblo, 4)))]
    tabw <- as.vector(is[, 1])
    is <- t(t(is) * sqrt(inter$values[1:ncol(is)]))
    is <- as.data.frame(is)
    row.names(is) <- tnames
    names(is) <- paste("IS", 1:ncol(is), sep = "")
    atp$RV <- RV
    atp$RV.eig <- inter$values
    atp$RV.coo <- is
    atp$tabw <- tabw
    tab <- X[[1]] * tabw[1]
    for (i in 2:nblo) {
        tab <- tab + X[[i]] * tabw[i]
    }
    tab <- as.data.frame(tab, row.names = row.names(X))
    names(tab) <- unique.col.names
    comp <- as.dudi(tab, col.w = cw, row.w = lw, nf = nf, scannf = scannf, 
        call = match.call(), type = "pta")
    atp$rank <- comp$rank
    nf <- atp$nf <- comp$nf
    atp$tab <- comp$tab
    atp$lw <- comp$lw
    atp$cw <- comp$cw
    atp$eig <- comp$eig
    atp$li <- comp$li
    atp$co <- comp$co
    atp$l1 <- comp$l1
    atp$c1 <- comp$c1
    w1 <- matrix(0, nblo * 4, nf)
    w2 <- matrix(0, nblo * 4, nf)
    i1 <- 0
    i2 <- 0
    for (k in 1:nblo) {
        i1 <- i2 + 1
        i2 <- i2 + 4
        tab1 <- as.matrix(sepa$L1[X$TL[, 1] == levels(X$TL[,1])[k], ])
        tab1 <- t(tab1 * lw) %*% as.matrix(comp$l1)
        tab2 <- as.matrix(sepa$C1[X$TC[, 1] == levels(X$TC[, 1])[k], ])
        tab2 <- (t(tab2) * cw) %*% as.matrix(comp$c1)
        for (i in 1:min(nf, 4)) {
            if (tab2[i, i] < 0) {
                for (j in 1:nf) tab2[i, j] <- -tab2[i, j]
            }
            if (tab1[i, i] < 0) {
                for (j in 1:nf) tab1[i, j] <- -tab1[i, j]
            }
        }
        w1[i1:i2, ] <- tab1
        w2[i1:i2, ] <- tab2
    }
    w1 <- data.frame(w1, row.names = auxinames$tab)
    w2 <- data.frame(w2, row.names = auxinames$tab)
    names(w2) <- names(w1) <- paste("C", 1:nf, sep = "")
    atp$Tcomp <- w1
    atp$Tax <- w2
    tab <- as.matrix(X[[1]])
    w <- as.matrix(comp$c1)
    cooli <- t(t(tab) * cw) %*% w
    for (k in 2:nblo) {
        tab <- as.matrix(X[[k]])
        cooliauxi <- t(t(tab) * cw) %*% w
        cooli <- rbind(cooli, cooliauxi)
    }
    cooli <- data.frame(cooli, row.names = auxinames$row)
    atp$Tli <- cooli
    tab <- as.matrix(X[[1]])
    w <- as.matrix(comp$l1) * lw
    cooco <- t(tab) %*% w
    for (k in 2:nblo) {
        tab <- as.matrix(X[[k]])
        coocoauxi <- t(tab) %*% w
        cooco <- rbind(cooco, coocoauxi)
    }
    cooco <- data.frame(cooco, row.names = auxinames$col)
    atp$Tco <- cooco
    normcompro <- sum(atp$eig)
    indica <- as.factor(rep(1:nblo, sepa$rank))
    w <- split(sepa$Eig, indica)
    normtab <- unlist(lapply(w, sum))
    covv <- rep(0, nblo)
    w1 <- atp$tab * lwsqrt
    w1 <- t(t(w1) * cwsqrt)
    for (k in 1:nblo) {
        wk <- X[[k]] * lwsqrt
        wk <- t(t(wk) * cwsqrt)
        covv[k] <- sum(w1 * wk)
    }
    atp$cos2 <- covv/sqrt(normcompro)/sqrt(normtab)
    atp$TL <- X$TL
    atp$TC <- X$TC
    atp$T4 <- X$T4
    atp$blo <- X$blo
    atp$tab.names <- tnames
    atp$call <- match.call()
    class(atp) <- c("pta", "dudi")
    if (!inherits (X,"kcoinertia")) return(atp) 
    # Modifs pour prendre en compte STATICO
    # on a affaire a une pta de type STATICO
    # nblo nombre de tableau
    blocks <- X$supblo
    nblo <- length(blocks)
    w <- NULL
    for (i in 1:nblo) w <- c(w, 1:blocks[i])
    w <- cbind.data.frame(factor(rep(1:nblo, blocks)), factor(w))
    names(w) <- c("T", "I")
    atp$supTI <- w
	supTInames <- as.data.frame(matrix(unlist(strsplit(auxinames$Trow, "[.]")), ncol=2, byrow=T))
    levels(atp$supTI$T) <- atp$tab.names
    levels(atp$supTI$I) <- supTInames[,2]
#    atp$supTI <- auxinames$Trow
#    atp$supTI <- as.data.frame(matrix(unlist(strsplit(auxinames$Trow, "[.]")), ncol=2, byrow=T))
#	names(atp$supTI) <- c("T", "I")
	lw <- X$suplw
    lw <- split(lw, factor(rep(1:length(blocks),blocks)))
    lw <- lapply(lw, function(x) x/sum(x))
    lw <- unlist(lw)    
    # les lignes d'origine en supplémentaires X
    w <- X$supX%*%as.matrix(atp$l1*atp$lw)
# Correction des row names - JT 7 - Jan 2014
    w <- data.frame(w, row.names = auxinames$Trow)
    w <- scalewt(w, lw, center = FALSE, scale = TRUE)
    w <- as.data.frame(w)
    names(w) <- gsub("RS","sco",names(atp$l1))
    atp$supIX <- w
    # les lignes d'origine en supplémentaires Y
    w <- X$supY%*%as.matrix(atp$c1*atp$cw)
# Correction des row names - JT - 7 Jan 2014
    w <- data.frame(w, row.names = auxinames$Trow)
    w <- scalewt(w, lw, center = FALSE, scale = TRUE)
    w <- as.data.frame(w)
    names(w) <- gsub("RS","sco",names(atp$l1))
    atp$supIY <- w
    return(atp)
}
 

"plot.pta" <- function (x, xax = 1, yax = 2, option = 1:4, ...) {
    if (!inherits(x, "pta")) 
        stop("Object of type 'pta' expected")
    nf <- x$nf
    if (xax > nf) 
        stop("Non convenient xax")
    if (yax > nf) 
        stop("Non convenient yax")
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    mfrow <- n2mfrow(length(option))
    par(mfrow = mfrow)
    for (j in option) {
        if (j == 1) {
            coolig <- x$RV.coo[, c(1, 2)]
            s.corcircle(coolig, label = x$tab.names, 
                cgrid = 0, sub = "Interstructure", csub = 1.5, 
                possub = "topleft", fullcircle = TRUE)
            l0 <- length(x$RV.eig)
            add.scatter.eig(x$RV.eig, l0, 1, 2, posi = "bottomleft", 
                ratio = 1/4)
        }
        if (j == 2) {
            coolig <- x$li[, c(xax, yax)]
            s.label(coolig, sub = "Compromise", csub = 1.5, 
                possub = "topleft", )
            add.scatter.eig(x$eig, x$nf, xax, yax, posi = "bottomleft", 
                ratio = 1/4)
        }
        if (j == 3) {
            cooco <- x$co[, c(xax, yax)]
            s.arrow(cooco, sub = "Compromise", csub = 1.5, 
                possub = "topleft")
        }
        if (j == 4) {
            plot(x$tabw, x$cos2, xlab = "Tables weights", 
                ylab = "Cos 2")
            scatterutil.grid(0)
            title(main = "Typological value")
            par(xpd = TRUE)
            scatterutil.eti(x$tabw, x$cos2, label = x$tab.names, 
                clabel = 1)
        }
    }
}


"print.pta" <- function (x, ...) {
    cat("Partial Triadic Analysis\n")
    cat("class:")
    cat(class(x), "\n")
    cat("table number:", length(x$blo), "\n")
    cat("row number:", length(x$lw), "  column number:", length(x$cw), 
        "\n")
    cat("\n     **** Interstructure ****\n")
    cat("\neigen values: ")
    l0 <- length(x$RV.eig)
    cat(signif(x$RV.eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
    cat(" $RV       matrix      ", nrow(x$RV), "    ", ncol(x$RV), "    RV coefficients\n")
    cat(" $RV.eig   vector      ", length(x$RV.eig), "      eigenvalues\n")
    cat(" $RV.coo   data.frame  ", nrow(x$RV.coo), "    ", ncol(x$RV.coo), 
        "   array scores\n")
    cat(" $tab.names    vector      ", length(x$tab.names), "       array names\n")
    cat("\n      **** Compromise ****\n")
    cat("\neigen values: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
    cat("\n $nf:", x$nf, "axis-components saved")
    cat("\n $rank: ")
    cat(x$rank, "\n\n")
    sumry <- array("", c(5, 4), list(rep("", 5), c("vector", 
        "length", "mode", "content")))
    sumry[1, ] <- c("$tabw", length(x$tabw), mode(x$tabw), "array weights")
    sumry[2, ] <- c("$cw", length(x$cw), mode(x$cw), "column weights")
    sumry[3, ] <- c("$lw", length(x$lw), mode(x$lw), "row weights")
    sumry[4, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    sumry[5, ] <- c("$cos2", length(x$cos2), mode(x$cos2), "cosine^2 between compromise and arrays")
    
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
    sumry <- array("", c(7, 4), list(rep("", 7), c("data.frame", 
        "nrow", "ncol", "content")))
    sumry[1, ] <- c("$Tli", nrow(x$Tli), ncol(x$Tli), "row coordinates (each table)")
    sumry[2, ] <- c("$Tco", nrow(x$Tco), ncol(x$Tco), "col coordinates (each table)")
    sumry[3, ] <- c("$Tcomp", nrow(x$Tcomp), ncol(x$Tcomp), "principal components (each table)")
    sumry[4, ] <- c("$Tax", nrow(x$Tax), ncol(x$Tax), "principal axis (each table)")
    sumry[5, ] <- c("$TL", nrow(x$TL), ncol(x$TL), "factors for Tli")
    sumry[6, ] <- c("$TC", nrow(x$TC), ncol(x$TC), "factors for Tco")
    sumry[7, ] <- c("$T4", nrow(x$T4), ncol(x$T4), "factors for Tax Tcomp")
    
    print(sumry, quote = FALSE)
    cat("\n")
}

