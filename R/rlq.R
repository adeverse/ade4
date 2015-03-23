"plot.rlq" <- function (x, xax = 1, yax = 2, ...) {
  if (!inherits(x, "rlq")) 
    stop("Use only with 'rlq' objects")
  if (x$nf == 1) {
    warnings("One axis only : not yet implemented")
    return(invisible())
  }
  if (xax > x$nf) 
    stop("Non convenient xax")
  if (yax > x$nf) 
    stop("Non convenient yax")
  def.par <- par(no.readonly = TRUE)
  on.exit(par(def.par))
  layout(matrix(c(1, 1, 3, 1, 1, 4, 2, 2,5,2,2,6,8,8,7), 3, 5), 
         respect = TRUE)
  par(mar = c(0.1, 0.1, 0.1, 0.1))
  s.label(x$lR[, c(xax, yax)], sub = "R row scores",csub = 2,clabel = 1.25)
  s.label(x$lQ[, c(xax, yax)], sub = "Q row scores",csub = 2,clabel = 1.25)
  s.corcircle(x$aR, xax, yax, sub = "R axes", csub = 2, clabel = 1.25)
  s.arrow(x$l1, xax = xax, yax = yax, sub = "R Canonical weights", csub = 2, clabel = 1.25)
  s.arrow(x$c1, xax = xax, yax = yax, sub = "Q Canonical weights", csub = 2, clabel = 1.25)
  s.corcircle(x$aQ, xax, yax, sub = "Q axes", csub = 2, clabel = 1.25)
  scatterutil.eigen(x$eig, wsel = c(xax, yax))
}

"print.rlq" <- function (x, ...) {
  if (!inherits(x, "rlq")) 
    stop("to be used with 'rlq' object")
  cat("RLQ analysis\n")
  cat("call: ")
  print(x$call)
  cat("class: ")
  cat(class(x), "\n")
  cat("\n$rank (rank)     :", x$rank)
  cat("\n$nf (axis saved) :", x$nf)
  ## cat("\n$RV (RV coeff)   :", x$RV)
  cat("\n\neigen values: ")
  l0 <- length(x$eig)
  cat(signif(x$eig, 4)[1:(min(5, l0))])
  if (l0 > 5) 
    cat(" ...\n\n")
  else cat("\n\n")
  sumry <- array("", c(3, 4), list(1:3, c("vector", "length", 
                                          "mode", "content")))
  sumry[1, ] <- c("$eig", length(x$eig), mode(x$eig), "Eigenvalues")
  sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), paste("Row weigths (for", x$call[[2]], "cols)"))
  sumry[3, ] <- c("$cw", length(x$cw), mode(x$cw), paste("Col weigths (for", x$call[[4]], "cols)"))
  
  print(sumry, quote = FALSE)
  cat("\n")
  sumry <- array("", c(11, 4), list(1:11, c("data.frame", "nrow", 
                                            "ncol", "content")))
  sumry[1, ] <- c("$tab", nrow(x$tab), ncol(x$tab), paste("Crossed Table (CT): cols(", x$call[[2]], ") x cols(", x$call[[4]], ")", sep=""))
  sumry[2, ] <- c("$li", nrow(x$li), ncol(x$li), paste("CT row scores (cols of ", x$call[[2]], ")", sep=""))
  sumry[3, ] <- c("$l1", nrow(x$l1), ncol(x$l1), paste("Principal components (loadings for ", x$call[[2]], " cols)", sep=""))
  sumry[4, ] <- c("$co", nrow(x$co), ncol(x$co), paste("CT col scores (cols of ", x$call[[4]], ")", sep=""))
  sumry[5, ] <- c("$c1", nrow(x$c1), ncol(x$c1), paste("Principal axes (loadings for ", x$call[[4]], " cols)", sep=""))
  sumry[6, ] <- c("$lR", nrow(x$lR), ncol(x$lR), paste("Row scores (rows of ", x$call[[2]], ")", sep=""))
  sumry[7, ] <- c("$mR", nrow(x$mR), ncol(x$mR), paste("Normed row scores (rows of ", x$call[[2]], ")", sep=""))
  sumry[8, ] <- c("$lQ", nrow(x$lQ), ncol(x$lQ), paste("Row scores (rows of ", x$call[[4]], ")", sep=""))
  sumry[9, ] <- c("$mQ", nrow(x$mQ), ncol(x$mQ), paste("Normed row scores (rows of ", x$call[[4]], ")", sep=""))
  sumry[10, ] <- c("$aR", nrow(x$aR), ncol(x$aR), paste("Corr ", x$call[[2]], " axes / rlq axes", sep=""))
  sumry[11, ] <- c("$aQ", nrow(x$aQ), ncol(x$aQ),  paste("Corr ", x$call[[3]], " axes / coinertia axes", sep=""))
  
  print(sumry, quote = FALSE)
  cat("\n")
}

"rlq" <- function( dudiR, dudiL, dudiQ , scannf = TRUE, nf = 2) {
  
  normalise.w <- function(X, w) {
    f2 <- function(v) sqrt(sum(v * v * w)/sum(w))
    norm <- apply(X, 2, f2)
    X <- sweep(X, 2, norm, "/")
    return(X)
  }
  
  if (!inherits(dudiR, "dudi")) 
    stop("Object of class dudi expected")
  lig1 <- nrow(dudiR$tab)
  
  if (!inherits(dudiL, "dudi")) 
    stop("Object of class dudi expected")
  if (!inherits(dudiL, "coa")) 
    stop("dudi.coa expected for table L")
  lig2 <- nrow(dudiL$tab)
  col2 <- ncol(dudiL$tab)
  if (!inherits(dudiQ, "dudi")) 
    stop("Object of class dudi expected")
  lig3 <- nrow(dudiQ$tab)

  if (lig1 != lig2) 
    stop("Non equal row numbers")
  if (any((dudiR$lw - dudiL$lw)^2 > 1e-07)) 
    stop("Non equal row weights")
  if (col2 != lig3) 
    stop("Non equal row numbers")
  if (any((dudiL$cw - dudiQ$lw)^2 > 1e-07)) 
    stop("Non equal row weights")
  tabcoiner <- t(as.matrix(dudiR$tab)) %*% diag(dudiL$lw) %*% (as.matrix(dudiL$tab)) %*% diag(dudiL$cw) %*% (as.matrix(dudiQ$tab))
  tabcoiner <- data.frame(tabcoiner)
  names(tabcoiner) <- names(dudiQ$tab)
  row.names(tabcoiner) <- names(dudiR$tab)
  if (nf > dudiR$nf) 
    nf <- dudiR$nf
  if (nf > dudiQ$nf) 
    nf <- dudiQ$nf
  coi <- as.dudi(tabcoiner, dudiQ$cw, dudiR$cw, scannf = scannf, nf = nf, call = match.call(), type = "rlq")
  U <- as.matrix(coi$c1) * unlist(coi$cw)
  U <- data.frame(as.matrix(dudiQ$tab) %*% U)
  row.names(U) <- row.names(dudiQ$tab)
  names(U) <- paste("AxcQ", (1:coi$nf), sep = "")
  coi$lQ <- U
  U <- normalise.w(U, dudiQ$lw)
  row.names(U) <- row.names(dudiQ$tab)
  names(U) <- paste("NorS", (1:coi$nf), sep = "")
  coi$mQ <- U
  U <- as.matrix(coi$l1) * unlist(coi$lw)
  U <- data.frame(as.matrix(dudiR$tab) %*% U)
  row.names(U) <- row.names(dudiR$tab)
  names(U) <- paste("AxcR", (1:coi$nf), sep = "")
  coi$lR <- U
  U <- normalise.w(U, dudiR$lw)
  row.names(U) <- row.names(dudiR$tab)
  names(U) <- paste("NorS", (1:coi$nf), sep = "")
  coi$mR <- U
  U <- as.matrix(coi$c1) * unlist(coi$cw)
  U <- data.frame(t(as.matrix(dudiQ$c1)) %*% U)
  row.names(U) <- paste("Ax", (1:dudiQ$nf), sep = "")
  names(U) <- paste("AxcQ", (1:coi$nf), sep = "")
  coi$aQ <- U
  U <- as.matrix(coi$l1) * unlist(coi$lw)
  U <- data.frame(t(as.matrix(dudiR$c1)) %*% U)
  row.names(U) <- paste("Ax", (1:dudiR$nf), sep = "")
  names(U) <- paste("AxcR", (1:coi$nf), sep = "")
  coi$aR <- U
  ## remove RV which is probably wrong or at least not defined
  ## RV <- sum(coi$eig)/sqrt(sum(dudiQ$eig^2))/sqrt(sum(dudiR$eig^2))
  ## coi$RV <- RV
  return(coi)
  
}

"summary.rlq" <- function (object, ...) {
  if (!inherits(object, "rlq")) 
    stop("to be used with 'rlq' object")

  thetitle <- "RLQ analysis" 
  cat(thetitle)
  cat("\n\n")
  NextMethod()
  
  appel <- as.list(object$call)
  dudiL <- eval.parent(appel$dudiL)
  dudiR <- eval.parent(appel$dudiR)
  dudiQ <- eval.parent(appel$dudiQ)
  norm.w <- function(X, w) {
    f2 <- function(v) sqrt(sum(v * v * w)/sum(w))
    norm <- apply(X, 2, f2)
    return(norm)
  }
  util <- function(n) {
    return(sapply(1:n, function(x) paste(1:x, collapse = "")))
  }
  eig <- object$eig[1:object$nf]
  covar <- sqrt(eig)
  sdR <- norm.w(object$lR, dudiR$lw)
  sdQ <- norm.w(object$lQ, dudiQ$lw)
  corr <- covar/sdR/sdQ
  U <- cbind.data.frame(eig, covar, sdR, sdQ, corr)
  row.names(U) <- as.character(1:object$nf)
  res <- list(EigDec = U)
  cat("\nEigenvalues decomposition:\n")
  print(U)
  cat(paste("\nInertia & coinertia R (", deparse(appel$dudiR),"):\n", sep=""))
  inertia <- cumsum(sdR^2)
  max <- cumsum(dudiR$eig[1:object$nf])
  ratio <- inertia/max
  U <- cbind.data.frame(inertia, max, ratio)
  row.names(U) <- util(object$nf)
  res$InerR <- U
  print(U)
  cat(paste("\nInertia & coinertia Q (", deparse(appel$dudiR),"):\n", sep=""))
  inertia <- cumsum(sdQ^2)
  max <- cumsum(dudiQ$eig[1:object$nf])
  ratio <- inertia/max
  U <- cbind.data.frame(inertia, max, ratio)
  row.names(U) <- util(object$nf)
  res$InerQ <- U
  print(U)
  cat(paste("\nCorrelation L (", deparse(appel$dudiL),"):\n", sep=""))
  max <- sqrt(dudiL$eig[1:object$nf])
  ratio <- corr/max
  U <- cbind.data.frame(corr, max, ratio)
  row.names(U) <- 1:object$nf
  res$CorL <- U
  print(U)
}

