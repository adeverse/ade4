######################### triangle.plot ######################################
"triangle.plot" <- function (ta, label = as.character(1:nrow(ta)), clabel = 0, cpoint = 1,
    draw.line = TRUE, addaxes = FALSE, addmean = FALSE, labeltriangle = TRUE, 
    sub = "", csub = 0, possub = "topright", show.position = TRUE, 
    scale = TRUE, min3 = NULL, max3 = NULL, box = FALSE) 
{
    seg <- function(a, b, col = par("col")) {
        segments(a[1], a[2], b[1], b[2], col = col)
    }
    nam <- names(ta)
    ta <- t(apply(ta, 1, function(x) x/sum(x)))
    d <- triangle.param(ta, scale = scale, min3 = min3, max3 = max3)
    opar <- par(mar = par("mar"))
    on.exit(par(opar))
    A <- d$A
    B <- d$B
    C <- d$C
    xy <- d$xy
    mini <- d$mini
    maxi <- d$maxi
    if (show.position) 
        add.position.triangle(d)
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
        points(xy, pch = 20, cex = par("cex") * cpoint)
    if (clabel > 0) 
        scatterutil.eti(xy[, 1], xy[, 2], label, clabel)
    if (addaxes) {
        pr0 <- dudi.pca(ta, scale = FALSE, scannf = FALSE)$c1
        w1 <- triangle.posipoint(apply(ta, 2, mean), mini, maxi)
        points(w1[1], w1[2], pch = 16, cex = 2)
        a1 <- pr0[, 1]
        x1 <- a1[1] * A + a1[2] * B + a1[3] * C
        seg(w1 - x1, w1 + x1)
        a1 <- pr0[, 2]
        x1 <- a1[1] * A + a1[2] * B + a1[3] * C
        seg(w1 - x1, w1 + x1)
    }
    if (addmean) {
        m <- apply(ta, 2, mean)
        w1 <- triangle.posipoint(m, mini, maxi)
        points(w1[1], w1[2], pch = 16, cex = 2)
        w2 <- triangle.posipoint(c(m[1], mini[2], 1 - m[1] - 
            mini[2]), mini, maxi)
        w3 <- triangle.posipoint(c(1 - m[2] - mini[3], m[2], 
            mini[3]), mini, maxi)
        w4 <- triangle.posipoint(c(mini[1], 1 - m[3] - mini[1], 
            m[3]), mini, maxi)
        points(w2[1], w2[2], pch = 20, cex = 2)
        points(w3[1], w3[2], pch = 20, cex = 2)
        points(w4[1], w4[2], pch = 20, cex = 2)
        seg(w1, w2)
        seg(w1, w3)
        seg(w1, w4)
        text(w2[1], w2[2], labels = as.character(round(m[1], 
            digits = 3)), cex = 1.5, pos = 2)
        text(w3[1], w3[2], labels = as.character(round(m[2], 
            digits = 3)), cex = 1.5, pos = 1)
        text(w4[1], w4[2], labels = as.character(round(m[3], 
            digits = 3)), cex = 1.5, pos = 4)
    }
    if (csub > 0) 
        scatterutil.sub(sub, csub, possub)
    if (box) box()
    return(invisible(xy))
} 

######################### triangle.posipoint ######################################
"triangle.posipoint" <- function (x, mini, maxi) {
    x <- (x - mini)/(maxi - mini)
    x <- x/sum(x)
    x1 <- (x[2] - x[1])/sqrt(2)
    y1 <- (2 * x[3] - x[2] - x[1])/sqrt(6)
    return(c(x1, y1))
} 

######################### add.position.triangle ######################################
"add.position.triangle" <- function (d) {
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    w <- matrix(0, 3, 3)
    w[1, 1] <- d$mini[1]
    w[1, 2] <- d$mini[2]
    w[1, 3] <- d$maxi[3]
    w[2, 1] <- d$maxi[1]
    w[2, 2] <- d$mini[2]
    w[2, 3] <- d$mini[3]
    w[3, 1] <- d$mini[1]
    w[3, 2] <- d$maxi[2]
    w[3, 3] <- d$mini[3]
    A <- triangle.posipoint(c(0, 0, 1), c(0, 0, 0), c(1, 1, 1))
    B <- triangle.posipoint(c(1, 0, 0), c(0, 0, 0), c(1, 1, 1))
    C <- triangle.posipoint(c(0, 1, 0), c(0, 0, 0), c(1, 1, 1))
    a <- triangle.posipoint(w[1, ], c(0, 0, 0), c(1, 1, 1))
    b <- triangle.posipoint(w[2, ], c(0, 0, 0), c(1, 1, 1))
    c <- triangle.posipoint(w[3, ], c(0, 0, 0), c(1, 1, 1))
    plot(0, 0, type = "n", xlim = c(-0.71, 4 - 0.71), ylim = c(-4 + 
        0.85, 0.85), xlab = "", ylab = "", xaxt = "n", yaxt = "n", 
        asp = 1, frame.plot = FALSE)
    polygon(c(A[1], B[1], C[1]), c(A[2], B[2], C[2]))
    polygon(c(a[1], b[1], c[1]), c(a[2], b[2], c[2]), col = grey(0.75))
    par(new = TRUE)

}

######################### triangle.biplot ######################################
"triangle.biplot" <- function (ta1, ta2, label = as.character(1:nrow(ta1)), draw.line = TRUE,
    show.position = TRUE, scale = TRUE) 
{
    seg <- function(a, b, col = 1) {
        segments(a[1], a[2], b[1], b[2], col = col)
    }
    nam <- names(ta1)
    ta1 <- t(apply(ta1, 1, function(x) x/sum(x)))
    ta2 <- t(apply(ta2, 1, function(x) x/sum(x)))
    d <- triangle.param(rbind(ta1, ta2), scale = scale)
    opar <- par(mar = par("mar"))
    on.exit(par(opar))
    A <- d$A
    B <- d$B
    C <- d$C
    xy <- d$xy
    mini <- d$mini
    maxi <- d$maxi
    if (show.position) 
        add.position.triangle(d)
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    plot(0, 0, type = "n", xlim = c(-0.8, 0.8), ylim = c(-0.6, 
        1), xlab = "", ylab = "", xaxt = "n", yaxt = "n", asp = 1, 
        frame.plot = FALSE)
    seg(A, B)
    seg(B, C)
    seg(C, A)
    text(C[1], C[2], labels = paste(mini[1]), pos = 2)
    text(C[1], C[2], labels = paste(maxi[3]), pos = 4)
    text((A + C)[1]/2, (A + C)[2]/2, labels = nam[1], cex = 1.5, 
        pos = 2)
    text(A[1], A[2], labels = paste(maxi[1]), pos = 2)
    text(A[1], A[2], labels = paste(mini[2]), pos = 1)
    text((A + B)[1]/2, (A + B)[2]/2, labels = nam[2], cex = 1.5, 
        pos = 1)
    text(B[1], B[2], labels = paste(maxi[2]), pos = 1)
    text(B[1], B[2], labels = paste(mini[3]), pos = 4)
    text((B + C)[1]/2, (B + C)[2]/2, labels = nam[3], cex = 1.5, 
        pos = 4)
    if (draw.line) {
        nlg <- 10 * (maxi[1] - mini[1])
        for (i in (1:(nlg - 1))) {
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
    nl <- nrow(ta1)
    for (i in (1:nl)) {
        arrows(xy[i, 1], xy[i, 2], xy[i + nl, 1], xy[i + nl, 
            2], length = 0.1, angle = 15)
    }
    points(xy[1:nrow(ta1), ])
    text(xy[1:nrow(ta1), ], label, pos = 4)
 }

######################### triangle.param ######################################
"triangle.param" <- function (ta, scale = TRUE, min3 = NULL, max3 = NULL) {
    if (ncol(ta) != 3) 
        stop("Non convenient data")
    if (min(ta) < 0) 
        stop("Non convenient data")
    if ((!is.null(min3)) & (!is.null(max3))) 
        scale <- TRUE
    cal <- matrix(0, 9, 3)
    tb <- t(apply(ta, 1, function(x) x/sum(x)))
    mini <- apply(tb, 2, min)
    maxi <- apply(tb, 2, max)
    mini <- (floor(mini/0.1))/10
    maxi <- (floor(maxi/0.1) + 1)/10
    mini[mini<0] <- 0
    maxi[maxi>1] <- 1
    if (!is.null(min3)) 
        mini <- min3
    if (!is.null(max3)) 
        maxi <- min3
    ampli <- maxi - mini
    amplim <- max(ampli)
    # correction d'un bug trouvé par J. Lobry 15/11/2004
    if (!all(ampli==amplim)) {
        for (j in 1:3) {
            k <- amplim - ampli[j]
            while (k > 0) {
                if ((k > 0) & (maxi[j] < 1)) {
                    maxi[j] <- maxi[j] + 0.1
                    k <- k - 1
                }
                if ((k > 0) & (mini[j] > 0)) {
                    mini[j] <- mini[j] - 0.1
                    k <- k - 1
                }
            }
        }
    }
    cal[1, 1] <- mini[1]
    cal[1, 2] <- mini[2]
    cal[1, 3] <- 1 - cal[1, 1] - cal[1, 2]
    cal[2, 1] <- mini[1]
    cal[2, 2] <- maxi[2]
    cal[2, 3] <- 1 - cal[2, 1] - cal[2, 2]
    cal[3, 1] <- maxi[1]
    cal[3, 2] <- mini[2]
    cal[3, 3] <- 1 - cal[3, 1] - cal[3, 2]
    cal[4, 1] <- mini[1]
    cal[4, 3] <- mini[3]
    cal[4, 2] <- 1 - cal[4, 1] - cal[4, 3]
    cal[5, 1] <- mini[1]
    cal[5, 3] <- maxi[3]
    cal[5, 2] <- 1 - cal[5, 1] - cal[5, 3]
    cal[6, 1] <- maxi[1]
    cal[6, 3] <- mini[3]
    cal[6, 2] <- 1 - cal[6, 1] - cal[6, 3]
    cal[7, 2] <- mini[2]
    cal[7, 3] <- mini[3]
    cal[7, 1] <- 1 - cal[7, 2] - cal[7, 3]
    cal[8, 2] <- mini[2]
    cal[8, 3] <- maxi[3]
    cal[8, 1] <- 1 - cal[8, 2] - cal[8, 3]
    cal[9, 2] <- maxi[2]
    cal[9, 3] <- mini[3]
    cal[9, 1] <- 1 - cal[9, 2] - cal[9, 3]
    mini <- apply(cal, 2, min)
    mini <- round(mini, digits = 4)
    maxi <- apply(cal, 2, max)
    maxi <- round(maxi, digits = 4)
    ampli <- maxi - mini
    if (!scale) {
        mini <- c(0, 0, 0)
        maxi <- c(1, 1, 1)
    }
    A <- c(-1/sqrt(2), -1/sqrt(6))
    B <- c(1/sqrt(2), -1/sqrt(6))
    C <- c(0, 2/sqrt(6))
    xy <- t(apply(tb, 1, FUN = triangle.posipoint, mini = mini, 
        maxi = maxi))
    # pour avoir en sortie une matrice des coordonnées
    dimnames(xy) <- list(row.names(ta),c("x","y"))
    return(list(A = A, B = B, C = C, xy = xy, mini = mini, maxi = maxi))
}
