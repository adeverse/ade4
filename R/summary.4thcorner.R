"summary.4thcorner" <-  function(object,...){
  
  cat("Fourth-corner Statistics\n")
  cat("------------------------\n")
  cat("Permutation method ",object$model," (",object$npermut," permutations)\n")
  if(inherits(object, "4thcorner.rlq")){
    cat("trRLQ statistic","\n\n")
    cat("---\n\n")
    print(object$trRLQ)
  } else {
    cat("\nAdjustment method for multiple comparisons:  ", object$tabG$adj.method, "\n")
    
    
    xrand <- object$tabG
    sumry <- list(Test = xrand$names, Stat= xrand$statnames, Obs = xrand$obs, Std.Obs = xrand$expvar[, 1], Alter = xrand$alter)
    sumry <- as.matrix(as.data.frame(sumry))
    if (any(xrand$rep[1] != xrand$rep)) {
      sumry <- cbind(sumry[, 1:4], N.perm = xrand$rep)
    }
    
    sumry <- cbind(sumry, Pvalue = format.pval(xrand$pvalue))
    
    if (xrand$adj.method != "none") {
      sumry <- cbind(sumry, Pvalue.adj = format.pval(xrand$adj.pvalue))
    }
    signifpval <- symnum(xrand$adj.pvalue, corr = FALSE, na = FALSE, cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1), symbols = c("***", "**", "*", ".", " "))
    sumry <- cbind(sumry,signifpval)
    colnames(sumry)[ncol(sumry)] <- " "
    rownames(sumry) <- 1:nrow(sumry)
    
    print(sumry, quote = FALSE, right = TRUE)
    
    cat("\n---\nSignif. codes: ", attr(signifpval, "legend"), "\n")
    invisible(sumry)
  }
  
}

