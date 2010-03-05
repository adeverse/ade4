"scalewt" <- function (X, wt = rep(1, nrow(X)), center = TRUE, scale = TRUE) {
    X <- as.matrix(X)
    n <- nrow(X)
    if (length(wt) != n)
        stop("length of wt must equal the number of rows in x")
    if (any(wt < 0) || (s <- sum(wt)) == 0)
        stop("weights must be non-negative and not all zero")
    wt <- wt/s
    center <- if (center)
        apply(wt * X, 2, sum)
    else 0
    X <- sweep(X, 2, center)
    if (scale){
        norm <- apply(X * X * wt, 2, sum)
        temp <- norm < 1e-14
        if(any(temp)){
            warning("Variables with null variance not standardized.")
            norm[temp] <- 1
        }
        X <- sweep(X, 2, sqrt(norm), "/")
    }
    return(X)
}
