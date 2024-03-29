"mantel.rtest" <- function (m1, m2, nrepet = 99, ...) {
    if (!inherits(m1, "dist")) 
        stop("Object of class 'dist' expected")
    if (!inherits(m2, "dist")) 
        stop("Object of class 'dist' expected")
    n <- attr(m1, "Size")
    if (n != attr(m2, "Size")) 
        stop("Non convenient dimension")

    permutedist <- function(m) {
      w0 <- sample.int(attr(m, "Size"))
      m <- as.matrix(m)
      return(stats::as.dist(m[w0, w0]))
    }
    
    mantelnoneuclid <- function(m1, m2, nrepet) {
        obs <- stats::cor(unclass(m1), unclass(m2))
        if (nrepet == 0) 
            return(obs)
        perm <- matrix(0, nrow = nrepet, ncol = 1)
        perm <- apply(perm, 1, function(x) stats::cor(unclass(m1), unclass(permutedist(m2))))
        w <- as.randtest(obs = obs, sim = perm, call = match.call(), subclass = "mantelrtest", ...)
        return(w)
    }
    if (is.euclid(m1) & is.euclid(m2)) {
        tab1 <- pcoscaled(m1)
        obs <- stats::cor(dist.quant(tab1, 1), m2)
        if (nrepet == 0) 
            return(obs)
        perm <- rep(0, nrepet)
        perm <- unlist(lapply(perm, function(x) stats::cor(stats::dist(tab1[sample(n), 
            ]), m2)))
        w <- as.randtest(obs = obs, sim = perm, call = match.call(), subclass = "mantelrtest", ...)
        return(w)
    }
    w <- mantelnoneuclid(m1, m2, nrepet = nrepet)
    return(w)
}
