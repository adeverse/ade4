"dudi.dec" <- function (df, eff, scannf = TRUE, nf = 2) {
    df <- as.data.frame(df)
    if (!is.data.frame(df)) 
        stop("data.frame expected")
    lig <- nrow(df)
    if (any(df < 0)) 
        stop("negative entries in table")
    if ((sum(df)) == 0) 
        stop("all frequencies are zero")
    if (length(eff) != lig) 
        stop("non convenient dimension")
    if (any(eff) <= 0) 
        stop("non convenient vector eff")
    rtot <- sum(eff)
    row.w <- eff/rtot
    col.w <- apply(df, 2, sum)
    col.w <- col.w/rtot
    df <- sweep(df, 1, eff, "/")
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
        call = match.call(), type = "dec")
    X$R <- rtot
    return(X)
}
