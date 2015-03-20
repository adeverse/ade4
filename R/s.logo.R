"s.logo" <- function (dfxy, listlogo, klogo=NULL,
    clogo=1, rectlogo=TRUE,
    xax = 1, yax = 2, neig = NULL, 
    cneig = 1, xlim = NULL, ylim = NULL, grid = TRUE, addaxes = TRUE, 
    cgrid = 1, include.origin = TRUE, origin = c(0, 0), sub = "", 
    csub = 1.25, possub = "bottomleft", pixmap = NULL, contour = NULL, 
    area = NULL, add.plot = FALSE) 
{
  dfxy <- data.frame(dfxy)
    if (!is.list(listlogo)) stop (paste(deparse(substitute(listlogo)),' is not a list'))
    nlogo <- length(listlogo)
    if(is.null(klogo)) klogo <- 1:nlogo
    npoi <- nrow(dfxy)
    classico <- unlist(lapply(listlogo, function(x) (charmatch("pixmap",class(x))==1)))
    if (is.null(classico))
        stop(paste(deparse(substitute(listlogo)),'is not a list of pixmap objects'))
    if (any(is.na(classico)))
        stop(paste(deparse(substitute(listlogo)),'is not a list of pixmap objects'))
    if (!all(classico))
        stop(paste(deparse(substitute(listlogo)),'is not a list of pixmap objects'))
    klogo <- rep(klogo,length=npoi)
    if (any(klogo>nlogo)) stop('invalid index')
    rectlogo=rep(rectlogo,length=npoi)
    if (!is.logical(rectlogo)) 
       stop(paste(deparse(substitute(rectlogo)),'is not logical'))
    clogo=rep(clogo,length=npoi)
    if (!is.numeric(clogo)) 
       stop(paste(deparse(substitute(clogo)),'is not numeric'))
    opar <- par(mar = par("mar"))
    on.exit(par(opar))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    coo <- scatterutil.base(dfxy = dfxy, xax = xax, yax = yax, 
        xlim = xlim, ylim = ylim, grid = grid, addaxes = addaxes, 
        cgrid = cgrid, include.origin = include.origin, origin = origin, 
        sub = sub, csub = csub, possub = possub, pixmap = pixmap, 
        contour = contour, area = area, add.plot = add.plot)
    if (!is.null(neig)) {
        if (is.null(class(neig))) 
            neig <- NULL
        if (class(neig) != "neig") 
            neig <- NULL
         deg <- attr(neig, "degrees")
        if ((length(deg)) != (length(coo$x))) 
            neig <- NULL
    }
    if (!is.null(neig)) {
        fun <- function(x, coo) {
            segments(coo$x[x[1]], coo$y[x[1]], coo$x[x[2]], coo$y[x[2]], 
                lwd = par("lwd") * cneig)
        }
        apply(unclass(neig), 1, fun, coo = coo)
    }
    scatterutil.logo(coo$x, coo$y, listlogo, klogo, clogo, rectlogo)
    box()
    invisible(match.call())
}

"scatterutil.logo" <- function(coox,cooy,lico,kico,cico,rico) {
    drawlogo <- function (pixmap, x , y, clogo=1, rectangle = TRUE) {
        w <- par("usr")
        luser <- w[2]-w[1]
        lpixe <- 96*(par("pin")[1])/clogo
        llogo <- attr(pixmap,"size")[2]
        l <- llogo*luser/lpixe/2
        huser <- w[4]-w[3]
        hpixe <- 96*(par("pin")[2])/clogo
        hlogo <- attr(pixmap,"size")[1]
        h <- hlogo*huser/hpixe/2
        pixmap::addlogo(pixmap, c(x-l,x+l),c(y-h,y+h))
        if (rectangle) rect(x-l,y-h,x+l,y+h)
    }

    for (k in 1:length(coox)) {
        x <- coox[k]
        y <- cooy[k]
        numico <- kico[k]
        clogo <- cico[numico]
        pixmap <- lico[[numico]]
        rec <- rico[numico]
        drawlogo(pixmap, x , y, clogo, rec)
        #text(x,y,as.character(k),cex=3)
    }
}
