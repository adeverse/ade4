"kplot.sepan" <- function (object, xax = 1, yax = 2, which.tab = 1:length(object$blo),
    mfrow = NULL, permute.row.col = FALSE, clab.row = 1, clab.col = 1.25, 
    traject.row = FALSE, csub = 2, possub = "bottomright", show.eigen.value = TRUE, ...) 
{
    if (!inherits(object, "sepan")) 
        stop("Object of type 'sepan' expected")
    opar <- par(ask = par("ask"), mfrow = par("mfrow"), mar = par("mar"))
    on.exit(par(opar))
    nbloc <- length(object$blo)
    if (is.null(mfrow)) 
        mfrow <- n2mfrow(length(which.tab))
    par(mfrow = mfrow)
    if (length(which.tab) > prod(mfrow)) 
        par(ask = TRUE)
    rank.fac <- factor(rep(1:nbloc, object$rank))
    nf <- ncol(object$Li)
    neig <- max(object$rank)
    appel <- as.list(object$call)
    X <- eval(appel$X, sys.frame(0))
    names.li <- row.names(X[[1]])
    for (ianal in which.tab) {
        coolig <- object$Li[object$TL[, 1] == ianal, c(xax, yax)]
        row.names(coolig) <- names.li
        coocol <- object$Co[object$TC[, 1] == ianal, c(xax, yax)]
        row.names(coocol) <- names(X[[ianal]])
        if (permute.row.col) {
            auxi <- coolig
            coolig <- coocol
            coocol <- auxi
        }
        if (clab.row > 0) 
            cpoi <- 0
        else cpoi <- 2
        if (!traject.row) 
            s.label(coolig, clab = clab.row, cpoi = cpoi)
        else s.traject(coolig, clab = 0, cpoi = 2)
        born <- par("usr")
        k1 <- min(coocol[, 1])/born[1]
        k2 <- max(coocol[, 1])/born[2]
        k3 <- min(coocol[, 2])/born[3]
        k4 <- max(coocol[, 2])/born[4]
        k <- c(k1, k2, k3, k4)
        coocol <- 0.7 * coocol/max(k)
        s.arrow(coocol, clab = clab.col, add.p = TRUE, sub = object$tab.names[ianal], 
            csub = csub, possub = possub)
        w <- object$Eig[rank.fac == ianal]
        if (length(w) < neig) 
            w <- c(w, rep(0, neig - length(w)))
        if (show.eigen.value) 
            add.scatter.eig(w, nf, xax, yax, posi = c("bottom", 
                "top"), ratio = 1/4)
    }
} 


"kplot.sepan.coa" <- function (object, xax = 1, yax = 2, which.tab = 1:length(object$blo),
    mfrow = NULL, permute.row.col = FALSE, clab.row = 1, clab.col = 1.25, 
    csub = 2, possub = "bottomright", show.eigen.value = TRUE, 
    poseig = c("bottom", "top"), ...) 
{
    if (!inherits(object, "sepan")) 
        stop("Object of type 'sepan' expected")
    opar <- par(ask = par("ask"), mfrow = par("mfrow"), mar = par("mar"))
    on.exit(par(opar))
    nbloc <- length(object$blo)
    if (is.null(mfrow)) 
        mfrow <- n2mfrow(length(which.tab))
    par(mfrow = mfrow)
    if (length(which.tab) > prod(mfrow)) 
        par(ask = TRUE)
    rank.fac <- factor(rep(1:nbloc, object$rank))
    nf <- ncol(object$Li)
    neig <- max(object$rank)
    appel <- as.list(object$call)
    X <- eval(appel$X, sys.frame(0))
    names.li <- row.names(X[[1]])
    for (ianal in which.tab) {
        coocol <- object$C1[object$TC[, 1] == ianal, c(xax, yax)]
        row.names(coocol) <- names(X[[ianal]])
        coolig <- object$Li[object$TL[, 1] == ianal, c(xax, yax)]
        row.names(coolig) <- names.li
        if (permute.row.col) {
            auxi <- coolig
            coolig <- coocol
            coocol <- auxi
        }
        if (clab.col > 0) 
            cpoi <- 0
        else cpoi <- 3
        s.label(coocol, clab = 0, cpoi = 0, sub = object$tab.names[ianal], 
            csub = csub, possub = possub)
        s.label(coocol, clab = clab.col, cpoi = cpoi, add.p = TRUE)
        s.label(coolig, clab = clab.row, add.p = TRUE)
        if (permute.row.col) {
            auxi <- coolig
            coolig <- coocol
            coocol <- auxi
        }
        w <- object$Eig[rank.fac == ianal]
        if (length(w) < neig) 
            w <- c(w, rep(0, neig - length(w)))
        if (show.eigen.value) 
            add.scatter.eig(w, nf, xax, yax, posi = poseig, ratio = 1/4)
    }
}
