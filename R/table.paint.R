"table.paint" <- function (df, x = 1:ncol(df), y = nrow(df):1, row.labels = row.names(df),
    col.labels = names(df), clabel.row = 1, clabel.col = 1, csize = 1, 
    clegend = 1) 
{
    x <- rank(x)
    y <- rank(y)
    opar <- par(mai = par("mai"), srt = par("srt"))
    on.exit(par(opar))
    table.prepare(x = x, y = y, row.labels = row.labels, col.labels = col.labels, 
        clabel.row = clabel.row, clabel.col = clabel.col, grid = FALSE, 
        pos = "paint")
    xtot <- x[col(as.matrix(df))]
    ytot <- y[row(as.matrix(df))]
    xdelta <- (max(x) - min(x))/(length(x) - 1)/2
    ydelta <- (max(y) - min(y))/(length(y) - 1)/2
    coeff <- diff(range(xtot))/15
    z <- unlist(df)
    br0 <- pretty(z, 6)
    nborn <- length(br0)
    coeff <- diff(range(x))/15
    numclass <- cut.default(z, br0, include.lowest = TRUE, labels = FALSE)
    valgris <- seq(1, 0, le = (nborn - 1))
    h <- csize * coeff
    rect(xtot - xdelta, ytot - ydelta, xtot + xdelta, ytot + 
        ydelta, col = gray(valgris[numclass]))
    if (clegend > 0) 
        scatterutil.legend.square.grey(br0, valgris, h/2, clegend)
}
