"ktab.data.frame" <- function (df, blocks, rownames = NULL, colnames = NULL, tabnames = NULL,
    w.row = rep(1, nrow(df))/nrow(df), w.col = rep(1, ncol(df))) 
{
    if (!inherits(df, "data.frame")) 
        stop("object 'data.frame' expected")
    nblo <- length(blocks)
    if (sum(blocks) != ncol(df)) 
        stop("Non convenient 'blocks' parameter")
    if (is.null(rownames)) 
        rownames <- row.names(df)
    else if (length(rownames) != length(row.names(df))) 
        stop("Non convenient rownames length")
    if (is.null(colnames)) 
        colnames <- names(df)
    else if (length(colnames) != length(names(df))) 
        stop("Non convenient colnames length")
    if (is.null(names(blocks))) 
        tn <- paste("Ana", 1:nblo, sep = "")
    else tn <- names(blocks)
    if (is.null(tabnames)) 
        tabnames <- tn
    else if (length(tabnames) != length(tn)) 
        stop("Non convenient tabnames length")
    for (x in c("lw", "cw", "blo", "TL", "TC", "T4")) tabnames[tabnames == 
        x] <- paste(x, "*", sep = "")
    indica <- as.factor(rep(1:nblo, blocks))
    res <- list()
    for (i in 1:nblo) {
        res[[i]] <- df[, indica == i]
    }
    names(blocks) <- tabnames
    res$lw <- w.row
    res$cw <- w.col
    res$blo <- blocks
    class(res) <- "ktab"
    row.names(res) <- rownames
    col.names(res) <- colnames
    tab.names(res) <- tabnames
    res <- ktab.util.addfactor(res)
    res$call <- match.call()
    
    return(res)
}
