"scatter.coa" <- function (x, xax = 1, yax = 2, method = 1:3, clab.row = 0.75,
    clab.col = 1.25, posieig = "top", sub = NULL, csub = 2, ...) 
{
    if (!inherits(x, "dudi")) 
        stop("Object of class 'dudi' expected")
    if (!inherits(x, "coa")) 
        stop("Object of class 'coa' expected")
    nf <- x$nf
    if ((xax > nf) || (xax < 1) || (yax > nf) || (yax < 1) || 
        (xax == yax)) 
        stop("Non convenient selection")
    if (method == 1) {
        coolig <- x$li[, c(xax, yax)]
        coocol <- x$co[, c(xax, yax)]
        names(coocol) <- names(coolig)
        s.label(rbind.data.frame(coolig, coocol), clab = 0, 
            cpoi = 0, sub = sub, csub = csub)
        # samedi, mars 29, 2003 at 15:35 correction SD pour ZAN
        s.label(coolig, clab = clab.row, add.p = TRUE)
        s.label(coocol, clab = clab.col, add.p = TRUE)
    }
    else if (method == 2) {
        coocol <- x$c1[, c(xax, yax)]
        coolig <- x$li[, c(xax, yax)]
        s.label(coocol, clab = clab.col, sub = sub, csub = csub)
        s.label(coolig, clab = clab.row, add.plot = TRUE)
    }
    else if (method == 3) {
        coolig <- x$l1[, c(xax, yax)]
        coocol <- x$co[, c(xax, yax)]
        s.label(coolig, clab = clab.col, sub = sub, csub = csub)
        s.label(coocol, clab = clab.row, add.plot = TRUE)
    }
    else stop("Unknown method")
    add.scatter.eig(x$eig, x$nf, xax, yax, posi = posieig, ratio = 1/4)
}

