"dist.binary" <- function (df, method = NULL, diag = FALSE, upper = FALSE) {
    METHODS <- c("JACCARD S3", "SOCKAL & MICHENER S4", "SOCKAL & SNEATH S5", 
        "ROGERS & TANIMOTO S6", "CZEKANOWSKI S7", "GOWER & LEGENDRE S9", "OCHIAI S12", "SOKAL & SNEATH S13", 
        "Phi of PEARSON S14", "GOWER & LEGENDRE S2")
    if (!(inherits(df, "data.frame") | inherits(df, "matrix"))) 
        stop("df is not a data.frame or a matrix")
    df <- as.matrix(df)
    if(!is.numeric(df))
      stop("df must contain  numeric values")
    if (any(df < 0)) 
        stop("non negative value expected in df")
    nlig <- nrow(df)
    d.names <- row.names(df)
    if(is.null(d.names))
      d.names <- 1:nlig
    nlig <- nrow(df)
    df <- as.matrix(1 * (df > 0))
    if (is.null(method)) {
        cat("1 = JACCARD index (1901) S3 coefficient of GOWER & LEGENDRE\n")
        cat("s1 = a/(a+b+c) --> d = sqrt(1 - s)\n")
        cat("2 = SOCKAL & MICHENER index (1958) S4 coefficient of GOWER & LEGENDRE \n")
        cat("s2 = (a+d)/(a+b+c+d) --> d = sqrt(1 - s)\n")
        cat("3 = SOCKAL & SNEATH(1963) S5 coefficient of GOWER & LEGENDRE\n")
        cat("s3 = a/(a+2(b+c)) --> d = sqrt(1 - s)\n")
        cat("4 = ROGERS & TANIMOTO (1960) S6 coefficient of GOWER & LEGENDRE\n")
        cat("s4 = (a+d)/(a+2(b+c)+d) --> d = sqrt(1 - s)\n")
        cat("5 = CZEKANOWSKI (1913) or SORENSEN (1948) S7 coefficient of GOWER & LEGENDRE\n")
        cat("s5 = 2*a/(2*a+b+c) --> d = sqrt(1 - s)\n")
        cat("6 = S9 index of GOWER & LEGENDRE (1986)\n")
        cat("s6 = (a-(b+c)+d)/(a+b+c+d) --> d = sqrt(1 - s)\n")
        cat("7 = OCHIAI (1957) S12 coefficient of GOWER & LEGENDRE\n")
        cat("s7 = a/sqrt((a+b)(a+c)) --> d = sqrt(1 - s)\n")
        cat("8 = SOKAL & SNEATH (1963) S13 coefficient of GOWER & LEGENDRE\n")
        cat("s8 = ad/sqrt((a+b)(a+c)(d+b)(d+c)) --> d = sqrt(1 - s)\n")
        cat("9 = Phi of PEARSON = S14 coefficient of GOWER & LEGENDRE\n")
        cat("s9 = ad-bc)/sqrt((a+b)(a+c)(b+d)(d+c)) --> d = sqrt(1 - s)\n")
        cat("10 = S2 coefficient of GOWER & LEGENDRE\n")
        cat("s10 =  a/(a+b+c+d) --> d = sqrt(1 - s) and unit self-similarity\n")
        cat("Select an integer (1-10): ")
        method <- as.integer(readLines(n = 1))
    }
    
    a <- df %*% t(df)
    b <- df %*% (1 - t(df))
    c <- (1 - df) %*% t(df)
    d <- ncol(df) - a - b - c

    if (method == 1) {
        d <- a/(a + b + c)
    }
    else if (method == 2) {
        d <- (a + d)/(a + b + c + d)
    }
    else if (method == 3) {
        d <- a/(a + 2 * (b + c))
    }
    else if (method == 4) {
        d <- (a + d)/(a + 2 * (b + c) + d)
    }
    # correction d'un bug signalé par Christian Düring <c.duering@web.de>
    else if (method == 5) {
        d <- 2*a/(2 * a + b + c)
    }
    else if (method == 6) {
        d <- (a - (b + c) + d)/(a + b + c + d)
        
    }
    else if (method == 7) {
        d <- a/sqrt((a+b)*(a+c))
    }
    else if (method == 8) {
        d <- a * d/sqrt((a + b) * (a + c) * (d + b) * (d + c))
    }
    else if (method == 9) {
        d <- (a * d - b * c)/sqrt((a + b) * (a + c) * (b + d) * 
            (d + c))
    }
    else if (method == 10) {
        d <- a/(a + b + c + d)
        diag(d) <- 1
    }
    else stop("Non convenient method")
    d <- sqrt(1 - d)
    # if (sum(diag(d)^2)>0) stop("diagonale non nulle")
    d <- as.dist(d)
    attr(d, "Size") <- nlig
    attr(d, "Labels") <- d.names
    attr(d, "Diag") <- diag
    attr(d, "Upper") <- upper
    attr(d, "method") <- METHODS[method]
    attr(d, "call") <- match.call()
    class(d) <- "dist"
    return(d)
}
