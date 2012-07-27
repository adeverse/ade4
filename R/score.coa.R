"score.coa" <- function (x, xax = 1, dotchart = FALSE, clab.r = 1, clab.c = 1,
    csub = 1, cpoi = 1.5, cet = 1.5, ...) 
{
    if (!inherits(x, "coa")) 
        stop("Object of class 'coa' expected")
    if (x$nf == 1) 
        xax <- 1
    if ((xax < 1) || (xax > x$nf)) 
        stop("non convenient axe number")
    "dudi.coa.dotchart" <- function(dudi, numfac, clab) {
        if (!inherits(dudi, "coa")) 
            stop("Object of class 'coa' expected")
        sli <- dudi$li[, numfac]
        sco <- dudi$co[, numfac]
        oli <- order(sli)
        oco <- order(sco)
        a <- c(sli[oli], sco[oco])
        gr <- as.factor(rep(c("Rows", "Columns"), c(length(sli), 
            length(sco))))
        lab <- c(row.names(dudi$li)[oli], row.names(dudi$co)[oco])
        if (clab > 0) 
            labels <- lab
        else labels <- NULL
        dotchart(a, labels = labels, groups = gr, pch = 20)
    }
    if (dotchart) {
        clab <- clab.r * clab.c
        dudi.coa.dotchart(x, xax, clab)
        return(invisible())
    }
    def.par <- par(mar = par("mar"))
    on.exit(par(def.par))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    sco.distri.class.2g <- function(score, fac1, fac2, weight, 
        labels1 = as.character(levels(fac1)), labels2 = as.character(levels(fac2)), 
        clab1, clab2, cpoi, cet) {
        nvar1 <- nlevels(fac1)
        nvar2 <- nlevels(fac2)
        ymin <- scoreutil.base(y = score, xlim = NULL, grid = TRUE, 
            cgrid = 0.75, include.origin = TRUE, origin = 0, 
            sub = NULL, csub = 0)
        ymax <- par("usr")[4]
        ylabel <- strheight("A", cex = par("cex") * max(1, clab1, 
            clab2)) * 1.4
        xmin <- par("usr")[1]
        xmax <- par("usr")[2]
        xaxp <- par("xaxp")
        nline <- xaxp[3] + 1
        v0 <- seq(xaxp[1], xaxp[2], le = nline)
        segments(v0, rep(ymin, nline), v0, rep(ymax, nline), 
            col = gray(0.5), lty = 1)
        rect(xmin, ymin, xmax, ymax)
        sum.col1 <- unlist(tapply(weight, fac1, sum))
        sum.col2 <- unlist(tapply(weight, fac2, sum))
        sum.col1[sum.col1 == 0] <- 1
        sum.col2[sum.col2 == 0] <- 1
        weight1 <- weight/sum.col1[fac1]
        weight2 <- weight/sum.col2[fac2]
        y.distri1 <- tapply(score * weight1, fac1, sum)
        y.distri1 <- rank(y.distri1)
        y.distri2 <- tapply(score * weight2, fac2, sum)
        y.distri2 <- rank(y.distri2) + nvar1 + 2
        y.distri <- c(y.distri1, y.distri2)
        ylabel <- strheight("A", cex = par("cex") * max(1, clab1, 
            clab2)) * 1.4
        y.distri1 <- (y.distri1 - min(y.distri))/(max(y.distri) - 
            min(y.distri))
        y.distri1 <- ymin + ylabel + (ymax - ymin - 2 * ylabel) * 
            y.distri1
        y.distri2 <- (y.distri2 - min(y.distri))/(max(y.distri) - 
            min(y.distri))
        y.distri2 <- ymin + ylabel + (ymax - ymin - 2 * ylabel) * 
            y.distri2
        for (i in 1:nvar1) {
            w <- weight1[fac1 == levels(fac1)[i]]
            y0 <- y.distri1[i]
            score0 <- score[fac1 == levels(fac1)[i]]
            x.moy <- sum(w * score0)
            x.et <- sqrt(sum(w * (score0 - x.moy)^2))
            x1 <- x.moy - cet * x.et
            x2 <- x.moy + cet * x.et
            etiagauche <- TRUE
            if ((x1 - xmin) < (xmax - x2)) 
                etiagauche <- FALSE
            segments(x1, y0, x2, y0)
            if (clab1 > 0) {
                cha <- labels1[i]
                cex0 <- par("cex") * clab1
                xh <- strwidth(cha, cex = cex0)
                xh <- xh + strwidth("x", cex = cex0)
                yh <- strheight(cha, cex = cex0) * 5/6
                if (etiagauche) 
                  x0 <- x1 - xh/2
                else x0 <- x2 + xh/2
                rect(x0 - xh/2, y0 - yh, x0 + xh/2, y0 + yh, 
                  col = "white", border = 1)
                text(x0, y0, cha, cex = cex0)
            }
            points(x.moy, y0, pch = 20, cex = par("cex") * cpoi)
        }
        for (i in 1:nvar2) {
            w <- weight2[fac2 == levels(fac2)[i]]
            y0 <- y.distri2[i]
            score0 <- score[fac2 == levels(fac2)[i]]
            x.moy <- sum(w * score0)
            x.et <- sqrt(sum(w * (score0 - x.moy)^2))
            x1 <- x.moy - cet * x.et
            x2 <- x.moy + cet * x.et
            etiagauche <- TRUE
            if ((x1 - xmin) < (xmax - x2)) 
                etiagauche <- FALSE
            segments(x1, y0, x2, y0)
            if (clab2 > 0) {
                cha <- labels2[i]
                cex0 <- par("cex") * clab2
                xh <- strwidth(cha, cex = cex0)
                xh <- xh + strwidth("x", cex = cex0)
                yh <- strheight(cha, cex = cex0) * 5/6
                if (etiagauche) 
                  x0 <- x1 - xh/2
                else x0 <- x2 + xh/2
                rect(x0 - xh/2, y0 - yh, x0 + xh/2, y0 + yh, 
                  col = "white", border = 1)
                text(x0, y0, cha, cex = cex0)
            }
            points(x.moy, y0, pch = 20, cex = par("cex") * cpoi)
        }
    }
    if (inherits(x, "witwit")) {
        y <- eval.parent(as.list(x$call)[[2]])
        oritab <- eval.parent(as.list(y$call)[[2]])
    }
    else oritab <- eval.parent(as.list(x$call)[[2]])
    l.names <- row.names(oritab)
    c.names <- names(oritab)
    oritab <- as.matrix(oritab)
    a <- x$co[col(oritab), xax]
    a <- a + x$li[row(oritab), xax]
    a <- a/sqrt(2 * x$eig[xax] * (1 + sqrt(x$eig[xax])))
    a <- a[oritab > 0]
    aco <- col(oritab)[oritab > 0]
    aco <- factor(aco)
    levels(aco) <- c.names
    ali <- row(oritab)[oritab > 0]
    ali <- factor(ali)
    levels(ali) <- l.names
    aw <- oritab[oritab > 0]/sum(oritab)
    sco.distri.class.2g(a, aco, ali, aw, clab1 = clab.c, clab2 = clab.r, 
        cpoi = cpoi, cet = cet)
    scatterutil.sub("Rows", csub = csub, possub = "topleft")
    scatterutil.sub("Columns", csub = csub, possub = "bottomright")
}



"reciprocal.coa" <- function (x) {
    if (!inherits(x, "coa")) 
        stop("Object of class 'coa' expected")
    if (inherits(x, "witwit")) {
        y <- eval.parent(as.list(x$call)[[2]])
        oritab <- eval.parent(as.list(y$call)[[2]])
    }
    else oritab <- eval.parent(as.list(x$call)[[2]])
    l.names <- row.names(oritab)
    c.names <- names(oritab)
    oritab <- as.matrix(oritab)
    f1 <- function(x,oritab,xax){
      a <- x$co[col(oritab), xax]
      a <- a + x$li[row(oritab), xax]
      a <- a/sqrt(2 * x$eig[xax] * (1 + sqrt(x$eig[xax])))
      a <- a[oritab > 0]
    }
    res <- sapply(1:x$nf,f1,x=x,oritab=oritab)
    aco <- col(oritab)[oritab > 0]
    aco <- factor(aco)
    levels(aco) <- c.names
    ali <- row(oritab)[oritab > 0]
    ali <- factor(ali)
    levels(ali) <- l.names
    aw <- oritab[oritab > 0]/sum(oritab)
    res <- cbind.data.frame(res,Row=ali,Col=aco,Weight=aw)
    names(res)[1:x$nf] <- paste("Scor",1:x$nf,sep="")
    rownames(res) <- paste(ali,aco,sep="")
    return(res)
}
