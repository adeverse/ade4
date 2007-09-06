"RVdist.randtest" <- function (m1, m2, nrepet=999) {
    if (!inherits(m1, "dist")) 
        stop("Object of class 'dist' expected")
    if (!inherits(m2, "dist")) 
        stop("Object of class 'dist' expected")
    if (!is.euclid(m1)) stop ("Euclidean matrices expected")
    if (!is.euclid(m2)) stop ("Euclidean matrices expected")
    n <- attr(m1, "Size")
    if (n != attr(m2, "Size")) 
        stop("Non convenient dimension")
    m1 <- as.matrix(m1)
    m2 <- as.matrix(m2)
    res <- .C("testdistRV", as.integer(nrepet), as.integer (n), as.double(m1),
        as.double(m2), RV=double(nrepet+1),PACKAGE="ade4")$RV
    obs=res[1]
    return(as.randtest(res[-1],obs))
}

