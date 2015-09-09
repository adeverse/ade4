randtest.rlq <- function(xtest, nrepet = 999, modeltype = 6, ...) {
  if (!inherits(xtest,"dudi"))
    stop("Object of class dudi expected")
  if (!inherits(xtest,"rlq"))
    stop("Object of class 'rlq' expected")
  if (!(modeltype %in% c(2, 4, 5, 6)))
    stop("modeltype should be 2, 4, 5 or 6")
  
  if(modeltype == 6){
    test1 <- randtest.rlq(xtest, modeltype = 2, nrepet = nrepet,...)
    test2 <- randtest.rlq(xtest, modeltype = 4, nrepet = nrepet,...)
    res <- combine.randtest.rlq(test1,test2)
    res$call <-  match.call()
    return(res)
  }
  
  appel <- as.list(xtest$call)
  dudiR <- eval.parent(appel$dudiR)
  dudiQ <- eval.parent(appel$dudiQ)
  dudiL <- eval.parent(appel$dudiL)
  
  
  R.cw <- dudiR$cw
  appelR <- as.list(dudiR$call)
  Rinit <- as.data.frame(eval.parent(appelR$df))
  
  ## Test the different cases
  typR <- dudi.type(dudiR$call)
  
  ## index can take two values (1 quantitative / 2 factor)
  if(typR %in% c(1,3,4,5,6,7)) {
    indexR <- rep(1,ncol(Rinit))
    assignR <- 1:ncol(Rinit)
  } else if (typR == 2) {
    indexR <- rep(2, ncol(Rinit))
    assignR <- rep(1:ncol(Rinit), apply(Rinit, 2, function(x) nlevels(as.factor(x))))
    Rinit <- acm.disjonctif(Rinit)
  } else if (typR == 8) {
    indexR <- ifelse(dudiR$index == 'q', 1, 2)
    assignR <- dudiR$assign
    
    res <- matrix(0, nrow(Rinit), 1)
    
    for (j in 1:(ncol(Rinit))) {
      if (indexR[j] == 1) {
        res <- cbind(res, Rinit[, j])
      } else if (indexR[j] == 2) {
        w <- fac2disj(Rinit[, j], drop = TRUE)
        res <- cbind(res, w)
      }
    }
    
    Rinit <- res[,-1]
    
  } else stop ("Not yet available")


  
  Q.cw <- dudiQ$cw
  appelQ <- as.list(dudiQ$call)
  Qinit <- as.data.frame(eval.parent(appelQ$df))
  typQ <- dudi.type(dudiQ$call)
  
  if (typQ %in% c(1,3,4,5,6,7)) {
    indexQ <- rep(1,ncol(Qinit))
    assignQ <- 1:ncol(Qinit)
  } else if (typQ == 2) {
    indexQ <- rep(2,ncol(Qinit))
    assignQ <- rep(1:ncol(Qinit), apply(Qinit, 2, function(x) nlevels(as.factor(x))))
    Qinit <- acm.disjonctif(Qinit)
  } else if (typQ == 8) {
    indexQ <- ifelse(dudiQ$index == 'q',1,2)
    assignQ <- dudiQ$assign
    
    res <- matrix(0, nrow(Qinit), 1)
    
    for (j in 1:(ncol(Qinit))) {
      if (indexQ[j] == 1) {
        res <- cbind(res, Qinit[, j])
      } else if (indexQ[j] == 2) {
        w <- fac2disj(Qinit[, j], drop = TRUE)
        res <- cbind(res, w)
      }
    }
    Qinit <- res[,-1]
    
  } else stop ("Not yet available")
  
  L <- dudiL$tab
  L.cw <- dudiL$cw
  L.lw <- dudiL$lw
  isim <- testertracerlq(nrepet, R.cw, Q.cw, L.lw, L.cw, Rinit, Qinit, L, typQ, typR,indexR, assignR, indexQ, assignQ, modeltype)
  
  obs <- isim[1]
  return(as.randtest(isim[-1], obs, call = match.call()))
}


combine.randtest.rlq <- function(obj1, obj2) {
  if(!inherits(obj1, "randtest") | !inherits(obj2, "randtest"))
    stop("Not a 'randtest' object")
  
  call1 <- as.list(obj1$call)
  call2 <- as.list(obj2$call)
  
  if((call1[[1]] != "randtest.rlq") | (call2[[1]] != "randtest.rlq"))
    stop("Objects must obtained by the 'randtest.rlq' function")
  
  ## if argument is missing, modeltype = 5 (default)
  if(is.null(call1$modeltype) | is.null(call2$modeltype))
    stop("modeltype(s) must be 2 or 4")
  ## modeltype 2 and 4 should be combined
  modeltypes <- c(call1$modeltype, call2$modeltype)
  if(sum(sort(modeltypes) == c(2,4))!=2)
     stop("modeltype(s) must be 2 and 4")
  sim <- cbind(obj1$sim, obj2$sim)
  colnames(sim) <- paste("Model",modeltypes)
  res <- as.krandtest(sim, c(obj1$obs,obj2$obs), alter = c(obj1$alter, obj2$alter), call=match.call(), p.adjust.method = "none")
  res$comb.pvalue <- max(obj1$pvalue, obj2$pvalue)
  return(res)
}
