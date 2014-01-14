"kplot.pta" <- function (object, xax = 1, yax = 2, which.tab = 1:nrow(object$RV),
    mfrow = NULL, which.graph = 1:4, clab = 1, cpoint = 2, csub = 2, 
    possub = "bottomright", ask = par("ask"), ...) 
{
    if (!inherits(object, "pta")) 
        stop("Object of type 'pta' expected")
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    show <- rep(FALSE, 4)
    if (!is.numeric(which.graph) || any(which.graph < 1) || any(which.graph > 
        4)) 
        stop("`which' must be in 1:4")
    show[which.graph] <- TRUE
    if (is.null(mfrow)) {
        mfcol <- c(length(which.tab), length(which.graph))
        par(mfcol = mfcol)
    }
    else par(mfrow = mfrow)
    par(ask = ask)
    if (show[1]) {
        for (ianal in which.tab) {
            coo2 <- object$Tax[object$T4[, 1] == levels(object$T4[,1])[ianal], c(xax, yax)]
            row.names(coo2) <- as.character(1:4)
            s.corcircle(coo2, clabel = clab, cgrid = 0, sub = row.names(object$RV)[ianal], 
                csub = csub, possub = possub)
        }
    }
    if (show[2]) {
        par(mar = c(0.1, 0.1, 0.1, 0.1))
        coo1 <- object$li[, c(xax, yax)]
        cootot <- object$Tli[, c(xax, yax)]
        names(cootot) <- names(coo1)
        coofull <- coo1
        for (i in which.tab) coofull <- rbind.data.frame(coofull, cootot[object$TL[, 1] == levels(object$TL[,1])[i], ])
        for (ianal in which.tab) {
            scatterutil.base(coofull, 1, 2, xlim = NULL, ylim = NULL, 
                grid = TRUE, addaxes = TRUE, cgrid = 1, include.origin = TRUE, 
                origin = c(0, 0), sub = row.names(object$RV)[ianal], 
                csub = csub, possub = possub, pixmap = NULL, 
                contour = NULL, area = NULL, add.plot = FALSE)
            coo2 <- cootot[object$TL[, 1] == levels(object$TL[,1])[ianal], 1:2]
            s.label(coo2, add.plot = TRUE, clabel = clab, label = row.names(object$Tli)[object$TL[, 1] == levels(object$TL[,1])[ianal]])
        }
    }
    if (show[3]) {
        par(mar = c(0.1, 0.1, 0.1, 0.1))
        coo1 <- object$co[, c(xax, yax)]
        cootot <- object$Tco[, c(xax, yax)]
        names(cootot) <- names(coo1)
        coofull <- coo1
        for (i in which.tab) coofull <- rbind.data.frame(coofull, 
            cootot[object$TC[, 1] == levels(object$TC[,1])[i], ])
        for (ianal in which.tab) {
            scatterutil.base(coofull, 1, 2, xlim = NULL, ylim = NULL, 
                grid = TRUE, addaxes = TRUE, cgrid = 1, include.origin = TRUE, 
                origin = c(0, 0), sub = row.names(object$RV)[ianal], 
                csub = csub, possub = possub, pixmap = NULL, 
                contour = NULL, area = NULL, add.plot = FALSE)
            coo2 <- object$Tco[object$TC[, 1] == levels(object$TC[,1])[ianal], c(xax, yax)]
            s.arrow(coo2, add.plot = TRUE, clabel = clab, sub = row.names(object$RV)[ianal], 
                csub = csub, possub = possub)
        }
    }
    if (show[4]) {
        for (ianal in which.tab) {
            coo2 <- object$Tcomp[object$T4[, 1] == levels(object$T4[,1])[ianal], c(xax, yax)]
            row.names(coo2) <- as.character(1:4)
            s.corcircle(coo2, clabel = clab, cgrid = 0, sub = row.names(object$RV)[ianal], 
                csub = csub, possub = possub)
        }
    }
}
