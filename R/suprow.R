"suprow" <- function (x, ...) UseMethod("suprow")

"suprow.coa" <- function (x, Xsup, ...) {
    Xsup <- data.frame(Xsup)
    if (!inherits(x, "dudi")) 
        stop("Object of class 'dudi' expected")
    if (!inherits(x, "coa")) 
        stop("Object of class 'coa' expected")
    if (!inherits(Xsup, "data.frame")) 
        stop("Xsup is not a data.frame")
    if (ncol(Xsup) != ncol(x$tab)) 
        stop("non convenient col numbers")
    lwsup <- apply(Xsup, 1, sum)
    lwsup[lwsup == 0] <- 1
    Xsup <- sweep(Xsup, 1, lwsup, "/")
    coosup <- as.matrix(Xsup) %*% as.matrix(x$c1)
    coosup <- data.frame(coosup, row.names = row.names(Xsup))
    names(coosup) <- names(x$li)
    return(coosup)
}

"suprow.default" <- function (x, Xsup, ...) {
    Xsup <- data.frame(Xsup)
    if (!inherits(x, "dudi")) 
        stop("Object of class 'dudi' expected")
    if (!inherits(Xsup, "data.frame")) 
        stop("Xsup is not a data.frame")
    if (ncol(Xsup) != ncol(x$tab)) 
        stop("non convenient col numbers")
    coosup <- as.matrix(Xsup) %*% t(t(as.matrix(x$c1)) * x$cw)
    coosup <- data.frame(coosup, row.names = row.names(Xsup))
    names(coosup) <- names(x$li)
    return(coosup)
}

"suprow.pca" <- function (x, Xsup, ...) {
    Xsup <- data.frame(Xsup)
    if (!inherits(x, "dudi")) 
        stop("Object of class 'dudi' expected")
    if (!inherits(x, "pca")) 
        stop("Object of class 'pca' expected")
    if (!inherits(Xsup, "data.frame")) 
        stop("Xsup is not a data.frame")
    if (ncol(Xsup) != ncol(x$tab)) 
        stop("non convenient col numbers")
    f1 <- function(w) (w - x$cent)/x$norm
    Xsup <- t(apply(Xsup, 1, f1))
    coosup <- as.matrix(Xsup) %*% as.matrix(x$c1)
    coosup <- data.frame(coosup, row.names = row.names(Xsup))
    names(coosup) <- names(x$li)
    return(coosup)
}
