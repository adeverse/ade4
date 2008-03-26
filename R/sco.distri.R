"sco.distri" <- function (score, df, y.rank = TRUE, csize = 1, labels = names(df),
    clabel = 1, xlim = NULL, grid = TRUE, cgrid = 0.75, include.origin = TRUE, 
    origin = 0, sub = NULL, csub = 1) 
{
    if (!is.vector(score)) 
        stop("vector expected for score")
    if (!is.numeric(score)) 
        stop("numeric expected for score")
    if (!is.data.frame(df)) 
        stop("data.frame expected for df")
    if (any(df < 0)) 
        stop("data >=0 expected in df")
    n <- length(score)
    if ((nrow(df) != n)) 
        stop("Non convenient match")
    n <- length(score)
    nvar <- ncol(df)
    opar <- par(mar = par("mar"))
    on.exit(par(opar))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    ymin <- scoreutil.base(y = score, xlim = xlim, grid = grid, 
        cgrid = cgrid, include.origin = include.origin, origin = origin, 
        sub = sub, csub = csub)
    ymax <- par("usr")[4]
    ylabel <- strheight("A", cex = par("cex") * max(1, clabel)) * 
        1.4
    xmin <- par("usr")[1]
    xmax <- par("usr")[2]
    xaxp <- par("xaxp")
    nline <- xaxp[3] + 1
    v0 <- seq(xaxp[1], xaxp[2], le = nline)
    if (grid) {
        segments(v0, rep(ymin, nline), v0, rep(ymax, nline), 
            col = gray(0.5), lty = 1)
    }
    rect(xmin, ymin, xmax, ymax)
    sum.col <- apply(df, 2, sum)
    labels <- labels[sum.col > 0]
    df <- df[, sum.col > 0]
    nvar <- ncol(df)
    sum.col <- apply(df, 2, sum)
    df <- sweep(df, 2, sum.col, "/")
    y.distri <- (nvar:1)
    if (y.rank) {
        y.distri <- drop(score %*% as.matrix(df))
        y.distri <- rank(y.distri)
    }
    ylabel <- strheight("A", cex = par("cex") * max(1, clabel)) * 
        1.4
    y.distri <- (y.distri - min(y.distri))/(max(y.distri) - min(y.distri))
    y.distri <- ymin + ylabel + (ymax - ymin - 2 * ylabel) * 
        y.distri
    res <- matrix(0,nvar,2)
    for (i in 1:nvar) {
        w <- df[, i]
        y0 <- y.distri[i]
        x.moy <- sum(w * score)
        x.et <- sqrt(sum(w * (score - x.moy)^2))
        res[i,1] <- x.moy
        res[i,2] <- x.et * x.et
        x1 <- x.moy - x.et * csize
        x2 <- x.moy + x.et * csize
        etiagauche <- TRUE
        if ((x1 - xmin) < (xmax - x2)) 
            etiagauche <- FALSE
        segments(x1, y0, x2, y0)
        if (clabel > 0) {
            cha <- labels[i]
            cex0 <- par("cex") * clabel
            xh <- strwidth(cha, cex = cex0)
            xh <- xh + strwidth("x", cex = cex0)
            if (etiagauche) 
                x0 <- x1 - xh/2
            else x0 <- x2 + xh/2
            text(x0, y0, cha, cex = cex0)
        }
        points(x.moy, y0, pch = 20, cex = par("cex") * 2)
    }
    res <- as.data.frame(res)
    names(res) <- c("mean","var")
    rownames(res) <- names(df)
    invisible(res)
}
