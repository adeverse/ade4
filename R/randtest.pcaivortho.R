"randtest.pcaivortho" <- function (xtest, nrepet = 99, ...) {
    if (!inherits(xtest, "dudi")) 
        stop("Object of class dudi expected")
    if (!inherits(xtest, "pcaivortho")) 
        stop("Type 'pcaivortho' expected")
    appel <- as.list(xtest$call)
    dudi1 <- eval.parent(appel$dudi)
    df <- as.data.frame(eval.parent(appel$df))
    y <- as.matrix(dudi1$tab)
    inertot <- sum(dudi1$eig)
    sqlw <- sqrt(dudi1$lw)
    sqcw <- sqrt(dudi1$cw)
    
    
    fmla <- as.formula(paste("y ~", paste(dimnames(df)[[2]], collapse = "+")))
    mf <- model.frame(fmla,data=cbind.data.frame(y,df))
    mt <- attr(mf,"terms")
    x <- model.matrix(mt,mf)
    wt <- outer(sqlw, sqcw)
    ## Fast function for computing sum of squares of the fitted table
    obs <- sum((lm.wfit(y = y,x = x, w = dudi1$lw)$residuals * wt)^2) / inertot
    isim <- c()
    for(i in 1:nrepet)
      isim[i] <-  sum((lm.wfit(y = y,x = x[sample(nrow(x)),], w = dudi1$lw)$residuals * wt)^2) / inertot
    
    return(as.randtest(isim,obs,call=match.call()))
    
  }

