"dotcircle" <- function (z,alpha0=pi/2,xlim=range(pretty(z)),labels=names(z),clabel=1,cleg=1) {
    if (!is.numeric(z)) stop("z is not numeric")
    n <- length(z)
    if (n<=2) stop ("length(z)<3")
    if (is.null (labels)) clabel <- 0
    if (length(labels)!=length(z)) clabel <- 0
    alpha <- alpha0-(1:n)*2*pi/n
    leg <- xlim
    leg0 <- (leg-min(leg))/(max(leg)-min(leg))*0.8+0.2
    z0 <- (z-min(leg))/(max(leg)-min(leg))*0.8+0.2
    opar <- graphics::par(mar = graphics::par("mar"),srt=graphics::par("srt"))
    on.exit(graphics::par(opar))
    graphics::par(mar = c(0.1, 0.1, 0.1, 0.1))
    x <- z0*cos(alpha)
    y <- z0*sin(alpha)

    graphics::plot( c(0,0), type = "n", ylab = "", asp = 1, xaxt = "n", 
        yaxt = "n", frame.plot = FALSE, xlim=c(-1.2,1.2), ylim=c(-1.2,1.2))
   # if (clabel > 0) scatter.util.eti.circ(x, y, label, clabel)
   # if (csub > 0) scatter.util.sub(sub, csub, possub)
   # if (box) box()
    
    graphics::symbols(0, 0, circles=0.2,inches=FALSE,add=TRUE)
    for (i in 1:2) {
        graphics::symbols(0, 0, circles=leg0[i],inches=FALSE,add=TRUE,fg=grDevices::grey(0.5))
    }
    graphics::points(x,y,type="o",pch=20,cex=2)
    graphics::segments(x[n],y[n],x[1],y[1])
    graphics::segments(0.2*cos(alpha),0.2*sin(alpha),x,y)
    if (clabel>0) {
        for (i in 1:n) {
            graphics::par(srt=alpha[i]*360/2/pi)
            graphics::text(1.1*cos(alpha[i]),1.1*sin(alpha[i]),labels[i],adj=0,cex=graphics::par("cex")*clabel)
            graphics::segments(cos(alpha[i]),sin(alpha[i]),1.1*cos(alpha[i]),1.1*sin(alpha[i]),col=grDevices::grey(0.5))
        }
    }
    graphics::par(srt=0)
    if (cleg>0) {
        s.label(cbind.data.frame(c(0.2,0,-0.2,0),c(0,-0.2,0,0.2)),
            label=as.character(rep(leg[1],4)),add.plot=TRUE,clabel=cleg)
        s.label(cbind.data.frame(c(1,0,-1,0),c(0,-1,0,1)),
            label=as.character(rep(leg[2],4)),clabel=cleg, add.plot=TRUE)
    }
}
