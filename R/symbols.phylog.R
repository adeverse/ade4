"dotchart.phylog" <- function (phylog, values, ceti=1, cdot=1, ...) {
    if (!inherits(phylog, "phylog")) 
        stop("Non convenient data")
    if (! is.numeric (values)) stop ("'values' is not numeric")
    n <- length(values)
    if (length(phylog$leaves)!=n) stop ("Non convenient length")
    w <- plot.phylog (x=phylog, clabel.leaves=0, ...)
    mar.old <- par("mar")
    on.exit(par(mar=mar.old))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    par("usr"=c(0,1,-0.05,1))
    val.ref <- pretty(values,4)
    x1 <- w$xbase
    x2 <- 1 - (x1-max(w$xy$x))
    x1.use <- min(val.ref)
    x2.use <- max(val.ref)
    fun1 <- function (x) x1+(x2-x1)*(x-x1.use)/(x2.use-x1.use)
    xleg <- fun1(val.ref)
    miny <- 0 # min(w$xy$y)
    maxy <- max(w$xy$y)
    nleg <- length(xleg)
    segments(xleg,rep(miny,nleg),xleg,rep(maxy,nleg), col=grey(0.75))
    segments (w$xy$x,w$xy$y,rep(max(w$xy$x),n),w$xy$y, col=grey(0.75))
    segments (rep(xleg[1],n),w$xy$y,rep(max(xleg),n),w$xy$y, col=grey(0.5))
    if (cdot>0) points(fun1(values),w$xy$y,pch=21,cex=cdot,bg=1)
    if (ceti>0) text(xleg, rep((miny-0.05)/2,nleg),as.character(val.ref),cex=par("cex")*ceti) #(miny-0.05)/2
}


"symbols.phylog" <- function (phylog, circles, squares, csize = 1, clegend = 1, sub = "",
    csub = 1, possub = "topleft") 
{
    if (!inherits(phylog, "phylog")) 
        stop("Non convenient data")
    count <- 0
    if (!missing(circles)) {
        count <- count + 1
        data <- circles
        type <- 2
    }
    if (!missing(squares)) {
        count <- count + 1
        data <- squares
        type <- 1
    }
    if (count > 1) 
        stop("no more than one symbol type must be specified")
    if (csize <= 0) {
        data <- NULL
    }
    if (!is.null(data)) {
        if (is.null(names(data))) 
            names(data) <- names(phylog$leaves)
        if (length(data) != length(phylog$leaves)) data <- NULL
        if (!is.null(data)) {
            w1 <- sort(names(data))
            w2 <- sort(names(phylog$leaves))
            if (!all(w1 == w2)) {
                print(w1)
                print(w2)
                warning("names(data) non convenient for 'phylog' : we use the names of the leaves in 'phylog'")
                names(data) <- names(phylog$leaves)
            }
            data <- data[names(phylog$leaves)]
        }
    }
    opar <- par(mar = par("mar"))
    on.exit(par(opar))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    plot.default(0, 0, type = "n", xlab = "", ylab = "", xaxt = "n", 
        yaxt = "n", ylim = c(-0.2, 1.05), xlim = c(0, 1), xaxs = "i", 
        yaxs = "i", frame.plot = TRUE)
    symbol.max <- csize/20
    if (symbol.max > 0.5) 
        symbol.max <- 0.5
    dis <- phylog$droot
    dis <- 1 - ((1 - symbol.max) * dis/max(dis))
    xinit <- dis[names(phylog$leaves)]
    dn <- dis[names(phylog$nodes)]
    n <- length(xinit)
    yinit <- (n:1)/(n + 1)
    names(yinit) <- names(phylog$leaves)
    x <- dis
    yn <- rep(0, length(dn))
    names(yn) <- names(dn)
    y <- c(yinit, yn)
    legender <- function(br0, sq0, sig0, clegend, type) {
        br0 <- round(br0, dig = 6)
        cha <- as.character(br0[1])
        for (i in (2:(length(br0)))) cha <- paste(cha, br0[i], 
            sep = " ")
        cex0 <- par("cex") * clegend
        yh <- max(c(strheight(cha, cex = cex0), sq0))
        h <- strheight(cha, cex = cex0)
        y0 <- par("usr")[3] + yh/2 + h
        ltot <- strwidth(cha, cex = cex0) + sum(sq0) + h
        x0 <- par("usr")[1] + h/2
        for (i in (1:(length(sq0)))) {
            cha <- br0[i]
            cha <- paste(" ", cha, sep = "")
            xh <- strwidth(cha, cex = cex0)
            text(x0 + xh/2, y0, cha, cex = cex0)
            z0 <- sq0[i]
            x0 <- x0 + xh + z0/2
            if (sig0[i] >= 0) {
                if (type == 1) 
                  symbols(x0, y0, squares = z0, bg = "black", 
                    fg = "white", add = TRUE, inch = FALSE)
                else if (type == 2) 
                  symbols(x0, y0, circles = z0/2, bg = "black", 
                    fg = "white", add = TRUE, inch = FALSE)
            }
            else {
                if (type == 1) 
                  symbols(x0, y0, squares = z0, bg = "white", 
                    fg = "black", add = TRUE, inch = FALSE)
                else if (type == 2) 
                  symbols(x0, y0, circles = z0/2, bg = "white", 
                    fg = "black", add = TRUE, inch = FALSE)
            }
            x0 <- x0 + z0/2
        }
        invisible()
    }
    for (i in 1:length(phylog$parts)) {
        w <- phylog$parts[[i]]
        but <- names(phylog$parts)[i]
        y[but] <- mean(y[w])
        b <- range(y[w])
        segments(b[1], x[but], b[2], x[but])
        x1 <- x[w]
        y1 <- y[w]
        x2 <- rep(x[but], length(w))
        segments(y1, x1, y1, x2)
    }
    if (!is.null(data)) {
        sq <- sqrt(abs(data))
        w1 <- max(sq)
        sq <- symbol.max * sq/w1
        if (type == 1) {
            for (i in 1:n) {
                if (sign(data[i]) >= 0) {
                  symbols(yinit[i], xinit[i], squares = sq[i], 
                    bg = "black", fg = "white", add = TRUE, inch = FALSE)
                }
                else {
                  symbols(yinit[i], xinit[i], squares = sq[i], 
                    bg = "white", fg = "black", add = TRUE, inch = FALSE)
                }
            }
        }
        else if (type == 2) {
            for (i in 1:n) {
                if (sign(data[i]) >= 0) {
                  symbols(yinit[i], xinit[i], circles = sq[i]/2, 
                    bg = "black", fg = "white", add = TRUE, inch = FALSE)
                }
                else {
                  symbols(yinit[i], xinit[i], circles = sq[i]/2, 
                    bg = "white", fg = "black", add = TRUE, inch = FALSE)
                }
            }
        }
        if (clegend > 0) {
            br0 <- pretty(data, 4)
            l0 <- length(br0)
            br0 <- (br0[1:(l0 - 1)] + br0[2:l0])/2
            sq0 <- sqrt(abs(br0))
            sq0 <- symbol.max * sq0/w1
            sig0 <- sign(br0)
            legender(br0, sq0, sig0, clegend = clegend, type = type)
        }
    }
    if (csub > 0) 
        scatterutil.sub(sub, csub, possub)
}