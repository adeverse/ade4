"randtest" <- function (xtest, ...) {
    UseMethod("randtest")
}

"as.randtest" <- function (sim, obs, alter=c("greater", "less", "two-sided"), call = match.call() ) {
    res <- list(sim = sim, obs = obs)
    res$alter <- match.arg(alter)
    res$rep <- length(sim)
    res$expvar <- c(Std.Obs=(res$obs-mean(sim))/sd(sim),Expectation=mean(sim),Variance=var(sim))
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
    res$call <- call
    class(res) <- "randtest"
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
    obs <- x$obs
    sim <- x$sim
    r0 <- c(sim, obs)
    l0 <- max(sim) - min(sim)
    w0 <- l0/(log(length(sim), base = 2) + 1)
    w0 <- w0 * coeff
    xlim0 <- range(r0) + c(-w0, w0)
    h0 <- hist(sim, plot = FALSE, nclass = nclass)
    y0 <- max(h0$counts)

    hist(sim, plot = TRUE, nclass = nclass, xlim = xlim0, col = grey(0.8), 
        ...)
    lines(c(obs, obs), c(y0/2, 0))
    points(obs, y0/2, pch = 18, cex = 2)
    invisible()
}
