betweencoinertia <-
function (obj, fac, scannf = TRUE, nf = 2) 
{
  if (!inherits(obj, "coinertia")) 
    stop("Object of class coinertia expected")
  if (!is.factor(fac)) 
    stop("factor expected")
  appel <- as.list(obj$call)    
  dudiX <- eval(appel$dudiX, sys.frame(0))
  dudiY <- eval(appel$dudiY, sys.frame(0))
  ligX <- nrow(dudiX$tab)
  if (length(fac) != ligX) 
    stop("Non convenient dimension")
  
  mean.w <- function(x, w, fac, cla.w) {
    z <- x * w
    z <- tapply(z, fac, sum)/cla.w
    return(z)
  }
  cla.w <- tapply(dudiX$lw, fac, sum)
  tabmoyX <- apply(dudiX$tab, 2, mean.w, w = dudiX$lw, fac = fac, 
                   cla.w = cla.w)
  tabmoyX <- data.frame(tabmoyX)
  row.names(tabmoyX) <- levels(fac)
  names(tabmoyX) <- names(dudiX$tab)
  tabmoyY <- apply(dudiY$tab, 2, mean.w, w = dudiY$lw, fac = fac, 
                   cla.w = cla.w)
  tabmoyY <- data.frame(tabmoyY)    
  row.names(tabmoyY) <- levels(fac)
  names(tabmoyY) <- names(dudiY$tab)
  dudimoyX <- as.dudi(tabmoyX, dudiX$cw, as.vector(cla.w), scannf = FALSE, 
                      nf = nf, call = match.call(), type = "bet")
  dudimoyY <- as.dudi(tabmoyY, dudiY$cw, as.vector(cla.w), scannf = FALSE, 
                      nf = nf, call = match.call(), type = "coa")
  X <- coinertia(dudimoyX, dudimoyY, scannf = scannf, 
                 nf = nf)
  X$call <- match.call()
  ## cov=covB+covW, donc ce n'est pas vrai pour les carres et donc la coinertie
  ##X$ratio <- sum(X$eig)/sum(obj$eig)
  U <- as.matrix(X$l1) * unlist(X$lw)
  U <- data.frame(as.matrix(dudiY$tab) %*% U)
  row.names(U) <- row.names(dudiY$tab)
  names(U) <- names(X$lY)
  X$lsY <- U
  
  U <- as.matrix(X$c1) * unlist(X$cw)
  U <- data.frame(as.matrix(dudiX$tab) %*% U)
  row.names(U) <- row.names(dudiX$tab)
  names(U) <- names(X$lX)
  X$lsX <- U
  
  ratioX<-unlist(X$mX[1,]/X$lX[1,])
  X$msX<-data.frame(t(t(X$lsX)*ratioX))
  row.names(X$msX) <- row.names(X$lsX)
  names(X$msX) <- names(X$mX)

  ratioY<-unlist(X$mY[1,]/X$lY[1,])
  X$msY<-data.frame(t(t(X$lsY)*ratioY))
  row.names(X$msY) <- row.names(X$lsY)
  names(X$msY) <- names(X$mY)

  U <- as.matrix(X$l1) * unlist(X$lw)
  U <- data.frame(t(as.matrix(obj$l1)) %*% U)
  row.names(U) <- paste("AxcY", (1:obj$nf), sep = "")
  names(U) <- paste("AxbcY", (1:X$nf), sep = "")
  X$acY <- U
  names(X$aY)<-names(X$lY)<-names(X$lsY)<-names(X$acY)
  
  U <- as.matrix(X$c1) * unlist(X$cw)
  U <- data.frame(t(as.matrix(obj$c1)) %*% U)
  row.names(U) <- paste("AxcX", (1:obj$nf), sep = "")
  names(U) <- paste("AxbcX", (1:X$nf), sep = "")
  X$acX <- U 
  names(X$aX)<-names(X$lX)<-names(X$lsX)<-names(X$acX)
  
  class(X) <- c("betcoi", "dudi")
  return(X)
}

plot.betcoi <-
function(x, xax = 1, yax = 2, ...) {
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
  fac <- eval(appel$fac, sys.frame(0))
  def.par <- par(no.readonly = TRUE)
  on.exit(par(def.par))
  nf <- layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3),
               respect = TRUE)
  par(mar = c(0.1, 0.1, 0.1, 0.1))
  s.arrow(x$aX, xax, yax, sub = "X axes", csub = 2, clab = 1.25)
  s.arrow(x$aY, xax, yax, sub = "Y axes", csub = 2, clab = 1.25)
  scatterutil.eigen(x$eig, wsel = c(xax, yax))
  s.match.class(df1xy=x$msX,df2xy=x$msY,fac=fac,clab=1.5) # wt?
  
  s.arrow(x$l1, xax = xax, yax = yax, sub = "Y Canonical weights",
          csub = 2, clab = 1.25)
  s.arrow(x$c1, xax = xax, yax = yax, sub = "X Canonical weights",
          csub = 2, clab = 1.25)
  
}

print.betcoi <-
function (x, ...) 
{
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
  cat("\n\neigen values: ")
  l0 <- length(x$eig)
  cat(signif(x$eig, 4)[1:(min(5, l0))])
  if (l0 > 5) 
    cat(" ...\n\n")
  else cat("\n\n")
  sumry <- array("", c(3, 4), list(1:3, c("vector", "length", 
                                          "mode", "content")))
  sumry[1, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
  sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), "row weigths (crossed array)")
  sumry[3, ] <- c("$cw", length(x$cw), mode(x$cw), "col weigths (crossed array)")
  class(sumry) <- "table"
  print(sumry)
  cat("\n")
  sumry <- array("", c(17, 4), list(1:17, c("data.frame", "nrow", 
                                            "ncol", "content")))
  sumry[1, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "crossed array (CA)")
  sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), "Y col = CA row: coordinates")
  sumry[3, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "Y col = CA row: normed scores")
  sumry[4, ] <- c("$co", nrow(x$co), ncol(x$co), "X col = CA column: coordinates")
  sumry[5, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "X col = CA column: normed scores")
  sumry[6, ] <- c("$lX", nrow(x$lX), ncol(x$lX), "class coordinates (X)")
  sumry[7, ] <- c("$mX", nrow(x$mX), ncol(x$mX), "normed class scores (X)")
  sumry[8, ] <- c("$lY", nrow(x$lY), ncol(x$lY), "class coordinates (Y)")
  sumry[9, ] <- c("$mY", nrow(x$mY), ncol(x$mY), "normed class scores (Y)")

  sumry[10, ] <- c("$lsX", nrow(x$lsX), ncol(x$lsX), "row coordinates (X)")
  sumry[11, ] <- c("$msX", nrow(x$msX), ncol(x$msX), "normed row scores (X)")
  sumry[12, ] <- c("$lsY", nrow(x$lsY), ncol(x$lsY), "row coordinates (Y)")
  sumry[13, ] <- c("$msY", nrow(x$msY), ncol(x$msY), "normed row scores (Y)")
  sumry[14, ] <- c("$aX", nrow(x$aX), ncol(x$aX),
                   "between axis onto between co-inertia axis (X)")
  sumry[15, ] <- c("$aY", nrow(x$aY), ncol(x$aY),
                   "between axis onto between co-inertia axis (Y)")
  sumry[16, ] <- c("$acX", nrow(x$acX), ncol(x$acX),
                   "co-inertia axis onto between co-inertia axis (X)")
  sumry[17, ] <- c("$acY", nrow(x$acY), ncol(x$acY),
                   "co-inertia axis onto between co-inertia axis (Y)")
  
  class(sumry) <- "table"
  print(sumry)
  cat("\n")
}

