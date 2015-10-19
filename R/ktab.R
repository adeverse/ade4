########### is.ktab ###########
"is.ktab" <- function (x)
    inherits(x, "ktab")

########### [.ktab ########### 
"[.ktab" <- function (x, i, j, k) {
    ## i: index of blocks
    ## j: index of rows
    ## k: index of columns

    ## select blocks
    blocks <- x$blo
    nblo <- length(blocks)
    if(missing(i))
        i <- 1:nblo
    if (is.logical(i)) 
        i <- which(i)
    if (any(i > nblo)) 
        stop("Non convenient selection")
    indica <- as.factor(rep(1:nblo, blocks))
    res <- unclass(x)[i]
   
    tabw <- x$tabw[i]
    cw <- x$cw
    cw <- split(cw, indica)
    cw <- cw[i]
   
    ## select columns
    if(!missing(k)){
        res <- lapply(res, function(z) z[, k, drop = FALSE])
        cw <- lapply(cw, function(z) z[k, drop = FALSE])
    }
    cw <- unlist(cw)
    blocks <- unlist(lapply(res, function(z) ncol(z)))
    
    ## select rows
    lw <-  x$lw
    if(!missing(j)){
        res <- lapply(res, function(z) z[j,, drop = FALSE])
        lw <- lw[j, drop = FALSE]
    }
    res$lw <- lw / sum(lw)
    res$cw <- cw
    res$tabw <- tabw
   
    nblo <- length(blocks)
    res$blo <- blocks
    class(res) <- "ktab"
    res <- ktab.util.addfactor(res)
    res$call <- match.call()
    
    return(res)
}

########### print.ktab ########### 
"print.ktab" <- function (x, ...) {
    if (!inherits(x, "ktab")) 
        stop("to be used with 'ktab' object")
    cat("class:", class(x), "\n")
    ntab <- length(x$blo)
    cat("\ntab number:  ", ntab, "\n")
    sumry <- array("", c(ntab, 3), list(1:ntab, c("data.frame", 
        "nrow", "ncol")))
    for (i in 1:ntab) {
        sumry[i, ] <- c(names(x)[i], nrow(x[[i]]), ncol(x[[i]]))
    }
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(4, 4), list((ntab + 1):(ntab + 4), c("vector", 
        "length", "mode", "content")))
    sumry[1, ] <- c("$lw", length(x$lw), mode(x$lw), "row weigths")
    sumry[2, ] <- c("$cw", length(x$cw), mode(x$cw), "column weights")
    sumry[3, ] <- c("$blo", length(x$blo), mode(x$blo), "column numbers")
    sumry[4, ] <- c("$tabw", length(x$tabw), mode(x$tabw), "array weights")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(3, 4), list((ntab + 5):(ntab + 7), c("data.frame", 
        "nrow", "ncol", "content")))
    sumry[1, ] <- c("$TL", nrow(x$TL), ncol(x$TL), "Factors Table number Line number")
    sumry[2, ] <- c("$TC", nrow(x$TC), ncol(x$TC), "Factors Table number Col number")
    sumry[3, ] <- c("$T4", nrow(x$T4), ncol(x$T4), "Factors Table number 1234")
    
    print(sumry, quote = FALSE)
    cat("\n")
    cat((ntab + 8), "$call: ")
    print(x$call)
    cat("\n")
    cat("names :\n")
    for (i in 1:ntab) {
        cat(names(x)[i], ":", names(x[[i]]), "\n")
    }
    cat("\n")
    indica <- as.factor(rep(1:ntab, x$blo))
    w <- split(x$cw, indica)
    cat("Col weigths :\n")
    for (i in 1:ntab) {
        cat(names(x)[i], ":", w[[i]], "\n")
    }
    cat("\n")
    cat("Row weigths :\n")
    cat(x$lw)
    cat("\n")
}
########### c.ktab" ########### 
"c.ktab" <- function (...) {
    x <- list(...)
    n <- length(x)
    if (any(lapply(x, class) != "ktab")) 
        stop("arguments imply object without 'ktab' class")
    nr <- unlist(lapply(x, function(x) nrow(x[[1]])))
    if (length(unique(nr)) != 1) 
        stop("arguments imply object with non constant row numbers")
    lw <- x[[1]]$lw
    nr <- length(lw)
    noms <- row.names(x[[1]][[1]])
    res <- NULL
    cw <- NULL
    blocks <- NULL
    for (i in 1:n) {
        if (any(x[[i]]$lw != lw)) 
            stop("arguments imply object with non constant row weights")
        if (any(row.names(x[[i]][[1]]) != noms)) 
            stop("arguments imply object with non constant row.names")
        blo.i <- x[[i]]$blo
        nblo.i <- length(blo.i)
        res <- c(res, unclass(x[[i]])[1:nblo.i])
        cw <- c(cw, x[[i]]$cw)
        blocks <- c(blocks, blo.i)
    }
    names(res) <- make.names(names(res), TRUE)
    res$lw <- lw
    res$cw <- cw
    res$blo <- blocks
    class(res) <- "ktab"
    res <- ktab.util.addfactor(res)
    res$call <- match.call()
    return(res)
}

########### t.ktab" ########### 
"t.ktab" <- function (x) {
    if (!inherits(x, "ktab")) 
        stop("object 'ktab' expected")
    blocks <- x$blo
    nblo <- length(blocks)
    res <- x
    r.n <- row.names(x[[1]])
    for (i in 1:nblo) {
        r.new <- row.names(x[[i]])
        if (any(r.new != r.n)) 
            stop("non equal row.names among array")
    }
    if (length(unique(blocks)) != 1) 
        stop("non equal col numbers among array")
    c.n <- names(x[[1]])
    for (i in 1:nblo) {
        c.new <- names(x[[i]])
        if (any(c.new != c.n)) 
            stop("non equal col.names among array")
    }
    new.row.names <- names(x[[1]])
    indica <- as.factor(rep(1:nblo, blocks))
    w <- split(x$cw, indica)
    col.w <- w[[1]]
    for (i in 1:nblo) {
        col.w.new <- w[[i]]
        if (any(col.w != col.w.new)) 
            stop("non equal column weights among array")
    }
    for (j in 1:nblo) {
        w <- x[[j]]
        w <- data.frame(t(w))
        row.names(w) <- new.row.names
        res[[j]] <- w
        blocks[j] <- ncol(w)
    }
    res$lw <- col.w
    res$cw <- rep(x$lw, nblo)
    res$blo <- blocks
    class(res) <- "ktab"
    res <- ktab.util.addfactor(res)
    res$call <- match.call()
    return(res)
}

########### row.names.ktab ########### 
"row.names.ktab" <- function (x) {
    if (!inherits(x, "ktab")) 
        stop("to be used with 'ktab' object")
    ntab <- length(x$blo)
    cha <- attr(x[[1]], "row.names")
    for (i in 1:ntab) {
        if (any(attr(x[[i]], "row.names") != cha)) 
            warnings(paste("array", i, "and array 1 have different row.names"))
    }
    return(cha)
}
########### row.names<-.ktab ########### 
"row.names<-.ktab" <- function (x, value) {
    if (!inherits(x, "ktab")) 
        stop("to be used with 'ktab' object")
    ntab <- length(x$blo)
    old <- attr(x[[1]], "row.names")
    if (!is.null(old) && length(value) != length(old)) 
        stop("invalid row.names length")
    value <- as.character(value)
    if (any(duplicated(value))) 
        stop("duplicate row.names are not allowed")
    for (i in 1:ntab) {
        attr(x[[i]], "row.names") <- value
    }
    x
}
########### col.names ########### 
"col.names" <- function (x) UseMethod("col.names")

########### col.names<- ########### 
"col.names<-" <- function (x, value) UseMethod("col.names<-")

########### col.names.ktab ########### 
"col.names.ktab" <- function (x) {
    if (!inherits(x, "ktab")) 
        stop("to be used with 'ktab' object")
    ntab <- length(x$blo)
    cha <- unlist(lapply(1:ntab, function(y) attr(x[[y]], "names")))
    return(cha)
}
########### col.names<-.ktab ########### 
"col.names<-.ktab" <- function (x, value) {
    if (!inherits(x, "ktab")) 
        stop("to be used with 'ktab' object")
    ntab <- length(x$blo)
    old <- unlist(lapply(1:ntab, function(y) attr(x[[y]], "names")))
    if (!is.null(old) && length(value) != length(old)) 
        stop("invalid col.names length")
    value <- as.character(value)
    indica <- as.factor(rep(1:ntab, x$blo))
    for (i in 1:ntab) {
        if (any(duplicated(value[indica == i]))) 
            stop("duplicate col.names are not allowed in the same array")
        attr(x[[i]], "names") <- value[indica == i]
    }
    x
}


########### tab.names ########### 
# fonction générique
"tab.names" <- function (x) UseMethod("tab.names")
########### tab.names.ktab ########### 
# méthode pour ktab
"tab.names.ktab" <- function (x) {
    if (!inherits(x, "ktab")) 
        stop("to be used with 'ktab' object")
    ntab <- length(x$blo)
    cha <- names(x)[1:ntab]
    return(cha)
}
########### tab.names<- ########### 
# fonction générique
"tab.names<-" <- function (x, value) UseMethod("tab.names<-")
########### tab.names<-.ktab ########### 
# méthode pour ktab
# les tab.names d'un ktab est le vecteur des noms des k premières composantes
# ce nombre de tableaux est la longueur de la composante blo
"tab.names<-.ktab" <- function (x, value) {
    if (!inherits(x, "ktab")) 
        stop("to be used with 'ktab' object")
    ntab <- length(x$blo)
    old <- tab.names(x)[1:ntab]
    if (!is.null(old) && length(value) != length(old)) 
        stop("invalid tab.names length")
    value <- as.character(value)
    if (any(duplicated(value))) 
        stop("duplicate tab.names are not allowed")
    names(x)[1:ntab] <- value
    x
}
########### ktab.util.names ###########
# utilitaire qui récupère dans un ktab
# une liste de 3 éléments
# les noms des lignes "." les noms des tableaux
# les noms des colonnes sans duplicats
# les noms des tableaux "." 1234
# pour donner des étiquettes aux TL, TC et T4 dans les graphiques
"ktab.util.names" <- function (x) {
    w <- row.names(x)
    w1 <- paste(w, as.character(x$TL[, 1]), sep = ".")
    w <- col.names(x)
    if (any(duplicated(w))) 
        w <- paste(w, as.character(x$TC[, 1]), sep = ".")
    w2 <- w
    w <- tab.names(x)
    l0 <- length(w)
    w3 <- paste(rep(w, rep(4, l0)), as.character(1:4), sep = ".")
    # Cas d'un ktab de type kcoinertie
    if (!inherits (x,"kcoinertia")) return(list(row = w1, col = w2, tab = w3)) 
#    w4 <- paste(rep(tab.names(x), each=nrow(x$supX)/length(tab.names(x))), row.names(x$supX), sep=".")
#    Admettre des ktabs ayant des nombres de lignes (colonnes) différents
    w4 <- paste(rep(tab.names(x), x$supblo), row.names(x$supX), sep=".")
    return(list(row = w1, col = w2, tab = w3, Trow=w4))
}

########### ktab.util.addfactor<- ########### 
## utility used for ktab objects
## add the componenst TL TC and T4
## x is an object of class ktab not yet finished (should contains tables, lw and blo)
# we obtain the col number (unique for each table) and the number of row (common to all tables)
"ktab.util.addfactor" <- function (x) {
    blocks <- x$blo
    nlig <- length(x$lw)
    nblo <- length(x$blo)
    rowname <- row.names(x)
    colname <- col.names(x)
    blocname <- tab.names(x)
    
    w <- cbind.data.frame(gl(nblo, nlig, labels = blocname), factor(rep(1:nlig, 
        nblo), labels = rowname))
    names(w) <- c("T", "L")
    x$TL <- w
    w <- NULL
    for (i in 1:nblo) w <- c(w, 1:blocks[i])
    w <- cbind.data.frame(factor(rep(1:nblo, blocks), labels = blocname), factor(colname))
    names(w) <- c("T", "C")
    x$TC <- w
    w <- cbind.data.frame(gl(nblo, 4, labels = blocname), factor(rep(1:4, nblo)))
    names(w) <- c("T", "4")
    x$T4 <- w
    x
}
