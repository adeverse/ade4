"table.cont" <- function (df, x = 1:ncol(df), y = 1:nrow(df), row.labels = row.names(df),
    col.labels = names(df), clabel.row = 1, clabel.col = 1, abmean.x = FALSE, 
    abline.x = FALSE, abmean.y = FALSE, abline.y = FALSE, csize = 1, clegend = 0, 
    grid = TRUE) 
{
    opar <- par(mai = par("mai"), srt = par("srt"))
    on.exit(par(opar))
    if (any(df < 0)) 
        stop("Non negative values expected")
    df <- df/sum(df)
    table.prepare(x = x, y = y, row.labels = row.labels, col.labels = col.labels, 
        clabel.row = clabel.row, clabel.col = clabel.col, grid = grid, 
        pos = "leftbottom")
    xtot <- x[col(as.matrix(df))]
    ytot <- y[row(as.matrix(df))]
    coeff <- diff(range(x))/15
    z <- unlist(df)
    sq <- sqrt(abs(z))
    w1 <- max(sq)
    sq <- csize * coeff * sq/w1
    for (i in 1:length(z)) symbols(xtot[i], ytot[i], squares = sq[i], 
        bg = "white", fg = 1, add = TRUE, inches = FALSE)
    f1 <- function(x,xval) {
        w1 <- weighted.mean(xval, x)
        xval <- (xval - w1)^2
        w2 <- sqrt(weighted.mean(xval, x))
        return(c(w1, w2))
    }
    if (abmean.x) {
        val <- y
        w <- t(apply(df, 2, f1,xval=val))
        points(x, w[, 1], pch = 20, cex = 2)
        segments(x, w[, 1] - w[, 2], x, w[, 1] + w[, 2])
    }
    if (abmean.y) {
        val <- x
        w <- t(apply(df, 1, f1,xval=val))
        points(w[, 1], y, pch = 20, cex = 2)
        segments(w[, 1] - w[, 2], y, w[, 1] + w[, 2], y)
    }
    df <- as.matrix(df)
    x <- x[col(df)]
    y <- y[row(df)]
    df <- as.vector(df)
    if (abline.x) {
        abline(lm(y ~ x, weights = df))
    }
    if (abline.y) {
        w <- coefficients(lm(x ~ y, weights = df))
        if (w[2] == 0) 
            abline(h = w[1])
        else abline(c(-w[1]/w[2], 1/w[2]))
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
