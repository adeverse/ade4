"kplot.foucart" <- function (object, xax = 1, yax = 2, mfrow = NULL, which.tab = 1:length(object$blo),
    clab.r = 1, clab.c = 1.25, csub = 2, possub = "bottomright", ...) 
{
    if (!inherits(object, "foucart")) 
        stop("Object of type 'foucart' expected")
    opar <- par(ask = par("ask"), mfrow = par("mfrow"), mar = par("mar"))
    on.exit(par(opar))
    if (is.null(mfrow)) 
        mfrow <- n2mfrow(length(which.tab))
    par(mfrow = mfrow)
    if (length(which.tab) > prod(mfrow)) 
        par(ask = TRUE)
    coolig <- object$Tli[, c(xax, yax)]
    coocol <- object$Tco[, c(xax, yax)]
    names(coocol) <- names(coolig)
    cootot <- rbind.data.frame(coocol, coolig)
    if (clab.r > 0) 
        cpoi <- 0
    else cpoi <- 2
    for (ianal in which.tab) {
        coolig <- object$Tli[object$TL[, 1] == levels(object$TL[,1])[ianal], c(xax, yax)]
        coocol <- object$Tco[object$TC[, 1] == levels(object$TC[,1])[ianal], c(xax, yax)]
        s.label(cootot, clabel = 0, cpoint = 0, sub = object$tab.names[ianal], 
            csub = csub, possub = possub)
        s.label(coolig, clabel = clab.r, cpoint = cpoi, add.plot = TRUE)
        s.label(coocol, clabel = clab.c, add.plot = TRUE)
    }
}
