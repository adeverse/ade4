"dist.prop" <- function (df, method = NULL, diag = FALSE, upper = FALSE) {
    METHODS <- c("d1 Manly", "Overlap index Manly", "Rogers 1972", 
        "Nei 1972", "Edwards 1971")
    if (!inherits(df, "data.frame")) 
        stop("df is not a data.frame")
    if (any(df < 0)) 
        stop("non negative value expected in df")
    dfs <- apply(df, 1, sum)
    if (any(dfs == 0)) 
        stop("row with all zero value")
    df <- df/dfs
    if (is.null(method)) {
        cat("1 = d1 Manly\n")
        cat("d1 = Sum|p(i)-q(i)|/2\n")
        cat("2 = Overlap index Manly\n")
        cat("d2=1-Sum(p(i)q(i))/sqrt(Sum(p(i)^2)/sqrt(Sum(q(i)^2)\n")
        cat("3 = Rogers 1972 (one locus)\n")
        cat("d3=sqrt(0.5*Sum(p(i)-q(i)^2))\n")
        cat("4 = Nei 1972 (one locus)\n")
        cat("d4=-ln(Sum(p(i)q(i)/sqrt(Sum(p(i)^2)/sqrt(Sum(q(i)^2))\n")
        cat("5 = Edwards 1971 (one locus)\n")
        cat("d5= sqrt (1 - (Sum(sqrt(p(i)q(i))))\n")
        cat("Selec an integer (1-5): ")
        method <- as.integer(readLines(n = 1))
    }
    nlig <- nrow(df)
    d <- matrix(0, nlig, nlig)
    d.names <- row.names(df)
    df <- as.matrix(df)
    fun1 <- function(x) {
        p <- df[x[1], ]
        q <- df[x[2], ]
        w <- sum(abs(p - q))/2
        return(w)
    }
    fun2 <- function(x) {
        p <- df[x[1], ]
        q <- df[x[2], ]
        w <- 1 - sum(p * q)/sqrt(sum(p * p))/sqrt(sum(q * q))
        return(w)
    }
    fun3 <- function(x) {
        p <- df[x[1], ]
        q <- df[x[2], ]
        w <- sqrt(0.5 * sum((p - q)^2))
        return(w)
    }
    fun4 <- function(x) {
        p <- df[x[1], ]
        q <- df[x[2], ]
        if (sum(p * q) == 0) 
            stop("sum(p*q)==0 -> non convenient data")
        w <- -log(sum(p * q)/sqrt(sum(p * p))/sqrt(sum(q * q)))
        return(w)
    }
    fun5 <- function(x) {
        p <- df[x[1], ]
        q <- df[x[2], ]
        w <- sqrt(1 - sum(sqrt(p * q)))
        return(w)
    }
    index <- cbind(col(d)[col(d) < row(d)], row(d)[col(d) < row(d)])
    method <- method[1]
    if (method == 1) 
        d <- unlist(apply(index, 1, fun1))
    else if (method == 2) 
        d <- unlist(apply(index, 1, fun2))
    else if (method == 3) 
        d <- unlist(apply(index, 1, fun3))
    else if (method == 4) 
        d <- unlist(apply(index, 1, fun4))
    else if (method == 5) 
        d <- unlist(apply(index, 1, fun5))
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
