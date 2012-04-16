"table.dist" <- function (d, x = 1:(attr(d, "Size")), labels = as.character(x),
    clabel = 1, csize = 1, grid = TRUE) 
{
    opar <- par(mai = par("mai"), srt = par("srt"))
    on.exit(par(opar))
    if (!inherits(d, "dist")) 
        stop("object of class 'dist expected")
    table.prepare(x, x, labels, labels, clabel, clabel, grid, 
        "leftbottom")
    n <- attr(d, "Size")
    d <- as.matrix(d)
    xtot <- x[col(d)]
    ytot <- x[row(d)]
    coeff <- diff(range(x))/n
    z <- as.vector(d)
    sq <- sqrt(z * pi)
    w1 <- max(sq)
    sq <- csize * coeff * sq/w1
    symbols(xtot, ytot, circles = sq, fg = 1, bg = grey(0.8), 
        add = TRUE, inches = FALSE)
}
