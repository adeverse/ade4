"randtest" <- function (xtest, ...) {
    UseMethod("randtest")
}

"as.randtest" <- function (sim, obs, alter = c("greater", "less", "two-sided"), output = c("light", "full"), call = match.call(), subclass = NULL ) {
    output <- match.arg(output)
    if(output == "full")
        res <- list(sim = sim, obs = obs)
    else 
        res <- list(obs = obs)
        
    res$alter <- match.arg(alter)
    sim <- stats::na.omit(sim)
    res$rep <- length(sim)
    res$expvar <- c(Std.Obs=(res$obs-mean(sim))/stats::sd(sim),Expectation=mean(sim),Variance=stats::var(sim))
    if(res$alter=="greater"){
      res$pvalue <- (sum(sim >= obs) + 1)/(length(sim) + 1)
    }
    else if(res$alter=="less"){
      res$pvalue <- (sum(sim <= obs) + 1)/(length(sim) + 1)
    }
    else if(res$alter=="two-sided") {
      sim0 <- abs(sim-mean(sim))
      obs0 <- abs(obs-mean(sim))
      res$pvalue <- (sum(sim0 >= obs0) + 1)/(length(sim) +1)
    }
    
    ## compute histogram (mainly used for 'light' randtest)
    if(length(sim) > 0){
        r0 <- c(sim, obs)
        l0 <- max(sim) - min(sim)
        w0 <- l0/(log(length(sim), base = 2) + 1)
        xlim0 <- range(r0) + c(-w0, w0)
        h0 <- graphics::hist(sim, plot = FALSE, nclass = 10)
        res$plot <- list(hist = h0, xlim = xlim0)
    }
    
    res$call <- call
    class(res) <- "randtest"
    if(output == "light")
        class(res) <- c(subclass, class(res), "lightrandtest")
    return(res)
}

"print.randtest" <- function (x, ...) {
    if (!inherits(x, "randtest")) 
        stop("Non convenient data")
    cat("Monte-Carlo test\n")
    cat("Call: ")
    print(x$call)
    cat("\nObservation:", x$obs, "\n")
    cat("\nBased on", x$rep, "replicates\n")
    cat("Simulated p-value:", x$pvalue, "\n")
    cat("Alternative hypothesis:", x$alter, "\n\n")
    print(x$expvar)
}

"plot.randtest" <- function (x, nclass = 10, coeff = 1, ...) {
    if (!inherits(x, "randtest")) 
        stop("Non convenient data")
    if(!inherits(x, "lightrandtest") & nclass != 10){
    r0 <- c(x$sim, x$obs)
    l0 <- max(x$sim) - min(x$sim)
    w0 <- l0/(log(length(x$sim), base = 2) + 1)
    w0 <- w0 * coeff
    xlim0 <- range(r0) + c(-w0, w0)
    h0 <- graphics::hist(x$sim, plot = FALSE, nclass = nclass)
    } else {
        h0 <- x$plot$hist
        xlim0 <- x$plot$xlim
    }
    y0 <- max(h0$counts)

    graphics::plot(h0, xlim = xlim0, col = grDevices::grey(0.8), ...)
    graphics::lines(c(x$obs, x$obs), c(y0/2, 0))
    graphics::points(x$obs, y0/2, pch = 18, cex = 2)
    invisible()
}
