"s.corcircle" <- function (dfxy, xax = 1, yax = 2, label = row.names(df), clabel = 1,
    grid = TRUE, sub = "", csub = 1, possub = "bottomleft", cgrid = 0, 
    fullcircle = TRUE, box = FALSE, add.plot = FALSE) 
{
    arrow1 <- function(x0, y0, x1, y1, len = 0.1, ang = 15, lty = 1, 
        edge) {
        d0 <- sqrt((x0 - x1)^2 + (y0 - y1)^2)
        if (d0 < 1e-07) 
            return(invisible())
        segments(x0, y0, x1, y1, lty = lty)
        h <- strheight("A", cex = par("cex"))
        if (d0 > 2 * h) {
            x0 <- x1 - h * (x1 - x0)/d0
            y0 <- y1 - h * (y1 - y0)/d0
            if (edge) 
                arrows(x0, y0, x1, y1, angle = ang, length = len, 
                  lty = 1)
        }
    }
    scatterutil.circ <- function(cgrid, h, grid) {
        cc <- seq(from = -1, to = 1, by = h)
        col <- "lightgray"
        if(grid){
          for (i in 1:(length(cc))) {
            x <- cc[i]
            a1 <- sqrt(1 - x * x)
            a2 <- (-a1)
            segments(x, a1, x, a2, col = col)
            segments(a1, x, a2, x, col = col)
          }
        }
        symbols(0, 0, circles = 1, inches = FALSE, add = TRUE)
        segments(-1, 0, 1, 0)
        segments(0, -1, 0, 1)
        if (cgrid <= 0 | !grid) 
            return(invisible())
        cha <- paste("d = ", h, sep = "")
        cex0 <- par("cex") * cgrid
        xh <- strwidth(cha, cex = cex0)
        yh <- strheight(cha, cex = cex0) + strheight(" ", cex = cex0)/2
        x0 <- strwidth(" ", cex = cex0)
        y0 <- strheight(" ", cex = cex0)/2
        x1 <- par("usr")[2]
        y1 <- par("usr")[4]
        rect(x1 - x0, y1 - y0, x1 - xh - x0, y1 - yh - y0, col = "white", 
             border = 0)
        text(x1 - xh/2 - x0/2, y1 - yh/2 - y0/2, cha, cex = cex0)
    }
    origin <-c(0,0)
    df <- data.frame(dfxy)
    if (!is.data.frame(df)) 
        stop("Non convenient selection for df")
    if ((xax < 1) || (xax > ncol(df))) 
        stop("Non convenient selection for xax")
    if ((yax < 1) || (yax > ncol(df))) 
        stop("Non convenient selection for yax")
    x <- df[, xax]
    y <- df[, yax]
    if (add.plot) {
        for (i in 1:length(x)) arrow1(0, 0, x[i], y[i], len = 0.1, 
            ang = 15, edge = TRUE)
        if (clabel > 0) 
            scatterutil.eti.circ(x, y, label, clabel)
        return(invisible())
    }
    opar <- par(mar = par("mar"))
    on.exit(par(opar))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    x1 <- x
    y1 <- y
    x1 <- c(x1, -0.01, +0.01)
    y1 <- c(y1, -0.01, +0.01)
    if (fullcircle) {
        x1 <- c(x1, -1, 1)
        y1 <- c(y1, -1, 1)
    }
    x1 <- c(x1 - diff(range(x1)/20), x1 + diff(range(x1))/20)
    y1 <- c(y1 - diff(range(y1)/20), y1 + diff(range(y1))/20)
    plot(x1, y1, type = "n", ylab = "", asp = 1, xaxt = "n", 
        yaxt = "n", frame.plot = FALSE)
    scatterutil.circ(cgrid = cgrid, h = 0.2,grid=grid)
    for (i in 1:length(x)) arrow1(0, 0, x[i], y[i], len = 0.1, 
        ang = 15, edge = TRUE)
    if (clabel > 0) 
        scatterutil.eti.circ(x, y, label, clabel,origin)
    if (csub > 0) 
        scatterutil.sub(sub, csub, possub)
    if (box) 
        box()
    invisible(match.call())
}
