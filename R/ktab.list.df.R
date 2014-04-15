"ktab.list.df" <- function (obj, rownames = NULL, colnames = NULL, tabnames = NULL,
    w.row = rep(1, nrow(obj[[1]])), w.col = lapply(obj, function(x) rep(1/ncol(x), 
        ncol(x)))) 
{
    obj <- as.list(obj)
    if (any(unlist(lapply(obj, function(x) !inherits(x, "data.frame"))))) 
        stop("list of 'data.frame' object expected")
    nblo <- length(obj)
    res <- list()
    nlig <- nrow(obj[[1]])
    blocks <- unlist(lapply(obj, function(x) ncol(x)))
    cn <- unlist(lapply(obj, names))
    if (is.null(rownames)) 
        rownames <- row.names(obj[[1]])
    else if (length(rownames) != length(row.names(obj[[1]]))) 
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
    if (nlig != length(w.row)) 
        stop("Non convenient length for w.row")
    n1 <- unlist(lapply(w.col, length))
    n2 <- unlist(lapply(obj, ncol))
    if (any(n1 != n2)) 
        stop("Non convenient length in  w.col")
    for (i in 1:nblo) {
        res[[i]] <- obj[[i]]
    }
    lw <- w.row
    cw <- unlist(w.col)
    names(cw) <- NULL
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
