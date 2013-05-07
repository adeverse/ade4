"table.prepare" <- function (x, y, row.labels, col.labels, clabel.row, clabel.col,
                             grid, pos) 
{
  cexrow <- par("cex") * clabel.row
  cexcol <- par("cex") * clabel.col
  wx <- range(x)
  wy <- range(y)
  maxx <- max(x)
  maxy <- max(y)
  minx <- min(x)
  miny <- min(y)
  dx <- diff(wx)/(length(x))
  dy <- diff(wy)/(length(y))
  if (cexrow > 0) {
    ## ncar <- max(nchar(paste(" ", row.labels, " ", sep = "")))
    ## strx <- par("cin")[1] * ncar * cexrow/2 + 0.1
    strx <- max(strwidth(paste(" ", row.labels, " ", sep = ""), units = "inches", cex=cexrow))
  }
  else strx <- 0.1
  if (cexcol > 0) {
    ##ncar <- max(nchar(paste(" ", col.labels, " ", sep = "")))
    ##stry <- par("cin")[1] * ncar * cexcol/2 + 0.1
    stry <- max(strwidth(paste(" ", col.labels, " ", sep = ""), units = "inches", cex=cexcol))
  }
  else stry <- 0.1
  if (pos == "righttop") {
    par(mai = c(0.1, 0.1, stry, strx))
    xlim <- wx + c(-dx, 2 * dx)
    ylim <- wy + c(-2 * dy, 2 * dy)
    plot.default(0, 0, type = "n", xlab = "", ylab = "", 
                 xaxt = "n", yaxt = "n", xlim = xlim, ylim = ylim, 
                 xaxs = "i", yaxs = "i", frame.plot = FALSE)
    if (cexrow > 0) {
      for (i in 1:length(y)) {
        ynew <- seq(miny, maxy, le = length(y))
        ynew <- ynew[rank(y)]
        text(maxx + 2 * dx, ynew[i], row.labels[i], adj = 0, 
             cex = cexrow, xpd = NA)
        segments(maxx + 2 * dx, ynew[i], maxx + dx, y[i])
      }
    }
    if (cexcol > 0) {
      par(srt = 90)
      for (i in 1:length(x)) {
        xnew <- seq(minx, maxx, le = length(x))
        xnew <- xnew[rank(x)]
        text(xnew[i], maxy + 2 * dy, col.labels[i], adj = 0, 
             cex = cexcol, xpd = NA)
        segments(xnew[i], maxy + 2 * dy, x[i], maxy + 
                 dy)
      }
      par(srt = 0)
    }
    if (grid) {
      col <- "lightgray"
      for (i in 1:length(y)) segments(maxx + dx, y[i], 
                                      minx - dx, y[i], col = col)
      for (i in 1:length(x)) segments(x[i], miny - dy, 
                                      x[i], maxy + dy, col = col)
    }
    rect(minx - dx, miny - dy, maxx + dx, maxy + dy)
    return(invisible())
  }
  if (pos == "phylog") {
    par(mai = c(0.1, 0.1, stry, strx))
    xlim <- wx + c(-dx, 2 * dx)
    ylim <- wy + c(-dy, 2 * dy)
    plot.default(0, 0, type = "n", xlab = "", ylab = "", 
                 xaxt = "n", yaxt = "n", xlim = xlim, ylim = ylim, 
                 xaxs = "i", yaxs = "i", frame.plot = FALSE)
    if (cexrow > 0) {
      for (i in 1:length(y)) {
        ynew <- seq(miny, maxy, le = length(y))
        ynew <- ynew[rank(y)]
        text(maxx + 2 * dx, ynew[i], row.labels[i], adj = 0, 
             cex = cexrow, xpd = NA)
        segments(maxx + 2 * dx, ynew[i], maxx + dx, y[i])
      }
    }
    if (cexcol > 0) {
      par(srt = 90)
      xnew <- x[2:length(x)]
      x <- xnew
      for (i in 1:length(x)) {
        text(xnew[i], maxy + 2 * dy, col.labels[i], adj = 0, 
             cex = cexcol, xpd = NA)
        segments(xnew[i], maxy + 2 * dy, x[i], maxy + 
                 dy)
      }
      par(srt = 0)
    }
    minx <- min(x)
    if (grid) {
      col <- "lightgray"
      for (i in 1:length(y)) segments(maxx + dx, y[i], 
                                      minx - dx, y[i], col = col)
      for (i in 1:length(x)) segments(x[i], miny - dy, 
                                      x[i], maxy + dy, col = col)
    }
    rect(minx - dx, miny - dy, maxx + dx, maxy + dy)
    rect(-dx, miny - dy, minx - dx, maxy + dy)
    return(c(0, minx - dx))
  }
  if (pos == "leftbottom") {
    par(mai = c(stry, strx, 0.05, 0.05))
    xlim <- wx + c(-2 * dx, dx)
    ylim <- wy + c(-2 * dy, dy)
    plot.default(0, 0, type = "n", xlab = "", ylab = "", 
                 xaxt = "n", yaxt = "n", xlim = xlim, ylim = ylim, 
                 xaxs = "i", yaxs = "i", frame.plot = FALSE)
    if (cexrow > 0) {
      for (i in 1:length(y)) {
        ynew <- seq(miny, maxy, le = length(y))
        ynew <- ynew[rank(y)]
        w9 <- strwidth(row.labels[i], cex = cexrow)
        text(minx - w9 - 2 * dx, ynew[i], row.labels[i], 
             adj = 0, cex = cexrow, xpd = NA)
        segments(minx - 2 * dx, ynew[i], minx - dx, y[i])
      }
    }
    if (cexcol > 0) {
      par(srt = -90)
      for (i in 1:length(x)) {
        xnew <- seq(minx, maxx, le = length(x))
        xnew <- xnew[rank(x)]
        text(xnew[i], miny - 2 * dy, col.labels[i], adj = 0, 
             cex = cexcol, xpd = NA)
        segments(xnew[i], miny - 2 * dy, x[i], miny - 
                 dy)
      }
      par(srt = 0)
    }
    if (grid) {
      col <- "lightgray"
      for (i in 1:length(y)) segments(maxx + 2 * dx, y[i], 
                                      minx - dx, y[i], col = col)
      for (i in 1:length(x)) segments(x[i], miny - 2 * 
                                      dy, x[i], maxy + dy, col = col)
    }
    rect(minx - dx, miny - dy, maxx + dx, maxy + dy)
    return(invisible())
  }
  if (pos == "paint") {
    
    dx <- diff(wx)/(length(x) - 1)/2
    dy <- diff(wy)/(length(y) - 1)/2

    par(mai = c(0.2, strx, stry, 0.1))
    xlim <- wx + c(-dx, dx)
    ylim <- wy + c(-dy, dy)
    plot.default(0, 0, type = "n", xlab = "", ylab = "", 
                 xaxt = "n", yaxt = "n", xlim = xlim, ylim = ylim, 
                 xaxs = "i", yaxs = "i", frame.plot = TRUE)
    if (cexrow > 0) {
      ynew <- seq(miny, maxy, le = length(y))
      ynew <- ynew[rank(y)]
      ##w9 <- strwidth(row.labels, cex = cexrow)
      ##text(minx - w9 - 3 * dx/4, ynew, row.labels, adj = 0, cex = cexrow, xpd = NA)
      mtext(at =  ynew, side = 2, text = paste(row.labels," ", sep = ""), adj = 1, cex = cexrow, las = 1)
    }
    if (cexcol > 0) {
      xnew <- seq(minx, maxx, le = length(x))
      xnew <- xnew[rank(x)]
      ## par(srt = 90)
      ## text(xnew, maxy + 3 * dy/4, col.labels, adj = 0, cex = cexcol, xpd = NA)
      mtext(at = xnew, side = 3, text = paste(" ", col.labels, sep = ""), adj = 0, cex = cexcol, las = 2)
      par(srt = 0)
    }
    return(invisible())
  }
}


"table.value" <- function (df, x = 1:ncol(df), y = nrow(df):1, row.labels = row.names(df),
                           col.labels = names(df), clabel.row = 1, clabel.col = 1, csize = 1, 
                           clegend = 1, grid = TRUE) 
{
  opar <- par(mai = par("mai"), srt = par("srt"))
  on.exit(par(opar))
  table.prepare(x = x, y = y, row.labels = row.labels, col.labels = col.labels, 
                clabel.row = clabel.row, clabel.col = clabel.col, grid = grid, 
                pos = "righttop")
  xtot <- x[col(as.matrix(df))]
  ytot <- y[row(as.matrix(df))]
  coeff <- diff(range(xtot))/15
  z <- unlist(df)
  sq <- sqrt(abs(z))
  w1 <- max(sq)
  sq <- csize * coeff * sq/w1
  for (i in 1:length(z)) {
    if (sign(z[i]) >= 0) {
      symbols(xtot[i], ytot[i], squares = sq[i], bg = 1, 
              fg = 0, add = TRUE, inches = FALSE)
    }
    else {
      symbols(xtot[i], ytot[i], squares = sq[i], bg = "white", 
              fg = 1, add = TRUE, inches = FALSE)
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
}
