"scatter.fca" <- function (x, xax = 1, yax = 2, clab.moda = 1, labels = names(x$tab),
    sub = NULL, csub = 2, ...) 
{
    opar <- par(mfrow = par("mfrow"))
    on.exit(par(opar))
    if ((xax == yax) || (x$nf == 1)) 
        stop("Unidimensional plot (xax=yax) not yet implemented")
    par(mfrow = n2mfrow(length(x$blo)))
    oritab <- eval.parent(as.list(x$call)[[2]])
    indica <- factor(rep(names(x$blo), x$blo))
    for (j in levels(indica)) 
        s.distri(x$l1, xax= xax, yax=yax, oritab[, which(indica == j)], 
        clabel = clab.moda, sub = as.character(j), cellipse = 0, 
        cstar = 0.5, csub = csub, label = labels[which(indica == j)])
}
