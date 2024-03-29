bca.coinertia <- function (x, fac, scannf = TRUE, nf = 2, ...) {
  if (!inherits(x, "coinertia")) 
    stop("Xect of class coinertia expected")
  if (!is.factor(fac)) 
    stop("factor expected")
  appel <- as.list(x$call)    
  dudiX <- eval.parent(appel$dudiX)
  dudiY <- eval.parent(appel$dudiY)
  ligX <- nrow(dudiX$tab)
  if (length(fac) != ligX) 
    stop("Non convenient dimension")
  
  mean.w <- function(x, w, fac, cla.w) {
    z <- x * w
    z <- tapply(z, fac, sum)/cla.w
    return(z)
  }
  cla.w <- tapply(dudiX$lw, fac, sum)
  tabmoyX <- apply(dudiX$tab, 2, mean.w, w = dudiX$lw, fac = fac, cla.w = cla.w)
  tabmoyX <- data.frame(tabmoyX)
  row.names(tabmoyX) <- levels(fac)
  names(tabmoyX) <- names(dudiX$tab)
  tabmoyY <- apply(dudiY$tab, 2, mean.w, w = dudiY$lw, fac = fac, cla.w = cla.w)
  tabmoyY <- data.frame(tabmoyY)    
  row.names(tabmoyY) <- levels(fac)
  names(tabmoyY) <- names(dudiY$tab)
  dudimoyX <- as.dudi(tabmoyX, dudiX$cw, as.vector(cla.w), scannf = FALSE, 
                      nf = nf, call = match.call(), type = "bet")
  dudimoyY <- as.dudi(tabmoyY, dudiY$cw, as.vector(cla.w), scannf = FALSE, 
                      nf = nf, call = match.call(), type = "coa")
  res <- coinertia(dudimoyX, dudimoyY, scannf = scannf, nf = nf)
  res$call <- match.call()
  ## cov=covB+covW, donc ce n'est pas vrai pour les carres et donc la coinertie
  ##res$ratio <- sum(res$eig)/sum(x$eig)
  U <- as.matrix(res$l1) * unlist(res$lw)
  U <- data.frame(as.matrix(dudiY$tab) %*% U)
  row.names(U) <- row.names(dudiY$tab)
  names(U) <- names(res$lY)
  res$lsY <- U
  
  U <- as.matrix(res$c1) * unlist(res$cw)
  U <- data.frame(as.matrix(dudiX$tab) %*% U)
  row.names(U) <- row.names(dudiX$tab)
  names(U) <- names(res$lX)
  res$lsX <- U
  
  ratioX<-unlist(res$mX[1,]/res$lX[1,])
  res$msX<-data.frame(t(t(res$lsX)*ratioX))
  row.names(res$msX) <- row.names(res$lsX)
  names(res$msX) <- names(res$mX)
  
  ratioY<-unlist(res$mY[1,]/res$lY[1,])
  res$msY<-data.frame(t(t(res$lsY)*ratioY))
  row.names(res$msY) <- row.names(res$lsY)
  names(res$msY) <- names(res$mY)
  
  U <- as.matrix(res$l1) * unlist(res$lw)
  U <- data.frame(t(as.matrix(x$l1)) %*% U)
  row.names(U) <- paste("AxcY", (1:x$nf), sep = "")
  names(U) <- paste("AxbcY", (1:res$nf), sep = "")
  res$acY <- U
  names(res$aY)<-names(res$lY)<-names(res$lsY)<-names(res$acY)
  
  U <- as.matrix(res$c1) * unlist(res$cw)
  U <- data.frame(t(as.matrix(x$c1)) %*% U)
  row.names(U) <- paste("AxcX", (1:x$nf), sep = "")
  names(U) <- paste("AxbcX", (1:res$nf), sep = "")
  res$acX <- U 
  names(res$aX)<-names(res$lX)<-names(res$lsX)<-names(res$acX)
  
  class(res) <- c("betcoi", "dudi")
  return(res)
}

plot.betcoi <- function(x, xax = 1, yax = 2, ...) {
  if (!inherits(x, "betcoi"))
    stop("Use only with 'betcoi' objects")
  if (x$nf == 1) {
    warnings("One axis only : not yet implemented")
    return(invisible())
  }
  if (xax > x$nf)
    stop("Non convenient xax")
  if (yax > x$nf)
    stop("Non convenient yax")
  appel <- as.list(x$call)
  fac <- eval.parent(appel$fac)
  def.par <- graphics::par(no.readonly = TRUE)
  on.exit(graphics::par(def.par))
  nf <- graphics::layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), respect = TRUE)
  graphics::par(mar = c(0.1, 0.1, 0.1, 0.1))
  s.arrow(x$aX, xax, yax, sub = "X axes", csub = 2, clabel = 1.25)
  s.arrow(x$aY, xax, yax, sub = "Y axes", csub = 2, clabel = 1.25)
  scatterutil.eigen(x$eig, wsel = c(xax, yax))
  s.match.class(df1xy = x$msX, df2xy = x$msY, fac = fac, clabel = 1.5) # wt?
  
  s.arrow(x$l1, xax = xax, yax = yax, sub = "Y Canonical weights", csub = 2, clabel = 1.25)
  s.arrow(x$c1, xax = xax, yax = yax, sub = "X Canonical weights", csub = 2, clabel = 1.25)
}

print.betcoi <- function (x, ...) {
  if (!inherits(x, "betcoi")) 
    stop("to be used with 'betcoi' object")
  cat("Between coinertia analysis\n")
  cat("call: ")
  print(x$call)
  cat("class: ")
  cat(class(x), "\n")
  cat("\n$rank (rank)     :", x$rank)
  cat("\n$nf (axis saved) :", x$nf)
  cat("\n$RV (RV coeff)   :", x$RV)
  cat("\n\neigenvalues: ")
  l0 <- length(x$eig)
  cat(signif(x$eig, 4)[1:(min(5, l0))])
  if (l0 > 5) 
    cat(" ...\n\n")
  else cat("\n\n")
  sumry <- array("", c(3, 4), list(1:3, c("vector", "length", "mode", "content")))
  sumry[1, ] <- c("$eig", length(x$eig), mode(x$eig), "Eigenvalues")
  sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), paste("Row weigths (for ", eval(x$call[[2]])$call[[3]], " cols)", sep=""))
  sumry[3, ] <- c("$cw", length(x$cw), mode(x$cw), paste("Col weigths (for ", eval(x$call[[2]])$call[[2]], " cols)", sep=""))
  
  print(sumry, quote = FALSE)
  cat("\n")
  sumry <- array("", c(17, 4), list(1:17, c("data.frame", "nrow", "ncol", "content")))
  sumry[1, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "Crossed Table (CT)")
  sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), paste("CT row scores (cols of ", eval(x$call[[2]])$call[[3]], ")", sep=""))
  sumry[3, ] <- c("$l1", nrow(x$l1), ncol(x$l1), paste("CT normed row scores (cols of ", eval(x$call[[2]])$call[[3]], ")", sep=""))
  sumry[4, ] <- c("$co", nrow(x$co), ncol(x$co), paste("CT col scores (cols of ", eval(x$call[[2]])$call[[2]], ")", sep=""))
  sumry[5, ] <- c("$c1", nrow(x$c1), ncol(x$c1), paste("CT normed col scores (cols of ", eval(x$call[[2]])$call[[2]], ")", sep=""))
  sumry[6, ] <- c("$lX", nrow(x$lX), ncol(x$lX), paste("Class scores (for ", eval(x$call[[2]])$call[[2]], ")", sep=""))
  sumry[7, ] <- c("$mX", nrow(x$mX), ncol(x$mX), paste("Normed class scores (for ", eval(x$call[[2]])$call[[2]], ")", sep=""))
  sumry[8, ] <- c("$lY", nrow(x$lY), ncol(x$lY), paste("Class scores (for ", eval(x$call[[2]])$call[[3]], ")", sep=""))
  sumry[9, ] <- c("$mY", nrow(x$mY), ncol(x$mY), paste("Normed class scores (for ", eval(x$call[[2]])$call[[3]], ")", sep=""))
  sumry[10, ] <- c("$lsX", nrow(x$lsX), ncol(x$lsX), paste("Row scores (rows of ", eval(x$call[[2]])$call[[2]], ")", sep=""))
  sumry[11, ] <- c("$msX", nrow(x$msX), ncol(x$msX), paste("Normed row scores (rows of ", eval(x$call[[2]])$call[[2]], ")", sep=""))
  sumry[12, ] <- c("$lsY", nrow(x$lsY), ncol(x$lsY), paste("Row scores (rows of ", eval(x$call[[2]])$call[[3]], ")", sep=""))
  sumry[13, ] <- c("$msY", nrow(x$msY), ncol(x$msY), paste("Normed row scores (rows of ", eval(x$call[[2]])$call[[3]], ")", sep=""))
  sumry[14, ] <- c("$aX", nrow(x$aX), ncol(x$aX), paste("Corr ", eval(x$call[[2]])$call[[2]], " axes / betcoi axes", sep=""))
  sumry[15, ] <- c("$aY", nrow(x$aY), ncol(x$aY), paste("Corr ", eval(x$call[[2]])$call[[3]], " axes / betcoi axes", sep=""))
  sumry[16, ] <- c("$acX", nrow(x$acX), ncol(x$acX), paste("Corr ", eval(x$call[[2]])$call[[2]], " coinertia axes / betcoi axes", sep=""))
  sumry[17, ] <- c("$acY", nrow(x$acY), ncol(x$acY), paste("Corr ", eval(x$call[[2]])$call[[3]], " coinertia axes / betcoi axes", sep=""))
  
  print(sumry, quote = FALSE)
  cat("\n")
}
