"print.4thcorner" <-
  function(x,varQ = 1:length(x$varnames.Q), varR = 1:length(x$varnames.R), stat = c("D","D2"), ...){
    
    stat <- match.arg(stat)
    if(!inherits(x, "4thcorner.rlq")){
      if(stat=="D"){
        xrand <-  x$tabD
      } else {
        xrand <-  x$tabD2
      }
      idx.colR <- which(x$assignR %in% varR)
      idx.colQ <- which(x$assignQ %in% varQ)
      idx.vars <- sort(as.vector(outer(X = idx.colQ, Y = idx.colR, function(X,Y) length(x$assignR) * (X - 1) + Y)))
    } else {
      xrand <- x$tabG
      idx.vars <- 1:length(xrand$names)
    }
    
    cat("Fourth-corner Statistics\n")
    cat("------------------------\n")
    cat("Permutation method ",x$model," (",x$npermut," permutations)\n")
    cat("\nAdjustment method for multiple comparisons:  ", xrand$adj.method, "\n")
    cat("call: ",deparse(x$call),"\n\n")
    cat("---\n\n")
    
    ## idx.vars <- length(x$assignR) * (idx.colQ - 1) + idx.colR
    
    sumry <- list(Test = xrand$names, Stat= xrand$statnames, Obs = xrand$obs, Std.Obs = xrand$expvar[, 1], Alter = xrand$alter)
    sumry <- as.matrix(as.data.frame(sumry))
    if (any(xrand$rep[1] != xrand$rep)) {
      sumry <- cbind(sumry[, 1:4], N.perm = xrand$rep)
    }
    
    sumry <- cbind(sumry, Pvalue = xrand$pvalue)
    if (xrand$adj.method != "none") 
      sumry <- cbind(sumry, Pvalue.adj = xrand$adj.pvalue)
    signifpval <- symnum(xrand$adj.pvalue, corr = FALSE, na = FALSE, cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1), symbols = c("***", "**", "*", ".", " "))
    sumry <- cbind(sumry,signifpval)
    colnames(sumry)[ncol(sumry)] <- " "
    sumry <- sumry[idx.vars, , drop = FALSE]
    rownames(sumry) <- 1:nrow(sumry)
    
    print(sumry, quote = FALSE, right = TRUE)
    cat("\n---\nSignif. codes: ", attr(signifpval, "legend"), "\n")
    invisible(sumry)
  }
