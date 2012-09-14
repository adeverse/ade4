"randtest.cca" <- function (xtest, nrepet = 99, ...) {
    if (!inherits(xtest, "dudi")) 
        stop("Object of class dudi expected")
    if (!inherits(xtest, "pcaiv")) 
        stop("Type 'cca' expected")
    appel <- as.list(xtest$call)
    df <- as.data.frame(eval.parent(appel$sitenv))
    spe <- eval.parent(appel$sitspe)
    coa1 <- dudi.coa(spe, scannf = FALSE)
    y <- as.matrix(coa1$tab)
    sqlw <- sqrt(coa1$lw)
    sqcw <- sqrt(coa1$cw)
    inertot <- sum(coa1$eig)
    
    fmla <- as.formula(paste("y ~", paste(dimnames(df)[[2]], collapse = "+")))
    mf <- model.frame(fmla,data=cbind.data.frame(y,df))
    mt <- attr(mf,"terms")
    x <- model.matrix(mt,mf)
    wt <- outer(sqlw, sqcw)
    ## Fast function for computing sum of squares of the fitted table 
    obs <- sum((lm.wfit(y = y,x = x, w = coa1$lw)$fitted.values * wt)^2) / inertot
        
    isim <- c()
    for(i in 1:nrepet)
      isim[i] <- sum((lm.wfit(y = y,x = x[sample(nrow(x)),], w = coa1$lw)$fitted.values * wt)^2) / inertot
    return(as.randtest(isim,obs,call=match.call()))
    
 }
