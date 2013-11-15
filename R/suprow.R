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
    # bug 25/11/2004 On reproduisait bien les coordonnées supplémentaires
    # mais pas les valeurs du tableau, donc pas de transferts possibles en inter-intra
    # voir fiche QR8
    cwsup <- x$cw
    cwsup[cwsup == 0] <- 1
    Xsup <- sweep(Xsup, 2, cwsup, "/")
    # le centrage n'est pas indispensable
    Xsup <- Xsup-1
    Xsup[,cwsup == 1] <- 0
    return(list(tabsup=Xsup, lisup=coosup))
}

"suprow.dudi" <- function (x, Xsup, ...) {
    # modif pour Culhane, Aedin" <a.culhane@ucc.ie> 
    # suprow renvoie une liste à deux éléments tabsup et lisup
    Xsup <- data.frame(Xsup)
    if (!inherits(x, "dudi")) 
        stop("Object of class 'dudi' expected")
    if (!inherits(Xsup, "data.frame")) 
        stop("Xsup is not a data.frame")
    if (ncol(Xsup) != ncol(x$tab)) 
        stop("non convenient col numbers")
    # bug 25/11/2004 vue par fiche QR8
    coosup <- as.matrix(Xsup) %*% (as.matrix(x$c1) * x$cw)
    coosup <- data.frame(coosup, row.names = row.names(Xsup))
    names(coosup) <- names(x$li)
    return(list(tabsup=Xsup, lisup=coosup))
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
    return(list(tabsup=Xsup, lisup=coosup))
}
