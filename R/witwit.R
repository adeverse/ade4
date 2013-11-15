"witwit.coa" <- function (dudi, row.blocks, col.blocks, scannf = TRUE, nf = 2) {
    if (!inherits(dudi, "coa")) 
        stop("Object of class coa expected")
    lig <- nrow(dudi$tab)
    col <- ncol(dudi$tab)
    row.fac <- rep(1:length(row.blocks),row.blocks)
    col.fac <- rep(1:length(col.blocks),col.blocks)
    if (length(col.fac)!=col) stop ("Non convenient col.fac")
    if (length(row.fac)!=lig) stop ("Non convenient row.fac")
    tabinit <- as.matrix(eval.parent(as.list(dudi$call)$df))
    
    tabinit <- tabinit/sum(tabinit)
    # tabinit contient les pij
    wrmat <- rowsum(tabinit,row.fac, reorder = FALSE)[row.fac,]
    wrvec <- tapply(dudi$lw,row.fac,sum)[row.fac]
    wrvec <- as.numeric(wrvec)
    wrvec <- dudi$lw/wrvec
    wrmat <- wrmat*wrvec
    # wrmat contient les pi.*pd(i)j/pd(i)+
    
    wcmat <- rowsum(t(tabinit),col.fac, reorder = FALSE)[col.fac,]
    wcvec <- tapply(dudi$cw,col.fac,sum)[col.fac]
    wcvec <- as.numeric(wcvec)
    wcvec <- dudi$cw/wcvec
    wcmat <- t(wcmat*wcvec)
    # wcmat contient les pj.*pim(j)/p+m(j)
    wcmat <- wrmat+wcmat
    
    wrmat <- rowsum(tabinit,row.fac, reorder = FALSE)
    wrmat <- t(rowsum(t(wrmat),col.fac, reorder = FALSE))
    wrmat <- wrmat[row.fac,col.fac]
    wrmat <- wrmat*wrvec
    wrmat <- t(t(wrmat)*wcvec)
    # wrmat contient les pi.*p.j*pd(i)m(j)/pd(i)+/p+m(j)
    
    tabinit <- tabinit-wcmat+wrmat
    # le tableau est doublement centré par classe de lignes et de colonnes
    tabinit <- tabinit/dudi$lw
    tabinit <- t(t(tabinit)/dudi$cw)
    tabinit <- data.frame(tabinit)
    ww <- as.dudi(tabinit, dudi$cw, dudi$lw, scannf = scannf, nf = nf, 
        call = match.call(), type = "witwit")
   class(ww) <- c("witwit", "coa", "dudi")
 
    wr <- ww$li*ww$li*wrvec
    wr <- rowsum(as.matrix(wr),row.fac, reorder = FALSE)
    cha <- names(row.blocks)
    if (is.null(cha)) cha <- as.character(1:length(row.blocks))
    wr <- data.frame(wr)
    names(wr) <- names(ww$li)
    row.names(wr) <- cha
    ww$lbvar <- wr
    ww$lbw <- tapply(dudi$lw,row.fac,sum)

    wr <- ww$co*ww$co*wcvec
    wr <- rowsum(as.matrix(wr),col.fac, reorder = FALSE)
    cha <- names(col.blocks)
    if (is.null(cha)) cha <- as.character(1:length(col.blocks))
    wr <- data.frame(wr)
    names(wr) <- names(ww$co)
    row.names(wr) <- cha
    ww$cbvar <- wr
    ww$cbw <- tapply(dudi$cw,col.fac,sum)
    
    
   return(ww)
}

"summary.witwit" <- function (object, ...) {
    if (!inherits(object, "witwit")) 
        stop("For 'witwit' object")
    cat("Internal correspondence analysis\n")
    cat("class: ")
    cat(class(object))
    cat("\n$call: ")
    print(object$call)
    cat(object$nf, "axis-components saved")
    cat("\neigen values: ")
    l0 <- length(object$eig)
    cat(signif(object$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
    cat("\n")
    cat("Eigen value decomposition among row blocks\n")
    nf <- object$nf
    nrb <- nrow(object$lbvar)
    aa <- as.matrix(object$lbvar)
    sumry <- array("", c(nrb + 1, nf + 1), list(c(row.names(object$lbvar), 
        "mean"), c(names(object$lbvar), "weights")))
    sumry[(1:nrb), (1:nf)] <- round(aa, digits = 4)
    sumry[(1:nrb), (nf + 1)] <- round(object$lbw, digits = 4)
    sumry[(nrb + 1), (1:nf)] <- round(object$eig[1:nf], digits = 4)
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(nrb + 1, nf), list(c(row.names(object$lbvar), 
        "sum"), names(object$lbvar)))
    aa <- object$lbvar * object$lbw
    aa <- 1000 * t(t(aa)/object$eig[1:nf])
    sumry[(1:nrb), (1:nf)] <- round(aa, digits = 0)
    sumry[(nrb + 1), (1:nf)] <- rep(1000, nf)
    
    print(sumry, quote = FALSE)
    cat("\n")
    cat("Eigen value decomposition among column blocks\n")
    nrb <- nrow(object$cbvar)
    aa <- as.matrix(object$cbvar)
    sumry <- array("", c(nrb + 1, nf + 1), list(c(row.names(object$cbvar), 
        "mean"), c(names(object$cbvar), "weights")))
    sumry[(1:nrb), (1:nf)] <- round(aa, digits = 4)
    sumry[(1:nrb), (nf + 1)] <- round(object$cbw, digits = 4)
    sumry[(nrb + 1), (1:nf)] <- round(object$eig[1:nf], digits = 4)
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(nrb + 1, nf), list(c(row.names(object$cbvar), 
        "sum"), names(object$cbvar)))
    aa <- object$cbvar * object$cbw
    aa <- 1000 * t(t(aa)/object$eig[1:nf])
    sumry[(1:nrb), (1:nf)] <- round(aa, digits = 0)
    sumry[(nrb + 1), (1:nf)] <- rep(1000, nf)
    
    print(sumry, quote = FALSE)
    cat("\n")
}
