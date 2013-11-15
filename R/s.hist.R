"s.hist" <- function(dfxy, xax = 1, yax = 2, cgrid=1, cbreaks=2, adjust=1,...) {
    def.par <- par(no.readonly = TRUE)# save default, for resetting...
    layout(matrix(c(2,4,1,3),2,2,byrow=TRUE), c(3,1), c(1,3), TRUE)
    ## pour avoir des quadrillages compatibles
    if (cbreaks>=1) cbreaks <- floor(cbreaks)
    else if (cbreaks<0.1) cbreaks <- 2
    else cbreaks <-  1/floor(1/cbreaks)
    ## tracé du nuage 
    s.label(dfxy,xax,yax,cgrid=cgrid,...)
    par(mar=c(0.1,0.1,0.1,0.1))
    ## quadrillage du plan
    col <- "lightgray"
    lty <- 1
    xmin <- par("xaxp")[1]
    xmax <- par("xaxp")[2]
    xampli <- par("xaxp")[3]
     ax <- (xmax-xmin)/xampli/cbreaks

    ymin <- par("yaxp")[1]
    ymax <- par("yaxp")[2]
    yampli <- par("yaxp")[3]
    ay <- (ymax-ymin)/yampli/cbreaks
    a <- min(ax, ay)
    while ((xmin-a)>par("usr")[1]) xmin<-xmin-a
    while ((xmax+a)<par("usr")[2]) xmax<-xmax+a
    while ((ymin-a)>par("usr")[3]) ymin<-ymin-a
    while ((ymax+a)<par("usr")[4]) ymax<-ymax+a
    v0 <- seq(xmin, xmax, by = a)
    h0 <- seq(ymin, ymax, by = a)
    if (par("usr")[1] < xmin) v0 <- c(par("usr")[1],v0)
    if (par("usr")[2] > xmax) v0 <- c(v0,par("usr")[2])
    if (par("usr")[3] < ymin) h0 <- c(par("usr")[3],h0)
    if (par("usr")[4] > ymax) h0 <- c(h0,par("usr")[4])
    abline(v = v0[v0!=0], col = col, lty = lty)
    abline(h = h0[h0!=0], col = col, lty = lty)
    if (cgrid > 0) {
        a1 = round(a, digits = 3)
        cha <- paste(" d = ", a1, " ", sep = "")
        cex0 <- par("cex") * cgrid
        xh <- strwidth(cha, cex = cex0)
        yh <- strheight(cha, cex = cex0) * 5/3
        x1 <- par("usr")[2]
        y1 <- par("usr")[4]
        rect(x1 - xh, y1 - yh, x1 + xh, y1 + yh, col = "white", border = 0)
        text(x1 - xh/2, y1 - yh/2, cha, cex = cex0)
    }
    para<-par("usr")
    abline(h = 0, v = 0, lty = 1)
    box()

    ## calcul des histogrammes 
    nlig <- nrow(dfxy)
    w <- dfxy[,xax]
    xhist <- hist(w, breaks=v0,plot=FALSE)
    xdens <- density(w,adjust=adjust)
    xdensx <- xdens[[1]]
    xdensy <- xdens[[2]]*nlig*a
    w <- dfxy[,yax]
    yhist <- hist(w, breaks=h0,plot=FALSE)
    ydens <- density(w,adjust=adjust)
    ydensx <- ydens[[2]]*nlig*a
    ydensy <- ydens[[1]]
    top <- max(c(xhist$counts, yhist$counts))
    leg <- pretty(0:top)
    leg <- leg[-c(1,length(leg))]
    ## l'histogramme des x
    plot.default(0, 0, type = "n", xlab = "", ylab = "", xaxt = "n", yaxt = "n", xaxs = "i", yaxs = "i", frame.plot = TRUE)
    par(usr=c(para[1:2],c(0,top)))
    abline(h=leg,lty=2)
    rect(xhist$mids-a/2,rep(0,length(xhist$mids)),xhist$mids+a/2,xhist$counts,col=grey(0.8))
    lines(xdensx,xdensy)
    ## l'histogramme des y
    plot.default(0, 0, type = "n", xlab = "", ylab = "", xaxt = "n", yaxt = "n", xaxs = "i", yaxs = "i", frame.plot = TRUE)
    par(usr=c(c(0,top),para[3:4]))
    abline(v=leg,lty=2)
    rect(rep(0,length(yhist$mids)),yhist$mids-a/2,yhist$counts,yhist$mids+a/2,col=grey(0.8))
    lines(ydensx,ydensy)
    ## la légende dans le petit carré
    plot.default(0, 0, type = "n", xlab = "", ylab = "", xaxt = "n", yaxt = "n", xaxs = "i", yaxs = "i", frame.plot = FALSE)
    par(usr=c(c(0,top),c(0,top)))
    print(leg)
    symbols(rep(0,length(leg)),rep(0,length(leg)),circles = leg,lty=2, inches = FALSE, add=TRUE)
    scatterutil.eti (sqrt(0.5)*leg, sqrt(0.5)*leg, as.character(leg), clabel=1)
    ## restauration des paramètres
    par(def.par)#- reset to default
    invisible(match.call())
}


