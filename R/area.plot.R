########### area.plot         ################
########### area.util.contour ################
########### area.util.xy      ################
########### area2poly         ################
########### poly2area         ################
########### area2link         ################
########### area.util.class   ################

"area.plot" <- function (x, center= NULL, values = NULL, graph = NULL, lwdgraph = 2, nclasslegend = 8,
    clegend = 0.75, sub = "", csub = 1, possub = "topleft", cpoint = 0, 
    label = NULL, clabel = 0, ...) 
{
    # modif vendredi, mars 28, 2003 at 07:35 ajout de l'argument center
    # doit contenir les centres des polygones (autant de coordonnées que de classes dans area[,1])
    # si il est nul et utilisé il est calculé comme centre de gravité des sommets du polygones
    # avec area.util.xy(x)
    # si il est non nul, doit être de dimensions (nombre de niveaux de x[,1] , 2) et
    # contenir les coordonnées dans l'ordre de unique(x[,1])
    x.area <- x
    if(dev.cur() == 1) plot.new()
    opar <- par(mar = par("mar")) #, new = par("new")
    on.exit(par(opar))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    if (!is.factor(x.area[, 1])) 
        stop("Factor expected in x.area[1,]")
    fac <- x.area[, 1]
    lev.poly <- unique(fac)
    nlev <- nlevels(lev.poly)
    x1 <- x.area[, 2]
    x2 <- x.area[, 3]
    r1 <- range(x1)
    r2 <- range(x2)
    plot(r1, r2, type = "n", asp = 1, xlab = "", ylab = "", xaxt = "n", 
        yaxt = "n", frame.plot = FALSE)
    if (!is.null(values)) {
        if (!is.vector(values)) 
            values <- as.vector(values)
        if (length(values) != nlev) 
            values <- rep(values, le = nlev)
        br0 <- pretty(values, nclasslegend - 1)
        nborn <- length(br0)
        h <- diff(range(x1))/20
        numclass <- cut.default(values, br0, include.lowest = TRUE, 
            labels = FALSE, right = TRUE)
        valgris <- seq(1, 0, le = (nborn - 1))
    }
    if (!is.null(graph)) {
        if (class(graph) != "neig") 
            stop("graph need an object of class 'ng'")
    }
    if (cpoint != 0) 
        points(x1, x2, pch = 20, cex = par("cex") * cpoint)
    for (i in 1:nlev) {
        a1 <- x1[fac == lev.poly[i]]
        a2 <- x2[fac == lev.poly[i]]
        if (!is.null(values)) 
            polygon(a1, a2, col = grey(valgris[numclass[i]]))
        else polygon(a1, a2)
    }
    if (!is.null(graph) | (clabel > 0)) {
        if (!is.null(center)) {
            center = as.matrix(center)
            if (ncol(center)!=2) center <- NULL
            if (nrow(center)!=length(lev.poly)) center <-NULL
        }
        if (!is.null(center)) w=list(x=center[,1],y=center[,2]) else
        w <- area.util.xy(x.area)
     }
    if (!is.null(graph)) {
        for (i in 1:nrow(graph)) {
            segments(w$x[graph[i, 1]], w$y[graph[i, 1]], w$x[graph[i, 
                2]], w$y[graph[i, 2]], lwd = lwdgraph)
        }
    }
    if (clabel > 0) {
        if (is.null(label)) 
            label <- as.character(unique(x.area[,1]))
        scatterutil.eti(w$x, w$y, label, clabel = clabel)
    }
    scatterutil.sub(sub, csub, possub)
    if (!is.null(values)) 
        scatterutil.legend.square.grey(br0, valgris, h, clegend)
}

"area.util.contour" <- function (area) {
    poly <- area[, 1]
    x <- area[, 2]
    y <- area[, 3]
    res <- NULL
    f1 <- function(x) {
        if (x[1] > x[3]) {
            s <- x[1]
            x[1] <- x[3]
            x[3] <- s
            s <- x[2]
            x[2] <- x[4]
            x[4] <- s
        }
        if (x[1] == x[3]) {
            if (x[2] > x[4]) {
                s <- x[2]
                x[2] <- x[4]
                x[4] <- s
            }
        }
        return(paste(x[1], x[2], x[3], x[4], sep = "A"))
    }
    for (i in 1:(nlevels(poly))) {
        xx <- x[poly == levels(poly)[i]]
        yy <- y[poly == levels(poly)[i]]
        n0 <- length(xx)
        xx <- c(xx, xx[1])
        yy <- c(yy, yy[1])
        z <- cbind(xx[1:n0], yy[1:n0], xx[2:(n0 + 1)], yy[2:(n0 + 
            1)])
        z <- apply(z, 1, f1)
        res <- c(res, z)
    }
    res <- res[table(res)[res] < 2]
    res <- unlist(lapply(res, function(x) as.numeric(unlist(strsplit(x, 
        "A")))))
    res <- matrix(res, ncol = 4, byrow = TRUE)
    res <- data.frame(res)
    names(res) <- c("x1", "y1", "x2", "y2")
    return(res)
}

"area.util.xy" <- function (area) {
    fac <- area[, 1]
    lev.poly <- unique(fac)
    npoly <- length(lev.poly)
    x <- rep(0, npoly)
    y <- rep(0, npoly)
    for (i in 1:npoly) {
        lev <- lev.poly[i]
        a1 <- area[fac == lev, 2]
        a2 <- area[fac == lev, 3]
        x[i] <- mean(a1)
        y[i] <- mean(a2)
    }
    cbind.data.frame(x = x, y = y, row.names = as.character(lev.poly))
}

"area2poly" <- function (area) {
    if (!is.factor(area[, 1])) 
        stop("Factor expected in area[,1]")
    fac <- area[, 1]
    lev.poly <- unique(fac)
    nlev <- nlevels(lev.poly)
    label.poly <- as.character(lev.poly)
    x1 <- area[, 2]
    x2 <- area[, 3]
    res <- list()
    for (i in 1:nlev) {
        a1 <- x1[fac == lev.poly[i]]
        a2 <- x2[fac == lev.poly[i]]
        res <- c(res, list(as.matrix(cbind(a1, a2))))
        attr(res[[i]],"bbox") <- c(min(res[[i]][,1]),min(res[[i]][,2]),max(res[[i]][,1]),max(res[[i]][,2]))
    }
    r0 <- matrix(0, nlev, 4)
    r0[, 1] <- tapply(x1, fac, min)
    r0[, 2] <- tapply(x2, fac, min)
    r0[, 3] <- tapply(x1, fac, max)
    r0[, 4] <- tapply(x2, fac, max)
    class(res) <- "polylist"
    attr(res, "region.id") <- label.poly
    attr(res, "region.rect") <- r0
    # message de Stéphane Dray du 06/02/2004
    attr(res,"maplim") <- list(x=range(x1),y=range(x2))
    return(res)
} 

"poly2area" <- function (polys) {
    if (!inherits(polys, "polylist")) 
        stop("Non convenient data")
    if (!is.null(attr(polys, "region.id"))) 
        reg.names <- attr(polys, "region.id")
    else reg.names <- paste("R", 1:length(polys), sep = "")
    area <- data.frame(polys[[1]])
    area <- cbind(rep(reg.names[1], nrow(area)), area)
    names(area) <- c("reg", "x", "y")
    for (i in 2:length(polys)) {
        provi <- data.frame(polys[[i]])
        provi <- cbind(rep(reg.names[i], nrow(provi)), provi)
        names(provi) <- c("reg", "x", "y")
        area <- rbind.data.frame(area, provi)
    }
    area$reg <- factor(area$reg)
    return(area)
}

"area2link" <- function(area) {
    # création vendredi, mars 28, 2003 at 14:49
    if (!is.factor(area[, 1])) 
        stop("Factor expected in area[,1]")
    fac <- area[, 1]
    levpoly <- unique(fac)
    npoly <- length(levpoly)
    res <- matrix(0,npoly,npoly)
    dimnames(res) <- list(as.character(levpoly),as.character(levpoly))
    fun1 <- function(niv) {
        # X est un n-2 système de coordonnées xy
        # On vérifie que c'est une boucle (sommaire)
        X <- area[fac == niv, 2:3]
        n <- nrow(X)
        if (any(X[1,]!=X[n,])) X <- rbind(X,X[1,])
        n <- nrow(X)
        w <- paste(X[1:(n-1),1],X[1:(n-1),2],X[2:(n),1],X[2:(n),2],sep="/")
        w <- c(w,paste(X[2:(n),1],X[2:(n),2],X[1:(n-1),1],X[1:(n-1),2],sep="/"))
    }
    w <- lapply(levpoly,fun1)
    # w est une liste de vecteurs qui donnent les arêtes des polygones en charactères
    # du type x1/y1/x2/y2
    fun2 <- function (cha) {
        w <- as.numeric(strsplit(cha,"/")[[1]])
        res <- sqrt((w[1]-w[3])^2+(w[2]-w[4])^2)
        res
    }
    res <- matrix(0,npoly,npoly)
    x1 <- col(res)[col(res) < row(res)]
    x2 <- row(res)[col(res) < row(res)]
    lw <- cbind(x1,x2)
    fun3 <- function (x) {
        a <- w[[x[1]]]
        b <- w[[x[2]]]
        wd <- 0
        wab <- unlist(lapply(a, function(x) x%in%b))
        if (sum(wab)>0)  wd <- sum(unlist(lapply(a[wab], fun2)))
        wd/2
    }
    w <- apply(lw,1,fun3)
    res[col(res) < row(res) ] <- w
    res <- res+t(res)
    dimnames(res) <- list(as.character(levpoly),as.character(levpoly))
    return(res)
}

"area.util.class" <- function (area,fac) {
    if (nlevels(area[,1]!= length(fac))) stop ("non convenient matching")
    lreg <- split (as.character(unique(area[,1])),fac)
    "contour2poly" <- function(x) {
        a <- paste(x[,1],x[,2],sep="_")
        b <- paste(x[,3],x[,4],sep="_")
        a <- cbind(a,b)
        points <- a[1,1]
        rowcur <- 1
        colcur <- 1
        npts <- nrow(x)
        for (k in (1:(npts-2))) {
            colnew <- 3-colcur
            curnew <- a[rowcur,colnew]
            points <- c(points,curnew)
            a <- a[-rowcur,]
            coo <- which(a==curnew, arr.ind=TRUE)
            rowcur <- coo[1,1]
            colcur <- coo[1,2]
          }
        colnew <- 3-colcur
        curnew <- a[rowcur,colnew]
        points <- c(points,curnew)
        return(matrix(as.numeric(unlist(strsplit(points,"_"))), ncol=2, byrow=TRUE))
    }
    "souscontour" <- function(k) {
        sel <- unlist(lapply(lreg[[k]],function(x) which(area[,1]==x)))
        area.sel <- area[sel,]
        area.sel[,1] <- as.factor(as.character(area.sel[,1]))
        w <- area.util.contour(area.sel)
        w <- contour2poly(w)
        w <- cbind(rep(k,nrow(w)),w)
        return(w)
    }
    lcontour <- lapply(1:nlevels(fac),souscontour)
    w <- lcontour[[1]]
    for (k in 2:length(lcontour)) w <- rbind.data.frame(w,lcontour[[k]])
    w[,1] <- as.factor(levels(fac)[w[,1]])
    return(w)
}
