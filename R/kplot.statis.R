"kplot.statis" <- function (object, xax = 1, yax = 2, mfrow = NULL, which.tab = 1:length(object$tab.names),
    clab = 1.5, cpoi = 2, traject = FALSE, arrow = TRUE, class = NULL, 
    unique.scale = FALSE, csub = 2, possub = "bottomright", ...) 
{
    if (!inherits(object, "statis")) 
        stop("Object of type 'statis' expected")
    opar <- par(ask = par("ask"), mfrow = par("mfrow"), mar = par("mar"))
    on.exit(par(opar))
    if (is.null(mfrow)) 
        mfrow <- n2mfrow(length(which.tab))
    par(mfrow = mfrow)
    if (length(which.tab) > prod(mfrow)) 
        par(ask = TRUE)
    nf <- ncol(object$C.Co)
    if (xax > nf) 
        stop("Non convenient xax")
    if (yax > nf) 
        stop("Non convenient yax")
    cootot <- object$C.Co[, c(xax, yax)]
    label <- TRUE
    if (!is.null(class)) {
        class <- factor(class)
        if (length(class) != length(object$TC[, 1])) 
            class <- NULL
        else label <- FALSE
    }
    for (ianal in which.tab) {
        coocol <- cootot[object$TC[, 1] == levels(object$TC[,1])[ianal], ]
        if (unique.scale) 
            s.label(cootot, clabel = 0, cpoint = 0, sub = object$tab.names[ianal], 
                possub = possub, csub = csub)
        else s.label(coocol, clabel = 0, cpoint = 0, sub = object$tab.names[ianal], 
            possub = possub, csub = csub)
        if (arrow) {
            s.arrow(coocol, clabel = clab, add.plot = TRUE)
            label <- FALSE
        }
        if (label) 
            s.label(coocol, clabel = clab, cpoint = cpoi, add.plot = TRUE)
        if (traject) 
            s.traject(coocol, clabel = 0, add.plot = TRUE)
        if (!is.null(class)) {
            f1 <- as.factor(class[object$TC[, 1] == levels(object$TC[,1])[ianal]])
            s.class(coocol, f1, clabel = clab, cpoint = 2, 
                pch = 20, axesell = FALSE, cellipse = 0, add.plot = TRUE)
        }
    }
}
