"is.euclid" <- function (distmat, plot = FALSE, print = FALSE, tol = 1e-07) {
    if (!inherits(distmat, "dist")) 
        stop("Object of class 'dist' expected")
    distmat <- dist2mat(distmat)
    n <- ncol(distmat)
    delta <- -0.5 * bicenter.wt(distmat * distmat)
    lambda <- La.eigen(delta, symmetric = TRUE, only = TRUE)$values
    w0 <- lambda[n]/lambda[1]
    if (plot) 
        barplot(lambda)
    if (print) 
        print(lambda)
    return((w0 > -tol))
}

"summary.dist" <- function (object, ...) {
    if (!inherits(object, "dist")) 
        stop("For use on the class 'dist'")
    cat("Class: ")
    cat(class(object), "\n")
    cat("Distance matrix by lower triangle : d21, d22, ..., d2n, d32, ...\n")
    cat("Size:", attr(object, "Size"), "\n")
    cat("Labels:", attr(object, "Labels"), "\n")
    cat("call: ")
    print(attr(object, "call"))
    cat("method:", attr(object, "method"), "\n")
    cat("Euclidean matrix (Gower 1966):", is.euclid(object), "\n")
}

"mat2dist" <- function (m, diag = FALSE, upper = FALSE) {
    m <- as.matrix(m)
    retval <- m[row(m) > col(m)]
    attributes(retval) <- NULL
    attr(retval, "Labels") <- as.character(1:nrow(m))
    if (!is.null(rownames(m))) 
        attr(retval, "Labels") <- rownames(m)
    else if (!is.null(colnames(m))) 
        attr(retval, "Labels") <- colnames(m)
    attr(retval, "Size") <- nrow(m)
    attr(retval, "Diag") <- diag
    attr(retval, "Upper") <- upper
    attr(retval, "call") <- match.call()
    class(retval) <- "dist"
    retval
}

"dist2mat" <- function (x) {
    size <- attr(x, "Size")
    df <- matrix(0, size, size)
    df[row(df) > col(df)] <- x
    df <- df + t(df)
    labels <- attr(x, "Labels")
    dimnames(df) <- if (is.null(labels)) 
        list(1:size, 1:size)
    else list(labels, labels)
    df
}
