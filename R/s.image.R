s.image <- function(dfxy, z, xax=1, yax=2, span=0.5,
    xlim = NULL, ylim = NULL,
    kgrid=2, scale=TRUE, 
    grid = FALSE, addaxes = FALSE, cgrid = 0, include.origin = FALSE, 
    origin = c(0, 0), sub = "", csub = 1, possub = "topleft", 
    neig = NULL, cneig = 1, image.plot=TRUE, contour.plot=TRUE,
    pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE) 
{
    dfxy <- data.frame(dfxy)
    if(scale) 
      z <- scalewt(z)
    if(length(z) != nrow(dfxy)) 
      stop(paste("Non equal row numbers", nrow(dfxy), length(z)))
    opar <- graphics::par(mar = graphics::par("mar"))
    on.exit(graphics::par(opar))
    graphics::par(mar = c(0.1, 0.1, 0.1, 0.1))
    xy <- dfxy[,c(xax,yax)]
    names(xy) <- c("x","y")
    scatterutil.base(dfxy = xy, xax = xax, yax = yax, 
            xlim = xlim, ylim = ylim, grid = grid, addaxes = addaxes, 
            cgrid = cgrid, include.origin = include.origin, origin = origin, 
            sub = sub, csub = csub, possub = possub, pixmap = pixmap, 
            contour = contour, area = area, add.plot = add.plot)
    w <- cbind.data.frame(xy,z)
    ngrid <- floor(kgrid*sqrt(nrow(w)))
    if (ngrid<5) 
      ngrid<-5
    lo <- stats::loess(z~x+y,data=w,span=span)
    xg <- seq(from=graphics::par("usr")[1],to=graphics::par("usr")[2],le=ngrid)
    yg <- seq(from=graphics::par("usr")[3],to=graphics::par("usr")[4],le=ngrid)
    gr <- expand.grid(xg, yg)
    names(gr) <- names(xy)
    mod <- stats::predict(lo,newdata=gr)
    if(is.null(area)) {
      polyin <- w[grDevices::chull(xy),]
      grin <- splancs::inpip(gr,polyin)
      mod[-grin] <- NA
    } else {
      grin <- rep(0,nrow(gr))
      larea <- split(area[,2:3],area[,1])
      lapply(larea,function(x) grin <<- grin+splancs::inout(gr,x))
      mod[!grin] <- NA
    }
    
    mod <- matrix(mod,ngrid,ngrid)
    if(image.plot) 
      graphics::image(xg,yg,mod,add=TRUE, col=grDevices::gray((32:0)/32))
    if(contour.plot) 
      graphics::contour(xg,yg,mod,add=TRUE,labcex=1,lwd=2,nlevels=5,levels=pretty(z,7)[-c(1,7)],col="red")
    invisible(match.call())
}
