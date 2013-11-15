"table.phylog" <- function (df, phylog, x = 1:ncol(df), f.phylog = 0.5,
    labels.row = gsub("[_]"," ",row.names(df)), clabel.row = 1,
    labels.col = names(df), clabel.col = 1, 
    labels.nod = names(phylog$nodes), clabel.nod = 0, cleaves = 1,
    cnodes = 1, csize = 1, grid = TRUE, clegend=0.75)
{
    df <- as.data.frame(df)
    if (!inherits(df,"data.frame")) stop ("data.frame expected for 'df'")
    if (!inherits(phylog,"phylog")) stop ("class 'phylog' expected for 'phylog'")
    leave.names <- names(phylog$leaves)
    node.names <- names(phylog$nodes)
    n.leave <- length(leave.names)
    n.node <- length(node.names)
    if (f.phylog > 0.8) f.phylog <- 0.8
    if (f.phylog < 0.2) f.phylog <- 0.2
    opar <- par(mai = par("mai"), srt = par("srt"))
    on.exit(par(opar))
    w1 <- sort(row.names(df))
    w2 <- sort(names(phylog$leaves))
    if (!all(w1 == w2)) {
       print.noquote("names from 'df'")
       print(w1)
       print.noquote("names from 'phylog'")
       print(w2)
       stop ("non convenient matching information")
    }

    df <- df[names(phylog$leaves), ]
    # df données phylog structure
    frame()
    labels.row <- paste(" ", labels.row, " ", sep = "")
    labels.col <- paste(" ", labels.col, " ", sep = "")
    cexrow <- par("cex") * clabel.row
    strx <- 0.1
    if (cexrow > 0) {
        strx <- max( strwidth(labels.row, units = "inches", cex = cexrow))+0.1
    }
    cexcol <- par("cex") * clabel.col
    stry <- 0.1
    if (cexcol > 0) {
        stry <- max( strwidth(labels.col, units = "inches", cex = cexcol))+0.1
    }
    par(mai = c(0.1, 0.1, stry, strx))
    #nc <- ncol(df)
    #x <- 1/2/nc+(0:(nc-1))/nc
    # modif du 06/01/2005 le oaramètre x avait été oublié
    intermin <- abs(min(diff(sort(x))))
    intertot <- abs(max(x)-min(x))
    x <- (x-min(x)+intermin)/(intertot+2*intermin)
    x <- (1 - f.phylog) * x + f.phylog
    nl <- nrow(df)
    y <- 1/2/nl+((nl-1):0)/nl
    par(new = TRUE)
    plot.default(0, 0, type = "n", xlab = "", ylab = "", 
        xaxt = "n", yaxt = "n", xlim = c(-0.075,1), ylim = c(0,1), 
        xaxs = "i", yaxs = "i", frame.plot = FALSE)
    if (cexrow > 0) {
        for (i in 1:length(y)) {
            text(1.01, y[i], labels.row[i], adj = 0, 
              cex = cexrow, xpd = NA)
            segments(1, y[i], 1.01, y[i], xpd = NA)
        }
    }
    if (cexcol > 0) {
        par(srt = 90)
        for (i in 1:length(x)) {
            text(x[i], 1.01, labels.col[i], adj = 0, 
              cex = cexcol, xpd = NA)
            segments(x[i], 1.0, x[i], 1.01,, xpd = NA)
        }
        par(srt = 0)
    }
     if (grid) {
        col <- "lightgray"
        for (i in 1:length(y)) segments(1,y[i], 
            f.phylog, y[i], col = col)
        for (i in 1:length(x)) segments(x[i], 0, 
            x[i], 1, col = col)
    }
    rect(f.phylog, 0, 1, 1)
    xtot <- x[col(as.matrix(df))]
    ytot <- y[row(as.matrix(df))]
    coeff <- diff(range(xtot))/15
    z <- unlist(df)
    sq <- sqrt(abs(z))
    w1 <- max(sq)
    sq <- csize * coeff * sq/w1
    for (i in 1:length(z)) {
        if (sign(z[i]) >= 0) {
            symbols(xtot[i], ytot[i], squares = sq[i], bg = "black", 
                fg = "white", add = TRUE, inches = FALSE)
        }
        else {
            symbols(xtot[i], ytot[i], squares = sq[i], bg = "white", 
                fg = "black", add = TRUE, inches = FALSE)
        }
    }
    br0 <- pretty(z, 4)
    l0 <- length(br0)
    br0 <- (br0[1:(l0 - 1)] + br0[2:l0])/2
    sq0 <- sqrt(abs(br0))
    sq0 <- csize * coeff * sq0/w1
    sig0 <- sign(br0)
    
    dis <- phylog$droot
    dn <- phylog$droot[node.names]
    names(y) <- leave.names
    x <- dis
    x <- (x/max(x)) * f.phylog
    for (i in 1:n.leave) {
        segments(f.phylog, y[i], x[i], y[i], col = grey(0.7))
        points(x[i], y[i], pch = 20, cex = par("cex") * cleaves)
    }
    newlab <- as.character(1:length(phylog$nodes))
    newx <- NULL
    newy <- NULL
    yn <- rep(0, length(dn))
    names(yn) <- names(dn)
    y <- c(y, yn)
    for (i in 1:n.node) {
        w <- phylog$parts[[i]]
        if (clabel.nod>0) newlab[i] <- labels.nod[i]
        but <- names(phylog$parts)[i]
        y[but] <- mean(y[w])
        newy[i] <- y[but]
        newx[i] <- x[but]
        b <- range(y[w])
        segments(x[but], b[1], x[but], b[2])
        x1 <- x[w]
        y1 <- y[w]
        x2 <- rep(x[but], length(w))
        segments(x1, y1, x2, y1)
     }
     if (cnodes > 0) points(newx, newy, pch = 21, bg="white", cex = par("cex") * cnodes, xpd=NA)
     if (clabel.nod>0) (scatterutil.eti(newx,newy,newlab,clabel.nod))
     if (clegend > 0) 
            scatterutil.legend.bw.square(br0, sq0, sig0, clegend)

}
