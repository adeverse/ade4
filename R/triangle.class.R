######################### triangle.class ######################################
"triangle.class" <- function (ta, fac,
    col = rep(1, length(levels(fac))), wt = rep(1, length(fac)),cstar = 1,
    cellipse = 0, axesell = TRUE, label = levels(fac),
    clabel = 1, cpoint = 1, pch=20,
    draw.line = TRUE, addaxes = FALSE, addmean = FALSE, labeltriangle = TRUE, 
    sub = "", csub = 1, possub = "bottomright", show.position = TRUE, 
    scale = TRUE, min3 = NULL, max3 = NULL) 
{ 
    # modifiée le 18/11/2004 par cohérence avec triangle.param
   
    seg <- function(a, b, col = par("col")) {
        segments(a[1], a[2], b[1], b[2], col = col)
    }
 
    ta <- data.frame(ta)
    if (!is.data.frame(ta)) stop("Non convenient selection for ta")
    if (any(is.na(ta))) stop("NA non implemented")
    if (!is.factor(fac)) stop("factor expected for fac")
    if (ncol(ta)!=3) stop("3 columns expected for ta")
    if (nrow(ta)!=length(fac)) stop ("Non convenient dimension")
    dfdistri <- fac2disj(fac) * wt
    coul <- col
    w1 <- unlist(lapply(dfdistri, sum))
    dfdistri <- t(t(dfdistri)/w1)
     
    nam <- names(ta)
    ta <- t(apply(ta, 1, function(x) x/sum(x)))
    d <- triangle.param(ta, scale = scale, min3 = min3, max3 = max3)
    opar <- par(mar = par("mar"))
    on.exit(par(opar))
    A <- d$A
    B <- d$B
    C <- d$C
    xy <- d$xy
    xymoy <- as.matrix(t(dfdistri)) %*% as.matrix(xy)
    mini <- d$mini
    maxi <- d$maxi
    if (show.position) add.position.triangle(d)
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    plot(0, 0, type = "n", xlim = c(-0.8, 0.8), ylim = c(-0.6, 
        1), xlab = "", ylab = "", xaxt = "n", yaxt = "n", asp = 1, 
        frame.plot = FALSE)
    seg(A, B)
    seg(B, C)
    seg(C, A)
    text(C[1], C[2], labels = paste(mini[1]), pos = 2)
    text(C[1], C[2], labels = paste(maxi[3]), pos = 4)
    if (labeltriangle) 
        text((A + C)[1]/2, (A + C)[2]/2, labels = nam[1], cex = 1.5, 
            pos = 2)
    text(A[1], A[2], labels = paste(maxi[1]), pos = 2)
    text(A[1], A[2], labels = paste(mini[2]), pos = 1)
    if (labeltriangle) 
        text((A + B)[1]/2, (A + B)[2]/2, labels = nam[2], cex = 1.5, 
            pos = 1)
    text(B[1], B[2], labels = paste(maxi[2]), pos = 1)
    text(B[1], B[2], labels = paste(mini[3]), pos = 4)
    if (labeltriangle) 
        text((B + C)[1]/2, (B + C)[2]/2, labels = nam[3], cex = 1.5, 
            pos = 4)
    if (draw.line) {
        nlg <- 10 * (maxi[1] - mini[1])
        for (i in 1:(nlg - 1)) {
            x1 <- A + (i/nlg) * (B - A)
            x2 <- C + (i/nlg) * (B - C)
            seg(x1, x2, col = "lightgrey")
            x1 <- A + (i/nlg) * (B - A)
            x2 <- A + (i/nlg) * (C - A)
            seg(x1, x2, col = "lightgrey")
            x1 <- C + (i/nlg) * (A - C)
            x2 <- C + (i/nlg) * (B - C)
            seg(x1, x2, col = "lightgrey")
        }
    }
    if (cpoint > 0)
        for (i in 1:ncol(dfdistri)) {
            points(xy[dfdistri[,i] > 0,],pch = pch, cex = par("cex") * cpoint, col=coul[i])
        }

    if (cstar > 0) 
        for (i in 1:ncol(dfdistri)) {
            scatterutil.star(xy[,1], xy[,2], dfdistri[, i], cstar = cstar, coul[i])
        }
        
    if (cellipse > 0) 
        for (i in 1:ncol(dfdistri)) {
            scatterutil.ellipse(xy[,1], xy[,2], dfdistri[, i], 
                cellipse = cellipse, axesell = axesell, coul[i])
        }
    if (clabel > 0) 
        scatterutil.eti(xymoy[,1], xymoy[,2], label, clabel, coul = col)
    if (csub > 0) scatterutil.sub(sub, csub, possub)

}
