"dudi.nsc" <- function (df, scannf = TRUE, nf = 2) {
    df <- as.data.frame(df)
    col <- ncol(df)
    if (any(df < 0)) 
        stop("negative entries in table")
    if ((N <- sum(df)) == 0) 
        stop("all frequencies are zero")
    row.w <- apply(df, 1, sum)/N
    col.w <- apply(df, 2, sum)/N
    df <- t(apply(df, 1, function(x) if (sum(x) == 0) 
        col.w
    else x/sum(x)))
    df <- sweep(df, 2, col.w)
    df <- data.frame(col * df)
    X <- as.dudi(df, rep(1, col)/col, row.w, scannf = scannf, 
        nf = nf, call = match.call(), type = "nsc")
    X$N <- N
    return(X)
}
