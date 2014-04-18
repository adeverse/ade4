############ scatterutil.base #################
"scatterutil.base" <- function (dfxy, xax, yax, xlim, ylim, grid, addaxes, cgrid, include.origin,
    origin, sub, csub, possub, pixmap, contour, area, add.plot) 
{
    df <- data.frame(dfxy)
    if (!is.data.frame(df)) 
        stop("Non convenient selection for df")
    if ((xax < 1) || (xax > ncol(df))) 
        stop("Non convenient selection for xax")
    if ((yax < 1) || (yax > ncol(df))) 
        stop("Non convenient selection for yax")
    x <- df[, xax]
    y <- df[, yax]
    if (is.null(xlim)) {
        x1 <- x
        if (include.origin) 
            x1 <- c(x1, origin[1])
        x1 <- c(x1 - diff(range(x1)/10), x1 + diff(range(x1))/10)
        xlim <- range(x1)
    }
    if (is.null(ylim)) {
        y1 <- y
        if (include.origin) 
            y1 <- c(y1, origin[2])
        y1 <- c(y1 - diff(range(y1)/10), y1 + diff(range(y1))/10)
        ylim <- range(y1)
    }
    if (!is.null(pixmap)) {
        if (is.null(class(pixmap))) 
            pixmap <- NULL
        if (is.na(charmatch("pixmap", class(pixmap)))) 
            pixmap <- NULL
    }
   
    if (!is.null(contour)) {
        if (!is.data.frame(contour)) 
            contour <- NULL
        if (ncol(contour) != 4) 
            contour <- NULL
    }
    if (!is.null(area)) {
        if (!is.data.frame(area)) 
            area <- NULL
        if (!is.factor(area[, 1])) 
            area <- NULL
        if (ncol(area) < 3) 
            area <- NULL
    }
    if ( !add.plot) 
        plot.default(0, 0, type = "n", asp = 1, xlab = "", ylab = "", 
        xaxt = "n", yaxt = "n", xlim = xlim, ylim = ylim, xaxs = "i", 
        yaxs = "i", frame.plot = FALSE)

    if (!is.null(pixmap)) {
        pixmap::plot(pixmap, add = TRUE)
    }

    if (!is.null(contour)) {
        apply(contour, 1, function(x) segments(x[1], x[2], x[3], 
            x[4], lwd = 1))
    }
    if (grid & !add.plot) 
        scatterutil.grid(cgrid)
    if (addaxes & !add.plot) 
        abline(h = 0, v = 0, lty = 1)
    if (!is.null(area)) {
        nlev <- nlevels(area[, 1])
        x1 <- area[, 2]
        x2 <- area[, 3]
        for (i in 1:nlev) {
            lev <- levels(area[, 1])[i]
            a1 <- x1[area[, 1] == lev]
            a2 <- x2[area[, 1] == lev]
            polygon(a1, a2)
        }
    }
    if (csub > 0) 
        scatterutil.sub(sub, csub, possub)
    return(list(x = x, y = y))
}


############ scatterutil.chull #################
"scatterutil.chull" <- function (x, y, fac, optchull = c(0.25, 0.5, 0.75, 1), col=rep(1,length(levels(fac)))) {
    if (!is.factor(fac)) 
        return(invisible())
    if (length(x) != length(fac)) 
        return(invisible())
    if (length(y) != length(fac)) 
        return(invisible())
    for (i in 1:nlevels(fac)) {
        x1 <- x[fac == levels(fac)[i]]
        y1 <- y[fac == levels(fac)[i]]
        long <- length(x1)
        longinit <- long
        cref <- 1
        repeat {
            if (long < 3) 
                break
            if (cref == 0) 
                break
            num <- chull(x1, y1)
            x2 <- x1[num]
            y2 <- y1[num]
            taux <- long/longinit
            if ((taux <= cref) & (cref == 1)) {
                cref <- 0.75
                if (any(optchull == 1)) 
                  polygon(x2, y2, lty = 1, border=col[i])
            }
            if ((taux <= cref) & (cref == 0.75)) {
                if (any(optchull == 0.75)) 
                  polygon(x2, y2, lty = 5, border=col[i])
                cref <- 0.5
            }
            if ((taux <= cref) & (cref == 0.5)) {
                if (any(optchull == 0.5)) 
                  polygon(x2, y2, lty = 3, border=col[i])
                cref <- 0.25
            }
            if ((taux <= cref) & (cref == 0.25)) {
                if (any(optchull == 0.25)) 
                  polygon(x2, y2, lty = 2, border=col[i])
                cref <- 0
            }
            x1 <- x1[-num]
            y1 <- y1[-num]
            long <- length(x1)
        }
    }
}

############ scatterutil.eigen #################
"scatterutil.eigen" <- function (w, nf = NULL, xmax = length(w), ymin=min(0,min(w)), ymax = max(w), wsel = 1, sub = "Eigenvalues",
    csub = 2, possub = "topright",box=FALSE,yaxt="n") 
{
    opar <- par(mar = par("mar"),plt=par("plt"))
    on.exit(par(opar))
    par(mar = c(0.8, 2.8, 0.8, 0.8),plt=par("plt"))
    if (length(w) < xmax) 
        w <- c(w, rep(0, xmax - length(w)))
    # modif by TJ to handle 3 colors (respented/kept/others)
    col.w <- rep("white", length(w))
    if(!is.null(nf)) {col.w[1:nf] <- "grey"}
    col.w[wsel] <- "black"
    #
    barplot(w, col = col.w, ylim = c(ymin, ymax)*1.1,yaxt=yaxt)
    scatterutil.sub(cha = sub, csub = max(.8,csub), possub = possub)
    if(box) box()
}

############ scatterutil.ellipse #################
"scatterutil.ellipse" <- function (x, y, z, cellipse, axesell, coul = rep(1,length(x))) 
{
    if (any(is.na(z))) 
        return(invisible())
    if (sum(z * z) == 0) 
        return(invisible())
    util.ellipse <- function(mx, my, vx, cxy, vy, coeff) {
        lig <- 100
        epsi <- 1e-10
        x <- 0
        y <- 0
        if (vx < 0) 
            vx <- 0
        if (vy < 0) 
            vy <- 0
        if (vx == 0 && vy == 0) 
            return(NULL)
        delta <- (vx - vy) * (vx - vy) + 4 * cxy * cxy
        delta <- sqrt(delta)
        l1 <- (vx + vy + delta)/2
        l2 <- vx + vy - l1
        if (l1 < 0) 
            l1 <- 0
        if (l2 < 0) 
            l2 <- 0
        l1 <- sqrt(l1)
        l2 <- sqrt(l2)
        test <- 0
        if (vx == 0) {
            a0 <- 0
            b0 <- 1
            test <- 1
        }
        if ((vy == 0) && (test == 0)) {
            a0 <- 1
            b0 <- 0
            test <- 1
        }
        if (((abs(cxy)) < epsi) && (test == 0)) {
            a0 <- 1
            b0 <- 0
            test <- 1
        }
        if (test == 0) {
            a0 <- 1
            b0 <- (l1 * l1 - vx)/cxy
            norm <- sqrt(a0 * a0 + b0 * b0)
            a0 <- a0/norm
            b0 <- b0/norm
        }
        a1 <- 2 * pi/lig
        c11 <- coeff * a0 * l1
        c12 <- (-coeff) * b0 * l2
        c21 <- coeff * b0 * l1
        c22 <- coeff * a0 * l2
        angle <- 0
        for (i in 1:lig) {
            cosinus <- cos(angle)
            sinus <- sin(angle)
            x[i] <- mx + c11 * cosinus + c12 * sinus
            y[i] <- my + c21 * cosinus + c22 * sinus
            angle <- angle + a1
        }
        return(list(x = x, y = y, seg1 = c(mx + c11, my + c21, 
            mx - c11, my - c21), seg2 = c(mx + c12, my + c22, 
            mx - c12, my - c22)))
    }
    z <- z/sum(z)
    m1 <- sum(x * z)
    m2 <- sum(y * z)
    v1 <- sum((x - m1) * (x - m1) * z)
    v2 <- sum((y - m2) * (y - m2) * z)
    cxy <- sum((x - m1) * (y - m2) * z)
    ell <- util.ellipse(m1, m2, v1, cxy, v2, cellipse)
    if (is.null(ell)) 
        return(invisible())
    polygon(ell$x, ell$y, border=coul)
    if (axesell) 
        segments(ell$seg1[1], ell$seg1[2], ell$seg1[3], ell$seg1[4], 
            lty = 2, col=coul)
    if (axesell) 
        segments(ell$seg2[1], ell$seg2[2], ell$seg2[3], ell$seg2[4], 
            lty = 2, col=coul)
}

############ scatterutil.eti.circ #################
"scatterutil.eti.circ" <- function (x, y, label, clabel, origin=c(0,0), boxes=TRUE) {
    if (is.null(label)) 
        return(invisible())
    # message de JT warning pour R 1.7 modif samedi, mars 29, 2003 at 14:31
    if (any(is.na(label)))
        return(invisible())
    if (any(label == ""))
        return(invisible())
    # modif mercredi, juillet 2, 2003 at 17:26
    # pour les cas où le centre n'est pas l'origine
    xref <- x - origin[1]
    yref <- y - origin[2]
    for (i in 1:(length(x))) {
        cha <- as.character(label[i])
        cha <- paste(" ", cha, " ", sep = "")
        cex0 <- par("cex") * clabel
        
        xh <- strwidth(cha, cex = cex0)
        yh <- strheight(cha, cex = cex0) * 5/6
        if ((xref[i] > yref[i]) & (xref[i] > -yref[i])) {
            x1 <- x[i] + xh/2
            y1 <- y[i]
        }
        else if ((xref[i] > yref[i]) & (xref[i] <= (-yref[i]))) {
            x1 <- x[i]
            y1 <- y[i] - yh
        }
        else if ((xref[i] <= yref[i]) & (xref[i] <= (-yref[i]))) {
            x1 <- x[i] - xh/2
            y1 <- y[i]
        }
        else if ((xref[i] <= yref[i]) & (xref[i] > (-yref[i]))) {
            x1 <- x[i]
            y1 <- y[i] + yh
        }
        # modif JT du 7 dec 2005
        # le bloc if(boxes) ne doit contenir que la fonction rect, sinon ca plante
        # si boxes = FALSE
        if (boxes) {
            rect(x1 - xh/2, y1 - yh, x1 + xh/2, y1 + yh, col = "white", 
                border = 1)
        }
        text(x1, y1, cha, cex = cex0)
    }
}

############ scatterutil.eti #################
"scatterutil.convrot90" <- function(xh,yh){
  xusr <- par("usr")
  tmp <- xh
  xh <- yh/(xusr[4]-xusr[3])*par("pin")[2]
  xh <- xh/ par("pin")[1] * (xusr[2]-xusr[1])
  yh <- tmp/(xusr[2]-xusr[1])* par("pin")[1]
  yh <- yh/ par("pin")[2] * (xusr[4]-xusr[3])
  return(c(xh,yh))
}

"scatterutil.eti" <- function (x, y, label, clabel, boxes = TRUE, coul = rep(1, length(x)), horizontal = TRUE, bg = "white") 
{
    if (length(label) == 0) 
        return(invisible())
    if (is.null(label)) 
        return(invisible())
    if (any(label == "")) 
        return(invisible())
    cex0 <- par("cex") * clabel
    for (i in 1:(length(x))) {
        cha <- as.character(label[i])
        cha <- paste(" ", cha, " ", sep = "")
        x1 <- x[i]
        y1 <- y[i]
        xh <- strwidth(cha, cex = cex0)
        yh <- strheight(cha, cex = cex0) * 5/3
        if(!horizontal){
          tmp <- scatterutil.convrot90(xh,yh)
          xh <- tmp[1]
          yh <- tmp[2]
                    
        }
        if (boxes) {
            rect(x1 - xh/2, y1 - yh/2, x1 + xh/2, y1 + yh/2, 
                 col = bg, border = coul[i])
          }
        if(horizontal){
          text(x1, y1, cha, cex = cex0, col = coul[i])
        } else {
          text(x1, y1, cha, cex = cex0, col = coul[i], srt = 90)
        }
        
    }
}

############ scatterutil.sco #################

"scatterutil.sco" <- function(score, lim, grid, cgrid, include.origin, origin, sub, csub, horizontal, reverse){
  if (is.null(lim)) {
    x1 <- score
    if (include.origin) 
      x1 <- c(x1, origin)
    x1 <- c(x1 - diff(range(x1)/10), x1 + diff(range(x1))/10)
    lim <- range(x1)
  }
  if(horizontal){
    ylim <- c(0, 1)
    xlim <- lim
  } else {
    xlim <- c(0,1)
    ylim <- lim
  }
  
  plot.default(0, 0, type = "n", xlab = "", ylab = "", xaxt = "n", 
               yaxt = "n", xlim = xlim, ylim = ylim, xaxs = "i", yaxs = "i", 
               frame.plot = FALSE)
  
  if (grid) {
    if(horizontal){
      axp <- par("xaxp")
    } else {
      axp <- par("yaxp")
    }
    
    nline <- axp[3] + 1
    v0 <- seq(axp[1], axp[2], le = nline)
    if(horizontal){
      segments(v0, rep(0, nline), v0, rep( 1, nline), col = gray(0.5), lty = 1)
      segments(0, 0 , 0, 1, col = 1, lwd = 3)
    } else {
      segments(rep(0, nline), v0, rep( 1, nline), v0, col = gray(0.5), lty = 1)
      segments(0, 0 , 1, 0, col = 1, lwd = 3)
    }
    if (cgrid > 0) {
      a <- (axp[2] - axp[1])/axp[3]
      cha <- paste(" d = ", a," ",sep = "")
      cex0 <- par("cex") * cgrid
      xh <- strwidth(cha, cex = cex0)
      yh <- strheight(cha, cex = cex0) * 5/3
      x0 <- strwidth("  ", cex = cex0)
      y0 <- strheight(" ", cex = cex0)/2
      if(horizontal){
        if(reverse){
          x1 <- par("usr")[1]
          y1 <- par("usr")[4]
          rect(x1 + x0, y1 - y0 -yh, x1 + xh + x0, y1 - y0, col = "white", border = "white")
          text(x1 + xh/2 + x0, y1 - yh/2 - y0, cha, cex = cex0)
          
        } else {
          x1 <- par("usr")[1]
          y1 <- par("usr")[3]
          rect(x1 + x0, y1 + y0, x1 + xh + x0, y1 + yh + y0, col = "white", border = "white")
          text(x1 + xh/2 + x0, y1 + yh/2 + y0, cha, cex = cex0)
        }
      } else {
        
        tmp <- scatterutil.convrot90(xh,yh)
        xh <- tmp[1]
        yh <- tmp[2]
        tmp <- scatterutil.convrot90(x0,y0)
        x0 <- tmp[1]
        y0 <- tmp[2]
        if(reverse) {
          x1 <- par("usr")[2]
          y1 <- par("usr")[4]
          rect(x1 - x0 - xh, y1 - y0 - yh, x1  - x0, y1 -  y0, col = "white", border = "white")
          text(x1 - xh/2 - x0, y1 - yh/2 - y0, cha, cex = cex0, srt=270)          
        } else {
          x1 <- par("usr")[1]
          y1 <- par("usr")[4]
          rect(x1 + x0, y1 - y0 - yh, x1 + xh + x0, y1 -  y0, col = "white", border = "white")
          text(x1 + xh/2 + x0, y1 - yh/2 - y0, cha, cex = cex0, srt=90)
        }
      }
    }
  }
  
  href <- max(3, 2 * cgrid, 2 * csub)
  href <- strheight("A", cex = par("cex") * href)
  if(!horizontal){
    tmp <- scatterutil.convrot90(0,href)
    href <- tmp[1]
  }
  
  
  if (csub > 0) {
    cha <- as.character(sub)
    y1 <- par("usr")[3] + href/2
    if (all(c(length(cha) > 0, !is.null(cha), !is.na(cha), cha != ""))) {
      cha <- paste(" ",cha," ",sep="")
      cex0 <- par("cex") * csub
      xh <- strwidth(cha, cex = cex0)
      yh <- strheight(cha, cex = cex0) *5/3
      x0 <- strwidth(" ", cex = cex0)/2
      y0 <- strheight(" ", cex = cex0)/2
      if(horizontal){
        if(reverse) {
          x1 <- par("usr")[2]
          y1 <- par("usr")[4]
          rect(x1 - x0 - xh, y1 - y0 -yh, x1 -x0, y1 - y0, col = "white", border = "white")
          text(x1 - xh/2 - x0, y1 - yh/2 - y0, cha, cex = cex0)
        } else {
          x1 <- par("usr")[2]
          y1 <- par("usr")[3]
          rect(x1 - x0 - xh, y1 + y0, x1 -x0, y1 + yh + y0, col = "white", border = "white")
          text(x1 - xh/2 - x0, y1 + yh/2 + y0, cha, cex = cex0)
        }
      } else {
        tmp <- scatterutil.convrot90(xh,yh)
        xh <- tmp[1]
        yh <- tmp[2]
        tmp <- scatterutil.convrot90(x0,y0)
        x0 <- tmp[1]
        y0 <- tmp[2]
        if(reverse) {
          x1 <- par("usr")[2]
          y1 <- par("usr")[3]
          rect(x1 - x0 - xh, y1 + y0, x1 - x0 , y1 + yh + y0, col = "white", border = "white")
          text(x1 - xh/2 - x0, y1 + yh/2 + y0, cha, cex = cex0,srt=270)
 
        } else {
          x1 <- par("usr")[1]
          y1 <- par("usr")[3]
          rect(x1 + x0, y1 + y0, x1 + x0 + xh, y1 + yh + y0, col = "white", border = "white")
          text(x1 + xh/2 + x0, y1 + yh/2 + y0, cha, cex = cex0,srt=90)
        }
      }
      
    }
  }
  box()
  if(horizontal){
    if(reverse){
      abline( h = par("usr")[4] - href)
    } else {
      abline( h = par("usr")[3] + href)
    }
    return(c(min = par("usr")[1] , max = par("usr")[2], href = href))
  } else {
    if(reverse) {
      abline( v = par("usr")[2] - href)
    } else {
      abline( v = par("usr")[1] + href)
    }
    return(c(min = par("usr")[3] , max = par("usr")[4], href = href))
  }
  
}


############ scatterutil.grid #################
"scatterutil.grid" <- function (cgrid) {
    col <- "lightgray"
    lty <- 1
    xaxp <- par("xaxp")
    ax <- (xaxp[2] - xaxp[1])/xaxp[3]
    yaxp <- par("yaxp")
    ay <- (yaxp[2] - yaxp[1])/yaxp[3]
    a <- min(ax, ay)
    v0 <- seq(xaxp[1], xaxp[2], by = a)
    h0 <- seq(yaxp[1], yaxp[2], by = a)
    abline(v = v0, col = col, lty = lty)
    abline(h = h0, col = col, lty = lty)
    if (cgrid <= 0) 
        return(invisible())
    cha <- paste(" d = ", a, " ", sep = "")
    cex0 <- par("cex") * cgrid
    xh <- strwidth(cha, cex = cex0)
    yh <- strheight(cha, cex = cex0) * 5/3
    x1 <- par("usr")[2]
    y1 <- par("usr")[4]
    rect(x1 - xh, y1 - yh, x1 + xh, y1 + yh, col = "white", border = 0)
    text(x1 - xh/2, y1 - yh/2, cha, cex = cex0)
}

############ scatterutil.legend.bw.square #################
"scatterutil.legend.bw.square" <- function (br0, sq0, sig0, clegend) {
    br0 <- round(br0, digits = 6)
    cha <- as.character(br0[1])
    for (i in (2:(length(br0)))) cha <- paste(cha, br0[i], sep = " ")
    cex0 <- par("cex") * clegend
    yh <- max(c(strheight(cha, cex = cex0), sq0))
    h <- strheight(cha, cex = cex0)
    y0 <- par("usr")[3] + yh/2 + h/2
    ltot <- strwidth(cha, cex = cex0) + sum(sq0) + h
    rect(par("usr")[1] + h/4, y0 - yh/2 - h/4, par("usr")[1] + 
        ltot + h/4, y0 + yh/2 + h/4, col = "white")
    x0 <- par("usr")[1] + h/2
    for (i in (1:(length(sq0)))) {
        cha <- br0[i]
        cha <- paste(" ", cha, sep = "")
        xh <- strwidth(cha, cex = cex0)
        text(x0 + xh/2, y0, cha, cex = cex0)
        z0 <- sq0[i]
        x0 <- x0 + xh + z0/2
        if (sig0[i] >= 0) 
            symbols(x0, y0, squares = z0, bg = "black", fg = "white", 
                add = TRUE, inches = FALSE)
        else symbols(x0, y0, squares = z0, bg = "white", fg = "black", 
            add = TRUE, inches = FALSE)
        x0 <- x0 + z0/2
    }
    invisible()
}

############ scatterutil.legend.square.grey #################
"scatterutil.legend.square.grey" <- function (br0, valgris, h, clegend) {
    if (clegend <= 0) 
        return(invisible())
    br0 <- round(br0, digits = 6)
    nborn <- length(br0)
    cex0 <- par("cex") * clegend
    x0 <- par("usr")[1] + h
    x1 <- x0
    for (i in (2:(nborn))) {
        x1 <- x1 + h
        cha <- br0[i]
        cha <- paste(cha, "]", sep = "")
        xh <- strwidth(cha, cex = cex0)
        if (i == (nborn)) 
            break
        x1 <- x1 + xh + h
    }
    yh <- max(strheight(paste(br0), cex = cex0), h)
    y0 <- par("usr")[3] + yh/2 + h/2
    rect(par("usr")[1] + h/4, y0 - yh/2 - h/4, x1 - h/4, y0 + 
        yh/2 + h/4, col = "white")
    x0 <- par("usr")[1] + h
    for (i in (2:(nborn))) {
        symbols(x0, y0, squares = h, bg = gray(valgris[i - 1]), 
            add = TRUE, inches = FALSE)
        x0 <- x0 + h
        cha <- br0[i]
        if (cha < 1e-05) 
            cha <- round(cha, digits = 3)
        cha <- paste(cha, "]", sep = "")
        xh <- strwidth(cha, cex = cex0)
        if (i == (nborn)) 
            break
        text(x0 + xh/2, y0, cha, cex = cex0)
        x0 <- x0 + xh + h
    }
    invisible()
}

############ scatterutil.legendgris #################
"scatterutil.legendgris" <- function (w, nclasslegend, clegend) {
    l0 <- as.integer(nclasslegend)
    if (l0 == 0) 
        return(invisible())
    if (l0 == 1) 
        l0 <- 2
    if (l0 > 10) 
        l0 <- 10
    h0 <- 1/(l0 + 1)
    mid0 <- seq(h0/2, 1 - h0/2, le = l0 + 1)
    qq <- quantile(w, seq(0, 1, le = l0 + 1))
    w0 <- as.numeric(cut(w, br = qq, inc = TRUE))
    w0 <- seq(0, 1, le = l0)[w0]
    opar <- par(new = par("new"), mar = par("mar"), usr = par("usr"))
    on.exit(par(opar))
    par(new = TRUE)
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    plot(0, 0, type = "n", xlab = "", ylab = "", xaxt = "n", 
        yaxt = "n", xlim = c(0, 2), ylim = c(0, 1.5))
    rect(rep(0, l0), seq(h0/2, by = h0, le = l0), rep(h0, l0), 
        seq(3 * h0/2, by = h0, le = l0), col = gray(seq(1, 0, 
            le = l0)))
    text(rep(h0, 9), mid0, as.character(signif(qq, digits = 2)), 
        pos = 4, cex = par("cex") * clegend)
    box(col = "white")
}

############ scatterutil.scaling #################
"scatterutil.scaling" <- function (refold, refnew, xyold) {
    refold <- as.matrix(data.frame(refold))
    refnew <- as.matrix(data.frame(refnew))
    meanold <- apply(refold, 2, mean)
    meannew <- apply(refnew, 2, mean)
    refold0 <- sweep(refold, 2, meanold)
    refnew0 <- sweep(refnew, 2, meannew)
    sold <- sqrt(sum(refold0^2))
    snew <- sqrt(sum(refnew0^2))
    xyold <- sweep(xyold, 2, meanold)
    xyold <- t(t(xyold)/sold)
    xynew <- t(t(xyold) * snew)
    xynew <- sweep(xynew, 2, meannew, "+")
    xynew <- data.frame(xynew)
    names(xynew) <- names(xyold)
    row.names(xynew) <- row.names(xyold)
    return(xynew)
}
############ scatterutil.star #################
"scatterutil.star" <- function (x, y, z, cstar, coul = rep(1,length(x))) 
{
    z <- z/sum(z)
    x1 <- sum(x * z)
    y1 <- sum(y * z)
    for (i in which(z > 0)) {
        hx <- cstar * (x[i] - x1)
        hy <- cstar * (y[i] - y1)
        segments(x1, y1, x1 + hx, y1 + hy, col=coul)
    }
}


############ scatterutil.sub #################
"scatterutil.sub" <- function (cha, csub, possub = "bottomleft") {
    cha <- as.character(cha)
    if (length(cha) == 0) 
        return(invisible())
    if (is.null(cha)) 
        return(invisible())
    if (is.na(cha)) 
        return(invisible())
    if (any(cha == ""))
        return(invisible())
    if (csub == 0) 
        return(invisible())
    cex0 <- par("cex") * csub
    cha <- paste(" ", cha, " ", sep = "")
    xh <- strwidth(cha, cex = cex0)
    yh <- strheight(cha, cex = cex0) * 5/3
    if (possub == "bottomleft") {
        x1 <- par("usr")[1]
        y1 <- par("usr")[3]
        rect(x1, y1, x1 + xh, y1 + yh, col = "white", border = 0)
        text(x1 + xh/2, y1 + yh/2, cha, cex = cex0)
    }
    else if (possub == "topleft") {
        x1 <- par("usr")[1]
        y1 <- par("usr")[4]
        rect(x1, y1, x1 + xh, y1 - yh, col = "white", border = 0)
        text(x1 + xh/2, y1 - yh/2, cha, cex = cex0)
    }
    else if (possub == "bottomright") {
        x1 <- par("usr")[2]
        y1 <- par("usr")[3]
        rect(x1, y1, x1 - xh, y1 + yh, col = "white", border = 0)
        text(x1 - xh/2, y1 + yh/2, cha, cex = cex0)
    }
    else if (possub == "topright") {
        x1 <- par("usr")[2]
        y1 <- par("usr")[4]
        rect(x1, y1, x1 - xh, y1 - yh, col = "white", border = 0)
        text(x1 - xh/2, y1 - yh/2, cha, cex = cex0)
    }
}

