 "s.multinom" <- function (dfxy, dfrowprof, translate = FALSE,
    xax=1, yax=2,
    labelcat = row.names(dfxy), clabelcat = 1,
    cpointcat = if (clabelcat == 0) 2 else 0, 
    labelrowprof = row.names(dfrowprof),  clabelrowprof = 0.75,  
    cpointrowprof = if (clabelrowprof == 0) 2 else 0,
    pchrowprof = 20, coulrowprof = grey(0.8),
    proba = 0.95, n.sample = apply(dfrowprof,1,sum), 
    axesell = TRUE,
    ...
    ) {
        
    if (proba<0.5) proba <- 0.5
    if (proba>0.999) proba <- 0.999
    coeff <- sqrt(-2*log(1-proba))

    # les scores forment un data.frame comme dans toute fonction s
    dfxy <- data.frame(dfxy)
    dfrowprof <- data.frame(dfrowprof)
    if (!(inherits(dfxy,"data.frame"))) stop ("data.frame expected for dfxy")
    if (!(inherits(dfrowprof,"data.frame"))) stop ("data.frame expected for dfrowprof")
    # les noms des lignes de dfxy sont les noms des colonnes de dfrowprof
    nrowprof <- nrow(dfrowprof)
    ncat <- ncol(dfrowprof)
    if (nrow(dfxy)!= ncat) stop ("non convenient matching : nrow(dfxy)!= ncat")
    if (all(row.names(dfxy)!= names(dfrowprof))) stop ("non convenient matching : row.names(dfxy)!= names(dfrowprof)")
 
    n.sample <- rep(n.sample, len = nrowprof)
    wt <- rep(1, nrowprof)/nrowprof
    if (sum(n.sample)>0) wt <- n.sample/sum(n.sample)

    coulrowprof <- rep(coulrowprof, len = nrowprof)
    x <- dfxy[,xax]
    y <- dfxy[,yax]

      util.ellipse <- function(param, coeftai) {       
        vx <- param[3] ; cxy <- param[4]; vy <- param[5]
        lig <- 100
        if (vx < 0) vx <- 0 ; if (vy < 0) vy <- 0
        if (vx == 0 && vy == 0) return(NULL)
        covmat <- matrix(c(vx,cxy,cxy,vy),2,2)
        cov.eig <- eigen(covmat, symmetric =TRUE)
        l1 = sqrt(max(0,cov.eig$values[1]))
        l2 = sqrt(max(0,cov.eig$values[2]))
        c11 <- coeftai * cov.eig$vectors[1,1] * l1
        c12 <- (-coeftai) * cov.eig$vectors[2,1] * l2
        c21 <- coeftai * cov.eig$vectors[2,1] * l1
        c22 <- coeftai * cov.eig$vectors[1,1] * l2
        angle <- 2 * pi * (1:lig)/lig
        x <- param[1] + c11 * cos(angle) + c12 * sin(angle) 
        y <- param[2] + c21 * cos(angle) + c22 * sin(angle)        
        res <- list(x = x, y = y, seg1 = c(param[1] + c11, param[2] + c21, 
            param[1] - c11, param[2] - c21), seg2 = c(param[1] + c12, param[2] + c22, 
            param[1] - c12, param[2] - c22))
        return (res)
    }

    calcul.rowprof<- function(k) {
        w1 <- dfrowprof[k,]
        if (sum(w1)<1e-07) stop (paste("number",k,"profile without data"))
        w1 <- w1/sum(w1)
        mx <- sum(w1*x)
        my <- sum(w1*y)
        x0 <- x-mx
        y0 <- y-my
        vx <- sum(w1*x0*x0)
        vy <- sum(w1*y0*y0)
        cxy <- sum(w1*x0*y0)
        return(c(mx,my,vx,cxy,vy))
     }
     
    draw.rowprof<- function(k) {
        w <- as.numeric(unlist(res[k,]))
        if (n.sample[k] >0) cell <- coeff/sqrt(n.sample[k]) else cell <- 0
        ell <- util.ellipse(w, cell)
        if (!is.null(ell)) {
            polygon(ell$x, ell$y,border=coulrowprof[k],col=coulrowprof[k], lwd=2)
            if (axesell) {
                segments(ell$seg1[1], ell$seg1[2], ell$seg1[3], ell$seg1[4]) #, lty = 2
                segments(ell$seg2[1], ell$seg2[2], ell$seg2[3], ell$seg2[4]) #, lty = 2
            }
        }
    }
    opar <- par(mar = par("mar"))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    on.exit(par(opar))
    
    # calcul des paramètres de position et dispersion
    res <- t( matrix(unlist(lapply(1:nrowprof,calcul.rowprof)),nrow=5))
    res <- as.data.frame(res)
    names(res) <- c("mx","my","vx","cxy","vy")
    if (translate) {
        mgene <- c(sum(wt*res$mx),sum(wt*res$my))
        res[,1:2] <- sweep(res[,1:2],2,mgene,"-")
        dfxy <- sweep(dfxy[,c(xax,yax)],2,mgene,"-")
    } else mgene <- c(0,0)
    row.names(res) <- labelrowprof

    row.names(res) <- labelrowprof
    s.label(dfxy, 1, 2, clabel = 0, cpoint = cpointcat, ...)
    s.arrow(dfxy, add.plot = TRUE,origin = -mgene,clabel = clabelcat, label = labelcat)
    s.chull(dfxy, add.plot = TRUE, fac = factor(rep(1,ncat)), optchull = 1, clabel = 0)
    for (k in 1:nrowprof) draw.rowprof(k)           
    if (clabelrowprof > 0) 
        scatterutil.eti(as.numeric(res$mx), as.numeric(res$my),labelrowprof, clabelrowprof, coul = coulrowprof)
    if (clabelrowprof == 0) 
        points(as.numeric(res$mx), as.numeric(res$my), pch=pchrowprof, cex=par("cex")*cpointrowprof)
    box()
    res[,1:2] <- sweep(res[,1:2],2,mgene,"+")
    return(invisible(list(ell=res,tra=mgene,call=match.call())))
    
}
