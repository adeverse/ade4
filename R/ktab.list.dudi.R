"ktab.list.dudi" <- function (obj, rownames = NULL, colnames = NULL, tabnames = NULL) {
    obj <- as.list(obj)
    if (any(unlist(lapply(obj, function(x) !inherits(x, "dudi"))))) 
        stop("list of object 'dudi' expected")
    nblo <- length(obj)
    res <- list()
    lw <- obj[[1]]$lw
    cw <- NULL
    blocks <- unlist(lapply(obj, function(x) ncol(x$tab)))
    for (i in 1:nblo) {
        if (any(obj[[i]]$lw != lw)) 
            stop("Non equal row weights among arrays")
        res[[i]] <- obj[[i]]$tab
        cw <- c(cw, obj[[i]]$cw)
    }
    cn <- unlist(lapply(obj, function(x) names(x$tab)))
    if (is.null(rownames)) 
        rownames <- row.names(obj[[1]]$tab)
    else if (length(rownames) != length(row.names(obj[[1]]$tab))) 
        stop("Non convenient rownames length")
    if (is.null(colnames)) 
        colnames <- cn
    else if (length(colnames) != length(cn)) 
        stop("Non convenient colnames length")
    if (is.null(names(obj))) 
        tn <- paste("Ana", 1:nblo, sep = "")
    else tn <- names(obj)
    if (is.null(tabnames)) 
        tabnames <- tn
    else if (length(tabnames) != length(tn)) 
        stop("Non convenient tabnames length")
    names(blocks) <- tabnames
    res$blo <- blocks
    res$lw <- lw
    res$cw <- cw  
    class(res) <- "ktab"
    row.names(res) <- rownames
    col.names(res) <- colnames
    tab.names(res) <- tabnames
    res <- ktab.util.addfactor(res)
    res$call <- match.call()
   
    return(res)
}
