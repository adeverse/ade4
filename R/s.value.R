"s.value" <- function (dfxy, z, xax = 1, yax = 2, method = c("squaresize",
    "greylevel"), zmax=NULL, csize = 1, cpoint = 0, pch = 20, 
    clegend = 0.75, neig = NULL, cneig = 1, xlim = NULL, ylim = NULL, 
    grid = TRUE, addaxes = TRUE, cgrid = 0.75, include.origin = TRUE, 
    origin = c(0, 0), sub = "", csub = 1, possub = "topleft", 
    pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE) 
{
    # modif samedi, novembre 29, 2003 at 08:43 le coefficient de taille
    # est rapporté aux bornes utilisateurs pour reproduire les mêmes
    # valeurs sur plusieurs fenêtres
    dfxy <- data.frame(dfxy)
    if (length(z) != nrow(dfxy)) 
        stop(paste("Non equal row numbers", nrow(dfxy), length(z)))
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
    
    method <- method [1]
    if (method == "greylevel") {
        br0 <- pretty(z, 6)
        nborn <- length(br0)
        coeff <- diff(par("usr")[1:2])/15
        numclass <- cut.default(z, br0, include.lowest = TRUE, labels = FALSE)
        valgris <- seq(1, 0, le = (nborn - 1))
        h <- csize * coeff
        for (i in 1:(nrow(dfxy))) {
            symbols(coo$x[i], coo$y[i], squares = h, bg = gray(valgris[numclass[i]]), 
                add = TRUE, inches = FALSE)
        }
        scatterutil.legend.square.grey(br0, valgris, h/2, clegend)
        if (cpoint > 0) 
            points(coo$x, coo$y, pch = pch, cex = par("cex") * 
                cpoint)
    }
    else if (method == "squaresize") {
        coeff <- diff(par("usr")[1:2])/15
        sq <- sqrt(abs(z))
        if (is.null(zmax)) zmax <- max(abs(z))
        w1 <- sqrt(zmax)
        sq <- csize * coeff * sq/w1
        for (i in 1:(nrow(dfxy))) {
            if (sign(z[i]) >= 0) {
                symbols(coo$x[i], coo$y[i], squares = sq[i],
                    bg = "black", fg = "white", add = TRUE, inches = FALSE)
            }
            else {
                symbols(coo$x[i], coo$y[i], squares = sq[i], 
                  bg = "white", fg = "black", add = TRUE, inches = FALSE)
            }
        }
        br0 <- pretty(z, 4)
        l0 <- length(br0)
        br0 <- (br0[1:(l0 - 1)] + br0[2:l0])/2
        sq0 <- sqrt(abs(br0))
        sq0 <- csize * coeff * sq0/w1
        sig0 <- sign(br0)
        if (clegend > 0) 
            scatterutil.legend.bw.square(br0, sq0, sig0, clegend)
        if (cpoint > 0) 
            points(coo$x, coo$y, pch = pch, cex = par("cex") * 
                cpoint)
    }
    else if (method == "circlesize") {
        print("not yet implemented")
    }
    if (!add.plot) box()
    invisible(match.call())
}
