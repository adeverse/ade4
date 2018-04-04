"randtest.pcaiv" <- function (xtest, nrepet = 99, ...) {
    if (!inherits(xtest, "dudi")) 
        stop("Object of class dudi expected")
    if (!inherits(xtest, "pcaiv")) 
        stop("Type 'pcaiv' expected")
    appel <- as.list(xtest$call)
    dudi1 <- eval.parent(appel$dudi)
    df <- data.frame(eval.parent(appel$df))
    y <- as.matrix(dudi1$tab)
    inertot <- sum(dudi1$eig)
    sqlw <- sqrt(dudi1$lw)
    sqcw <- sqrt(dudi1$cw)
       
    fmla <- as.formula(paste("y ~", paste(names(df), collapse = "+")))
    mf <- model.frame(fmla, data = cbind.data.frame(y, df))
    mt <- attr(mf, "terms")
    x <- model.matrix(mt, mf)
    wt <- outer(sqlw, sqcw)
    ## Fast function for computing sum of squares of the fitted table
    obs <- sum((lm.wfit(y = y,x = x, w = dudi1$lw)$fitted.values * wt)^2) / inertot

    isim <- rep(NA, nrepet)
    for(i in 1:nrepet)
      isim[i] <- sum((lm.wfit(y = y, x = x[sample(nrow(x)), ], w = dudi1$lw)$fitted.values * wt)^2) / inertot
    return(as.randtest(sim = isim, obs = obs, call = match.call(), ...))
  }

