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

"dist.genet" <- function (genet, method = 1, diag = FALSE, upper = FALSE) { 
  
  .Deprecated(new="dist.genet", package="ade4", 
              msg="This function is now deprecated. Please use the 'dist.genpop' function in the 'adegenet' package.")
  
  METHODS = c("Nei","Edwards","Reynolds","Rodgers","Provesti")
  if (all((1:5)!=method)) {
    cat("1 = Nei 1972\n")
    cat("2 = Edwards 1971\n")
    cat("3 = Reynolds, Weir and Coockerman 1983\n")
    cat("4 = Rodgers 1972\n")
    cat("5 = Provesti 1975\n")
    cat("Select an integer (1-5): ")
    method <- as.integer(readLines(n = 1))
  }
  if (all((1:5)!=method)) (stop ("Non convenient method number"))
  if (!inherits(genet,"genet"))  
    stop("list of class 'genet' expected")
  df <- genet$tab
  col.blocks <- genet$loc.blocks
  nloci <- length(col.blocks)
  d.names <- genet$pop.names
  nlig <- nrow(df)
  
  if (is.null(names(col.blocks))) {
    names(col.blocks) <- paste("L", as.character(1:nloci), sep = "")
  }
  f1 <- function(x) {
    a <- sum(x)
    if (is.na(a)) 
      return(rep(0, length(x)))
    if (a == 0) 
      return(rep(0, length(x)))
    return(x/a)
  }
  k2 <- 0
  for (k in 1:nloci) {
    k1 <- k2 + 1
    k2 <- k2 + col.blocks[k]
    X <- df[, k1:k2]
    X <- t(apply(X, 1, f1))
    X.marge <- apply(X, 1, sum)
    if (any(sum(X.marge)==0)) stop ("Null row found")
    X.marge <- X.marge/sum(X.marge)
    df[, k1:k2] <- X
  }
  # df contient un tableau de fréquence
  df <- as.matrix(df)    
  if (method == 1) {
    d <- df%*%t(df)
    vec <- sqrt(diag(d))
    d <- d/vec[col(d)]
    d <- d/vec[row(d)]
    d <- -log(d)
    d <- as.dist(d)
  } else if (method == 2) {
    df <- sqrt(df)
    d <- df%*%t(df)
    d <- 1-d/nloci
    diag(d) <- 0
    d <- sqrt(d)
    d <- as.dist(d)
  } else if (method == 3) {
    denomi <- df%*%t(df)
    vec <- apply(df,1,function(x) sum(x*x))
    d <- -2*denomi + vec[col(denomi)] + vec[row(denomi)]
    diag(d) <- 0
    denomi <- 2*nloci - 2*denomi
    diag(denomi) <- 1
    d <- d/denomi
    d <- sqrt(d)
    d <- as.dist(d)
  } else if (method == 4) {
    loci.fac <- rep( names(col.blocks),col.blocks)
    loci.fac <- as.factor(loci.fac)
    ltab <- lapply(split(df,loci.fac[col(df)]),matrix,nrow=nlig)
    "dcano" <- function (mat) {
      daux <- mat%*%t(mat)
      vec <- diag(daux)
      daux <- -2*daux+vec[col(daux)]
      daux <- daux + vec[row(daux)]
      diag(daux) <- 0
      daux <- sqrt(daux/2)
      d <<- d+daux
    }
    d <- matrix(0,nlig,nlig)
    lapply(ltab, dcano)
    d <- d/length(ltab)
    d <- as.dist(d)
  } else if (method ==5) {
    w0 <- 1:(nlig-1)
    "loca" <- function (k) {
      w1 <- (k+1):nlig
      resloc <- unlist(lapply(w1, function(x) sum(abs(df[k,]-df[x,]))))
      return(resloc/2/nloci)
    }
    d <- unlist(lapply(w0,loca))
  } 
  attr(d, "Size") <- nlig
  attr(d, "Labels") <- d.names
  attr(d, "Diag") <- diag
  attr(d, "Upper") <- upper
  attr(d, "method") <- METHODS[method]
  attr(d, "call") <- match.call()
  class(d) <- "dist"
  return(d)
}

"fuzzygenet" <- function(X) {
  
  .Deprecated(new="fuzzygenet", package="ade4", 
              msg="This function is now deprecated. Please use the 'df2genind' function in the 'adegenet' package.")
  
  if (!inherits(X, "data.frame")) stop ("X is not a data.frame")
  nind <- nrow(X)
  ####################################################################################
  "codred" <- function(base, n) {
    # fonction qui fait des codes de noms ordonnés par ordre
    # alphabétique de longueur constante le plus simples possibles
    # base est une chaîne de charactères, n le nombre qu'on veut
    w <- as.character(1:n)
    max0 <- max(nchar(w))
    "fun1" <- function(x) while ( nchar(w[x]) < max0) w[x] <<- paste("0",w[x],sep="")
    lapply(1:n, fun1)
    return(paste(base,w,sep="")) 
  }
  ###################################################################################
  # ce qui touche au loci
  loc.names <- names(X)
  nloc <- ncol(X)
  loc.codes <- codred("L",nloc)
  names(loc.names) <- loc.codes
  names(X) <- loc.codes
  "cha6car" <- function(cha) {
    # pour compléter les chaînes de caratères par des zéros devant
    n0 <- nchar(cha)
    if (n0 == 6) return (cha)
    if (n0 >6) stop ("More than 6 characters")
    cha = paste("0",cha,sep="")
    cha = cha6car(cha)
  }
  X <- apply(X,c(1,2),cha6car)
  
  # Toutes les chaînes sont de 6 charactères suppose que le codage est complet
  # ou qu'il ne manque des zéros qu'au début
  "enumallel" <- function (x) {
    w <- as.character(x)
    w1 <- substr(w,1,3)
    w2 <- substr(w,4,6)
    w3 <- sort(unique (c(w1,w2)))
    return(w3)
  }
  all.util <- apply(X,2,enumallel)
  # all.util est une liste dont les composantes sont les noms des allèles ordonnés
  # peut comprendre 000 pour un non typé
  # on conserve le nombre d'individus typés par locus dans vec1
  "compter" <- function(x) {
    # compte le nombre d'individus typés par locus
    num0 <- x!="000000"
    num0 <- sum(num0)
    return(num0)
  }
  vec1 <- unlist(apply(X,2, compter))
  names(vec1) <- loc.codes
  # vec1 est le vecteur des effectifs d'individus typés par locus
  "polymor" <- function(x) {
    if (any(x=="000")) return(x[x!="000"])
    return(x)
  }
  "nallel" <- function(x) {
    l0 <- length(x)
    if (any(x=="000")) return(l0-1)
    return(l0)
  }
  vec2  <-  unlist(lapply(all.util, nallel))
  names(vec2) <- names(all.util)
  # vec2 est le vecteur du nombre d'allèles observés par locus
  
  all.names  <-  unlist(lapply(all.util, polymor))
  # all.names contient les nomds des alleles sans "000"
  loc.blocks  <-  unlist(lapply(all.util, nallel))
  names(loc.blocks) <- names(all.util)
  all.names  <-  unlist(lapply(all.util, polymor))
  w1 <- rep(loc.codes,loc.blocks)
  w2 <- unlist(lapply(loc.blocks, function(n) codred(".",n)))
  all.codes <- paste(w1,w2,sep="")
  all.names <- paste(rep(loc.names, loc.blocks),all.names,sep=".")
  names(all.names) <- all.codes
  # all.names est le nouveau nom des allèles
  w1 <- as.factor(w1)
  names(w1) <- all.codes
  loc.fac <- w1
  "manq"<- function(x) {
    if (any(x=="000")) return(TRUE)
    return(FALSE)
  }
  missingdata <- unlist(lapply(all.util, manq))
  "enumindiv" <- function (x) {
    x <- as.character(x)
    n <- length(x)
    w1 <- substr(x, 1, 3)
    w2 <- substr(x, 4, 6)
    "funloc1" <- function (k) {
      w0 <- rep(0,length(all.util[[k]]))
      names(w0) <- all.util[[k]]
      w0[w1[k]] <- w0[w1[k]]+1
      w0[w2[k]] <- w0[w2[k]]+1
      # ce locus n'a pas de données manquantes
      if (!missingdata[k]) return(w0)
      # ce locus a des données manquantes mais pas cet individu
      if (w0["000"]==0) return(w0[names(w0)!="000"])
      #cet individus a deux données manquantes
      if (w0["000"]==2) {
        w0 <- rep(NA, length(w0)-1)
        return(w0)
      }
      # il doit y avoir une seule donnée manquante
      stop( paste("a1 =",w1[k],"a2 =",w2[k], "Non implemented case"))
    }
    w  <-  as.numeric(unlist(lapply(1:n, funloc1)))
    return(w)
  }
  ind.all <- apply(X,1,enumindiv)
  ind.all <- data.frame(t(ind.all))
  names(ind.all) <- all.names
  nind <- nrow(ind.all)
  # ind.all contient un tableau individus - alleles codé 
  # ******* pour NA pour les manquants
  # 010010 pour les hétérozygotes
  # 000200 pour les homozygotes
  all.som <- apply(ind.all,2,function(x) sum(na.omit(x)))
  #all.som contient le nombre d'allèles présents par forme allélique
  names(all.som) = all.names
  
  center <- split(all.som, loc.fac)
  center <- lapply(center, function(x) 2*x/sum(x))
  center <- unlist(center)
  names(center) <- all.codes
  "modifier" <- function (x) {
    x[is.na(x)]=center[is.na(x)]
    return(x/2)
  }
  ind.all <- t(apply(ind.all, 1, modifier))
  ind.all <- as.data.frame(ind.all)
  names(ind.all) <- all.codes
  attr(ind.all,"col.blocks") <- vec2
  attr(ind.all,"all.names") <- all.names
  attr(ind.all,"loc.names") <- loc.names
  attr(ind.all,"row.w") <- rep(1/nind, nind)
  attr(ind.all,"col.freq") <- center/2
  attr(ind.all,"col.num") <- as.factor(rep(loc.names,vec2))
  return(ind.all)
}

"char2genet" <- function(X,pop,complete=FALSE) {
  
  .Deprecated(new="char2genet", package="ade4", 
              msg="This function is now deprecated. Please use the 'df2genind' and 'genind2genpop' functions in the 'adegenet' package.")
  
  if (!inherits(X, "data.frame")) stop ("X is not a data.frame")
  if (!is.factor(pop)) stop("pop is not a factor")
  nind <- length(pop)
  if (nrow(X) != nind) stop ("pop & X have non convenient dimension")
  # tri des lignes par ordre alphabétique des noms de population
  # tri par ordre alphabétique des noms de loci
  X <- X[order(pop),]
  X <- X[,sort(names(X))]
  pop <- sort(pop) # comme pop[order(pop)]
  ####################################################################################
  "codred" <- function(base, n) {
    # fonction qui fait des codes de noms ordonnés par ordre
    # alphabétique de longueur constante le plus simples possibles
    # base est une chaîne de charactères, n le nombre qu'on veut
    w <- as.character(1:n)
    max0 <- max(nchar(w))
    "fun1" <- function(x) while ( nchar(w[x]) < max0) w[x] <<- paste("0",w[x],sep="")
    lapply(1:n, fun1)
    return(paste(base,w,sep="")) 
  }
  ####################################################################################
  # Ce qui touche aux populations
  npop <- nlevels(pop)
  pop.names <- as.character(levels(pop))
  pop.codes <- codred("P", npop)
  names(pop.names) <- pop.codes
  levels(pop) <- pop.codes    
  ####################################################################################
  # Ce qui touche aux individus
  nind <- nrow(X)
  ind.names <- row.names(X)
  ind.codes <- codred("", nind)
  names(ind.names) <- ind.codes
  ###################################################################################
  # ce qui touche au loci
  loc.names <- names(X)
  nloc <- ncol(X)
  loc.codes <- codred("L",nloc)
  names(loc.names) <- loc.codes
  names(X) <- loc.codes
  "cha6car" <- function(cha) {
    # pour compléter les chaînes de caratères par des zéros devant
    n0 <- nchar(cha)
    if (n0 == 6) return (cha)
    if (n0 >6) stop ("More than 6 characters")
    cha = paste("0",cha,sep="")
    cha = cha6car(cha)
  }
  X <- as.data.frame(apply(X,c(1,2),cha6car))
  
  # Toutes les chaînes sont de 6 charactères suppose que le codage est complet
  # ou qu'il ne manque des zéros qu'au début
  "enumallel" <- function (x) {
    w <- as.character(x)
    w1 <- substr(w,1,3)
    w2 <- substr(w,4,6)
    w3 <- sort(unique (c(w1,w2)))
    return(w3)
  }
  all.util <- lapply(X,enumallel)
  # all.util est une liste dont les composantes sont les noms des allèles ordonnés
  # Correction d'un bug mis en evidence par Amalia
  # amalia@mail.imsdd.meb.uni-bonn.de 
  # La liste etait automatiquement une matrice quand le nombre d'allele par locus est constant
  # peut comprendre 000 pour un non typé
  # on conserve le nombre d'individus typés par locus et par populations
  "compter" <- function(x) {
    num0 <- x!="000000"
    num0 <- split(num0,pop)
    num0 <- as.numeric(unlist(lapply(num0,sum)))
    return(num0)
  }
  Z <- unlist(apply(X,2, compter))
  Z <- data.frame(matrix(Z,ncol=nloc))
  names(Z) <- loc.codes
  row.names(Z) <- pop.codes
  # Z est un data.frame populations-locus des effectifs d'individus
  ind.full <- apply(X,1,function (x) !any(x == "000000"))
  "polymor" <- function(x) {
    if (any(x=="000")) return(x[x!="000"])
    return(x)
  }
  "nallel" <- function(x) {
    l0 <- length(x)
    if (any(x=="000")) return(l0-1)
    return(l0)
  }
  loc.blocks  <-  unlist(lapply(all.util, nallel))
  names(loc.blocks) <- names(all.util)
  all.names  <-  unlist(lapply(all.util, polymor))
  w1 <- rep(loc.codes,loc.blocks)
  w2 <- unlist(lapply(loc.blocks, function(n) codred(".",n)))
  all.codes <- paste(w1,w2,sep="")
  all.names <- paste(rep(loc.names, loc.blocks),all.names,sep=".")
  names(all.names) <- all.codes
  w1 <- as.factor(w1)
  names(w1) <- all.codes
  loc.fac <- w1
  "manq"<- function(x) {
    if (any(x=="000")) return(TRUE)
    return(FALSE)
  }
  missingdata <- unlist(lapply(all.util, manq))
  "enumindiv" <- function (x) {
    x <- as.character(x)
    n <- length(x)
    w1 <- substr(x, 1, 3)
    w2 <- substr(x, 4, 6)
    "funloc1" <- function (k) {
      w0 <- rep(0,length(all.util[[k]]))
      names(w0) <- all.util[[k]]
      w0[w1[k]] <- w0[w1[k]]+1
      w0[w2[k]] <- w0[w2[k]]+1
      # ce locus n'a pas de données manquantes
      if (!missingdata[k]) return(w0)
      # ce locus a des données manquantes mais pas cet individu
      if (w0["000"]==0) return(w0[names(w0)!="000"])
      #cet individus a deux données manquantes
      if (w0["000"]==2) {
        w0 <- rep(NA, length(w0)-1)
        return(w0)
      }
      # il doit y avoir une seule donnée manquante
      stop( paste("a1 =",w1[k],"a2 =",w2[k], "Non implemented case"))
    }
    w  <-  as.numeric(unlist(lapply(1:n, funloc1)))
    return(w)
  }
  ind.all <- apply(X,1,enumindiv)
  ind.all <- data.frame(t(ind.all))
  names(ind.all) <- all.codes
  nallels <- length(all.codes)
  
  # ind.all contient un tableau individus - alleles codé 
  # ******* pour NA pour les manquants
  # 010010 pour les hétérozygotes
  # 000200 pour les homozygotes
  ind.all <- split(ind.all, pop)
  "remplacer" <- function (a,b) {
    if (all(!is.na(a))) return(a)
    if (all(is.na(a))) return(b)
    a[is.na(a)] <- b[is.na(a)]
    return(a)
  }
  
  "sommer"<- function (x){
    apply(x,2,function(x) sum(na.omit(x)))
  }
  all.pop <- matrix(unlist(lapply(ind.all,sommer)),nrow = nallels)
  all.pop = as.data.frame(all.pop)
  names(all.pop) <- pop.codes
  row.names(all.pop) <- all.codes
  
  center <- apply(all.pop,1,sum)
  center <- split(center, loc.fac)
  center <- unlist(lapply(center, function(x) x/sum(x)))
  names(center) <- all.codes
  "completer" <- function (x) {
    moy0  <-  apply(x,2,mean, na.rm=TRUE)
    y <- apply(x, 1, function(a) remplacer(a,moy0))
    return(y/2)
  }
  ind.all <- lapply(ind.all, completer)
  res <- list()
  pop.all <- unlist(lapply(ind.all,function(x) apply(x,1,mean)))
  pop.all <- matrix(pop.all, ncol=nallels, byrow=TRUE)
  pop.all <- data.frame(pop.all)
  names(pop.all) <- all.codes
  row.names(pop.all) <- pop.codes
  # 1) tableau de fréquences alléliques popualations-lignes
  # allèles-colonnes indispensable pour la classe genet
  res$tab <- pop.all
  # 2) marge du précédent calculé sur l'ensemble des individus typés par locus
  res$center <- center
  # 3) noms des populations renumérotées P001 ... P999
  # le vecteur contient les noms d'origine
  res$pop.names <- pop.names
  # 4) noms des allèles recodé L01.1, L01.2, ...
  # le vecteurs contient les noms d'origine.
  res$all.names <- all.names
  # 5) le vecteur du nombre d'allèles par loci
  res$loc.blocks <- loc.blocks
  # 6) le facteur répartissant les allèles par loci
  res$loc.fac <- loc.fac
  # 7) noms des loci renumérotées L01 ... L99
  # le vecteur contient les noms d'origine
  res$loc.names <- loc.names
  # 8) le nombre de gènes qui ont permis les calculs de fréquences
  res$pop.loc <- Z
  # 9) le nombre d'occurences de chaque forme allélique dans chaque population
  # allèles eln lignes, populations en colonnes
  res$all.pop <- all.pop
  #######################################################
  if (complete) {
    n0 <- length(all.codes) # nrow(ind.all[[1]])
    ind.all <- unlist(ind.all)
    ind.all <- matrix(ind.all, ncol=n0, byrow=TRUE)
    ind.all <- data.frame(ind.all)
    ind.all <- ind.all[ind.full,]
    pop.red <- pop[ind.full]
    names(ind.all) <- all.codes
    row.names(ind.all) <- ind.codes[ind.full]
    ind.all <- 2*ind.all
    # ind.all <- split(ind.all,pop.red)
    # ind.all <- lapply(ind.all,t)
    # 10) les typages d'individus complets
    # ind.all est une liste de matrices allèles-individus
    # ne contenant que les individus complètement typés
    # avec le codage 02000 ou 01001
    
    res$comp <- ind.all
    res$comp.pop <- pop.red
  }
  class(res) <- c("genet", "list")
  return(res)
}

"count2genet" <- function (PopAllCount) {
  
  .Deprecated(new="count2genet", package="ade4", 
              msg="This function is now deprecated. Please use the 'df2genind' and 'genind2genpop' functions in the 'adegenet' package.")
  
  # PopAllCount est un data.frame qui contient des dénombrements
  ####################################################################################
  "codred" <- function(base, n) {
    # fonction qui fait des codes de noms ordonnés par ordre
    # alphabétique de longueur constante le plus simples possibles
    # base est une chaîne de charactères, n le nombre qu'on veut
    w <- as.character(1:n)
    max0 <- max(nchar(w))
    "fun1" <- function(x) while ( nchar(w[x]) < max0) w[x] <<- paste("0",x,sep="")
    lapply(1:n, fun1)
    return(paste(base,w,sep="")) 
  }
  
  if (!inherits(PopAllCount,"data.frame")) stop ("data frame expected")
  if (!all(apply(PopAllCount,2,function(x) all(x==as.integer(x)))))
    stop("For integer values only")
  PopAllCount <- PopAllCount[sort(row.names(PopAllCount)),]
  PopAllCount <- PopAllCount[,sort(names(PopAllCount))]
  npop <- nrow(PopAllCount)
  w1 <- strsplit(names(PopAllCount),"[.]")
  loc.fac <- as.factor(unlist(lapply(w1, function(x) x[1])))
  loc.blocks <- as.numeric(table(loc.fac))
  nloc <- nlevels(loc.fac)    
  loc.names <- as.character(levels(loc.fac))
  pop.codes <- codred("P", npop)
  loc.codes <- codred("L",nloc)
  names(loc.blocks) <- loc.codes 
  pop.names <- row.names(PopAllCount)
  names(pop.names) <- pop.codes
  
  w1 <- rep(loc.codes,loc.blocks)
  w2 <- unlist(lapply(loc.blocks, function(n) codred(".",n)))
  all.codes <- paste(w1,w2,sep="")
  all.names <- names(PopAllCount)
  names(all.names) <- all.codes
  names(loc.names) <- loc.codes
  all.pop <- as.data.frame(t(PopAllCount))
  names(all.pop) <- pop.codes
  row.names(all.pop) <- all.codes
  
  center <- apply(all.pop,1,sum)
  center <- split(center,loc.fac)
  center <- unlist(lapply(center, function(x) x/sum(x)))
  names(center) <- all.codes
  
  PopAllCount <- split(all.pop,loc.fac)
  "pourcent" <- function(x) {
    x <- t(x)
    w <- apply(x,1,sum)
    w[w==0] <- 1
    x <- x/w
    return(x)
    # retourne un tableau populations-allèles
  }
  PopAllCount <- lapply(PopAllCount,pourcent)
  tab <- data.frame(provi=rep(1,npop))
  lapply(PopAllCount, function(x) tab <<- cbind.data.frame(tab,x))
  tab <- tab[,-1]
  names(tab) <- all.codes
  row.names(tab) <- pop.codes
  res <- list()
  res$tab <- tab
  res$center <- center
  res$pop.names <- pop.names
  res$all.names <- all.names
  res$loc.blocks <- loc.blocks
  res$loc.fac <- loc.fac
  res$loc.names <- loc.names
  res$pop.loc <- NULL
  res$all.pop <- all.pop
  res$complet <- NULL
  class(res) <- c("genet","list")
  return(res)
}

"freq2genet" <- function (PopAllFreq) {
  
  .Deprecated(new="freq2genet", package="ade4", 
              msg="This function is now deprecated. Please use the 'df2genind' and 'genind2genpop' functions in the 'adegenet' package.")
  
  # PopAllFreq est un data.frame qui contient des fréquences alléliques
  ####################################################################################
  "codred" <- function(base, n) {
    # fonction qui fait des codes de noms ordonnés par ordre
    # alphabétique de longueur constante le plus simples possibles
    # base est une chaîne de charactères, n le nombre qu'on veut
    w <- as.character(1:n)
    max0 <- max(nchar(w))
    nformat <- paste("%0",max0,"i",sep="")
    "fun1" <- function(x) w[x] <<- sprintf(nformat,x)
    # "fun1" <- function(x) while ( nchar(w[x]) < max0) w[x] <<- paste("0",x,sep="")
    lapply(1:n, fun1)
    return(paste(base,w,sep="")) 
  }
  
  if (!inherits(PopAllFreq,"data.frame")) stop ("data frame expected")
  if (!all(apply(PopAllFreq,2,function(x) all(x>=0))))
    stop("Data >= 0 expected")
  if (!all(apply(PopAllFreq,2,function(x) all(x<=1))))
    stop("Data <= 1 expected")
  PopAllFreq <- PopAllFreq[sort(row.names(PopAllFreq)),]
  PopAllFreq <- PopAllFreq[,sort(names(PopAllFreq))]
  npop <- nrow(PopAllFreq)
  w1 <- strsplit(names(PopAllFreq),"[.]")
  loc.fac <- as.factor(unlist(lapply(w1, function(x) x[1])))
  loc.blocks <- as.numeric(table(loc.fac))
  nloc <- nlevels(loc.fac)    
  loc.names <- as.character(levels(loc.fac))
  pop.codes <- codred("P", npop)
  loc.codes <- codred("L",nloc)
  names(loc.blocks) <- loc.codes 
  pop.names <- row.names(PopAllFreq)
  names(pop.names) <- pop.codes
  
  w1 <- rep(loc.codes,loc.blocks)
  w2 <- unlist(lapply(loc.blocks, function(n) codred(".",n)))
  all.codes <- paste(w1,w2,sep="")
  all.names <- names(PopAllFreq)
  names(all.names) <- all.codes
  names(loc.names) <- loc.codes
  all.pop <- as.data.frame(t(PopAllFreq))
  names(all.pop) <- pop.codes
  row.names(all.pop) <- all.codes
  
  center <- apply(all.pop,1,mean)
  center <- split(center,loc.fac)
  center <- unlist(lapply(center, function(x) x/sum(x)))
  names(center) <- all.codes
  
  PopAllFreq <- split(all.pop,loc.fac)
  "pourcent" <- function(x) {
    x <- t(x)
    w <- apply(x,1,sum)
    w[w==0] <- 1
    x <- x/w
    return(x)
    # retourne un tableau populations-allèles
  }
  PopAllFreq <- lapply(PopAllFreq,pourcent)
  tab <- data.frame(provi=rep(1,npop))
  lapply(PopAllFreq, function(x) tab <<- cbind.data.frame(tab,x))
  tab <- tab[,-1]
  names(tab) <- all.codes
  row.names(tab) <- pop.codes
  res <- list()
  res$tab <- tab
  res$center <- center
  res$pop.names <- pop.names
  res$all.names <- all.names
  res$loc.blocks <- loc.blocks
  res$loc.fac <- loc.fac
  res$loc.names <- loc.names
  res$pop.loc <- NULL
  res$all.pop <- all.pop
  res$complet <- NULL
  class(res) <- c("genet","list")
  return(res)
}

"multispati" <- function(dudi, listw, scannf=TRUE, nfposi=2, nfnega=0) {
    
    .Deprecated(new="multispati", package="ade4", 
                msg="This function is now deprecated. Please use the 'multispati' function in the 'adespatial' package.")
    
    if(!inherits(dudi,"dudi")) stop ("object of class 'dudi' expected")
    if(!inherits(listw,"listw")) stop ("object of class 'listw' expected") 
    if(listw$style!="W") stop ("object of class 'listw' with style 'W' expected")
    NEARZERO <- 1e-14
    
    dudi$cw <- dudi$cw
    fun <- function (x) spdep::lag.listw(listw,x,TRUE)
    tablag <- apply(dudi$tab,2,fun)
    covar <- t(tablag)%*%as.matrix((dudi$tab*dudi$lw))
    covar <- (covar+t(covar))/2
    covar <- covar * sqrt(dudi$cw)
    covar <- t(t(covar) * sqrt(dudi$cw))
    covar <- eigen(covar, symmetric = TRUE)
    res <- list()
    res$eig <- covar$values[abs(covar$values)>NEARZERO]
    ndim <- length(res$eig)
    covar$vectors <- covar$vectors[, abs(covar$values)>NEARZERO]
    
    if (scannf) {
        graphics::barplot(res$eig)
        cat("Select the first number of axes (>=1): ")
        nfposi <- as.integer(readLines(n = 1))
        
        cat("Select the second number of axes (>=0): ")
        nfnega <- as.integer(readLines(n = 1))
    }
    if (nfposi <= 0)  nfposi <- 1
    if (nfnega<=0) nfnega <- 0       
    
    if(nfposi > sum(res$eig > 0)){
        nfposi <- sum(res$eig > 0)
        warning(paste("There are only",sum(res$eig>0),"positive factors."))
    }
    if(nfnega > sum(res$eig < 0)){
        nfnega <- sum(res$eig < 0)
        warning(paste("There are only",sum(res$eig< 0),"negative factors."))
    }
    res$nfposi <- nfposi
    res$nfnega <- nfnega
    agarder <- c(1:nfposi,if (nfnega>0) (ndim-nfnega+1):ndim else NULL)
    dudi$cw[which(dudi$cw == 0)] <- 1
    auxi <- data.frame(covar$vectors[, agarder] /sqrt(dudi$cw))
    names(auxi) <- paste("CS", agarder, sep = "")
    row.names(auxi) <- names(dudi$tab)
    res$c1 <- auxi                     
    auxi <- as.matrix(auxi)*dudi$cw
    auxi1 <- as.matrix(dudi$tab)%*%auxi
    auxi1 <- data.frame(auxi1)
    names(auxi1) <- names(res$c1)
    row.names(auxi1) <- row.names(dudi$tab)
    res$li <- auxi1
    auxi1 <- as.matrix(tablag)%*%auxi
    auxi1 <- data.frame(auxi1)
    names(auxi1) <- names(res$c1)
    row.names(auxi1) <-  row.names(dudi$tab)    
    res$ls <- auxi1
    auxi <- as.matrix(res$c1) * unlist(dudi$cw)
    auxi <- data.frame(t(as.matrix(dudi$c1)) %*% auxi)
    row.names(auxi) <- names(dudi$li)
    names(auxi) <- names(res$li)
    res$as <- auxi
    res$call <- match.call()
    class(res) <- "multispati"
    return(res)
}

"summary.multispati" <- function (object, ...) {
    
    .Deprecated(new="summary.multispati", package="ade4", 
                msg="This method is now deprecated. Please use the 'summary.multispati' method in the 'adespatial' package.")
    
    norm.w <- function(X, w) {
        f2 <- function(v) sum(v * v * w)/sum(w)
        norm <- apply(X, 2, f2)
        return(norm)
    }
    
    if (!inherits(object, "multispati")) stop("to be used with 'multispati' object")
    
    cat("\nMultivariate Spatial Analysis\n")
    cat("Call: ")
    print(object$call)
    
    appel <- as.list(object$call)
    dudi <- eval.parent(appel$dudi)
    listw <- eval.parent(appel$listw)
    
    ## les scores de l'analyse de base
    nf <- dudi$nf
    eig <- dudi$eig[1:nf]
    cum <- cumsum (dudi$eig) [1:nf]
    ratio <- cum/sum(dudi$eig)
    w <- apply(dudi$l1,2,spdep::lag.listw,x=listw)
    moran <- apply(w*as.matrix(dudi$l1)*dudi$lw,2,sum)
    res <- data.frame(var=eig,cum=cum,ratio=ratio, moran=moran)
    cat("\nScores from the initial duality diagramm:\n")
    print(res)
    
    ## les scores de l'analyse spatiale
    ## on recalcule l'objet en gardant tous les axes
    eig <- object$eig
    nfposi <- object$nfposi
    nfnega <- object$nfnega
    nfposimax <- sum(eig > 0)
    nfnegamax <- sum(eig < 0)
    
    ms <- multispati(dudi=dudi, listw=listw, scannf=FALSE,
                     nfposi=nfposimax, nfnega=nfnegamax)
    
    ndim <- dudi$rank
    nf <- nfposi + nfnega
    agarder <- c(1:nfposi,if (nfnega>0) (ndim-nfnega+1):ndim else NULL)
    varspa <- norm.w(ms$li,dudi$lw)
    moran <- apply(as.matrix(ms$li)*as.matrix(ms$ls)*dudi$lw,2,sum)
    res <- data.frame(eig=eig,var=varspa,moran=moran/varspa)
    
    cat("\nMultispati eigenvalues decomposition:\n")
    print(res[agarder,])
    return(invisible(res))
}

"print.multispati" <- function(x, ...) {
    
    .Deprecated(new="print.multispati", package="ade4", 
                msg="This method is now deprecated. Please use the 'print.multispati' method in the 'adespatial' package.")
    
    cat("Multispati object \n")
    cat("class: ")
    cat(class(x))
    cat("\n$call: ")
    print(x$call)
    cat("\n$nfposi:", x$nfposi, "axis-components saved")
    cat("\n$nfnega:", x$nfnega, "axis-components saved")
    #cat("\n$rank: ")
    #cat(x$rank)
    cat("\nPositive eigenvalues: ")
    l0 <- sum(x$eig >= 0)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")  
    cat("Negative eigenvalues: ")
    l0 <- sum(x$eig <= 0)
    cat(sort(signif(x$eig, 4))[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
    cat('\n')
    sumry <- array("", c(1, 4), list(1, c("vector", "length", 
                                          "mode", "content")))
    sumry[1, ] <- c('$eig', length(x$eig), mode(x$eig), 'eigen values')
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(4, 4), list(1:4, c("data.frame", "nrow", "ncol", "content")))
    sumry[1, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "column normed scores")
    sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "row coordinates")
    sumry[3, ] <- c("$ls", nrow(x$ls), ncol(x$ls), 'lag vector coordinates')
    sumry[4, ] <- c("$as", nrow(x$as), ncol(x$as), 'inertia axes onto multispati axes')
    
    
    print(sumry, quote = FALSE)
    cat("other elements: ")
    if (length(names(x)) > 8) 
        cat(names(x)[9:(length(names(x)))], "\n")
    else cat("NULL\n")
}

"plot.multispati" <- function (x, xax = 1, yax = 2, ...) {
    
    .Deprecated(new="plot.multispati", package="ade4", 
                msg="This method is now deprecated. Please use the 'plot.multispati' method in the 'adespatial' package.")
    
    if (!inherits(x, "multispati")) 
        stop("Use only with 'multispati' objects")
    
    appel <- as.list(x$call)
    dudi <- eval.parent(appel$dudi)
    nf <- x$nfposi + x$nfnega
    if ((nf == 1) || (xax == yax)) {
        sco.quant(x$li[, 1], dudi$tab)
        return(invisible())
    }
    if (xax > nf) 
        stop("Non convenient xax")
    if (yax > nf) 
        stop("Non convenient yax")
    f1 <- function () 
    {
        opar <- graphics::par(mar = graphics::par("mar"))
        on.exit(graphics::par(opar))
        m <- length(x$eig)
        graphics::par(mar = c(0.8, 2.8, 0.8, 0.8))
        col.w <- rep(grDevices::grey(1), m) # elles sont toutes blanches
        col.w[1:x$nfposi] <- grDevices::grey(0.8)
        if (x$nfnega>0) col.w[m:(m-x$nfnega+1)] = grDevices::grey(0.8)
        j1 <- xax
        if (j1>x$nfposi) j1 = j1-x$nfposi +m -x$nfnega
        j2 <- yax
        if (j2>x$nfposi) j2 = j2-x$nfposi +m -x$nfnega
        col.w[c(j1,j2)] = grDevices::grey(0)
        graphics::barplot(x$eig, col = col.w)
        scatterutil.sub(cha ="Eigen values", csub = 2, possub = "topright")
    }
    
    def.par <- graphics::par(no.readonly = TRUE)
    on.exit(graphics::par(def.par))
    graphics::layout(matrix(c(3, 3, 1, 3, 3, 2), 3, 2))
    graphics::par(mar = c(0.2, 0.2, 0.2, 0.2))
    f1()
    s.arrow(x$c1, xax = xax, yax = yax, sub = "Canonical weights", 
            csub = 2, clabel = 1.25)
    s.match(x$li, x$ls, xax = xax, yax = yax, sub = "Scores and lag scores", csub = 2, clabel = 0.75) 
    
}
