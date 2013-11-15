"gridrowcol" <- function (nrow,ncol, cell.names=NULL) { 
    # Résultats utilisés dans le thèse de Cornillon p. 15 
    # corrections de 2 coquilles bas de p. 15
    nrow <- as.integer(nrow)
    if (nrow < 1) stop("nrow nonpositive")
    ncol <- as.integer(ncol)
    if (ncol < 1)  stop("ncol nonpositive")
    ncell <- nrow*ncol
    xy<-matrix(0,nrow,ncol)
    xy <- cbind(as.numeric(t(col(xy))),as.numeric(t(row(xy))))
    if (!is.null(cell.names)) {
        if (length(cell.names)!=nrow*ncol) cell.names <- NULL
    }
    if (is.null (cell.names)) {
        cell.names <- paste("R",xy[,2],"C",xy[,1],sep="")
    }
 
    xy <- data.frame(xy)
    names(xy)=c("x","y")
    row.names(xy) = cell.names
    xy$"y" <- nrow+1-xy$"y"
    res<- list(xy=xy)
    area <- rep(row.names(xy),rep(4,ncell))
    area <- as.factor(area)
    w <- cbind(xy$"x"-0.5,xy$"x"-0.5,xy$"x"+0.5,xy$"x"+0.5)
    w <- as.numeric(t(w))
    area <- cbind.data.frame(area,w)
    w <- cbind(xy$"y"-0.5,xy$"y"+0.5,xy$"y"+0.5,xy$"y"-0.5)
    w <- as.numeric(t(w))
    area <- cbind.data.frame(area,w)
    names(area) <- c("cell","x","y")
    res$area <- area
    d0 <- as.matrix(dist.quant(xy,1))
    d0 <- 1*(d0<1.2)
    diag(d0) <-0
    pvoisi <- unlist(apply(d0,1,sum))
    naret <- sum(pvoisi)
    pvoisi <- pvoisi/naret
    d0 <- neig(mat01=d0)
    res$neig <- d0

    xy$"y" <- nrow+1-xy$"y"
    # numero de colonne en x et numero de ligne en y
    "glin" <- function (n) {
        n<-n
        "vecpro" <- function(k) {
            x <- cos(k*pi*((1:n)-0.5)/n)
            x <- x/sqrt(sum(x*x))
            # print(x)
        }
        w <- unlist(lapply(0:(n-1),vecpro))
        w <- matrix(w,n)
    }
    
    orthobasis <- glin(nrow)%x%glin(ncol)
    
    # ce paragrahe calcule les valeurs de xtEx pour les vecteurs de orthobasis
    # et permet de vérifier qu'il s'agit bien des vecteurs propres
    # et que les valeurs propres sont bien celles qui sont calculées
    # d0=neig2mat(d0)
    # d1=apply(d0,1,sum)
    # d0=diag(d1)-d0
    # fun2 <- function(x) {
    #     w=d0*x
    #     return(sum(t(w)*x))
    # }
    # lambda <- unlist(apply(orthobasis,2,fun2))
    # print(lambda)
    # res$lambda <- lambda
    
    pirow <- pi/nrow
    picol<- pi/ncol
    salpha <- (sin((0:(nrow-1))*pirow/2))^2
    sbeta <- (sin((0:(ncol-1))*picol/2))^2
    z <- rep(sbeta,nrow)+rep(salpha,rep(ncol,nrow))
    z <- 4*z/nrow/ncol
    w <- order(z)[-1]
    z <- z[w]
    orthobasis <- sqrt(ncell)*orthobasis[,w]
    orthobasis <- data.frame(orthobasis)
    val <- unlist(lapply(orthobasis,function(x) sum(x*x*pvoisi)))
    val <- val - z*ncell*ncell/naret
    ord <- rev(order(val))
    orthobasis <- orthobasis[,ord]
    val <- val[ord]
    names(orthobasis) = paste("S",1:(ncell-1),sep="")
    row.names(orthobasis) = row.names(res$xy)
    # Les valeurs sont calculées à partir des valeurs propres de l'opérateur de lissage
    # Ce sont des valeurs de l'indice de Moran xtFx/v(x) v en 1/n
    # print(unlist(lapply(orthobasis,function(x) sum(x*x*pvoisi))))
    attr(orthobasis,"values") <- val
    attr(orthobasis,"weights") <- rep(1/ncell,ncell)
    attr(orthobasis,"call") <- match.call()
    attr(orthobasis,"class") <- c("orthobasis","data.frame")
    res$orthobasis <- orthobasis
    # ces ordres vérifient qu'on a bien trouvé les indices de Moran
    # d0 = neig2mat(d0)
    # d0 = d0/sum(d0) # Moran type W
    # moran <- unlist(lapply(orthobasis,function(x) sum(t(d0*x)*x)))
    # print(moran)
    # plot(moran,attr(orthobasis,"values"))
    # abline(lm(attr(orthobasis,"values")~moran))
    # print(summary(lm(attr(orthobasis,"values")~moran)))
    return(res)
}

    
