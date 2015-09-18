randboot.multiblock <- function(object, nrepet = 199, optdim, ...) 

{
    if (!inherits(object, "multiblock")) 
        stop("Object of type 'mbpcaiv' or 'mbpls' expected")
    
    if ((optdim < 0) | (optdim > object$rank))
        stop("Wrong number for optimal dimension")
    
    ## get some arguments 
    appel <- as.list(object$call)
    method <- as.character(appel[[1]])
    scale <- eval.parent(appel$scale)
    option <- eval.parent(appel$option)
    X <- eval.parent(appel$ktabX)
    Y <- eval.parent(appel$dudiY)  
    nr <- nrow(Y$tab)  
    ncY <- ncol(Y$tab)
    h <- object$rank

    nblo <- length(object$blo) ## number of X tables 
    ncX <- sum(X$blo) ## total number of variables in X

    ## prepare the outputs
       
    res <- list()    
    res$XYcoef <- list() 
    res$XYcoef <- rep(list(matrix(0, ncol = ncX, nrow = nrepet, dimnames = list(NULL, colnames(object$tabX)))), ncY)
     
    res$bipc <- matrix(0, ncol = nblo, nrow = nrepet)
    colnames(res$bipc) <- names(X$blo)	
    
    res$vipc <- matrix(0, ncol = ncX, nrow = nrepet)
    colnames(res$vipc) <- colnames(object$tabX)

    ## bootstrap and outputs
    for (i in 1 : nrepet){
        s <- sample(x = nr, replace = TRUE)
        Xboot <- X[, s, ]
        Yboot <- Y[s, ] 
        
        resboot <- do.call(method, list(dudiY = Yboot, ktabX = Xboot, scale = scale, option = option, scannf = FALSE, nf = as.integer(optdim)))
                
        for (k in 1:ncY)
            res$XYcoef[[k]][i, ] <- resboot$XYcoef[[k]][, optdim]
        res$bipc[i, ] <- resboot$bipc[, optdim]
        res$vipc[i, ] <- resboot$vipc[, optdim]     
    }

    thecall <- match.call()
    res$XYcoef <- lapply(1:ncY, function(x) as.krandboot(obs = object$XYcoef[[x]][, optdim], boot = res$XYcoef[[x]], call = thecall))
    names(res$XYcoef) <- colnames(object$tabY)
    res$bipc <- as.krandboot(obs = object$bipc[, optdim], boot = res$bipc, call = thecall)
    res$vipc <- as.krandboot(obs = object$vipc[, optdim], boot = res$vipc, call = thecall)
       
    return(res) 
}




testdim.multiblock <- function(object, nrepet = 100, quantiles = c(0.25, 0.75), ...){
  
  if (!inherits(object, "multiblock")) 
    stop("Object of type 'mbpcaiv' or 'mbpls' expected")

  ## get some arguments 
  appel <- as.list(object$call)
  method <- as.character(appel[[1]])
  scale <- eval.parent(appel$scale)
  option <- eval.parent(appel$option)
  X <- eval.parent(appel$ktabX)
  Y <- eval.parent(appel$dudiY)  
  nr <- nrow(Y$tab)  
  q <- ncol(Y$tab)
  h <- object$rank

  ## prepare outputs
  dimlab <- paste("Ax", (1 : h), sep = "")
  RMSEV <- RMSEC <- matrix(NA, nrow = nrepet, ncol = h)
  colnames(RMSEV) <- colnames(RMSEC) <- dimlab 
  rownames(RMSEV) <- rownames(RMSEC) <- 1:nrepet
 
  ## Two-fold cross validation
  
  Nc <- round(2 * nr / 3)
  Nv <- nr - Nc  

  for(i in 1 : nrepet) {
      
      ## Dividing X and Y into calibration (Xc, Yc) and validation (Xv, Yv) datasets
      s  <- sample(x = nr, size = Nc)  
      Xc <- X[, s, ]
      Xv <- X[, -s, ]
      Yc <- Y[s, ]
      Yv <- Y[-s, ]
      
      ## Applying the multiblock method to the calibration/validation datasets    
      rescal <- do.call(method, list(dudiY = Yc, ktabX = Xc, scale = scale, option = option, scannf = FALSE, nf = h))
      resval <- do.call(method, list(dudiY = Yv, ktabX = Xv, scale = scale, option = option, scannf = FALSE, nf = h))                   
      
      ## Compute Root Mean Square Errors of Calibration (RMSEC) and Validation (RMSEV)
      nblo   <- length(Xc$blo)    
      Xc.mat <- cbind.data.frame(unclass(Xc)[1:nblo])
      Xv.mat <- cbind.data.frame(unclass(Xv)[1:nblo])
      for(j in 1 : min(rescal$rank, resval$rank, h)){
          XYcoef.cal <- sapply(rescal$XYcoef, function(x) x[, j])
          intercept.cal <- sapply(rescal$intercept, function(x) x[, j])      
          residYc <- as.matrix(Yc$tab) - (matrix(rep(intercept.cal, each = Nc), ncol = q) + as.matrix(Xc.mat) %*% XYcoef.cal)      
          RMSEC[i, j] <- sqrt(sum(residYc^2) / (Nc * q)) 
          residYv <- as.matrix(Yv$tab) - (matrix(rep(intercept.cal, each = Nv), ncol = q) + as.matrix(Xv.mat) %*% XYcoef.cal)
          RMSEV[i, j] <- sqrt(sum(residYv^2) / (Nv * q))
      }
  }

  res <- as.krandxval(RMSEC, RMSEV, call = match.call(), quantiles = quantiles)
  return(res)
}


summary.multiblock <- function(object, ...) {
    
    if (!inherits(object, "multiblock")) 
        stop("to be used with 'mbpcaiv' or 'mbpls' object")
    
    thetitle <- ifelse(inherits(object, "mbpcaiv"), "Multiblock principal component analysis with instrumental variables",
                       "Multiblock partial least squares")
    cat(thetitle)
    cat("\n\n")
    Xk <- ktab.data.frame(df = object$tabX, blocks = object$blo, tabnames = names(object$blo))
    k <- length(object$blo)
    h <- object$rank
    appel <- as.list(object$call)
    
    ## Summary for eigenvalues and inertia
    summary.dudi(object)
    
    ## Summary for the variances of Y and X explained by the global component (lX)
    varT <- diag(crossprod(object$lX * object$lw, object$lX))
    
    covarTY <- diag(tcrossprod(crossprod(object$lX * object$lw, as.matrix(object$tabY))))
    varexplTY <- (covarTY/varT) / sum(covarTY/varT) * 100
    varexplTYcum <- cumsum(varexplTY) / sum(varexplTY) * 100
    
    covarTX <- diag(tcrossprod(crossprod(object$lX * object$lw, as.matrix(object$tabX))))
    varexplTX <- (covarTX/varT) / sum(covarTX/varT) * 100
    varexplTXcum <- cumsum(varexplTX) / sum(varexplTX) * 100 
   
    cat(paste("Inertia explained by the global latent, i.e.", deparse(substitute(object$lX)), "(in %): \n\n")) 
    sumry <- array(0, c(object$nf, 4), list(1:object$nf, c("varY", "varYcum", "varX", "varXcum")))
    sumry[, 1] <- varexplTY[1 : object$nf]
    sumry[, 2] <- varexplTYcum[1 : object$nf]
    sumry[, 3] <- varexplTX[1 : object$nf]
    sumry[, 4] <- varexplTXcum[1 : object$nf]
    rownames(sumry) <- colnames(object$lX)[1:object$nf]
    cat(paste(deparse(appel$dudiY), "$tab", " and ", deparse(appel$ktabX), ": \n", sep = ''))
    print(sumry, digits = 3)
    
    ## Summary for the variances of Xk explained by the global component (lX)
    sumryk <- list()
    
    for (j in 1:k) {
        covarTXk <- diag(tcrossprod(crossprod(object$lX * object$lw, as.matrix(Xk[[j]]))))
        varexplTXk <- (covarTXk/varT) / sum(covarTXk/varT) * 100
        varexplTXkcum  <- cumsum(varexplTXk) / sum(varexplTXk) * 100
        sumryk[[j]] <- cbind.data.frame(varXk = varexplTXk[1 : object$nf], varXkcum = varexplTXkcum[1 : object$nf])
        cat("\n")
        cat(paste(names(object$blo[j])), ":\n", sep = '')
        print(sumryk[[j]], digits = 3)
    }
    
    names(sumryk) <- names(object$blo)
    res <- c(list(YandX = sumry), sumryk)
    invisible(res)
}


print.multiblock <- function (x, ...) 
{
    if (!inherits(x, "multiblock")) 
        stop("to be used with 'mbpcaiv' or 'mbpls' object")
    
    thetitle <- ifelse(inherits(x, "mbpcaiv"), "Multiblock principal component analysis with instrumental variables",
                       "Multiblock partial least squares")
    cat(thetitle)
    cat(paste("\nlist of class", class(x)))
    l0 <- length(x$eig)
    cat("\n\n$eig:", l0, "eigen values\n")
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n")
    else cat("\n")
    cat("\n$call: ")
    print(x$call)
    cat("\n$nf:", x$nf, "axis saved\n\n")
    showed.names <- c("nf", "call", "eig", "lX", "lY", "Tli", "Yco", "faX", "bip", "bipc", "vip", "vipc", "cov2") 
    sumry <- array("", c(10, 4), list(1:10, c("data.frame", "nrow", 
        "ncol", "content")))
    sumry[1, ] <- c("$lX", nrow(x$lX), ncol(x$lX), "global components of the explanatory tables")
    sumry[2, ] <- c("$lY", nrow(x$lY), ncol(x$lY), "components of the dependent data table")
    sumry[3, ] <- c("$Tli", nrow(x$Tli), ncol(x$Tli), "partial components")
    sumry[4, ] <- c("$Yco", nrow(x$Yco), ncol(x$Yco), "inertia axes onto co-inertia axis")
    sumry[5, ] <- c("$faX", nrow(x$faX), ncol(x$faX), "loadings to build the global components")
    sumry[6, ] <- c("$bip", nrow(x$bip), ncol(x$bip), "block importances")
    sumry[7, ] <- c("$bipc", nrow(x$bipc), ncol(x$bipc), "cumulated block importances")
    sumry[8, ] <- c("$vip", nrow(x$vip), ncol(x$vip), "variable importances")
    sumry[9, ] <- c("$vipc", nrow(x$vipc), ncol(x$vipc), "cumulated variable importances")
    sumry[10, ] <- c("$cov2", nrow(x$cov2), ncol(x$cov2), "squared covariance between components")
    if(inherits(x, "mbpls"))
        sumry <- sumry[-3,]
    print(sumry, quote = FALSE)
    cat("other elements: ")
    cat(names(x)[!(names(x)%in%showed.names)], "\n")
    
}

