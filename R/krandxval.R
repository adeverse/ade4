as.krandxval <- function(RMSEc, RMSEv, quantiles = c(0.25, 0.75), names = colnames(RMSEc), call = match.call()){
    ## RMSEc: n x p matrix with residual mean square error of calibration
    ## RMSEv: n x p matrix with residual mean square error of validation
    ## n: number of repetitions, p: number of statistics
    if(nrow(RMSEc) != nrow(RMSEv))
        stop("Both RMSE should be computed on the same number of repetitions")

    if(ncol(RMSEc) != ncol(RMSEv))
        stop("Both RMSE should be computed on the same number of statistics")

    res <- list(RMSEc = RMSEc, RMSEv = RMSEv, rep = nrow(RMSEc))
        
    ## compute stats for RMSEc
    res$repRMSEc <- colSums(!is.na(res$RMSEc))
    res$statsRMSEc <- cbind.data.frame(Mean = colMeans(res$RMSEc, na.rm = TRUE), t(apply(res$RMSEc,2, quantile, probs = quantiles, na.rm = TRUE)))
    rownames(res$statsRMSEc) <- names

    ## compute stats for RMSEv
    res$repRMSEv <- colSums(!is.na(res$RMSEc))
    res$statsRMSEv <- cbind.data.frame(Mean = colMeans(res$RMSEv, na.rm = TRUE), t(apply(res$RMSEv,2, quantile, probs = quantiles, na.rm = TRUE)))
    rownames(res$statsRMSEv) <- names
    
    res$call <- call
    class(res) <- "krandxval"
    return(res)
}


print.krandxval <- function(x, ...){
    if (!inherits(x, "krandxval")) 
        stop("Non convenient data")
    cat("Two-fold cross-validation\n")
    cat("Call: ")
    print(x$call)
    cat("\nResults for", ncol(x$RMSEc), "statistics\n\n")
    cat("Root mean square error of calibration:\n")
    print(cbind.data.frame(N.rep = x$repRMSEc, x$statsRMSEc))
    cat("\nRoot mean square error of validation:\n")
    print(cbind.data.frame(N.rep = x$repRMSEv, x$statsRMSEv))
}
