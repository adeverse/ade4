"as.rtest" <- function (sim, obs, call = match.call()) {
    res <- list(sim = sim, obs = obs)
    res$rep <- length(sim)
    res$pvalue <- (sum(sim >= obs) + 1)/(length(sim) + 1)
    res$call <- call
    class(res) <- "rtest"
    return(res)
} 

"plot.rtest" <- function (x, nclass = 10, coeff = 1, ...) {
    if (!inherits(x, "rtest")) 
        stop("Non convenient data")
    obs <- x$obs
    sim <- x$sim
    r0 <- c(sim, obs)
    h0 <- hist(sim, plot = FALSE, nclass = nclass, xlim = xlim0)
    y0 <- max(h0$counts)
    l0 <- max(sim) - min(sim)
    w0 <- l0/(log(length(sim), base = 2) + 1)
    w0 <- w0 * coeff
    xlim0 <- range(r0) + c(-w0, w0)
    hist(sim, plot = TRUE, nclass = nclass, xlim = xlim0, col = grey(0.8), 
        ...)
    lines(c(obs, obs), c(y0/2, 0))
    points(obs, y0/2, pch = 18, cex = 2)
    invisible()
} 

"print.rtest" <- function (x, ...) {
    if (!inherits(x, "rtest")) 
        stop("Non convenient data")
    cat("Monte-Carlo test\n")
    cat("Observation:", x$obs, "\n")
    cat("Call: ")
    print(x$call)
    cat("Based on", x$rep, "replicates\n")
    cat("Simulated p-value:", x$pvalue, "\n")
} 

"rtest" <- function (xtest, ...) {
    UseMethod("rtest")
}
