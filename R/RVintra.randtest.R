"RVintra.randtest" <- function (df1, df2, fac, nrepet = 999, ...) {
    if (!is.data.frame(df1)) 
        stop("data.frame expected")
    if (!is.data.frame(df2)) 
        stop("data.frame expected")
    l1 <- nrow(df1)
    if (nrow(df2) != l1) 
        stop("Row numbers are different")
    if (any(row.names(df2) != row.names(df1))) 
        stop("row names are different")
    X <- scale(df1, scale = FALSE)
    Y <- scale(df2, scale = FALSE)
    X <- X/(sum(svd(X)$d^4)^0.25)
    Y <- Y/(sum(svd(Y)$d^4)^0.25)
    X <- as.matrix(X)
    Y <- as.matrix(Y)
	rv1 <- RVintrarandtestCpp(X, Y, fac, nrepet)
    obs <- rv1[1]
    w <- as.randtest(obs = obs, sim = rv1[-1], call = match.call(), ...)
    return(w)
}
