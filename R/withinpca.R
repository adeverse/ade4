"withinpca" <- function (df, fac, scaling = c("partial", "total"), scannf = TRUE,
    nf = 2) 
{
    if (!inherits(df, "data.frame")) 
        stop("Object of class 'data.frame' expected")
    if (!is.factor(fac)) 
        stop("factor expected")
    lig <- nrow(df)
    if (length(fac) != lig) 
        stop("Non convenient dimension")
    cla.w <- tapply(rep(1, length(fac)), fac, sum)
    df <- data.frame(scalewt(df))
    mean.w <- function(x) tapply(x, fac, sum)/cla.w
    tabmoy <- apply(df, 2, mean.w)
    tabw <- cla.w
    tabw <- tabw/sum(tabw)
    tabwit <- df
    tabwit <- tabwit - tabmoy[fac, ]
    scaling <- match.arg(scaling)
    if (scaling == "total") {
        tabwit <- scalewt(tabwit, center = FALSE, scale = TRUE)
    }
    else if (scaling == "partial") {
        for (j in levels(fac)) {
            w <- tabwit[fac == j, ]
            w <- scalewt(w)
            tabwit[fac == j, ] <- w
        }
    }
    
    tabwit <- data.frame(tabwit)
    
    df <- tabwit + tabmoy[fac, ]
    
    dudi <- as.dudi(df, row.w = rep(1, nrow(df))/nrow(df), col.w = rep(1, 
        ncol(df)), scannf = FALSE, nf = 4, call = match.call(), 
        type = "tmp")
    X <- as.dudi(tabwit, row.w = rep(1, nrow(df))/nrow(df), col.w = rep(1, 
        ncol(df)), scannf = scannf, nf = nf, call = match.call(), 
        type = "wit")
    X$ratio <- sum(X$eig)/sum(dudi$eig)
    U <- as.matrix(X$c1) * unlist(X$cw)
    U <- data.frame(as.matrix(dudi$tab) %*% U)
    row.names(U) <- row.names(dudi$tab)
    names(U) <- names(X$c1)
    X$ls <- U
    U <- as.matrix(X$c1) * unlist(X$cw)
    U <- data.frame(t(as.matrix(dudi$c1)) %*% U)
    row.names(U) <- names(dudi$li)
    names(U) <- names(X$li)
    X$as <- U
    X$tabw <- tabw
    X$fac <- fac
    class(X) <- c("within", "dudi")
    return(X)
}
