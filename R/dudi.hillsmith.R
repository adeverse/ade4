"dudi.hillsmith" <- function (df, row.w=rep(1, nrow(df))/nrow(df), scannf = TRUE, nf = 2) 
{
    df <- as.data.frame(df)
    if (!is.data.frame(df)) 
        stop("data.frame expected")

    df <- data.frame(df)
    nc <- ncol(df)
    nl <- nrow(df)
    row.w <- row.w/sum(row.w)
    if (any(is.na(df))) 
        stop("na entries in table")
    index <- rep("", nc)
    for (j in 1:nc) {
        w1 <- "q"
        if (is.factor(df[, j])) 
            w1 <- "f"
        if (is.ordered(df[, j])) 
            stop("use dudi.mix for ordered data")
        index[j] <- w1
    }
    res <- matrix(0, nl, 1)
    provinames <- "0"
    col.w <- NULL
    col.assign <- NULL
    k <- 0
    for (j in 1:nc) {
        if (index[j] == "q") {
            
                res <- cbind(res, scalewt(df[, j],wt=row.w))
                provinames <- c(provinames, names(df)[j])
                col.w <- c(col.w, 1)
                k <- k + 1
                col.assign <- c(col.assign, k)
            
        }
        else if (index[j] == "f") {
            w <- fac2disj(df[, j], drop = TRUE)
            cha <- paste(substr(names(df)[j], 1, 5), ".", names(w), 
                sep = "")
            col.w.provi <- drop(row.w %*% as.matrix(w))
            w <- t(t(w)/col.w.provi) - 1
            col.w <- c(col.w, col.w.provi)
            res <- cbind(res, w)
            provinames <- c(provinames, cha)
            k <- k + 1
            col.assign <- c(col.assign, rep(k, length(cha)))
        }
    }
    res <- data.frame(res)
    names(res) <- make.names(provinames, unique = TRUE)
    row.names(res)<-row.names(df)
    res <- res[, -1]
    names(col.w) <- provinames[-1]
    X <- as.dudi(res, col.w, row.w, scannf = scannf, nf = nf, 
        call = match.call(), type = "mix")
    X$assign <- factor(col.assign)
    X$index <- factor(index)
    rcor <- matrix(0, nc, X$nf)
    rcor <- row(rcor) + 0 + (0 + (0+1i)) * col(rcor)
    floc <- function(x) {
        i <- Re(x)
        j <- Im(x)
        if (index[i] == "q") {
            if (sum(col.assign == i)) {
                w <- X$l1[, j] * X$lw * X$tab[, col.assign == 
                  i]
                return(sum(w)^2)
            }
            else {
                w <- X$lw * X$l1[, j]
                w <- X$tab[, col.assign == i] * w
                w <- apply(w, 2, sum)
                return(sum(w^2))
            }
        }
        else if (index[i] == "f") {
            x <- X$l1[, j] * X$lw
            qual <- df[, i]
            poicla <- unlist(tapply(X$lw, qual, sum))
            z <- unlist(tapply(x, qual, sum))/poicla
            return(sum(poicla * z * z))
        }
        else return(NA)
    }
    rcor <- apply(rcor, c(1, 2), floc)
    rcor <- data.frame(rcor)
    row.names(rcor) <- names(df)
    names(rcor) <- names(X$l1)
    X$cr <- rcor
    X
}
