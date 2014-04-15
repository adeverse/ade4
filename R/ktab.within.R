"ktab.within" <- function (dudiwit, rownames = NULL, colnames = NULL, tabnames = NULL) {
    if (!inherits(dudiwit, "within")) 
        stop("Result from within expected for dudiwit")
    fac <- dudiwit$fac
    nblo <- nlevels(fac)
    res <- list()
    blocks <- rep(0, nblo)
    if (is.null(rownames)) 
        rownames <- names(dudiwit$tab)
    else if (length(rownames) != length(names(dudiwit$tab))) 
        stop("Non convenient rownames length")
    if (is.null(colnames)) 
        colnames <-  unlist(split(row.names(dudiwit$tab), fac))
    else if (length(colnames) != length(row.names(dudiwit$tab))) 
        stop("Non convenient colnames length")
    if (is.null(tabnames)) 
        tabnames <- levels(fac)
    else if (length(tabnames) != nblo)
        stop("Non convenient tabnames length")
    cw <- NULL
    for (i in 1:nblo) {
        k <- levels(fac)[i]
        w1 <- dudiwit$lw[fac == k]
        w1 <- w1/sum(w1)
        cw <- c(cw, w1)
        res[[i]] <- data.frame(t(dudiwit$tab[fac == k, ]))
        blocks[i] <- ncol(res[[i]])
    }
    names(blocks) <- tabnames
    res$lw <- dudiwit$cw
    res$cw <- cw
    res$blo <- blocks
    class(res) <- "ktab"
    row.names(res) <- rownames
    col.names(res) <- colnames
    tab.names(res) <- tabnames
    res <- ktab.util.addfactor(res)
    res$call <- match.call()
    res$tabw <- dudiwit$tabw
    return(res)
}
