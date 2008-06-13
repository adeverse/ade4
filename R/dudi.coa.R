"dudi.coa" <- function (df, scannf = TRUE, nf = 2) {
    df <- as.data.frame(df)
    if (!is.data.frame(df)) 
        stop("data.frame expected")
    if (any(df < 0)) 
        stop("negative entries in table")
    if ((N <- sum(df)) == 0) 
        stop("all frequencies are zero")
    df <- df/N
    row.w <- apply(df, 1, sum)
    col.w <- apply(df, 2, sum)
    df <- df/row.w
    df <- sweep(df, 2, col.w, "/") - 1
    if (any(is.na(df))) {
        fun1 <- function(x) {
            if (is.na(x)) 
                return(0)
            else return(x)
        }
        df <- apply(df, c(1, 2), fun1)
        df <- data.frame(df)
    }
    X <- as.dudi(df, col.w, row.w, scannf = scannf, nf = nf, 
        call = match.call(), type = "coa")
    X$N <- N
    return(X)
}
