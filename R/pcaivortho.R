"pcaivortho" <- function (dudi, df, scannf = TRUE, nf = 2) {
    lm.pcaiv <- function(x, df, weights, use) {
        if (!inherits(df, "data.frame")) 
            stop("data.frame expected")
        reponse.generic <- x
        begin <- "reponse.generic ~ "
        fmla <- as.formula(paste(begin, paste(names(df), collapse = "+")))
        df <- cbind.data.frame(reponse.generic, df)
        lm0 <- lm(fmla, data = df, weights = weights)
        if (use == 0) 
            return(predict(lm0))
        else if (use == 1) 
            return(residuals(lm0))
        else if (use == -1) 
            return(lm0)
        else stop("Non convenient use")
    }
    if (!inherits(dudi, "dudi")) 
        stop("dudi is not a 'dudi' object")
    df <- data.frame(df)
    if (!inherits(df, "data.frame")) 
        stop("df is not a 'data.frame'")
    if (nrow(df) != length(dudi$lw)) 
        stop("Non convenient dimensions")
    weights <- dudi$lw
    isfactor <- unlist(lapply(as.list(df), is.factor))
    for (i in 1:ncol(df)) {
        if (!isfactor[i]) 
            df[, i] <- scalewt(df[, i], weights)
    }
    tab <- data.frame(apply(dudi$tab, 2, lm.pcaiv, df = df, use = 1, 
        weights = dudi$lw))
    X <- as.dudi(tab, dudi$cw, dudi$lw, scannf = scannf, nf = nf, 
        call = match.call(), type = "pcaivortho")
    X$X <- df
    X$Y <- dudi$tab
    U <- as.matrix(X$c1) * unlist(X$cw)
    U <- as.matrix(dudi$tab) %*% U
    U <- data.frame(U)
    row.names(U) <- row.names(dudi$tab)
    names(U) <- names(X$li)
    X$ls <- U
   
    U <- as.matrix(X$c1) * unlist(X$cw)
    U <- data.frame(t(as.matrix(dudi$c1)) %*% U)
    row.names(U) <- names(dudi$li)
    names(U) <- names(X$li)
    X$as <- U
    return(X)
}


summary.pcaivortho <- function(object, ...){
  thetitle <- "Orthogonal principal component analysis with instrumental variables" 
  cat(thetitle)
  cat("\n\n")
  NextMethod()

  appel <- as.list(object$call)
  dudi <- eval.parent(appel$dudi)

  cat(paste("Total unconstrained inertia (",deparse(appel$dudi),"): ", sep = ""))
  cat(signif(sum(dudi$eig), 4))
  cat("\n\n")

  cat(paste("Inertia of" ,deparse(appel$dudi),"not explained by", deparse(appel$df), "(%): "))
  cat(signif(sum(object$eig) / sum(dudi$eig) * 100, 4))
  cat("\n\n")

  cat("Decomposition per axis:\n")
  sumry <- array(0, c(object$nf, 7), list(1:object$nf, c("iner", "inercum", "inerC", "inercumC", "ratio", "R2", "lambda")))
  sumry[, 1] <- dudi$eig[1:object$nf]
  sumry[, 2] <- cumsum(dudi$eig[1:object$nf])
  varpro <- apply(object$ls, 2, function(x) sum(x * x * object$lw))
  sumry[, 3] <- varpro
  sumry[, 4] <- cumsum(varpro)
  sumry[, 5] <- cumsum(varpro)/cumsum(dudi$eig[1:object$nf])
  sumry[, 6] <- object$eig[1:object$nf]/varpro
  sumry[, 7] <- object$eig[1:object$nf]
  print(sumry, digits = 3)
  invisible(sumry)
 }
