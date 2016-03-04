"suprow" <- function (x, ...) UseMethod("suprow")

"predict.dudi" <- function(object, newdata, ...){
    return(suprow(x = object, Xsup = newdata, ...)$lisup)    
}

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
    return(list(tabsup = Xsup, lisup = coosup))
}

"suprow.dudi" <- function (x, Xsup, ...) {
    # modif pour Culhane, Aedin" <a.culhane@ucc.ie> 
    # suprow renvoie une liste à deux éléments tabsup et lisup
    warning("The use of the 'suprow.dudi' method requires that the 
            supplementary table has been transformed as the original table")
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
    return(list(tabsup = Xsup, lisup = coosup))
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
    coosup <- as.matrix(Xsup) %*% (as.matrix(x$c1) * x$cw)
    coosup <- data.frame(coosup, row.names = row.names(Xsup))
    names(coosup) <- names(x$li)
    return(list(tabsup = Xsup, lisup = coosup))
}

"suprow.acm" <- function (x, Xsup, ...) {
    Xsup <- data.frame(Xsup)
    if (!inherits(x, "dudi")) 
        stop("Object of class 'dudi' expected")
    if (!inherits(x, "acm")) 
        stop("Object of class 'acm' expected")
    if (!inherits(Xsup, "data.frame")) 
        stop("Xsup is not a data.frame")
    if (ncol(Xsup) != nrow(x$cr)) 
        stop("non convenient col numbers")
    
    appel <- as.list(x$call)
    Xori <- as.data.frame(eval.parent(appel$df))
    for(j in 1:ncol(Xsup)){
        ## modify Xsup to ensure that factors have the same levels
        ## than the original table
        Xsup[,j] <- factor(Xsup[,j], levels = levels(Xori[,j]))
        if(any(is.na(Xsup[,j])))
            stop(paste("the factor", names(Xsup)[j] ,"in Xsup contains unknown levels)"))
    }
    
    nvar <- ncol(Xsup)
    Xsup <- acm.disjonctif(Xsup)
    Xsup <- t(t(Xsup)/ (x$cw * nvar)) - 1
    coosup <- Xsup %*% (as.matrix(x$c1) * x$cw)
    coosup <- data.frame(coosup, row.names = row.names(Xsup))
    names(coosup) <- names(x$li)
    return(list(tabsup = Xsup, lisup = coosup))
}


"suprow.mix" <- function (x, Xsup, ...) {
    Xsup <- data.frame(Xsup)
    appel <- as.list(x$call)
    if (!inherits(x, "dudi")) 
        stop("Object of class 'dudi' expected")
    if (!inherits(x, "mix")) 
        stop("Object of class 'mix' expected")
    if (appel[[1]] != "dudi.hillsmith") 
        stop("Not yet implemented for 'dudi.mix'. Please use 'dudi.hillsmith'.")
    if (!inherits(Xsup, "data.frame")) 
        stop("Xsup is not a data.frame")
    if (ncol(Xsup) != nrow(x$cr)) 
        stop("non convenient col numbers")
    
    Xori <- as.data.frame(eval.parent(appel$df))
    res <- matrix(0, nrow(Xsup), 1)
    for(j in 1:ncol(Xsup)){
        if (x$index[j] == "q") {
            var.tmp <- scale(Xsup[,j], scale = x$norm[j], center = x$center[j])
            res <- cbind(res, var.tmp)
        } else if(x$index[j] == "f"){
            ## modify Xsup to ensure that factors have the same levels
            ## than the original table
            Xsup[,j] <- factor(Xsup[,j], levels = levels(factor(Xori[,j])))
            if(any(is.na(Xsup[,j])))
                stop(paste("the factor", names(Xsup)[j] ,"in Xsup contains unknown levels)"))
            var.tmp <- fac2disj(Xsup[, j], drop = FALSE)
            col.w <- x$cw[x$assign == j]
            var.tmp <- t(t(var.tmp)/col.w) - 1
            res <- cbind(res, var.tmp)
        } 
    }
    
    res <- res[,-1]
    coosup <- res %*% (as.matrix(x$c1) * x$cw)
    coosup <- data.frame(coosup, row.names = row.names(Xsup))
    names(coosup) <- names(x$li)
    res <- data.frame(res, row.names = row.names(Xsup))
    names(res) <- names(x$tab)
    return(list(tabsup = res, lisup = coosup))
}
