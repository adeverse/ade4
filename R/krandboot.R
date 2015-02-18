as.krandboot <- function(obs, boot, quantiles = c(0.025, 0.975), names = colnames(boot), call = match.call()){
    ## obs: a vector (length p) with observed value of the statistic
    ## boot: a matrix (n p)  with bootstrapped values
    ## n: number of repetitions, p number of statistics
    if(ncol(boot) != length(obs))
        stop("Wrong number of statistics")
    
    res <- list(obs = obs, boot = boot)
    res$rep <- apply(boot, 2, function(x) length(na.omit(x)))

    res$stats <- t(sapply(1:length(obs), function(i) obs[i] - quantile(boot[,i] - obs[i], probs = rev(quantiles), na.rm = TRUE)))
    colnames(res$stats) <- rev(colnames(res$stats))
    if(is.null(names))
        names <- 1: nrow(res$stats)
    rownames(res$stats) <- names
    res$call <- call
    class(res) <- "krandboot"
    return(res)
}


print.krandboot <- function(x, ...){
    if (!inherits(x, "krandboot")) 
        stop("Non convenient data")
    cat("Multiple bootstrap\n")
    cat("Call: ")
    print(x$call)
    cat("\nNumber of statistics:  ", length(x$obs), "\n")
    cat("\nConfidence Interval:\n")
    print(cbind.data.frame(N.rep = x$rep, Obs = x$obs, x$stats))
    
}
