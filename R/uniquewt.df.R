"uniquewt.df" <- function (x) {
    x <- data.frame(x)
    col <- ncol(x)
    w <- unlist(x[1])
    for (j in 2:col) {
        w <- paste(w, x[, j], sep = "")
    }
    w <- factor(w, unique(w))
    levels(w) <- 1:length(unique(w))
    select <- match(1:length(w), w)[1:nlevels(w)]
    x <- x[select, ]
    attr(x, "factor") <- w
    attr(x, "len.class") <- as.vector(table(w))
    return(x)
}
