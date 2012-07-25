"pcaiv" <- function (dudi, df, scannf = TRUE, nf = 2) {
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
    tab <- data.frame(apply(dudi$tab, 2, lm.pcaiv, df = df, use = 0, 
        weights = dudi$lw))
    X <- as.dudi(tab, dudi$cw, dudi$lw, scannf = scannf, nf = nf, 
        call = match.call(), type = "pcaiv")
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
    w <- apply(X$ls, 2, function(x) coefficients(lm.pcaiv(x, 
        df, weights, -1)))
    w <- data.frame(w)
    names(w) <- names(X$l1)
    X$fa <- w
    fmla <- as.formula(paste("~ ", paste(names(df), collapse = "+")))
    w <- scalewt(model.matrix(fmla, data = df)[,-1], weights) * weights
    w <- t(w) %*% as.matrix(X$l1)
    w <- data.frame(w)
    X$cor <- w
    return(X)
}

"plot.pcaiv" <- function (x, xax = 1, yax = 2, ...) {
    if (!inherits(x, "pcaiv")) 
        stop("Use only with 'pcaiv' objects")
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
    layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), 
        respect = TRUE)
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    # modif mail P. Giraudoux 25/10/2004
    s.arrow(na.omit(x$fa), xax, yax, sub = "Loadings", csub = 2, 
        clabel = 1.25)
    s.arrow(na.omit(x$cor), xax = xax, yax = yax, sub = "Correlation", 
        csub = 2, clabel = 1.25)
    s.corcircle(x$as, xax, yax, sub = "Inertia axes", csub = 2)
    s.match(x$li, x$ls, xax, yax, clabel = 1.5, sub = "Scores and predictions", 
        csub = 2)
    if (inherits(x, "cca")) 
        s.label(x$co, xax, yax, clabel = 0, cpoint = 3, add.plot = TRUE)
    if (inherits(x, "cca")) 
        s.label(x$co, xax, yax, clabel = 1.25, sub = "Species", 
            csub = 2)
    else s.arrow(x$c1, xax = xax, yax = yax, sub = "Variables", 
        csub = 2, clabel = 1.25)
    scatterutil.eigen(x$eig, wsel = c(xax, yax))
}

"print.pcaiv" <- function (x, ...) {
    if (!inherits(x, "pcaiv")) 
        stop("to be used with 'pcaiv' object")
    cat("Principal Component Analysis with Instrumental Variables\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$rank (rank)     :", x$rank)
    cat("\n$nf (axis saved) :", x$nf)
    cat("\n\neigen values: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n\n")
    else cat("\n\n")
    sumry <- array("", c(3, 4), list(rep("", 3), c("vector", 
        "length", "mode", "content")))
    sumry[1, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), "row weigths (from dudi)")
    sumry[3, ] <- c("$cw", length(x$cw), mode(x$cw), "col weigths (from dudi)")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(3, 4), list(rep("", 3), c("data.frame", 
        "nrow", "ncol", "content")))
    sumry[1, ] <- c("$Y", nrow(x$Y), ncol(x$Y), "Dependant variables")
    sumry[2, ] <- c("$X", nrow(x$X), ncol(x$X), "Explanatory variables")
    sumry[3, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "modified array (projected variables)")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(4, 4), list(rep("", 4), c("data.frame", 
        "nrow", "ncol", "content")))
    sumry[1, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "PPA Pseudo Principal Axes")
    sumry[2, ] <- c("$as", nrow(x$as), ncol(x$as), "Principal axis of dudi$tab on PAP")
    sumry[3, ] <- c("$ls", nrow(x$ls), ncol(x$ls), "projection of lines of dudi$tab on PPA")
    sumry[4, ] <- c("$li", nrow(x$li), ncol(x$li), "$ls predicted by X")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(4, 4), list(rep("", 4), c("data.frame", 
        "nrow", "ncol", "content")))
    sumry[1, ] <- c("$fa", nrow(x$fa), ncol(x$fa), "Loadings (CPC as linear combinations of X")
    sumry[2, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "CPC Constraint Principal Components")
    sumry[3, ] <- c("$co", nrow(x$co), ncol(x$co), "inner product CPC - Y")
    sumry[4, ] <- c("$cor", nrow(x$cor), ncol(x$cor), "correlation CPC - X")
    
    print(sumry, quote = FALSE)
    cat("\n")
   
}

summary.pcaiv <- function(object, ...){
  thetitle <- "Principal component analysis with instrumental variables" 
  cat(thetitle)
  cat("\n\n")
  NextMethod()
    
  appel <- as.list(object$call)
  dudi <- eval.parent(appel$dudi)

  cat(paste("Total unconstrained inertia (",deparse(appel$dudi),"): ", sep = ""))
  cat(signif(sum(dudi$eig), 4))
  cat("\n\n")

  cat(paste("Inertia of" ,deparse(appel$dudi),"explained by", deparse(appel$df), "(%): "))
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
