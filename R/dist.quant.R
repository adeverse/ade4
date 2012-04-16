"dist.quant" <- function (df, method = NULL, diag = FALSE, upper = FALSE, tol = 1e-07) {
    METHODS <- c("Canonical", "Joreskog", "Mahalanobis")
    df <- data.frame(df)
    if (!inherits(df, "data.frame")) 
        stop("df is not a data.frame")
    if (is.null(method)) {
        cat("1 = Canonical\n")
        cat("d1 = ||x-y|| A=Identity\n")
        cat("2 = Joreskog\n")
        cat("d2=d2 = ||x-y|| A=1/diag(cov)\n")
        cat("3 = Mahalanobis\n")
        cat("d3 = ||x-y|| A=inv(cov)\n")
        cat("Selec an integer (1-3): ")
        method <- as.integer(readLines(n = 1))
    }
    nlig <- nrow(df)
    d <- matrix(0, nlig, nlig)
    d.names <- row.names(df)
    fun1 <- function(x) {
        sqrt(sum((df[x[1], ] - df[x[2], ])^2))
    }
    df <- as.matrix(df)
    index <- cbind(col(d)[col(d) < row(d)], row(d)[col(d) < row(d)])
    method <- method[1]
    if (method == 1) {
        d <- unlist(apply(index, 1, fun1))
    }
    else if (method == 2) {
        dfcov <- cov(df) * (nlig - 1)/nlig
        jor <- diag(dfcov)
        jor[jor == 0] <- 1
        jor <- 1/sqrt(jor)
        df <- t(t(df) * jor)
        d <- unlist(apply(index, 1, fun1))
    }
    else if (method == 3) {
        dfcov <- cov(df) * (nlig - 1)/nlig
        maha <- eigen(dfcov, symmetric = TRUE)
        maha.r <- sum(maha$values > (maha$values[1] * tol))
        maha.e <- 1/sqrt(maha$values[1:maha.r])
        maha.v <- maha$vectors[, 1:maha.r]
        maha.v <- t(t(maha.v) * maha.e)
        df <- df %*% maha.v
        d <- unlist(apply(index, 1, fun1))
    }
    else stop("Non convenient method")
    attr(d, "Size") <- nlig
    attr(d, "Labels") <- d.names
    attr(d, "Diag") <- diag
    attr(d, "Upper") <- upper
    attr(d, "method") <- METHODS[method]
    attr(d, "call") <- match.call()
    class(d) <- "dist"
    return(d)
}
