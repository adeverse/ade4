divc <- function(df, dis = NULL){
    # checking of user's data and initialization.
    if (!inherits(df, "data.frame")) stop("Non convenient df")
    if (any(df < 0)) stop("Negative value in df")
    if (!is.null(dis)) {
        if (!inherits(dis, "dist")) stop("Object of class 'dist' expected for distance")
        if (!is.euclid(dis)) stop("Euclidean property is expected for distance")
        dis <- as.matrix(dis)
        if (nrow(df)!= nrow(dis)) stop("Non convenient df")
    }
    if (is.null(dis)) dis <- (matrix(1, nrow(df), nrow(df)) - diag(rep(1, nrow(df)))) * sqrt(2)
    div <- as.data.frame(rep(0, ncol(df)))
    names(div) <- "diversity"
    rownames(div) <- names(df)
    for (i in 1:ncol(df)) {
        div[i, ] <- (t(df[, i]) %*% (as.matrix(dis)^2) %*% df[, i]) / 2 / (sum(df[, i])^2)
    }
    return(div)
}
