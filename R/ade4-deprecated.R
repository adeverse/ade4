"between" <- function (dudi, fac, scannf = TRUE, nf = 2) {
  .Deprecated(new="bca", package="ade4", 
              msg="To avoid some name conflicts, the 'between' function is now deprecated. Please use 'bca' instead")
  res <- bca(x=dudi, fac=fac, scannf = scannf, nf = nf)
  res$call <- match.call()
  return(res)
}

"betweencoinertia" <- function (obj, fac, scannf = TRUE, nf = 2) {
  .Deprecated(new="bca", package="ade4", 
              msg="To avoid some name conflicts, the 'betweencoinertia' function is now deprecated. Please use 'bca.coinertia' instead")
  res <- bca(x=obj, fac=fac, scannf = scannf, nf = nf)
  res$call <- match.call()
  return(res)
}

"within" <- function (dudi, fac, scannf = TRUE, nf = 2) {
  .Deprecated(new="wca", package="ade4", 
              msg="To avoid some name conflicts, the 'within' function is now deprecated. Please use 'wca' instead")
  res <- wca(x=dudi, fac=fac, scannf = scannf, nf = nf)
  res$call <- match.call()
  return(res)
}

"withincoinertia" <-  function (obj, fac, scannf = TRUE, nf = 2){
  .Deprecated(new="wca", package="ade4", 
              msg="To avoid some name conflicts, the 'withincoinertia' function is now deprecated. Please use 'wca.coinertia' instead")
  res <- wca(x=obj, fac=fac, scannf = scannf, nf = nf)
  res$call <- match.call()
  return(res)
}

"orthogram"<- function (x, orthobas = NULL, neig = NULL, phylog = NULL, nrepet = 999, posinega = 0, tol = 1e-07,
                        na.action = c("fail", "mean"), cdot = 1.5, cfont.main = 1.5, lwd = 2, nclass, high.scores = 0,
                        alter=c("greater", "less", "two-sided"), ...) {
  .Deprecated(new="orthogram", package="ade4", 
              msg="This function is now deprecated. Please use the 'orthogram' function in the 'adephylo' package.")
  "orthoneig" <- function (obj) {
    if (!inherits(obj, "neig"))
      stop("Object of class 'neig' expected")
    b0 <- neig.util.LtoG(obj)
    deg <- attr(obj, "degrees")
    m <- sum(deg)
    n <- length(deg)
    b0 <- -b0/m + diag(deg)/m
    # b0 est la matrice D-P
    eig <- eigen (b0, symmetric = TRUE)
    w0 <- abs(eig$values)/max(abs(eig$values))
    w0 <- which(w0<tol)
    if (length(w0)==0) stop ("abnormal output : no null eigenvalue")
    if (length(w0)==1) w0 <- (1:n)[-w0]
    else if (length(w0)>1) {
      # on ajoute le vecteur dérivé de 1n
      w <- cbind(rep(1,n),eig$vectors[,w0])
      # on orthonormalise l'ensemble
      w <- qr.Q(qr(w))
      # on met les valeurs propres à 0
      eig$values[w0] <- 0
      # on remplace les vecteurs du noyau par une base orthonormée contenant
      # en première position le parasite
      eig$vectors[,w0] <- w[,-ncol(w)]
      # on enlève la position du parasite
      w0 <- (1:n)[-w0[1]]
    }
    w0=rev(w0)
    rank <- length(w0)
    values <- n-eig$values[w0]*n
    eig <- eig$vectors[,w0]*sqrt(n)
    eig <- data.frame(eig)
    row.names(eig) <- names(deg)
    names(eig) <- paste("V",1:rank,sep="")
    attr(eig,"values")<-values
    eig
  }
  
  if (!is.numeric(x)) stop("x is not numeric")
  nobs <- length(x)
  if (!is.null(neig)) {
    orthobas <- orthoneig(neig)
  } else if (!is.null(phylog)) {
    if (!inherits(phylog, "phylog")) stop ("'phylog' expected with class 'phylog'")
    orthobas <- phylog$Bscores
  }
  
  if (is.null(orthobas)){
    stop ("'orthobas','neig','phylog' all NULL")
  }
  
  if (!inherits(orthobas, "data.frame")) stop ("'orthobas' is not a data.frame")
  if (nrow(orthobas) != nobs) stop ("non convenient dimensions")
  if (ncol(orthobas) != (nobs-1)) stop (paste("'orthobas' has",ncol(orthobas),"columns, expected:",nobs-1))
  vecpro <- as.matrix(orthobas)
  npro <- ncol(vecpro)
  if (any(is.na(x))) {
    if (na.action == "fail")
      stop("missing value in 'x'")
    else if (na.action == "mean")
      x[is.na(x)] <- mean(na.omit(x))
    else stop("unknown method for 'na.action'")
  }
  w <- t(vecpro/nobs)%*%vecpro
  if (any(abs(diag(w)-1)>tol)) {
    # print(abs(diag(w)-1))
    stop("'orthobas' is not orthonormal for uniform weighting")
  }
  diag(w) <- 0
  if ( any( abs(as.numeric(w))>tol) )
    stop("'orthobas' is not orthogonal for uniform weighting")
  if (nrepet < 99) nrepet <- 99
  if (posinega !=0) {
    if (posinega >= nobs-1) stop ("Non convenient value in 'posinega'")
    if (posinega <0) stop ("Non convenient value in 'posinega'")
  }
  
  # préparation d'un graphique à 6 fenêtres
  # 1 pgram
  # 2 pgram cumulé
  # 3-6 Tests de randomisation
  def.par <- par(no.readonly = TRUE)
  on.exit(par(def.par))
  layout (matrix(c(1,1,2,2,1,1,2,2,3,4,5,6),4,3))
  par(mar = c(0.1, 0.1, 0.1, 0.1))
  par(usr = c(0,1,-0.05,1))
  # layout.show(6)
  
  z <- x - mean(x)
  et <- sqrt(mean(z * z))
  if ( et <= tol*(max(z)-min(z))) stop ("No variance")
  z <- z/et
  sig50 <- (1:npro)/npro
  w <- .C("VarianceDecompInOrthoBasis",
          param = as.integer(c(nobs,npro,nrepet,posinega)),
          observed = as.double(z),
          vecpro = as.double(vecpro),
          phylogram = double(npro),
          phylo95 = double(npro),
          sig025 = double(npro),
          sig975 = double(npro),
          R2Max = double(nrepet+1),
          SkR2k = double(nrepet+1),
          Dmax = double(nrepet+1),
          SCE = double(nrepet+1),
          ratio = double(nrepet+1),
          PACKAGE="ade4"
  )
  ylim <- max(c(w$phylogram, w$phylo95))
  z0 <- apply(vecpro, 2, function(x) sum(z * x))
  names(w$phylogram) <- as.character(1:npro)
  phylocum <- cumsum(w$phylogram)
  lwd0=2
  fun <- function (y, last=FALSE) {
    delta <- (mp[2]-mp[1])/3
    sel <- 1:(npro - 1)
    segments(mp[sel]-delta,y[sel],mp[sel]+delta, y[sel],lwd=lwd0)
    if(last) segments(mp[npro]-delta,y[npro],mp[npro]+delta, y[npro],lwd=lwd0)
  }
  y0 <- phylocum - sig50
  h.obs <- max(y0)
  x0 <- min(which(y0 == h.obs))
  par(mar = c(3.1, 2.5, 2.1, 2.1))
  mp <- barplot(w$phylogram, col = grey(1 - 0.3 * (sign(z0) > 0)),
                ylim = c(0, ylim * 1.05))
  scores.order <- (1:length(w$phylogram))[order(w$phylogram, decreasing=TRUE)[1:high.scores]]
  fun(w$phylo95,TRUE)
  abline(h = 1/npro)
  if (posinega!=0) {
    verti = (mp[posinega]+mp[posinega+1])/2
    abline (v=verti, col="red",lwd=1.5)
  }
  title(main = "Variance decomposition",font.main=1, cex.main=cfont.main)
  box()
  obs0 <- rep(0, npro)
  names(obs0) <- as.character(1:npro)
  barplot(obs0, ylim = c(-0.05, 1.05))
  abline(h=0,col="white")
  if (posinega!=0) {
    verti = (mp[posinega]+mp[posinega+1])/2
    abline (v=verti, col="red",lwd=1.5)
  }
  
  title(main = "Cumulative decomposition",font.main=1, cex.main=cfont.main)
  points(mp, phylocum, pch = 21, cex = cdot, type = "b")
  segments(mp[1], 1/npro, mp[npro], 1, lty = 1)
  fun(w$sig975)
  fun(w$sig025)
  arrows(mp[x0], sig50[x0], mp[x0], phylocum[x0], angle = 15, length = 0.15,
         lwd = 2)
  box()
  if (missing(nclass)) {
    nclass <- as.integer (nrepet/25)
    nclass <- min(c(nclass,40))
  }
  plot.randtest (as.randtest (w$R2Max[-1],w$R2Max[1],call=match.call(), output = "full"),main = "R2Max",nclass=nclass)
  if (posinega !=0) {
    plot.randtest (as.randtest (w$ratio[-1],w$ratio[1],call=match.call(), output = "full"),main = "Ratio",nclass=nclass)
  } else {
    plot.randtest (as.randtest (w$SkR2k[-1],w$SkR2k[1],call=match.call(), output = "full"),main = "SkR2k",nclass=nclass)
  }
  plot.randtest (as.randtest (w$Dmax[-1],w$Dmax[1], call=match.call(), output = "full"),main = "DMax",nclass=nclass)
  plot.randtest (as.randtest (w$SCE[-1],w$SCE[1], call=match.call(), output = "full"),main = "SCE", nclass=nclass)
  
  w$param <- w$observed <- w$vecpro <- NULL
  w$phylogram <- NULL
  w$phylo95 <- w$sig025 <- w$sig975 <- NULL
  if (posinega==0) {
    w <- as.krandtest(obs=c(w$R2Max[1],w$SkR2k[1],w$Dmax[1],w$SCE[1]),sim=cbind(w$R2Max[-1],w$SkR2k[-1],w$Dmax[-1],w$SCE[-1]),names=c("R2Max","SkR2k","Dmax","SCE"),alter=alter,call=match.call(), ...)
  } else {
    w <- as.krandtest(obs=c(w$R2Max[1],w$SkR2k[1],w$Dmax[1],w$SCE[1],w$ratio[1]),sim=cbind(w$R2Max[-1],w$SkR2k[-1],w$Dmax[-1],w$SCE[-1],w$ratio[-1]),names=c("R2Max","SkR2k","Dmax","SCE","ratio"),alter=alter,call=match.call(), ...)
  }
  
  if (high.scores != 0)
    w$scores.order <- scores.order
  return(w)
}

"EH" <- function(phyl, select = NULL) {
  .Deprecated(new="EH", package="ade4", 
              msg="This function is now deprecated. Please use the 'EH' function in the 'adiv' package.")
  if (!inherits(phyl, "phylog")) stop("unconvenient phyl")
  if(is.null(phyl$Wdist)) phyl <- newick2phylog.addtools(phyl)
  if (is.null(select))
    return(sum(phyl$leaves) + sum(phyl$nodes))
  else {
    if(!is.numeric(select)) stop("unconvenient select")
    select <- unique(select)
    nbesp <- length(phyl$leaves)
    nbselect <- length(select)
    if(any(is.na(match(select, 1:nbesp)))) stop("unconvenient select")
    phyl.D <- as.matrix(phyl$Wdist^2 / 2)
    if(length(select)==1) return(max(phyl.D))
    if(length(select)==2) return(phyl.D[select[1], select[2]] + max(phyl.D))
    fun <- function(i) {
      min(phyl.D[select[i], select[1:(i - 1)]])
    }
    res <-  phyl.D[select[1], select[2]] + max(phyl.D) + sum(sapply(3:nbselect, fun)) 
    return(res)
  }
}

"orisaved" <- function(phyl, rate = 0.1, method = 1) {
  .Deprecated(new="orisaved", package="ade4", 
              msg="This function is now deprecated. Please use the 'orisaved' function in the 'adiv' package.")
  if (!inherits(phyl, "phylog")) stop("unconvenient phyl")
  if(is.null(phyl$Wdist)) phyl <- newick2phylog.addtools(phyl)
  if (any(is.na(match(method, 1:2)))) stop("unconvenient method")
  if (length(method) != 1) stop("only one method can be chosen")
  if (length(rate) != 1) stop("unconvenient rate")
  if (!is.numeric(rate)) stop("rate must be a real value")
  if (!(rate>=0 & rate<=1)) stop("rate must be between 0 and 1")
  if (rate == 0) return(0)
  phy.h <- hclust(phyl$Wdist^2 / 2)
  nbesp <- length(phy.h$labels)
  Rate <- round(seq(0, nbesp, by = nbesp * rate))
  Rate <- Rate[-1]
  phyl.D <- as.matrix(phyl$Wdist^2 / 2)
  Orig <- (solve(phyl.D)%*%rep(1, nbesp) / sum(solve(phyl.D)))
  OrigCalc <- function(i) {
    if (method == 1) {
      return(sum(unlist(lapply(split(Orig, cutree(phy.h, i)), max))))
    }
    if (method == 2) {
      return(sum(unlist(lapply(split(Orig, cutree(phy.h, i)), min))))
    }
  }
  res <- c(0, sapply(Rate, OrigCalc))
  return(res)
}

"randEH" <- function(phyl, nbofsp, nbrep = 10) {
  .Deprecated(new="randEH", package="ade4", 
              msg="This function is now deprecated. Please use the 'randEH' function in the 'adiv' package.")
  if (!inherits(phyl, "phylog")) stop("unconvenient phyl")
  if(is.null(phyl$Wdist)) phyl <- newick2phylog.addtools(phyl)
  if (length(nbofsp)!= 1) stop("unconvenient nbofsp")
  nbesp <- length(phyl$leaves)
  if (!((0 <= nbofsp) & (nbofsp <= nbesp))) stop("unconvenient nbofsp")
  nbofsp <- round(nbofsp)
  if (nbofsp == 0) return(rep(0, nbrep))
  if (nbofsp == nbesp) {
    return(rep(EH(phyl), nbrep))
  }
  simuA1 <- function(i, phy) {
    comp = sample(1:nbesp, nbofsp)
    if (nbofsp == 2) {
      phyl.D <- as.matrix(phyl$Wdist^2 / 2)
      resc <- (max(phyl.D) + phyl.D[comp[1], comp[2]])
    }
    else {
      if (nbofsp == 1)
        resc <- max(phyl$Wdist^2 / 2)
      else {
        resc <- EH(phyl, select = comp)
      }
    }
    return(resc)
  }
  res <- sapply(1:nbrep, simuA1, phyl)
  return(res)
}

"optimEH" <- function(phyl, nbofsp, tol = 1e-8, give.list = TRUE) {
  .Deprecated(new="optimEH", package="ade4", 
              msg="This function is now deprecated. Please use the 'optimEH' function in the 'adiv' package.")
  if (!inherits(phyl, "phylog")) stop("unconvenient phyl")
  if(is.null(phyl$Wdist)) phyl <- newick2phylog.addtools(phyl)
  phy.h <- hclust(phyl$Wdist^2 / 2)
  nbesp <- length(phy.h$labels)
  if (length(nbofsp) != 1) stop("unconvenient nbofsp")
  if (nbofsp == 0) return(0)
  if (!((0 < nbofsp) & (nbofsp <= nbesp))) stop("unconvenient nbofsp")
  nbofsp <- round(nbofsp)
  sp.names <- phy.h$labels
  if (nbofsp == nbesp) {
    res1 <- EH(phyl)
    sauv.names <- sp.names
  }
  else {
    phyl.D <- as.matrix(phyl$Wdist^2 / 2)
    Orig <- (solve(phyl.D)%*%rep(1, nbesp) / sum(solve(phyl.D)))
    Orig <- as.data.frame(Orig)
    car1 <- split(Orig, cutree(phy.h, nbofsp))
    name1 <- lapply(car1,function(x) rownames(x)[abs(x - max(x)) < tol])
    sauv.names <- lapply(name1, paste, collapse = " OR ")
    comp <- as.character(as.vector(lapply(name1, function(x) x[1])))
    nb1 <- as.vector(sapply(comp, function(x) (1:nbesp)[sp.names == x]))
    if (nbofsp == 2)
      res1 <- max(phyl$Wdist^2 / 2) * 2
    else {
      if (nbofsp == 1)
        res1 <- max(phyl$Wdist^2 / 2)
      else {
        res1 <- EH(phyl, select = nb1)
      }
    }
  }
  if (give.list == TRUE)
    return(list(value = res1, selected.sp = cbind.data.frame(names = unlist(sauv.names))))
  else
    return(res1)
}
