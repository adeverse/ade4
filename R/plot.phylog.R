"plot.phylog" <- function (x, y = NULL,
    f.phylog = 0.5, cleaves = 1, cnodes = 0,
    labels.leaves = names(x$leaves), clabel.leaves = 1,
    labels.nodes = names(x$nodes), clabel.nodes = 0,
    sub = "", csub = 1.25, possub = "bottomleft", draw.box = FALSE, ...)
 {
    if (!inherits(x, "phylog")) 
        stop("Non convenient data")
    leaves.number <- length(x$leaves)
    leaves.names <- names(x$leaves)
    nodes.number <- length(x$nodes)
    nodes.names <- names(x$nodes)
    if (length(labels.leaves) != leaves.number) labels.leaves <- names(x$leaves)
    if (length(labels.nodes) != nodes.number) labels.nodes <- names(x$nodes)
    leaves.car <- gsub("[_]"," ",labels.leaves)
    nodes.car <- gsub("[_]"," ",labels.nodes)
    mar.old <- par("mar")
    on.exit(par(mar=mar.old))

    par(mar = c(0.1, 0.1, 0.1, 0.1))

    if (f.phylog < 0.05) f.phylog <- 0.05 
    if (f.phylog > 0.95) f.phylog <- 0.95 

    maxx <- max(x$droot)
    plot.default(0, 0, type = "n", xlab = "", ylab = "", xaxt = "n", 
        yaxt = "n", xlim = c(-maxx*0.15, maxx/f.phylog), ylim = c(-0.05, 1), xaxs = "i", 
        yaxs = "i", frame.plot = FALSE)

    x.leaves <- x$droot[leaves.names]
    x.nodes <- x$droot[nodes.names]
    if (is.null(y)) y <- (leaves.number:1)/(leaves.number + 1)
    else y <- (leaves.number+1-y)/(leaves.number+1)
    names(y) <- leaves.names
    xcar <- maxx*1.05
    xx <- c(x.leaves, x.nodes)
     
    if (clabel.leaves > 0) {
        for (i in 1:leaves.number) {
            text(xcar, y[i], leaves.car[i], adj = 0, cex = par("cex") * 
                clabel.leaves)
            segments(xcar, y[i], xx[i], y[i], col = grey(0.7))
        }
    }
    yleaves <- y[1:leaves.number]
    xleaves <- xx[1:leaves.number]
    if (cleaves > 0) {
        for (i in 1:leaves.number) {
            points(xx[i], y[i], pch = 21, bg=1, cex = par("cex") * cleaves)
        }
    }
    yn <- rep(0, nodes.number)
    names(yn) <- nodes.names
    y <- c(y, yn)
    for (i in 1:length(x$parts)) {
        w <- x$parts[[i]]
        but <- names(x$parts)[i]
        y[but] <- mean(y[w])
        b <- range(y[w])
        segments(xx[but], b[1], xx[but], b[2])
        x1 <- xx[w]
        y1 <- y[w]
        x2 <- rep(xx[but], length(w))
        segments(x1, y1, x2, y1)
    }
    if (cnodes > 0) {
        for (i in nodes.names) {
            points(xx[i], y[i], pch = 21, bg="white", cex = cnodes)
        }
    }
    if (clabel.nodes > 0) {
        scatterutil.eti(xx[names(x.nodes)], y[names(x.nodes)], nodes.car, 
            clabel.nodes)
    }
    x <- (x.leaves - par("usr")[1])/(par("usr")[2]-par("usr")[1])
    y <- y[leaves.names]
    xbase <- (xcar - par("usr")[1])/(par("usr")[2]-par("usr")[1])
    if (csub>0) scatterutil.sub(sub, csub=csub, possub=possub)
    if (draw.box) box()
    if (cleaves > 0) points(xleaves, yleaves, pch = 21, bg=1, cex = par("cex") * cleaves)
    
    return(invisible(list(xy=data.frame(x=x, y=y), xbase= xbase, cleaves=cleaves)))
}



"radial.phylog" <- function (phylog, circle = 1,
    cleaves = 1, cnodes = 0,
    labels.leaves = names(phylog$leaves), clabel.leaves = 1,
    labels.nodes = names(phylog$nodes), clabel.nodes = 0,
    draw.box = FALSE) 
{
    if (!inherits(phylog, "phylog")) 
        stop("Non convenient data")
    leaves.number <- length(phylog$leaves)
    leaves.names <- names(phylog$leaves)
    nodes.number <- length(phylog$nodes)
    nodes.names <- names(phylog$nodes)
    if (length(labels.leaves) != leaves.number) labels.leaves <- names(phylog$leaves)
    if (length(labels.nodes) != nodes.number) labels.nodes <- names(phylog$nodes)
    if (circle<0) stop("'circle': non convenient value")
    leaves.car <- gsub("[_]"," ",labels.leaves)
    nodes.car <- gsub("[_]"," ",labels.nodes)
    
    opar <- par(mar = par("mar"), srt = par("srt"))
    on.exit(par(opar))
    par(mar = c(0.1, 0.1, 0.1, 0.1))

    dis <- phylog$droot
    dis <- dis/max(dis)
    rayon <- circle
    dis <- dis * rayon
    dist.leaves <- dis[leaves.names]
    dist.nodes <- dis[nodes.names]
    plot.default(0, 0, type = "n", asp = 1, xlab = "", ylab = "", 
        xaxt = "n", yaxt = "n", xlim = c(-2, 2), ylim = c(-2, 
            2), xaxs = "i", yaxs = "i", frame.plot = FALSE)
    d.rayon <- rayon/(nodes.number - 1)
    alpha <- 2 * pi * (1:leaves.number)/leaves.number
    names(alpha) <- leaves.names
    x <- dist.leaves * cos(alpha)
    y <- dist.leaves * sin(alpha)
    xcar <- (rayon + d.rayon) * cos(alpha)
    ycar <- (rayon + d.rayon) * sin(alpha)
    if (clabel.leaves>0) {
        for (i in 1:leaves.number) {
            segments(xcar[i], ycar[i], x[i], y[i], col = grey(0.7))
        }
        for (i in 1:leaves.number) {
            par(srt = alpha[i] * 360/2/pi)
            text(xcar[i], ycar[i], leaves.car[i], adj = 0, cex = par("cex") * 
                clabel.leaves)
            segments(xcar[i], ycar[i], x[i], y[i], col = grey(0.7))
        }
    }
    if (cleaves > 0) {
        for (i in 1:leaves.number) points(x[i], y[i], pch = 21, bg="black", cex = par("cex") * 
            cleaves)
    }
    ang <- rep(0, length(dist.nodes))
    names(ang) <- names(dist.nodes)
    ang <- c(alpha, ang)
    for (i in 1:length(phylog$parts)) {
        w <- phylog$parts[[i]]
        but <- names(phylog$parts)[i]
        ang[but] <- mean(ang[w])
        b <- range(ang[w])
        a.seq <- c(seq(b[1], b[2], by = pi/180), b[2])
        lines(dis[but] * cos(a.seq), dis[but] * sin(a.seq))
        x1 <- dis[w] * cos(ang[w])
        y1 <- dis[w] * sin(ang[w])
        x2 <- dis[but] * cos(ang[w])
        y2 <- dis[but] * sin(ang[w])
        segments(x1, y1, x2, y2)
    }
    if (cnodes > 0) {
        for (i in 1:length(phylog$parts)) {
            w <- phylog$parts[[i]]
            but <- names(phylog$parts)[i]
            ang[but] <- mean(ang[w])
             points(dis[but] * cos(ang[but]), dis[but] * sin(ang[but]), 
                pch = 21, bg="white", cex = par("cex") * cnodes)
        }
    }
    points(0, 0, pch = 21, cex = par("cex") * 2, bg = "red")
    if (clabel.nodes > 0) {
        delta <- strwidth(as.character(length(dist.nodes)), cex = par("cex") * 
            clabel.nodes)
        for (j in 1:length(dist.nodes)) {
            i <- names(dist.nodes)[j]
            par(srt = (ang[i] * 360/2/pi + 90))
            x1 <- dis[i] * cos(ang[i])
            y1 <- dis[i] * sin(ang[i])
            symbols(x1, y1, delta, bg = "white", add = TRUE, inches = FALSE)
            text(x1, y1, nodes.car[j], adj = 0.5, cex = par("cex") * 
                clabel.nodes)
        }
    }
    if (draw.box) box()
    return(invisible())
}

#######################################################################################
enum.phylog<-function (phylog, no.over=1000) {

    # Pour chaque phylogénie phylog, il existe un grand nombre de représentations
    # toutes équivalentes ssociées à la même topologie
    # Il y en a exactement 2^k pour une phylogénie résolue 
    # (que des dichotomies), ou k représente le nombre de noeuds
    # Cette fonction énumère tous les possibles
    if (!inherits(phylog, "phylog")) stop("Object 'phylog' expected")
    leaves.number<- length(phylog$leaves)
    leaves.names<- names(phylog$leaves)
    # les descendants sont pris par la racine
    parts <- rev(phylog$parts)
    nodes.number<- length(parts)
    nodes.names<- (names(parts))
    nodes.dim <- unlist(lapply(parts,length))
    perms.number <- prod(gamma(nodes.dim+1))
    if (perms.number>no.over) {
        cat("Permutation number =",perms.number,"( no.over =", no.over,")\n")
        return(invisible())
    }
    
    "perm" <- function(cha=as.character(1:n),a=matrix(1,1,1)) {
        n0 <- ncol(a)
        n <- length(cha)
        if (n0 == n) {
            a <- apply(a,c(1,2),function(x) cha[x])
            return(a)
        }
        fun1 <- function(x) {
                xplus <- length(x)+1
                fun2 <- function (j) {
                        if (j==1) w <- c(xplus,x)
                        else if (j==xplus) w <- c(x,xplus)
                        else w <- c(x[1:j-1],xplus,x[j:length(x)])
                        return(w)
                }
                return(sapply(1:(length(x)+1) , fun2))
        }
        a <- matrix(unlist(apply(a,1,fun1)),ncol=n0+1,byrow=TRUE)
        Recall(cha,a)
    }
    
    res <- matrix (1,1,1)
    
    lw <- lapply(parts,perm)
    names(lw) <- nodes.names
    res <- lw[[1]]

    lw[[1]]<- NULL
    
    "permtot" <- function (matcar) {
        n1 <- nrow(res) ; n2 <- nrow(matcar)
        p1 <- ncol(res) ; p2 <- ncol(matcar)
        f1 <- function(x) unlist(apply(res,1,function(y) c(y,x)))
        res <<- matrix(unlist(apply(matcar,1,f1)),n1*n2, p1+p2,byrow=TRUE)
    }
    
    lapply(lw, permtot)
    
    ##############################################
    fac <- factor(rep(1:nodes.number,nodes.dim))
    renum <- function (cha) {
        cha <- split(cha, fac)
        names(cha) <- nodes.names
        w <- cha[[1]]
        for (j in nodes.names[-1]) {
              k <- which(w==j)
              wcha <- cha[[j]]
              if (k==1) w <- c(wcha,w[-k])
              else if (k == length(w)) w <- c(w[-k],wcha)
              else w <- c(w[1:(k-1)],wcha,w[(k+1):length(w)])
        }
        res <- 1:leaves.number
        names(res) <- w
        return(res[leaves.names])
    }
    return(t(apply(res,1,renum)))  
    
    
}
