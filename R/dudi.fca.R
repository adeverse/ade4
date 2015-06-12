"dudi.fca" <- function (df, scannf = TRUE, nf = 2) {
    df <- as.data.frame(df)
    if (!is.data.frame(df)) 
        stop("data.frame expected")
    if (is.null(attr(df, "col.blocks"))) 
        stop("attribute 'col.blocks' expected for df")
    if (is.null(attr(df, "row.w"))) 
        stop("attribute 'row.w' expected for df")
    bloc <- attr(df, "col.blocks")
    row.w <- attr(df, "row.w")
    indica <- attr(df, "col.num")
    nvar <- length(bloc)
    col.w <- apply(df * row.w, 2, sum)
    df <- sweep(df, 2, col.w, "/") - 1
    col.w <- col.w/length(bloc)
    X <- as.dudi(df, col.w, row.w, scannf = scannf, nf = nf, 
        call = match.call(), type = "fca")
    rcor <- matrix(0, nvar, X$nf)
    rcor <- row(rcor) + 0 + (0+1i) * col(rcor)
    floc <- function(x) {
        i <- Re(x)
        j <- Im(x)
        if (i == 1) 
            k1 <- 0
        else k1 <- cumsum(bloc)[i - 1]
        k2 <- k1 + bloc[i]
        k1 <- k1 + 1
        z <- X$co[k1:k2, j]
        poicla <- X$cw[k1:k2] * nvar
        return(sum(poicla * z * z))
    }
    rcor <- apply(rcor, c(1, 2), floc)
    rcor <- data.frame(rcor)
    row.names(rcor) <- names(bloc)
    names(rcor) <- names(X$l1)
    X$cr <- rcor
    X$blo <- bloc
    X$indica <- indica
    return(X)
}

"prep.fuzzy.var" <- function (df, col.blocks, row.w = rep(1, nrow(df))) {
    if (!is.data.frame(df)) 
        stop("data.frame expected")
    if (!is.null(row.w)) {
        if (length(row.w) != nrow(df)) 
            stop("non convenient dimension")
    }
    if (sum(col.blocks) != ncol(df)) {
        stop("non convenient data in col.blocks")
    }
    if (is.null(row.w)) 
        row.w <- rep(1, nrow(df))/nrow(df)
    row.w <- row.w/sum(row.w)
    if (is.null(names(col.blocks))) {
        names(col.blocks) <- paste("FV", as.character(1:length(col.blocks)), 
            sep = "")
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
    col.w <- rep(1, ncol(df))
    for (k in 1:(length(col.blocks))) {
        k1 <- k2 + 1
        k2 <- k2 + col.blocks[k]
        X <- df[, k1:k2]
        X <- t(apply(X, 1, f1))
        X.marge <- apply(X, 1, sum)
        X.marge <- X.marge * row.w
        X.marge <- X.marge/sum(X.marge)
        X.mean <- apply(X * X.marge, 2, sum)
        nr <- sum(X.marge == 0)
        if (nr > 0) {
            nc <- col.blocks[k]
            X[X.marge == 0, ] <- rep(X.mean, rep(nr, nc))
            cat(nr, "missing data found in block", k, "\n")
        }
        df[, k1:k2] <- X
        col.w[k1:k2] <- X.mean
    }
    attr(df, "col.blocks") <- col.blocks
    attr(df, "row.w") <- row.w
    attr(df, "col.freq") <- col.w
    col.num <- factor(rep((1:length(col.blocks)), col.blocks))
    attr(df, "col.num") <- col.num
    return(df)
}

"dudi.fpca" <- function (df, scannf = TRUE, nf = 2) {
    if (!is.data.frame(df)) 
        stop("data.frame expected")
    if (is.null(attr(df, "col.blocks"))) 
        stop("attribute 'col.blocks' expected for df")
    if (is.null(attr(df, "row.w"))) 
        stop("attribute 'row.w' expected for df")
    bloc <- attr(df, "col.blocks")
    row.w <- attr(df, "row.w")
    indica <- attr(df, "col.num")
    nvar <- length(bloc)
    col.w <- unlist(lapply(bloc, function(k) rep(1/k,k)))
    X <- dudi.pca (df, row.w = row.w, col.w = col.w, center = TRUE,
        scale = FALSE, scannf = scannf, nf = nf)
    X$call <- match.call()
    X$blo <- bloc
    X$indica <- indica
    w1 <- unlist(lapply(X$tab,function(x) sum(x*x*row.w)))
    w1 <- unlist(tapply(w1*col.w,indica,sum))
    w2 <- tapply(X$cent,indica,function(x) 1-sum(x*x))
    ratio <- w1/sum(w1)
    w1 <- cbind.data.frame(inertia=w1,max=w2,FST=w1/w2)
    row.names(w1) <- names(bloc)
    X$FST <- w1
    row.names(w1) <- names(bloc)
    floc1 <- function(ifac)
        tapply(col.w*X$co[,ifac]*X$co[,ifac],indica,sum)
    w2 <- unlist(lapply(1:X$nf,floc1))
    w2 <- matrix(w2,nvar,X$nf)
    w3 <- X$eig[1:X$nf]
    w2 <- t(apply(w2,1,function(x) x/w3))
    w2 <- as.data.frame(w2)
    names(w2)=paste("Ax",1:X$nf,sep="")
    row.names(w2) <- names(bloc)
    w2 <- cbind.data.frame(w2,total=ratio)
    w2 <- round(1000*w2,0)
    X$inertia <- w2
    return(X)
} 
