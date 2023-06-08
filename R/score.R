"score" <- function (x, ...) UseMethod("score")

"scoreutil.base" <- function (y, xlim, grid, cgrid, include.origin, origin, sub,
    csub) 
{
    if (is.null(xlim)) {
        x1 <- y
        if (include.origin) 
            x1 <- c(x1, origin)
        x1 <- c(x1 - diff(range(x1)/10), x1 + diff(range(x1))/10)
        xlim <- range(x1)
    }
    ylim <- c(0, 1)
    graphics::plot.default(0, 0, type = "n", xlab = "", ylab = "", xaxt = "n", 
        yaxt = "n", xlim = xlim, ylim = ylim, xaxs = "i", yaxs = "i", 
        frame.plot = FALSE)
    href <- max(3, 2 * cgrid, 2 * csub)
    href <- graphics::strheight("A", cex = graphics::par("cex") * href)
    if (grid) {
        xaxp <- graphics::par("xaxp")
        nline <- xaxp[3] + 1
        v0 <- seq(xaxp[1], xaxp[2], le = nline)
        graphics::segments(v0, rep(graphics::par("usr")[3], nline), v0, rep(graphics::par("usr")[3] + 
            href, nline), col = grDevices::gray(0.5), lty = 1)
        graphics::segments(0, graphics::par("usr")[3], 0, graphics::par("usr")[3] + href, col = 1, 
            lwd = 3)
        if (cgrid > 0) {
            a <- (xaxp[2] - xaxp[1])/xaxp[3]
            cha <- paste("d = ", a, sep = "")
            cex0 <- graphics::par("cex") * cgrid
            xh <- graphics::strwidth(cha, cex = cex0)
            yh <- graphics::strheight(cha, cex = cex0) + graphics::strheight(" ", 
                cex = cex0)/2
            x0 <- graphics::strwidth("  ", cex = cex0)
            y0 <- graphics::strheight(" ", cex = cex0)/2
            x1 <- graphics::par("usr")[1]
            y1 <- graphics::par("usr")[3]
            graphics::rect(x1 + x0, y1 + y0, x1 + xh + x0, y1 + yh + y0, 
                col = "white", border = 0)
            graphics::text(x1 + xh/2 + x0/2, y1 + yh/2 + y0/2, cha, cex = cex0)
        }
    }
    y1 <- rep(graphics::par("usr")[3] + href/2, length(y))
    y2 <- rep(graphics::par("usr")[3] + href, length(y))
    graphics::segments(y, y1, y, y2)
    if (csub > 0) {
        cha <- as.character(sub)
        if (all(c(length(cha) > 0, !is.null(cha), !is.na(cha), 
            cha != ""))) {
            cex0 <- graphics::par("cex") * csub
            xh <- graphics::strwidth(cha, cex = cex0)
            yh <- graphics::strheight(cha, cex = cex0)
            x0 <- graphics::strwidth(" ", cex = cex0)
            y0 <- graphics::strheight(" ", cex = cex0)
            x1 <- graphics::par("usr")[2]
            y1 <- graphics::par("usr")[3]
            graphics::rect(x1 - x0 - xh, y1, x1, y1 + yh + y0, col = "white", 
                border = 0)
            graphics::text(x1 - xh/2 - x0/2, y1 + yh/2 + y0/2, cha, cex = cex0)
        }
    }
    graphics::rect(graphics::par("usr")[1], graphics::par("usr")[3], graphics::par("usr")[2], graphics::par("usr")[3] + 
        href)
    return(graphics::par("usr")[3] + href)
}
