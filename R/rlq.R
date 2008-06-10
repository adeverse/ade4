"plot.rlq" <-
function (x, xax = 1, yax = 2, ...) 
{
    if (!inherits(x, "rlq")) 
        stop("Use only with 'rlq' objects")
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
    layout(matrix(c(1, 1, 3, 1, 1, 4, 2, 2,5,2,2,6,8,8,7), 3, 5), 
        respect = TRUE)
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    s.label(x$lR[, c(xax, yax)], sub = "R row scores",csub = 2,clab=1.25)
    s.label(x$lQ[, c(xax, yax)], sub = "Q row scores",csub = 2,clab=1.25)
    s.corcircle(x$aR, xax, yax, sub = "R axes", csub = 2, clab = 1.25)
    s.arrow(x$l1, xax = xax, yax = yax, sub = "R Canonical weights", csub = 2, clab = 1.25)
    s.corcircle(x$aQ, xax, yax, sub = "Q axes", csub = 2, clab = 1.25)
    s.arrow(x$c1, xax = xax, yax = yax, sub = "Q Canonical weights", csub = 2, clab = 1.25)
    scatterutil.eigen(x$eig, wsel = c(xax, yax))
    
    
}
"print.rlq" <-
function (x, ...) 
{
    if (!inherits(x, "rlq")) 
        stop("to be used with 'rlq' object")
    cat("RLQ analysis\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$rank (rank)     :", x$rank)
    cat("\n$nf (axis saved) :", x$nf)
    cat("\n$RV (RV coeff)   :", x$RV)
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
    class(sumry) <- "table"
    print(sumry)
    cat("\n")
    sumry <- array("", c(11, 4), list(1:11, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "crossed array (CA)")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "R col = CA row: coordinates")
    sumry[3, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "R col = CA row: normed scores")
    sumry[4, ] <- c("$co", nrow(x$co), ncol(x$co), "Q col = CA column: coordinates")
    sumry[5, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "Q col = CA column: normed scores")
    sumry[6, ] <- c("$lR", nrow(x$lR), ncol(x$lR), "row coordinates (R)")
    sumry[7, ] <- c("$mR", nrow(x$mR), ncol(x$mR), "normed row scores (R)")
    sumry[8, ] <- c("$lQ", nrow(x$lQ), ncol(x$lQ), "row coordinates (Q)")
    sumry[9, ] <- c("$mQ", nrow(x$mQ), ncol(x$mQ), "normed row scores (Q)")
    sumry[10, ] <- c("$aR", nrow(x$aR), ncol(x$aR), "axis onto rlq axis (R)")
    sumry[11, ] <- c("$aQ", nrow(x$aQ), ncol(x$aQ), "axis onto rlq (Q)")
    class(sumry) <- "table"
    print(sumry)
    cat("\n")
}
"rlq" <-
function( dudiR, dudiL, dudiQ , scannf = TRUE, nf = 2) {

    normalise.w <- function(X, w) {
    f2 <- function(v) sqrt(sum(v * v * w)/sum(w))
    norm <- apply(X, 2, f2)
    X <- sweep(X, 2, norm, "/")
    return(X)
    }
    

    if (!inherits(dudiR, "dudi")) 
        stop("Object of class dudi expected")
    lig1 <- nrow(dudiR$tab)
    
    if (!inherits(dudiL, "dudi")) 
        stop("Object of class dudi expected")
    if (!inherits(dudiL, "coa")) 
        stop("dudi.coa expected for table L")
    lig2 <- nrow(dudiL$tab)
    col2 <- ncol(dudiL$tab)
    if (!inherits(dudiQ, "dudi")) 
        stop("Object of class dudi expected")
    lig3 <- nrow(dudiQ$tab)

    if (lig1 != lig2) 
        stop("Non equal row numbers")
    if (any((dudiR$lw - dudiL$lw)^2 > 1e-07)) 
        stop("Non equal row weights")
    if (col2 != lig3) 
        stop("Non equal row numbers")
    if (any((dudiL$cw - dudiQ$lw)^2 > 1e-07)) 
        stop("Non equal row weights")
    tabcoiner <- t(as.matrix(dudiR$tab)) %*% diag(dudiL$lw) %*% (as.matrix(dudiL$tab)) %*% diag(dudiL$cw) %*% (as.matrix(dudiQ$tab))
    tabcoiner <- data.frame(tabcoiner)
    names(tabcoiner) <- names(dudiQ$tab)
    row.names(tabcoiner) <- names(dudiR$tab)
    if (nf > dudiR$nf) 
        nf <- dudiR$nf
    if (nf > dudiQ$nf) 
        nf <- dudiQ$nf
    coi <- as.dudi(tabcoiner, dudiQ$cw, dudiR$cw, scannf = scannf, nf = nf, call = match.call(), type = "rlq")
    U <- as.matrix(coi$c1) * unlist(coi$cw)
    U <- data.frame(as.matrix(dudiQ$tab) %*% U)
    row.names(U) <- row.names(dudiQ$tab)
    names(U) <- paste("AxcQ", (1:coi$nf), sep = "")
    coi$lQ <- U
    U <- normalise.w(U, dudiQ$lw)
    row.names(U) <- row.names(dudiQ$tab)
    names(U) <- paste("NorS", (1:coi$nf), sep = "")
    coi$mQ <- U
    U <- as.matrix(coi$l1) * unlist(coi$lw)
    U <- data.frame(as.matrix(dudiR$tab) %*% U)
    row.names(U) <- row.names(dudiR$tab)
    names(U) <- paste("AxcR", (1:coi$nf), sep = "")
    coi$lR <- U
    U <- normalise.w(U, dudiR$lw)
    row.names(U) <- row.names(dudiR$tab)
    names(U) <- paste("NorS", (1:coi$nf), sep = "")
    coi$mR <- U
    U <- as.matrix(coi$c1) * unlist(coi$cw)
    U <- data.frame(t(as.matrix(dudiQ$c1)) %*% U)
    row.names(U) <- paste("Ax", (1:dudiQ$nf), sep = "")
    names(U) <- paste("AxcQ", (1:coi$nf), sep = "")
    coi$aQ <- U
    U <- as.matrix(coi$l1) * unlist(coi$lw)
    U <- data.frame(t(as.matrix(dudiR$c1)) %*% U)
    row.names(U) <- paste("Ax", (1:dudiR$nf), sep = "")
    names(U) <- paste("AxcR", (1:coi$nf), sep = "")
    coi$aR <- U
    RV <- sum(coi$eig)/sqrt(sum(dudiQ$eig^2))/sqrt(sum(dudiR$eig^2))
    coi$RV <- RV
    return(coi)
    
}

"summary.rlq" <-
function (object, ...) 
{
    if (!inherits(object, "rlq")) 
        stop("to be used with 'rlq' object")
    appel <- as.list(object$call)
    dudiL <- eval(appel$dudiL, sys.frame(0))
    dudiR <- eval(appel$dudiR, sys.frame(0))
    dudiQ <- eval(appel$dudiQ, sys.frame(0))
    norm.w <- function(X, w) {
        f2 <- function(v) sqrt(sum(v * v * w)/sum(w))
        norm <- apply(X, 2, f2)
        return(norm)
    }
    util <- function(n) {
        x <- "1"
        for (i in 2:n) x[i] <- paste(x[i - 1], i, sep = "")
        return(x)
    }
    eig <- object$eig[1:object$nf]
    covar <- sqrt(eig)
    sdR <- norm.w(object$lR, dudiR$lw)
    sdQ <- norm.w(object$lQ, dudiQ$lw)
    corr <- covar/sdR/sdQ
    U <- cbind.data.frame(eig, covar, sdR, sdQ, corr)
    row.names(U) <- as.character(1:object$nf)
    cat("\nEigenvalues decomposition:\n")
    print(U)
    cat("\nInertia & coinertia R:\n")
    inertia <- cumsum(sdR^2)
    max <- cumsum(dudiR$eig[1:object$nf])
    ratio <- inertia/max
    U <- cbind.data.frame(inertia, max, ratio)
    row.names(U) <- util(object$nf)
    print(U)
    cat("\nInertia & coinertia Q:\n")
    inertia <- cumsum(sdQ^2)
    max <- cumsum(dudiQ$eig[1:object$nf])
    ratio <- inertia/max
    U <- cbind.data.frame(inertia, max, ratio)
    row.names(U) <- util(object$nf)
    print(U)
    cat("\nCorrelation L:\n")

    max <- sqrt(dudiL$eig[1:object$nf])
    ratio <- corr/max
    U <- cbind.data.frame(corr, max, ratio)
    row.names(U) <- 1:object$nf
    print(U)

}

randtest.rlq<-function(xtest, nrepet=999,...)
{
    nrepet<-nrepet+1
    if (!inherits(xtest,"dudi"))
        stop("Object of class dudi expected")
    if (!inherits(xtest,"rlq"))
        stop("Object of class 'rlq' expected")
    appel<-as.list(xtest$call)
    dudiR<-eval(appel$dudiR,sys.frame(0))
    dudiQ<-eval(appel$dudiQ,sys.frame(0))
    dudiL<-eval(appel$dudiL,sys.frame(0))
    acm.util <- function(cl) {
        n <- length(cl)
        cl <- as.factor(cl)
        x <- matrix(0, n, length(levels(cl)))
        x[(1:n) + n * (unclass(cl) - 1)] <- 1
        dimnames(x) <- list(names(cl), as.character(levels(cl)))
        data.frame(x)
    }

    R.cw<-dudiR$cw
    appelR<-as.list(dudiR$call)
    Rinit<-eval(appelR$df,sys.frame(0))
    if (appelR[[1]] == "dudi.pca") {
      appelR$scale<-eval(appelR$scale,sys.frame(0))
      appelR$center<-eval(appelR$center,sys.frame(0))
      if (is.null(appelR$scale)) appelR$scale<-TRUE
      if (is.null(appelR$center)) appelR$center<-TRUE
      if(!(is.logical(appelR$center))) stop("Not implemented for decentred PCA: read the documentation file.")      
      if (appelR$center == FALSE && appelR$scale == FALSE) typR<-"nc"
      if (appelR$center == FALSE && appelR$scale == TRUE) typR<-"cs"
      if (appelR$center == TRUE  && appelR$scale == FALSE) typR<-"cp"
      if (appelR$center == TRUE  && appelR$scale == TRUE) typR<-"cn"
      indexR<-rep("q",ncol(Rinit))
      assignR<-1:ncol(Rinit)
    } else if (appelR[[1]] == "dudi.coa") {
        typR<-"fc"
        indexR<-rep("q",ncol(Rinit))
        assignR<-1:ncol(Rinit)
    } else if (appelR[[1]] == "dudi.fca") {
        typR<-"fc"
        indexR<-rep("q",ncol(Rinit))
        assignR<-1:ncol(Rinit)
    } else if (appelR[[1]] == "dudi.acm") {
        typR<-"cm"
        indexR<-rep("f",ncol(Rinit))
        assignR<- rep(1:ncol(Rinit),apply(Rinit,2,function(x) length(levels(as.factor(x)))))
        Rinit <- acm.disjonctif(Rinit)
    } else if (appelR[[1]] == "dudi.hillsmith") {
        indexR<-dudiR$index
        assignR<-dudiR$assign
        typR<-"hi"
        res <- matrix(0, nrow(Rinit), 1)

            for (j in 1:(ncol(Rinit))) {
                if (indexR[j] == "q") {
                    res <- cbind(res, Rinit[, j])
                }
                else if (indexR[j] == "f") {
                    w <- acm.util(factor(Rinit[, j]))
                    res <- cbind(res, w)
                }
            }
            Rinit<-res[,-1]
        
    } else stop ("Not yet available")


    
    Q.cw<-dudiQ$cw
    appelQ<-as.list(dudiQ$call)
    Qinit<-eval(appelQ$df,sys.frame(0))
    
    if (appelQ[[1]] == "dudi.pca") {        
      appelQ$scale<-eval(appelQ$scale,sys.frame(0))
      appelQ$center<-eval(appelQ$center,sys.frame(0))
      if (is.null(appelQ$scale)) appelQ$scale<-TRUE
      if (is.null(appelQ$center)) appelQ$center<-TRUE
      if(!(is.logical(appelR$center))) stop("Not implemented for decentred PCA: read the documentation file.")      
      if (appelQ$center == FALSE && appelQ$scale == FALSE) typQ<-"nc"
      if (appelQ$center == FALSE && appelQ$scale == TRUE) typQ<-"cs"
      if (appelQ$center == TRUE  && appelQ$scale == FALSE) typQ<-"cp"
      if (appelQ$center == TRUE  && appelQ$scale == TRUE) typQ<-"cn"
      indexQ<-rep("q",ncol(Qinit))
      assignQ<-1:ncol(Qinit)
    } else if (appelQ[[1]] == "dudi.coa") {
        typQ<-"fc"
        indexQ<-rep("q",ncol(Qinit))
        assignQ<-1:ncol(Qinit)
    } else if (appelQ[[1]] == "dudi.fca") {
        typQ<-"fc"
        indexQ<-rep("q",ncol(Qinit))
        assignQ<-1:ncol(Qinit)
    } else if (appelQ[[1]] == "dudi.acm") {
        typQ<-"cm"
        indexQ<-rep("f",ncol(Qinit))
        assignQ<- rep(1:ncol(Qinit),apply(Qinit,2,function(x) length(levels(as.factor(x)))))
        Qinit <- acm.disjonctif(Qinit)
        
    } else if (appelQ[[1]] == "dudi.hillsmith") {
        indexQ<-dudiQ$index
        assignQ<-dudiQ$assign
 	 typQ<-"hi"
            res <- matrix(0, nrow(Qinit), 1)
            for (j in 1:(ncol(Qinit))) {
                if (indexQ[j] == "q") {
                    res <- cbind(res, Qinit[, j])
                }
                else if (indexQ[j] == "f") {
                    w <- acm.util(factor(Qinit[, j]))
                    res <- cbind(res, w)
                }
            }
            Qinit<-res[,-1]
        
    }  else stop ("Not yet available")  

    L<-dudiL$tab
    L.cw<-dudiL$cw
    L.lw<-dudiL$lw
    isim<-testertracerlq(nrepet, R.cw, Q.cw, L.lw, L.cw, Rinit,Qinit,L, typQ,typR,ifelse(indexR=='f',1,2),assignR,ifelse(indexQ=='f',1,2),assignQ)
    # On calcule le RV a partir de la coinertie
    obs<-isim[1]
    return(as.randtest(isim[-1],obs,call=match.call()))
}

testertracerlq<-function (npermut, pcR, pcQ, plL, pcL,tabR, tabQ, tabL,typQ, typR,indexR,assignR,indexQ,assignQ){ 
.C("testertracerlq", as.integer(npermut), as.double(pcR), as.integer(length(pcR)), 
    as.double(pcQ), as.integer(length(pcQ)), as.double(plL), as.integer(length(plL)),
    as.double(pcL), as.integer(length(pcL)), 
    as.double(t(tabR)), as.double(t(tabQ)),as.double(t(tabL)),
    as.integer(assignR),as.integer(assignQ),
    as.integer(indexR),as.integer (length(indexR)),as.integer(indexQ), as.integer (length(indexQ)),
    as.character(typQ), typR=as.character(typR), inersim = double(npermut+1), PACKAGE = "ade4")$inersim
}

