"as.krandtest" <- function (sim, obs, alter="greater", call = match.call(), names = colnames(sim), p.adjust.method = "none", output = c("light", "full")) {
    output <- match.arg(output)
    if(output == "full")
        res <- list(sim = sim, obs = obs)
    else 
        res <- list(obs = obs)
    
  if(length(obs)!=length(alter))
    alter <- rep(alter, length = length(obs))
  res$alter <- alter
  ## Invalid permutations are stored as NA
  res$rep <- apply(sim, 2, function(x) length(stats::na.omit(x)))
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
      
    vec.sim <- stats::na.omit(sim[,i])
    if(length(vec.sim > 0)){
        ## compute histogram (mainly used for 'light' randtest)
        r0 <- c(vec.sim, obs[i])
        l0 <- max(vec.sim) - min(vec.sim)
        w0 <- l0/(log(length(vec.sim), base = 2) + 1)
        xlim0 <- range(r0) + c(-w0, w0)
        h0 <- graphics::hist(vec.sim, plot = FALSE, nclass = 10)
        res$plot[[i]] <- list(hist = h0, xlim = xlim0)
    }
    
    res$alter[i] <- match.arg(res$alter[i], c("greater", "less", "two-sided"))
    res$expvar[i,1] <- (obs[i] - mean(vec.sim)) / stats::sd(vec.sim)
    res$expvar[i,2] <- mean(vec.sim)
    res$expvar[i,3] <- stats::sd(vec.sim)
    
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
  res$adj.pvalue <- stats::p.adjust(res$pvalue, method = p.adjust.method)
  res$adj.method <- p.adjust.method
  res$call <- call
  class(res) <- "krandtest"
  if(output == "light")
      class(res) <- c(class(res), "lightkrandtest")
  
  return(res)
}


"plot.krandtest" <- function (x, mfrow = NULL, nclass = 10, main.title = x$names, ...) {
  if (!inherits(x, "krandtest")) 
    stop("to be used with 'krandtest' object")
  if (is.null(mfrow))
    mfrow = grDevices::n2mfrow(x$ntest)
  def.par <- graphics::par(no.readonly = TRUE)
  on.exit(graphics::par(def.par))
  graphics::par(mfrow = mfrow)
  graphics::par(mar = c(3.1, 2.5, 2.1, 2.1))
  if (length(main.title)!=length(x$names)) 
    main.title <- x$names
  if(inherits(x, "lightkrandtest")) {
    for (k in 1:x$ntest) {
        y0 <- max(x$plot[[k]]$hist$counts)
      graphics::plot(x$plot[[k]]$hist, xlim = x$plot[[k]]$xlim, col = grDevices::grey(0.8), main = main.title[k], ...)
      graphics::lines(c(x$obs[k], x$obs[k]), c(y0/2, 0))
      graphics::points(x$obs[k], y0/2, pch = 18, cex = 2)
    }
      } else {
  
  for (k in 1:x$ntest) {
    plot.randtest(as.randtest(x$sim[,k], x$obs[k], call = match.call()), main = main.title[k], nclass = nclass)
  }
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
  
}


"[.krandtest" <- function(x, i) {
  res <- list()
  if (!inherits(x, "lightkrandtest"))
    if(length(i) == 1)
      res$sim <- x$sim[, i, drop = FALSE]
    else
      res$sim <- x$sim[, i]
  res$obs <- x$obs[i]
  res$alter <- x$alter[i]
  res$rep <- x$rep[i]
  res$ntest <- length(i)
  res$expvar <- x$expvar[i, ]
  res$names <- x$names[i]
  res$pvalue <- x$pvalue[i]
  res$plot <- x$plot[i]
  res$adj.pvalue <- x$adj.pvalue[i]
  res$adj.method <- x$adj.method
  res$call <- match.call()
  class(res) <- class(x)
  return(res)
}

"[[.krandtest" <- function(x, i) {
  if(length(i) != 1)
    stop("Only one element can be selected: 'i' must be an index of length at 1.")
  
  obj <- x[i]

  res <- list()
  if (!inherits(x, "lightkrandtest"))
    res$sim <- obj$sim
  res$obs <- obj$obs
  res$alter <- obj$alter
  res$rep <- obj$rep
  res$expvar <- obj$expvar
  res$pvalue <- obj$pvalue
  res$plot <- obj$plot
  res$call <- match.call()
  
  class(res) <- "randtest"
  if (inherits(x, "lightkrandtest")) 
    class(res) <- c(class(res), "lightrandtest")
  
  return(res)
}

