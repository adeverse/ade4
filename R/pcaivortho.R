"pcaivortho" <- function (dudi, df, scannf = TRUE, nf = 2) {
    lm.pcaiv <- function(x, df, weights, use) {
        if (!inherits(df, "data.frame")) 
            stop("data.frame expected")
        reponse.generic <- x
        begin <- "reponse.generic ~ "
        fmla <- as.formula(paste(begin, paste(names(df), collapse = "+")))
        df <- cbind.data.frame(reponse.generic, df)
        lm0 <- lm(fmla, data = df, weights = weights)
        if (use == 0) 
            return(predict(lm0))
        else if (use == 1) 
            return(residuals(lm0))
        else if (use == -1) 
            return(lm0)
        else stop("Non convenient use")
    }
    if (!inherits(dudi, "dudi")) 
        stop("dudi is not a 'dudi' object")
    df <- data.frame(df)
    if (!inherits(df, "data.frame")) 
        stop("df is not a 'data.frame'")
    if (nrow(df) != length(dudi$lw)) 
        stop("Non convenient dimensions")
    weights <- dudi$lw
    isfactor <- unlist(lapply(as.list(df), is.factor))
    for (i in 1:ncol(df)) {
        if (!isfactor[i]) 
            df[, i] <- scalewt(df[, i], weights)
    }
    tab <- data.frame(apply(dudi$tab, 2, lm.pcaiv, df = df, use = 1, 
        weights = dudi$lw))
    X <- as.dudi(tab, dudi$cw, dudi$lw, scannf = scannf, nf = nf, 
        call = match.call(), type = "pcaivortho")
    X$X <- df
    X$Y <- dudi$tab
    U <- as.matrix(X$c1) * unlist(X$cw)
    U <- as.matrix(dudi$tab) %*% U
    U <- data.frame(U)
    row.names(U) <- row.names(dudi$tab)
    names(U) <- names(X$li)
    X$ls <- U
   
    U <- as.matrix(X$c1) * unlist(X$cw)
    U <- data.frame(t(as.matrix(dudi$c1)) %*% U)
    row.names(U) <- names(dudi$li)
    names(U) <- names(X$li)
    X$as <- U
    return(X)
}
