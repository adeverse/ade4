as.randxval <- function(RMSEc, RMSEv, quantiles = c(0.25, 0.75), call = match.call()){
    ## RMSEc: a vector (length n) with residual mean square error of calibration
    ## RMSEv: a vector (length n) with residual mean square error of validation
    ## n: number of repetitions
    if(length(RMSEc) != length(RMSEv))
        stop("Both RMSE should be computed on the same number of repetitions")
    
    res <- list(RMSEc = RMSEc, RMSEv = RMSEv, rep = c(length(na.omit(RMSEc)), length(na.omit(RMSEv))))
    res$stats <- rbind(quantile(RMSEc, probs = quantiles, na.rm = TRUE), quantile(RMSEv, probs = quantiles, na.rm = TRUE))
    res$stats <- cbind(Mean = c(mean(RMSEc), mean(RMSEv)), res$stats)
    rownames(res$stats) <- c("RMSEc", "RMSEv")
    res$call <- call
    class(res) <- "randxval"
    return(res)
}


print.randxval <- function(x, ...){
    if (!inherits(x, "randxval")) 
        stop("Non convenient data")
    cat("Two-fold cross-validation\n")
    cat("Call: ")
    print(x$call)
    cat("\nRoot mean square error of calibration and validation:\n")
    print(cbind.data.frame(N.rep = x$rep, x$stats))
}
