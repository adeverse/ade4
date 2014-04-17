randboot <- function (object, ...) {
    UseMethod("randboot")
}

as.randboot <- function(obs, boot, quantiles = c(0.025, 0.975), call = match.call()){
    ## obs: observed value of the statistic
    ## boot: a vector (length n) with bootstrapped values
    ## n: number of repetitions
        
    res <- list(obs = obs, boot = boot, rep = length(na.omit(boot)))
    res$stats <- obs - quantile(boot - obs, probs = rev(quantiles), na.rm = TRUE)
    names(res$stats) <- rev(names(res$stats))
    res$call <- call
    class(res) <- "randboot"
    return(res)
}


print.randboot <- function(x, ...){
    if (!inherits(x, "randboot")) 
        stop("Non convenient data")
    cat("Bootstrap\n")
    cat("Call: ")
    print(x$call)
    cat("\nObservation:", x$obs, "\n")
    cat("\nBased on", x$rep, "replicates\n")
    cat("\nConfidence Interval:\n")
    print(x$stats)
}
