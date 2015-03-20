"s.kde2d" <- function(dfxy, xax = 1, yax = 2,
    pch = 20, cpoint = 1, neig = NULL, cneig = 2, xlim = NULL, 
    ylim = NULL, grid = TRUE, addaxes = TRUE, 
    cgrid = 1, include.origin = TRUE, origin = c(0, 0), sub = "", 
    csub = 1.25, possub = "bottomleft", pixmap = NULL, contour = NULL, 
    area = NULL, add.plot = FALSE) { 
    
    # kde2d is a function of the library MASS
    # Venables, W. N. and Ripley, B. D. (2002) _Modern Applied
    # Statistics with S._ Fourth edition.  Springer.
    # "kde2d" <- function (x, y, h, n = 25, lims = c(range(x), range(y))) {
    #   nx <- length(x)
    #   if (length(y) != nx) 
    #       stop("Data vectors must be the same length")
    #   gx <- seq(lims[1], lims[2], length = n)
    #   gy <- seq(lims[3], lims[4], length = n)
    #   if (missing(h)) 
    #       h <- c(bandwidth.nrd(x), bandwidth.nrd(y))
    #   h <- h/4
    #   ax <- outer(gx, x, "-")/h[1]
    #   ay <- outer(gy, y, "-")/h[2]
    #   z <- matrix(dnorm(ax), n, nx) %*% t(matrix(dnorm(ay), n, 
    #       nx))/(nx * h[1] * h[2])
    #   return(list(x = gx, y = gy, z = z))
    # }
    # "bandwidth.nrd" <- function(x) {
    #   r <- quantile(x, c(0.25, 0.75)) 
    #   h <- (r[2] - r[1])/1.34 4 * 1.06 * min(sqrt(var(x)), h) * length(x)^(-1/5)
    # } 

    par(mar=c(0.1,0.1,0.1,0.1))
    s.label(dfxy, xax = xax, yax = yax, clabel = 0,
    pch = pch, cpoint = cpoint, neig = neig, 
    cneig = cneig, xlim = xlim, ylim = ylim, grid = grid, addaxes = addaxes, 
    cgrid = cgrid, include.origin = include.origin, origin = origin, 
    sub = sub, csub = csub, possub = possub, pixmap = pixmap, contour = contour, 
    area = area, add.plot = add.plot)
    
    x <- as.numeric(dfxy[,xax])
    y <- as.numeric(dfxy[,yax])
    xykde = MASS::kde2d(x, y, lims=par("usr"))
    zlim = range(xykde$z, finite = TRUE)
    lev=seq(zlim[1],zlim[2],le=8)
    lev=lev[2:7]
    # col0 = gray(seq(0,.9,len=6))
    # col0 = heat.colors(6)
    # col0 = rainbow(6)
    col0="blue"
    contour(xykde,add=TRUE,lwd=2,col=col0,levels=lev,drawlabels=FALSE)
    invisible(match.call())
 }

