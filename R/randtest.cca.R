"randtest.cca" <- function (xtest, nrepet = 99, ...) {
    if (!inherits(xtest, "dudi")) 
        stop("Object of class dudi expected")
    if (!inherits(xtest, "pcaiv")) 
        stop("Type 'cca' expected")
    appel <- as.list(xtest$call)
    df <- eval.parent(appel$sitenv)
    spe <- eval.parent(appel$sitspe)
    coa1 <- dudi.coa(spe, scannf = FALSE)
    y <- as.matrix(coa1$tab)
    sqlw <- sqrt(coa1$lw)
    sqcw <- sqrt(coa1$cw)
    inertot <- sum(coa1$eig)
    ## Fast function for computing sum of squares of the fitted table from routines 'dqrls{base}'. 
    lmwfit <- function(y,x,sqlw,sqcw) {
      n <- nrow(x)
      p <- ncol(x)
      ny <- NCOL(y)
      storage.mode(y) <- "double"
      z <- .Fortran("dqrls",qr=x*sqlw,n=n,p=p,y=y*sqlw,ny=ny,tol=1e-07,coefficients=mat.or.vec(p,ny),residuals=y,effects=mat.or.vec(n,ny),rank =integer(1),pivot=1:p,qraux=double(p),work=double(2*p), PACKAGE="base")
      tab <- sqlw*y-z$residuals
      tab <- sweep(tab,2,sqcw,"*")
      return(sum(tab^2))
    }
    
    fmla <- as.formula(paste("y ~", paste(dimnames(df)[[2]], collapse = "+")))
    mf <- model.frame(fmla,data=cbind.data.frame(y,df))
    mt <- attr(mf,"terms")
    x <- model.matrix(mt,mf)
    obs <- lmwfit(y,x,sqlw,sqcw)/inertot
    isim <- c()
    for(i in 1:nrepet)
      isim[i] <- lmwfit(y,x[sample(nrow(x)),],sqlw,sqcw)/inertot
    return(as.randtest(isim,obs,call=match.call()))
    
 }
