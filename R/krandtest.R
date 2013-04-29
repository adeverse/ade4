"as.krandtest" <- function (sim, obs, alter="greater", call = match.call(),names = colnames(sim), p.adjust.method = "none") {
  res <- list(sim = sim, obs = obs)
  if(length(obs)!=length(alter))
    alter <- rep(alter,length = length(obs))
  res$alter <- alter
  ## Invalid permutations are stored as NA
  res$rep <- apply(sim, 2, function(x) length(na.omit(x)))
  res$ntest <- length(obs)
  res$expvar <- data.frame(matrix(0, res$ntest, 3))
  if(!is.null(names)){
    res$names <- names
  } else {
    res$names <- paste("test", 1:res$ntest, sep="")
  }
  
  names(res$expvar) <- c("Std.Obs","Expectation","Variance")
  res$pvalue <- rep(0,length(obs))
  for(i in 1:length(obs)){
    vec.sim <- na.omit(sim[,i])

    res$alter[i] <- match.arg(res$alter[i], c("greater", "less", "two-sided"))
    res$expvar[i,1] <- (res$obs[i] - mean(vec.sim)) / sd(vec.sim)
    res$expvar[i,2] <- mean(vec.sim)
    res$expvar[i,3] <- sd(vec.sim)
    
    if(res$alter[i]=="greater"){
      res$pvalue[i] <- (sum(vec.sim >= obs[i]) + 1)/(res$rep[i] + 1)
    }
    else if(res$alter[i]=="less"){
      res$pvalue[i] <- (sum(vec.sim <= obs[i]) + 1)/(res$rep[i] + 1)
    }
    else if(res$alter[i]=="two-sided") {
      sim0 <- abs(vec.sim - mean(vec.sim))
      obs0 <- abs(obs[i] - mean(vec.sim))
      res$pvalue[i] <- (sum(sim0 >= obs0) + 1) / (res$rep[i] +1)
    }
  }
  p.adjust.method <- match.arg(p.adjust.method, p.adjust.methods)
  res$adj.pvalue <- p.adjust(res$pvalue, method = p.adjust.method)
  res$adj.method <- p.adjust.method
  res$call <- call
  class(res) <- "krandtest"
  return(res)
}


"plot.krandtest" <- function (x, mfrow = NULL, nclass = NULL, main.title = x$names, ...) {
  if (!inherits(x, "krandtest")) 
    stop("to be used with 'krandtest' object")
  if (is.null(mfrow))
    mfrow = n2mfrow(x$ntest)
  def.par <- par(no.readonly = TRUE)
  on.exit(par(def.par))
  par(mfrow = mfrow)
  par(mar = c(3.1, 2.5, 2.1, 2.1))
  if (length(main.title)!=length(x$names)) 
    main.title <- x$names
  for (k in 1:x$ntest) {
    plot.randtest(as.randtest(x$sim[,k], x$obs[k],call = match.call()), main = main.title[k], nclass = nclass)
  }
}


"print.krandtest" <- function (x, ...) {
  if (!inherits(x, "krandtest")) 
    stop("to be used with 'krandtest' object")
  cat("class:", class(x), "\n")
  ##    dig0 <- ceiling (log(x$rep)/log(10))
  cat("Monte-Carlo tests\n")
  cat("Call: ")
  print(x$call)
  cat("\nNumber of tests:  ", x$ntest, "\n")
  cat("\nAdjustment method for multiple comparisons:  ", x$adj.method, "\n")
  
  sumry <- list(Test = x$names, Obs = x$obs, Std.Obs = x$expvar[,1], Alter = x$alter)
  sumry <- as.data.frame(sumry)
  row.names(sumry) <- 1:x$ntest
  
  if(any(x$rep[1] != x$rep)){
    sumry <- cbind(sumry[,1:4], N.perm = x$rep)
  } else {
    cat("Permutation number:  ", x$rep[1], "\n")
  }
  sumry <- cbind(sumry, Pvalue = x$pvalue)
  if(x$adj.method != "none")
    sumry <- cbind(sumry, Pvalue.adj = x$adj.pvalue)
  
  print(sumry)
  cat("\n")
  
  if (length(names(x)) > 9) {
    cat("other elements: ")
    cat(names(x)[10:(length(x))], "\n")      
  }
}

