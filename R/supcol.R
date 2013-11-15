"supcol" <- function (x, ...) UseMethod("supcol") 

"supcol.coa" <- function (x, Xsup, ...) {
    # modif pour Culhane, Aedin" <a.culhane@ucc.ie> 
    # supcol renvoie une liste à deux éléments tabsup et cosup
    Xsup <- data.frame(Xsup)
    if (!inherits(x, "dudi")) 
        stop("Object of class 'dudi' expected")
    if (!inherits(x, "coa")) 
        stop("Object of class 'coa' expected")
    if (!inherits(Xsup, "data.frame")) 
        stop("Xsup is not a data.frame")
    if (nrow(Xsup) != nrow(x$tab)) 
        stop("non convenient row numbers")
    cwsup <- apply(Xsup, 2, sum)
    cwsup[cwsup == 0] <- 1
    Xsup <- sweep(Xsup, 2, cwsup, "/")
    coosup <- t(as.matrix(Xsup)) %*% as.matrix(x$l1)
    coosup <- data.frame(coosup, row.names = names(Xsup))
    names(coosup) <- names(x$co)
    return(list(tabsup=Xsup, cosup=coosup))
}

"supcol.dudi" <- function (x, Xsup, ...) {
    Xsup <- data.frame(Xsup)
    if (!inherits(x, "dudi")) 
        stop("Object of class 'dudi' expected")
    if (!inherits(Xsup, "data.frame")) 
        stop("Xsup is not a data.frame")
    if (nrow(Xsup) != nrow(x$tab)) 
        stop("non convenient row numbers")
    coosup <- t(as.matrix(Xsup)) %*% (as.matrix(x$l1) * x$lw)
    coosup <- data.frame(coosup, row.names = names(Xsup))
    names(coosup) <- names(x$co)
    return(list(tabsup=Xsup, cosup=coosup))
}
