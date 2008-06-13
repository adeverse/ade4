"dudi.pca" <- function (df, row.w = rep(1, nrow(df))/nrow(df), col.w = rep(1,
    ncol(df)), center = TRUE, scale = TRUE, scannf = TRUE, nf = 2) 
{
    df <- as.data.frame(df)
    nc <- ncol(df)
    if (any(is.na(df))) 
        stop("na entries in table")
    f1 <- function(v) sum(v * row.w)/sum(row.w)
    f2 <- function(v) sqrt(sum(v * v * row.w)/sum(row.w))
    if (is.logical(center)) {
        if (center) {
            center <- apply(df, 2, f1)
            df <- sweep(df, 2, center)
        }
        else center <- rep(0, nc)
    }
    else if (is.numeric(center) && (length(center) == nc)) 
        df <- sweep(df, 2, center)
    else stop("Non convenient selection for center")
    if (scale) {
        norm <- apply(df, 2, f2)
        norm[norm < 1e-08] <- 1
        df <- sweep(df, 2, norm, "/")
    }
    else norm <- rep(1, nc)
    X <- as.dudi(df, col.w, row.w, scannf = scannf, nf = nf, 
        call = match.call(), type = "pca")
    X$cent <- center
    X$norm <- norm
    X
}

