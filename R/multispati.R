"multispati" <- function(dudi, listw, scannf=TRUE, nfposi=2, nfnega=0) {
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
        barplot(res$eig)
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



print.multispati <- function(x, ...)
{
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
        opar <- par(mar = par("mar"))
        on.exit(par(opar))
        m <- length(x$eig)
        par(mar = c(0.8, 2.8, 0.8, 0.8))
        col.w <- rep(grey(1), m) # elles sont toutes blanches
        col.w[1:x$nfposi] <- grey(0.8)
        if (x$nfnega>0) col.w[m:(m-x$nfnega+1)] = grey(0.8)
        j1 <- xax
        if (j1>x$nfposi) j1 = j1-x$nfposi +m -x$nfnega
        j2 <- yax
        if (j2>x$nfposi) j2 = j2-x$nfposi +m -x$nfnega
        col.w[c(j1,j2)] = grey(0)
         barplot(x$eig, col = col.w)
        scatterutil.sub(cha ="Eigen values", csub = 2, possub = "topright")
    }
    
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    layout(matrix(c(3, 3, 1, 3, 3, 2), 3, 2))
    par(mar = c(0.2, 0.2, 0.2, 0.2))
    f1()
    s.arrow(x$c1, xax = xax, yax = yax, sub = "Canonical weights", 
        csub = 2, clabel = 1.25)
    s.match(x$li, x$ls, xax = xax, yax = yax, sub = "Scores and lag scores", csub = 2, clabel = 0.75) 
 
}
