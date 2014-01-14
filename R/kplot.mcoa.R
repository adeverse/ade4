"kplot.mcoa" <- function (object, xax = 1, yax = 2, which.tab = 1:nrow(object$cov2),
    mfrow = NULL, option = c("points", "axis", "columns"), clab = 1, 
    cpoint = 2, csub = 2, possub = "bottomright", ...) 
{
    if (!inherits(object, "mcoa")) 
        stop("Object of type 'mcoa' expected")
    opar <- par(ask = par("ask"), mfrow = par("mfrow"), mar = par("mar"))
    on.exit(par(opar))
    option <- option[1]
    if (option == "points") {
        if (is.null(mfrow)) 
            mfrow <- n2mfrow(length(which.tab) + 1)
        par(mfrow = mfrow)
        if (length(which.tab) > prod(mfrow) - 1) 
            par(ask = TRUE)
        par(mar = c(0.1, 0.1, 0.1, 0.1))
        coo1 <- object$SynVar[, c(xax, yax)]
        cootot <- object$Tl1[, c(xax, yax)]
        names(cootot) <- names(coo1)
        coofull <- coo1
        for (i in which.tab) coofull <- rbind.data.frame(coofull, 
            cootot[object$TL[, 1] == levels(object$TL[,1])[i], ])
        s.label(coo1, clabel = clab, sub = "Reference", possub = "bottomright", 
            csub = csub)
        for (ianal in which.tab) {
            scatterutil.base(coofull, 1, 2, xlim = NULL, ylim = NULL, 
                grid = TRUE, addaxes = TRUE, cgrid = 1, include.origin = TRUE, 
                origin = c(0, 0), sub = row.names(object$cov2)[ianal], 
                csub = csub, possub = possub, pixmap = NULL, 
                contour = NULL, area = NULL, add.plot = FALSE)
            coo2 <- cootot[object$TL[, 1] == levels(object$TL[,1])[ianal], 1:2]
            s.match(coo1, coo2, clabel = 0, add.plot = TRUE)
            s.label(coo1, clabel = 0, cpoint = cpoint, add.plot = TRUE)
        }
        return(invisible())
    }
    if (is.null(mfrow)) 
        mfrow <- n2mfrow(length(which.tab))
    par(mfrow = mfrow)
    if (option == "axis") {
        if (length(which.tab) > prod(mfrow)) 
            par(ask = TRUE)
        for (ianal in which.tab) {
            coo2 <- object$Tax[object$T4[, 1] == levels(object$T4[,1])[ianal], c(xax, yax)]
            row.names(coo2) <- as.character(1:4)
            s.corcircle(coo2, clabel = clab, sub = row.names(object$cov2)[ianal], 
                csub = csub, possub = possub)
        }
        return(invisible())
    }
    if (option == "columns") {
        if (length(which.tab) > prod(mfrow)) 
            par(ask = TRUE)
        for (ianal in which.tab) {
            coo2 <- object$Tco[object$TC[, 1] == levels(object$TC[,1])[ianal], c(xax, yax)]
            s.arrow(coo2, clabel = clab, sub = row.names(object$cov2)[ianal], 
                csub = csub, possub = possub)
        }
        return(invisible())
    }
}
