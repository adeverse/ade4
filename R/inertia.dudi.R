"inertia.dudi" <- function (dudi, row.inertia = FALSE, col.inertia = FALSE) {
    if (!inherits(dudi, "dudi")) 
        stop("Object of class 'dudi' expected")
    app <- function(x) {
        if (is.na(x)) 
            return(x)
        if (is.infinite(x)) 
            return(NA)
        if ((ceiling(x) - x) > (x - floor(x))) 
            return(floor(x))
        else return(ceiling(x))
    }
    nf <- dudi$nf
    inertia <- dudi$eig
    cum <- cumsum(inertia)
    ratio <- cum/sum(inertia)
    TOT <- cbind.data.frame(inertia, cum, ratio)
    listing <- list(TOT = TOT)
    if (row.inertia) {
        w <- dudi$tab * sqrt(dudi$lw)
        w <- sweep(w, 2, sqrt(dudi$cw), "*")
        w <- w * w
        con.tra <- apply(w, 1, sum)/sum(w)
        w <- dudi$li * dudi$li * dudi$lw
        w <- sweep(w, 2, dudi$eig[1:nf], "/")
        listing$row.abs <- apply(10000 * w, c(1, 2), app)
        w <- dudi$tab
        w <- sweep(w, 2, sqrt(dudi$cw), "*")
        d2 <- apply(w * w, 1, sum)
        w <- dudi$li * dudi$li
        w <- sweep(w, 1, d2, "/")
        w <- w * sign(dudi$li)
        names(w) <- names(dudi$li)
        w <- cbind.data.frame(w, con.tra)
        listing$row.rel <- apply(10000 * w, c(1, 2), app)
        w <- dudi$li * dudi$li
        w <- sweep(w, 1, d2, "/")
        w <- data.frame(t(apply(w, 1, cumsum)))
        names(w) <- names(dudi$li)
        remain <- 1 - w[, ncol(w)]
        w <- cbind.data.frame(w, remain)
        listing$row.cum <- apply(10000 * w, c(1, 2), app)
    }
    if (col.inertia) {
        w <- dudi$tab * sqrt(dudi$lw)
        w <- sweep(w, 2, sqrt(dudi$cw), "*")
        w <- w * w
        con.tra <- apply(w, 2, sum)/sum(w)
        w <- dudi$co * dudi$co * dudi$cw
        w <- sweep(w, 2, dudi$eig[1:nf], "/")
        listing$col.abs <- apply(10000 * w, c(1, 2), app)
        w <- dudi$tab
        w <- sweep(w, 1, sqrt(dudi$lw), "*")
        d2 <- apply(w * w, 2, sum)
        w <- dudi$co * dudi$co
        w <- sweep(w, 1, d2, "/")
        w <- w * sign(dudi$co)
        names(w) <- names(dudi$co)
        w <- cbind.data.frame(w, con.tra)
        listing$col.rel <- apply(10000 * w, c(1, 2), app)
        w <- dudi$co * dudi$co
        w <- sweep(w, 1, d2, "/")
        w <- data.frame(t(apply(w, 1, cumsum)))
        names(w) <- names(dudi$co)
        remain <- 1 - w[, ncol(w)]
        w <- cbind.data.frame(w, remain)
        listing$col.cum <- apply(10000 * w, c(1, 2), app)
    }
    return(listing)
}
