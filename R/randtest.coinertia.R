"randtest.coinertia" <- function(xtest, nrepet = 999, fixed = 0, ...) {
  if(!inherits(xtest,"dudi"))
    stop("Object of class dudi expected")
  if(!inherits(xtest,"coinertia"))
    stop("Object of class 'coinertia' expected")
  appel <- as.list(xtest$call)
  dudiX <- eval.parent(appel$dudiX)
  dudiY <- eval.parent(appel$dudiY)

  ## X table
  X <- dudiX$tab
  X.cw <- dudiX$cw
  X.lw <- dudiX$lw
  appelX <- as.list(dudiX$call)
  apx <- appelX$df
  Xinit <- eval.parent(appelX$df)

  ## Test the different cases
  typX <- dudi.type(dudiX$call)
  if(typX == 2)
    Xinit <- acm.disjonctif(Xinit)
  if(!(typX %in% (1:7)))
    stop ("Not yet available")

  ## Y table
  Y <- dudiY$tab
  Y.cw <- dudiY$cw
  Y.lw <- dudiY$lw
  appelY <- as.list(dudiY$call)
  apy <- appelY$df
  Yinit <- eval.parent(appelY$df)
 
  ## Test the different cases
  typY <- dudi.type(dudiY$call)
  if(typY == 2)
    Yinit <- acm.disjonctif(Yinit)
  if(!(typY %in% (1:7)))
    stop ("Not yet available")
  
  if(identical(all.equal(X.lw, Y.lw), TRUE)) {
    if(identical(all.equal(X.lw, rep(1/nrow(X), nrow(X))), TRUE)) {
      isim <- testertrace(nrepet, X.cw, Y.cw, X, Y, nrow(X), ncol(X), ncol(Y))
    } else {
      if(fixed == 0) {
        cat("Warning: non uniform weight. The results from simulations\n")
        cat("are not valid if weights are computed from analysed data.\n")
        isim <- testertracenu(nrepet, X.cw, Y.cw, X.lw, X, Y, nrow(X), ncol(X), ncol(Y), Xinit, Yinit, typX, typY)
	if(typX == 2)
          isim[-1] <- isim[-1]/ncol(eval.parent(appelX$df))
	if(typY == 2)
          isim[-1] <- isim[-1]/ncol(eval.parent(appelY$df))
      } else if(fixed == 1) {
        cat("Warning: non uniform weight. The results from permutations\n")
        cat("are valid only if the row weights come from the fixed table.\n")
        cat("The fixed table is table X : ")
        print(apx)
        isim <- testertracenubis(nrepet, X.cw, Y.cw, X.lw, X, Y, nrow(X), ncol(X), ncol(Y), Xinit, Yinit, typX, typY, fixed)
	if(typY == 2)
          isim[-1] <- isim[-1]/ncol(eval.parent(appelY$df))
      } else if (fixed==2) {
        cat("Warning: non uniform weight. The results from permutations\n")
        cat("are valid only if the row weights come from the fixed table.\n")
        cat("The fixed table is table Y : ")
        print(apy)
        isim <- testertracenubis(nrepet, X.cw, Y.cw, X.lw, X, Y, nrow(X), ncol(X), ncol(Y), Xinit, Yinit, typX, typY, fixed)
	if(typX == 2)
          isim[-1] <- isim[-1]/ncol(eval.parent(appelX$df))
	
      }
      else
        stop ("Error : fixed must be =< 2")
    }
    
    ## RV computed using the coinertia
    isim <- isim/sqrt(sum(dudiX$eig^2))/sqrt(sum(dudiY$eig^2))
    obs <- isim[1]
    return(as.randtest(isim[-1],obs,call=match.call()))
  } else {
    stop ("Equal row weights expected")
  }
}
