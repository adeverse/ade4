varipart <- function(Y, X, W = NULL, nrepet = 999, type = c("simulated", "parametric"), scale = FALSE, ...){
    
    if (!inherits(Y, "dudi"))
       dudiY <- dudi.pca(Y, center = TRUE, scale = scale, scannf = FALSE) 
    else
      dudiY <- Y  
    response.generic <- as.matrix(dudiY$tab)
    inertot <- sum(dudiY$eig)
    sqlw <- sqrt(dudiY$lw)
    sqcw <- sqrt(dudiY$cw)    
    type <- match.arg(type)
    
    # fast computation of R2/adjusted 
    R2test <- function(df){ 
        df <- data.frame(df)
        fmla <- as.formula(paste("response.generic ~", paste(names(df), collapse = "+")))
        mf <- model.frame(fmla, data = cbind.data.frame(response.generic,df))
        mt <- attr(mf,"terms")
        x <- model.matrix(mt, mf)
        wt <- outer(sqlw, sqcw)
        
        ## Fast function for computing sum of squares of the fitted table
        obs <- sum((lm.wfit(y = response.generic, x = x, w = dudiY$lw)$fitted.values * wt)^2) / inertot
        isim <- c()
        for (i in 1:nrepet)
            isim[i] <- sum((lm.wfit(y = response.generic, x = x[sample(nrow(x)),], w = dudiY$lw)$fitted.values * wt)^2) / inertot
        
        r2 <- c(obs, isim)
        
        ## adjustment
        p <- ncol(x) - 1 ## we remove 1 for the intercept
        if (type == "parametric") {
            if (dudi.type(dudiY$call) %in% c(4, 5)) {
                r2.adj <- 1 - (1 - r2) / (1 - p / (nrow(x) - 1))
            } else
                stop("parametric correction can only be used for objects created by dudi.pca with center = TRUE")
        } else if (type == "simulated")
            r2.adj <- 1 - (1 - r2) / (1 - mean(r2[-1]))
        
        return(list(r2 = r2, r2.adj = r2.adj))
    }
    
    rda.ab <- R2test(X)
    if (is.null(W)) {
        test <- as.randtest(obs = rda.ab$r2[1], sim = rda.ab$r2[-1], call = match.call(), ...)
        res <- list(test = test, R2.adj = rda.ab$r2.adj[1])
    } else {
        rda.bc <- R2test(W)
        rda.abc <- R2test(cbind(X, W))
        
        test <- as.krandtest(obs = c(rda.ab$r2[1], rda.bc$r2[1], rda.abc$r2[1]), sim = cbind(rda.ab$r2, rda.bc$r2, rda.abc$r2)[-1,], names = c("ab", "bc", "abc"), call = match.call(), ...) 
        
        a.adj <- rda.abc$r2.adj[1] - rda.bc$r2.adj[1]
        c.adj <- rda.abc$r2.adj[1] - rda.ab$r2.adj[1]
        b.adj <- rda.abc$r2.adj[1] - a.adj - c.adj
        d.adj <- 1 - rda.abc$r2.adj[1]
        
        a <- rda.abc$r2[1] - rda.bc$r2[1]
        c <- rda.abc$r2[1] - rda.ab$r2[1]
        b <- rda.abc$r2[1] - a - c
        d <- 1 - rda.abc$r2[1]
        
        res <- list(test = test, R2 = c(a = a, b = b, c = c, d = d), R2.adj = c(a = a.adj, b = b.adj, c = c.adj, d = d.adj), call = match.call())
    }
    
    class(res) <- c("varipart", "list")
    return(res)
}

print.varipart <- function(x, ...){
    if (!inherits(x, "varipart")) 
        stop("to be used with 'varipart' object")
    cat("Variation Partitioning\n")
    cat("class: ")
    cat(class(x), "\n")
    cat("\nTest of fractions:\n")
    print(x$test)
    if (!is.null(x[["R2"]])) {
        cat("\nIndividual fractions:\n")
        print(x$R2)
    }
    cat("\nAdjusted fractions:\n")
    print(x$R2.adj)
}
