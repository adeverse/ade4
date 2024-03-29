"mantel.randtest" <- function(m1, m2, nrepet = 999, ...) {
    if (!inherits(m1, "dist")) 
        stop("Object of class 'dist' expected")
    if (!inherits(m2, "dist")) 
        stop("Object of class 'dist' expected")
    n <- attr(m1, "Size")
    if (n != attr(m2, "Size")) 
        stop("Non convenient dimension")
    isim <- testmantelCpp(nrepet, as.matrix(m1), as.matrix(m2))
    obs <- isim[1]
    return(as.randtest(sim = isim[-1], obs = obs, call = match.call(), subclass = "mantelrtest", ...))
}
