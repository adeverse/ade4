wca.dpcoa <- function (x, fac, scannf = TRUE, nf = 2, ...){

    if (!inherits(x, "dpcoa")) 
        stop("Object of class dpcoa expected")
    if (!is.factor(fac)) 
        stop("factor expected")
    tabw <- tapply(x$lw, fac, sum)
    tabw <- tabw/sum(tabw)

    tabwit <- scalefacwt(x$tab, fac = fac, wt = x$lw, scale = FALSE, drop = FALSE)
    res <- as.dudi(tabwit, x$cw, x$lw, scannf = scannf, nf = nf, call = match.call(), type = "witdpcoa")
    res$ratio <- sum(res$eig)/sum(x$eig)
       
    U <- as.matrix(res$c1) * unlist(res$cw)
    U <- data.frame(as.matrix(x$tab) %*% U)
    row.names(U) <- row.names(x$tab)
    names(U) <- names(res$li)
    res$ls <- U
    
    U <- as.matrix(res$c1) * unlist(res$cw)
    U <- data.frame(t(as.matrix(x$c1)) %*% U)
    row.names(U) <- names(x$li)
    names(U) <- names(res$li)
    res$as <- U
    
    res$tabw <- tabw
    res$fac <- fac

    res$co <- res$l1 <- NULL

    ## add species information
    res$dw <- x$dw
    dis <- eval.parent(as.list(x$call)$dis)
    
    U <- as.matrix(dudi.pco(dis, row.w = x$dw, full = TRUE)$li) %*% as.matrix(res$c1)
    U <- data.frame(U)
    row.names(U) <- attr(dis, "Labels")
    res$dls <- U 
    class(res) <- c("witdpcoa", "within", "dudi")
    return(res)
}


bca.dpcoa <- function(x, fac, scannf = TRUE, nf = 2, ...){
    if (!inherits(x, "dpcoa")) 
        stop("Object of class dpcoa expected")
    if (!is.factor(fac)) 
        stop("factor expected")
    tabw <- tapply(x$lw, fac, sum)
    tabw <- as.vector(tabw/sum(tabw))
    
    tabmoy <- meanfacwt(df = x$tab, fac = fac, wt = x$lw, drop = FALSE)
    
    res <- as.dudi(data.frame(tabmoy), x$cw, tabw, scannf = scannf, nf = nf, call = match.call(), type = "betdpcoa")
    res$ratio <- sum(res$eig)/sum(x$eig)
       
    U <- as.matrix(res$c1) * unlist(res$cw)
    U <- data.frame(as.matrix(x$tab) %*% U)
    row.names(U) <- row.names(x$tab)
    names(U) <- names(res$li)
    res$ls <- U
    
    U <- as.matrix(res$c1) * unlist(res$cw)
    U <- data.frame(t(as.matrix(x$c1)) %*% U)
    row.names(U) <- names(x$li)
    names(U) <- names(res$li)
    res$as <- U
    
    res$fac <- fac

    res$co <- res$l1 <- NULL

    ## add species information
    res$dw <- x$dw 
    dis <- eval.parent(as.list(x$call)$dis)
    
    U <- as.matrix(dudi.pco(dis, row.w = x$dw, full = TRUE)$li) %*% as.matrix(res$c1)
    U <- data.frame(U)
    row.names(U) <- attr(dis, "Labels")
    res$dls <- U 
    class(res) <- c("betdpcoa", "between", "dudi")
    return(res)
}


bwca.dpcoa <- function(x, fac, cofac, scannf = TRUE, nf = 2, ...){

    if (!inherits(x, "dpcoa")) 
        stop("Object of class dpcoa expected")
    if (!is.factor(fac) || !is.factor(cofac) ) 
        stop("factor expected")

    cofac01 <- model.matrix( ~ -1 + cofac)
    fac01 <- model.matrix( ~ -1 + fac)
    x.resid <- lm.wfit(x = cofac01, y = fac01, w = x$lw)$residuals
    tab <- lm.wfit(x = x.resid, y = as.matrix(x$tab), w = x$lw)$fitted.values
    res <- as.dudi(data.frame(tab), x$cw, x$lw, scannf = scannf, nf = nf, call = match.call(), type = "betwitdpcoa")

    res$ratio <- sum(res$eig)/sum(x$eig)

    U <- as.matrix(res$c1) * unlist(res$cw)
    U <- data.frame(as.matrix(x$tab) %*% U)
    row.names(U) <- row.names(x$tab)
    names(U) <- names(res$li)
    res$ls <- U
    
    U <- as.matrix(res$c1) * unlist(res$cw)
    U <- data.frame(t(as.matrix(x$c1)) %*% U)
    row.names(U) <- names(x$li)
    names(U) <- names(res$li)
    res$as <- U

    res$fac <- fac
    res$cofac <- cofac
    
    res$co <- res$l1 <- NULL

    ## add species information
    res$dw <- x$dw
    dis <- eval.parent(as.list(x$call)$dis)
    
    U <- as.matrix(dudi.pco(dis, row.w = x$dw, full = TRUE)$li) %*% as.matrix(res$c1)
    U <- data.frame(U)
    row.names(U) <- attr(dis, "Labels")
    res$dls <- U 
    class(res) <- c("betwitdpcoa", "betwit", "dudi")
    return(res)
}





randtest.betwit <- function(xtest, nrepet = 999, ...){
    if (!inherits(xtest, "betwit")) 
        stop("Object of class 'betwit' expected")
    appel <- as.list(xtest$call)
    dudi1 <- eval.parent(appel$x)
    fac <- eval.parent(appel$fac)
    cofac <- eval.parent(appel$cofac)
    inertot <- sum(dudi1$eig)
    cofac01 <- model.matrix( ~ -1 + cofac)
    fac01 <- model.matrix( ~ -1 + fac)
    x.resid <- lm.wfit(x = cofac01, y = fac01, w = dudi1$lw)$residuals
    
    lm1 <- lm.wfit(x = cofac01, y = as.matrix(dudi1$tab), w = dudi1$lw)
    Y.r <- lm1$residuals
    Y.f <- lm1$fitted.values
    
    wt <- outer(sqrt(dudi1$lw), sqrt(dudi1$cw))
    obs <- sum((lm.wfit(y = Y.f + Y.r, x = x.resid, w = dudi1$lw)$fitted.values * wt)^2)/inertot
    isim <- c()
    ## permutation under reduced-model
    for (i in 1:nrepet)
        isim[i] <- sum((lm.wfit(y =  Y.f + Y.r[sample(nrow(Y.r)), ], x = x.resid, w = dudi1$lw)$fitted.values * wt)^2)/inertot
    return(as.randtest(isim, obs, call = match.call()))
}






summary.betwit <- function(object, ...){
    thetitle <- "Between within-class analysis"
    cat(thetitle)
    cat("\n\n")
    NextMethod()
    appel <- as.list(object$call)
    dudi <- eval.parent(appel$x)
    cat(paste("Total unconstrained inertia (", deparse(appel$x), 
              "): ", sep = ""))
    cat(signif(sum(dudi$eig), 4))
    cat("\n\n")
    cat(paste("Inertia of", deparse(appel$x), "independent of", 
              deparse(appel$cofac), "explained by", deparse(appel$fac), "(%): "))
    cat(signif(object$ratio * 100, 4))
    cat("\n\n")
}



print.witdpcoa <- function (x, ...){
    if (!inherits(x, "witdpcoa")) 
        stop("to be used with 'witdpcoa' object")
    cat("Within double principal coordinate analysis\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$nf (axis saved) :", x$nf)
    cat("\n$rank: ", x$rank)
    cat("\n$ratio: ", x$ratio)
    cat("\n\neigen values: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n\n")
    else cat("\n\n")
    
    sumry <- array("", c(5, 4), list(1:5, c("vector", "length", 
                                              "mode", "content")))
    sumry[1, ] <- c("$dw", length(x$dw), mode(x$dw), "category weights")
    sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), "collection weights")
    sumry[3, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    sumry[4, ] <- c("$tabw", length(x$tabw), mode(x$tabw), "class weigths")
    sumry[5, ] <- c("$fac", length(x$fac), mode(x$fac), "factor for grouping")
    
    print(sumry, quote = FALSE)
    cat("\n")
    
    sumry <- array("", c(5, 4), list(1:5, c("data.frame", "nrow", 
                                              "ncol", "content")))
    sumry[1, ] <- c("$dls", nrow(x$dls), ncol(x$dls), "coordinates of the categories")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "coordinates of the collections")
    sumry[3, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "scores of the principal axes of the categories")
    sumry[4, ] <- c("$ls", nrow(x$ls), ncol(x$ls), "projection of the original collections")
    sumry[5, ] <- c("$as", nrow(x$as), ncol(x$as), "dpcoa axes onto wca axes")
    
    print(sumry, quote = FALSE)
}


print.betdpcoa <- function (x, ...){
    if (!inherits(x, "betdpcoa")) 
        stop("to be used with 'betdpcoa' object")
    cat("Between double principal coordinate analysis\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$nf (axis saved) :", x$nf)
    cat("\n$rank: ", x$rank)
    cat("\n$ratio: ", x$ratio)
    cat("\n\neigen values: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n\n")
    else cat("\n\n")
    
    sumry <- array("", c(4, 4), list(1:4, c("vector", "length", 
                                              "mode", "content")))
    sumry[1, ] <- c("$dw", length(x$dw), mode(x$dw), "category weights")
    sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), "collection weights")
    sumry[3, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    sumry[4, ] <- c("$fac", length(x$fac), mode(x$fac), "factor for grouping")
    
    print(sumry, quote = FALSE)
    cat("\n")
    
    sumry <- array("", c(5, 4), list(1:5, c("data.frame", "nrow", 
                                              "ncol", "content")))
    sumry[1, ] <- c("$dls", nrow(x$dls), ncol(x$dls), "coordinates of the categories")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "coordinates of the classes")
    sumry[3, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "scores of the principal axes of the categories")
    sumry[4, ] <- c("$ls", nrow(x$ls), ncol(x$ls), "coordinates of the collections")
    sumry[5, ] <- c("$as", nrow(x$as), ncol(x$as), "dpcoa axes onto wca axes")
    
    print(sumry, quote = FALSE)
}
