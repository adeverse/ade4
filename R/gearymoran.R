"gearymoran" <- function (bilis, X, nrepet=999) {
    # bilis doit être une matrice
    bilis <- as.matrix(bilis)
    nobs <- ncol(bilis)
    # bilis doit être carrée
    if (nrow(bilis) != nobs) stop ("'bilis' is not squared")
    # bilis doit être symétrique
    bilis <- (bilis + t(bilis))/2
    # bilis doit être à termes positifs (voisinages)
    if (any(bilis<0)) stop ("term <0 found in 'bilis'")
    test.names <- names(X)
    X <- data.matrix(X)
    if (nrow(X) != nobs) stop ("non convenient dimension")
    nvar <- ncol(X)
    res <- .C("gearymoran",
        param = as.integer(c(nobs,nvar,nrepet)),
        data = as.double(X),
        bilis = as.double(bilis),
        obs = double(nvar),
        result = double (nrepet*nvar),
        obstot = double(1),
        restot = double (nrepet)
    )
    res <- c(res$obs,res$result)
    res <- matrix(res, ncol=nvar, byr=TRUE)
    res <- as.data.frame(res)
    names(res) <- test.names
    res <- as.list(res)
    class(res) <- "krandtest"
    return(res)       
}
