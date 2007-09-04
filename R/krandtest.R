"as.krandtest" <- function (sim, obs, alter=c("greater", "less", "two-sided"), call = match.call(),names=colnames(sim)) {
    res <- list(sim = sim, obs = obs)
    res$alter <- match.arg(alter)
    res$rep <- nrow(sim)
    res$ntest <- length(obs)
    res$expvar <- data.frame(matrix(0,res$ntest,3))
    if(!is.null(names)){ res$names <- names} else{res$names <- paste("test",1:res$ntest,sep="")}
    names(res$expvar) <- c("Std.Obs","Expectation","Variance")
    res$pvalue <- rep(0,length(obs))
    for(i in 1:length(obs)){
      res$expvar[i,1] <- (res$obs[i]-mean(sim[,i]))/sd(sim[,i])
      res$expvar[i,2] <- mean(sim[,i])
      res$expvar[i,3] <-sd(sim[,i])
      if(res$alter=="greater"){
        res$pvalue[i] <- (sum(sim[,i] >= obs[i]) + 1)/(length(sim[,i]) + 1)
      }
      else if(res$alter=="less"){
        res$pvalue[i] <- (sum(sim[,i] <= obs[i]) + 1)/(length(sim[,i]) + 1)
      }
      else if(res$alter=="two-sided") {
        sim0 <- abs(sim[,i]-mean(sim[,i]))
        obs0 <- abs(obs[i]-mean(sim[,i]))
        res$pvalue[i] <- (sum(sim0 >= obs0) + 1)/(length(sim[,i]) +1)
      }
    }
    res$call <- call
    class(res) <- "krandtest"
    return(res)
  }


"plot.krandtest" <- function (x, mfrow=NULL, nclass= NULL, main.title = x$names, ...) {
    if (!inherits(x, "krandtest")) 
        stop("to be used with 'krandtest' object")
    if (is.null(mfrow)) mfrow=n2mfrow(x$ntest)
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    par(mfrow=mfrow)
    par(mar = c(3.1, 2.5, 2.1, 2.1))
    if (length(main.title)!=length(x$names)) 
        main.title <- x$names
    for (k in 1:x$ntest) {
        plot.randtest (as.randtest (x$sim[,k],x$obs[k],call=match.call()),main = main.title[k],nclass=nclass)
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
    cat("\nTest number:  ", x$ntest, "\n")
    cat("Permutation number:  ", x$rep, "\n")
    cat("Alternative hypothesis:", x$alter, "\n\n")
    sumry <- list(Test=x$names,Obs= x$obs, Std.Obs=x$expvar[,1],Pvalue=x$pvalue)
    sumry <- as.data.frame(sumry)
    row.names(sumry) <- 1:x$ntest
    print(sumry, ...)
    cat("\n")
    cat("other elements: ")
    if (length(names(x)) > 9) 
        cat(names(x)[10:(length(x))], "\n")
    else cat("NULL\n")

}

