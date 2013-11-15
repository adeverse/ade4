"dist.genet" <- function (genet, method = 1, diag = FALSE, upper = FALSE) { 
    METHODS = c("Nei","Edwards","Reynolds","Rodgers","Provesti")
    if (all((1:5)!=method)) {
        cat("1 = Nei 1972\n")
        cat("2 = Edwards 1971\n")
        cat("3 = Reynolds, Weir and Coockerman 1983\n")
        cat("4 = Rodgers 1972\n")
        cat("5 = Provesti 1975\n")
        cat("Select an integer (1-5): ")
        method <- as.integer(readLines(n = 1))
    }
    if (all((1:5)!=method)) (stop ("Non convenient method number"))
    if (!inherits(genet,"genet"))  
        stop("list of class 'genet' expected")
    df <- genet$tab
    col.blocks <- genet$loc.blocks
    nloci <- length(col.blocks)
    d.names <- genet$pop.names
    nlig <- nrow(df)

    if (is.null(names(col.blocks))) {
        names(col.blocks) <- paste("L", as.character(1:nloci), sep = "")
    }
    f1 <- function(x) {
        a <- sum(x)
        if (is.na(a)) 
            return(rep(0, length(x)))
        if (a == 0) 
            return(rep(0, length(x)))
        return(x/a)
    }
    k2 <- 0
    for (k in 1:nloci) {
        k1 <- k2 + 1
        k2 <- k2 + col.blocks[k]
        X <- df[, k1:k2]
        X <- t(apply(X, 1, f1))
        X.marge <- apply(X, 1, sum)
        if (any(sum(X.marge)==0)) stop ("Null row found")
        X.marge <- X.marge/sum(X.marge)
        df[, k1:k2] <- X
    }
    # df contient un tableau de fréquence
    df <- as.matrix(df)    
    if (method == 1) {
        d <- df%*%t(df)
        vec <- sqrt(diag(d))
        d <- d/vec[col(d)]
        d <- d/vec[row(d)]
        d <- -log(d)
        d <- as.dist(d)
    } else if (method == 2) {
        df <- sqrt(df)
        d <- df%*%t(df)
        d <- 1-d/nloci
        diag(d) <- 0
        d <- sqrt(d)
        d <- as.dist(d)
    } else if (method == 3) {
       denomi <- df%*%t(df)
       vec <- apply(df,1,function(x) sum(x*x))
       d <- -2*denomi + vec[col(denomi)] + vec[row(denomi)]
       diag(d) <- 0
       denomi <- 2*nloci - 2*denomi
       diag(denomi) <- 1
       d <- d/denomi
       d <- sqrt(d)
       d <- as.dist(d)
    } else if (method == 4) {
        loci.fac <- rep( names(col.blocks),col.blocks)
        loci.fac <- as.factor(loci.fac)
        ltab <- lapply(split(df,loci.fac[col(df)]),matrix,nrow=nlig)
        "dcano" <- function (mat) {
            daux <- mat%*%t(mat)
            vec <- diag(daux)
            daux <- -2*daux+vec[col(daux)]
            daux <- daux + vec[row(daux)]
            diag(daux) <- 0
            daux <- sqrt(daux/2)
            d <<- d+daux
        }
        d <- matrix(0,nlig,nlig)
        lapply(ltab, dcano)
        d <- d/length(ltab)
        d <- as.dist(d)
    } else if (method ==5) {
        w0 <- 1:(nlig-1)
        "loca" <- function (k) {
            w1 <- (k+1):nlig
            resloc <- unlist(lapply(w1, function(x) sum(abs(df[k,]-df[x,]))))
            return(resloc/2/nloci)
        }
        d <- unlist(lapply(w0,loca))
    } 
    attr(d, "Size") <- nlig
    attr(d, "Labels") <- d.names
    attr(d, "Diag") <- diag
    attr(d, "Upper") <- upper
    attr(d, "method") <- METHODS[method]
    attr(d, "call") <- match.call()
    class(d) <- "dist"
    return(d)
    
}
