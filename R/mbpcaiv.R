mbpcaiv <- function(dudiY, ktabX, scale = TRUE, option = c("uniform", "none"), scannf = TRUE, nf = 2) {

    ## -------------------------------------------------------------------------------
    ##			       Some tests
    ##--------------------------------------------------------------------------------
    
    if (!inherits(dudiY, "dudi"))
        stop("object 'dudi' expected")
    if (!inherits(ktabX, "ktab"))
        stop("object 'ktab' expected")
    if (any(row.names(ktabX) != row.names(dudiY$tab)))
        stop("ktabX and dudiY must have the same rows")
    if (!(all.equal(ktabX$lw/sum(ktabX$lw), dudiY$lw/sum(dudiY$lw))))
        stop("ktabX and dudiY must have the same row weights")
    if (nrow(dudiY$tab) < 6)
        stop("Minimum six rows are required")
    if (any(ktabX$blo < 2))
        stop("Minimum two variables per explanatory block are required")
    if (!(is.logical(scale)))
        stop("Non convenient selection for scaling")
    if (!(is.logical(scannf)))
        stop("Non convenient selection for scannf")
    if (nf < 0)
        nf <- 2
    
    ## Only works with centred pca (dudi.pca with center=TRUE) with uniform row weights
    # if (!any(dudi.type(dudiY$call) == c(3,4)))
    #    stop("Only implemented for centred pca")

    # Vérifier la formule / arrondi
    #if (any(dudiY$lw != 1/nrow(dudiY$tab)))
    #    stop("Only implemented for uniform row weights")

    option <- match.arg(option)
    
    ## -------------------------------------------------------------------------------
    ##			Arguments and data transformation
    ## -------------------------------------------------------------------------------
    
    ## Preparation of the data frames
    Y     <- scalewt(as.matrix(dudiY$tab), wt = dudiY$lw, center = TRUE, scale = scale)
    nblo  <- length(ktabX$blo)
    Xk    <- lapply(unclass(ktabX)[1 : nblo], scalewt, wt = ktabX$lw, center = TRUE, scale = scale)
      
    nr    <- nrow(Y) 
    ncolY <- ncol(Y) 
    
    ## Block weighting
    if (option[1] == "uniform"){
        Y <- Y / sqrt(sum(dudiY$eig)) ## Here we use biased variance. We should use Y <- Y / sqrt(nr/(nr-1)*sum(dudiY$eig)) for unbiased estimators
        for (k in 1 : nblo){
            Xk[[k]] <- Xk[[k]] / sqrt((nblo/nr) * sum(diag(crossprod(Xk[[k]])))) ## same : Xk[[k]] <- Xk[[k]] / sqrt((nblo/(nr-1)) * sum(diag(crossprod(Xk[[k]])))) for unbiased estimators
        }
    }
    
    X           <- cbind.data.frame(Xk)
    colnames(X) <- col.names(ktabX)
    ncolX       <- ncol(X)
    maxdim      <- qr(X)$rank
    
       
    ##-----------------------------------------------------------------------
    ##                         Prepare the outputs
    ##-----------------------------------------------------------------------

  
    ## Yc1 (V in Bougeard et al): was c1
    ## lY (U): was ls
    ## Ajout: de Yco (cov(Y, lX)) -> norme total = eig 
    
    ## lX (T): was li
    ## faX (W*): was Wstar
   
    ## Tl1 (Tk): was Tk
    ## Ajout: Tli (Tk non normÃ© = Tk2) norme total = eig
    ## Tfa (Wk): was Wk
    ## Ajout: cov2 (cov^2(lY, Tl1))
    ## XYcoef: (Beta) was beta

    ## bip, bipc
    ## vip, vipc
    
    ## Suppression: W
    ## Suppression: l1
    ## Suppression de C (remplacÃ© par Yco)
    ## Suppression de Ak (remplacÃ© par cov2)
    
    dimlab <- paste("Ax", 1:maxdim, sep = "")
    res    <- list(tabX = X, tabY = as.data.frame(Y), nf = nf, lw = ktabX$lw, X.cw = ktabX$cw, blo = ktabX$blo, rank = maxdim, eig = rep(0, maxdim), TL = ktabX$TL, TC = ktabX$TC)

    res$Yc1  <- matrix(0, nrow = ncolY, ncol = maxdim, dimnames = list(colnames(dudiY$tab), dimlab))
    res$lX   <- res$lY <- matrix(0, nrow = nr, ncol = maxdim, dimnames = list(row.names(dudiY$tab), dimlab))
    res$cov2 <- Ak <- matrix(0, nrow = nblo, ncol = maxdim, dimnames = list(names(ktabX$blo), dimlab))
    res$Tfa  <- lapply(1:nblo, function(k)  matrix(0, nrow = ncol(Xk[[k]]), ncol = maxdim, dimnames = list(colnames(Xk[[k]]), dimlab)))
    res$Tli  <- res$Tl1 <- rep(list(matrix(0, nrow = nr, ncol = maxdim, dimnames = list(row.names(dudiY$tab), dimlab))), nblo)
    res$faX <- matrix(0, nrow = ncolX, ncol = maxdim, dimnames = list(col.names(ktabX), dimlab))
    lX1 <- res$lX
    W <- res$faX
    
    ##-----------------------------------------------------------------------
    ##     Compute components and loadings by an iterative algorithm
    ##-----------------------------------------------------------------------
    
      Y <- as.matrix(Y)
      X <- as.matrix(X)
        
      f1 <- function(x) lm.wfit(x = x, y = Y, w = res$lw)$fitted.values
     
      for(h in 1 : maxdim) {
          
          ## iterative algorithm
          
          ## Compute the matrix M for the eigenanalysis
          M <- lapply(lapply(Xk, f1), function (x) crossprod(x * sqrt(res$lw)))
          M <- Reduce("+", M)
          
          ## Compute the loadings V and the components U (Y dataset)
          eig.M <- eigen(M)
          
          if (eig.M$values[1] < sqrt(.Machine$double.eps)) {
              res$rank <- h-1 ## update the rank
              break
          }
  
          res$eig[h] <- eig.M$values[1]    
          res$Yc1[, h]  <- eig.M$vectors[, 1, drop = FALSE]
          res$lY[, h]  <- Y %*% res$Yc1[, h]
          
          ## Compute the loadings Wk and the components Tk (Xk datasets)
          
          covutcarre <- 0
          covutk <- rep(0, nblo)   
          for (k in 1 : nblo) {
              lm1 <- lm.wfit(x = Xk[[k]], y = res$lY[, h], w = res$lw)
              res$Tfa[[k]][, h] <- lm1$coefficients / sqrt(sum(res$lw * lm1$fitted.values^2))
              res$Tl1[[k]][, h] <- scalewt(lm1$fitted.values, wt = res$lw)
              res$Tli[[k]][, h] <- lm1$fitted.values 
              
              covutk[k] <- crossprod(res$lY[, h] * res$lw, res$Tl1[[k]][, h])
              res$cov2[k, h] <- covutk[k]^2
              covutcarre <- covutcarre + res$cov2[k, h]
          }
          
          for(k in 1 : nblo) {
              Ak[k, h] <- covutk[k] / sqrt(sum(res$cov2[,h]))
              res$lX[, h]  <- res$lX[, h] + Ak[k, h] * res$Tl1[[k]][, h]
          }
          
          lX1[, h] <- res$lX[, h] / sqrt(sum(res$lX[, h]^2))
  
          ## use ginv to avoid NA in coefficients (collinear system)
          W[, h]  <- tcrossprod(MASS::ginv(crossprod(X)), X) %*% res$lX[, h]
          
          ## Deflation of the Xk datasets on the global components T
          Xk <- lapply(Xk, function(y) lm.wfit(x = as.matrix(res$lX[, h]), y = y, w = res$lw)$residuals)
          X  <- as.matrix(cbind.data.frame(Xk))
    }

    ##-----------------------------------------------------------------------
    ##     Compute regressions coefficients
    ##-----------------------------------------------------------------------
    
    ## Use of the original (and not the deflated) datasets X and Y	
    X <- as.matrix(res$tabX)
    Y <- as.matrix(res$tabY)

    ## Computing the regression coefficients of X onto the global components T (Wstar)
    ## res$faX <- lm.wfit(x = X, y = res$lX, w = res$lw)$coefficients ## lm is not used to avoid NA coefficients in the case of not full rank matrices
    res$faX[, 1] <- W[, 1, drop = FALSE]
    A <- diag(ncolX)
    if(maxdim >= 2){
        for(h in 2:maxdim){
            a <- crossprod(lX1[, h-1], X) / sqrt(sum(res$lX[, h-1]^2))
            A <- A %*% (diag(ncolX) - W[, h-1] %*% a)
            res$faX[, h] <- A %*% W[, h]
            X <- X - tcrossprod(lX1[, h-1]) %*% X
        }
    }
    
    ##  Computing the regression coefficients of X onto Y (Beta)
    res$Yco <-  t(Y) %*% diag(res$lw) %*% res$lX
    norm.li <- diag(crossprod(res$lX * sqrt(res$lw)))
    ##res$C   <- t(lm.wfit(x = res$lX, y = Y, w = res$lw)$coefficients)
    ##res$XYcoef <- lapply(1:ncolY, function(x) t(apply(sweep(res$faX, 2 , res$C[x,], "*"), 1, cumsum)))
    res$XYcoef <- lapply(1:ncolY, function(x) t(apply(sweep(res$faX, 2 , res$Yco[x,] / norm.li, "*"), 1, cumsum)))
    names(res$XYcoef) <- colnames(dudiY$tab)
    
    ##  Computing the intercept
    X <- cbind.data.frame(lapply(unclass(ktabX)[1 : nblo], scalewt, wt = dudiY$lw, center = FALSE, scale = scale))
    if (any(apply(X, 2, weighted.mean, w = dudiY$lw) < sqrt(.Machine$double.eps)) == FALSE & scale == TRUE) {
        ## i.e. center=F, scale=T
        meanY <- apply(sweep(as.matrix(dudiY$tab), 2, sqrt(apply(dudiY$tab, 2, varwt, wt = dudiY$lw)), "/"), 2, weighted.mean, w = dudiY$lw)
        meanX <- apply(sweep(as.matrix(X), 2, sqrt(apply(X, 2, varwt, wt = dudiY$lw)), "/"), 2, weighted.mean, w = dudiY$lw)
    } else {
        meanY  <- apply(as.matrix(dudiY$tab), 2, weighted.mean, w = dudiY$lw)
        meanX  <- apply(as.matrix(X), 2, weighted.mean, w = dudiY$lw)    
    }
    res$intercept <- lapply(1:ncolY, function(x)  (meanY[x] - meanX %*% res$XYcoef[[x]]))
    names(res$intercept) <- colnames(dudiY$tab)
    
    ##-----------------------------------------------------------------------
    ##   		Variable and block importances
    ##-----------------------------------------------------------------------

    ## Block importances
    res$bip <- Ak^2
    
    if (nblo == 1 | res$rank ==1)
        res$bipc <- res$bip
    else 
        res$bipc <- t(sweep(apply(sweep(res$bip, 2, res$eig, "*") , 1, cumsum), 1, cumsum(res$eig), "/"))
   
    ## Variable importances
    WcarreAk <- res$faX^2 * res$bip[rep(1:nblo, ktabX$blo),]
    res$vip  <- sweep(WcarreAk, 2, colSums(WcarreAk), "/")
    if (nblo == 1 | res$rank ==1)
        res$vipc <- res$vip
    else 
        res$vipc <- t(sweep(apply(sweep(res$vip, 2, res$eig, "*") , 1, cumsum), 1, cumsum(res$eig), "/"))
    
    ##-----------------------------------------------------------------------
    ##			         Modify the outputs
    ##-----------------------------------------------------------------------
    
    if (scannf == TRUE){
        barplot(res$eig[1:res$rank])
        cat("Select the number of global components: ")
        res$nf <- as.integer(readLines(n = 1))
    }

    if(res$nf > res$rank)
        res$nf <- res$rank
    
    ## keep results for the nf dimensions (except eigenvalues and lX)
    res$eig <- res$eig[1:res$rank]
    res$lX  <- res$lX[, 1:res$rank]
    res$Tfa <- do.call("rbind", res$Tfa)
    res$Tl1 <- do.call("rbind", res$Tl1)
    res$Tli <- do.call("rbind", res$Tli)
    res <- modifyList(res, lapply(res[c("Yc1", "Yco", "lY", "Tfa", "Tl1", "Tli", "cov2", "faX", "vip", "vipc", "bip", "bipc")], function(x) x[, 1:res$nf, drop = FALSE]))
    res$XYcoef <- lapply(res$XYcoef, function(x) x[, 1:res$nf, drop = FALSE])
    res$intercept <- lapply(res$intercept, function(x) x[, 1:res$nf, drop = FALSE])
    res$call <- match.call()
    class(res) <- c("multiblock", "mbpcaiv")
    return(res)
}


