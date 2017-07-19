varipart <- function(dudiY, X, W, nrepet = 999, type = c("simulated", "parametric"), ...){
    

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
        for(i in 1:nrepet)
            isim[i] <- sum((lm.wfit(y = response.generic, x = x[sample(nrow(x)),], w = dudiY$lw)$fitted.values * wt)^2) / inertot
        
        r2 <- c(obs, isim)
        
        ## adjustment
        p <- ncol(x) - 1 ## we remove 1 for the intercept
        if(type == "parametric") ## rajouter test pour acp
            r2.adj <- 1 - (1 - r2) / (1 - p / (nrow(x) - 1))
        else if(type == "simulated")
            r2.adj <- 1 - (1 - r2) / (1 - mean(r2[-1]))
        
        return(list(r2 = r2, r2.adj = r2.adj))
    }
    
    # y=pop, x=env, w=space, n=nb of permutation
    rda.ab <- R2test(X)
    rda.bc <- R2test(W)
    rda.abc <- R2test(cbind(X, W))
    
    test <- as.krandtest(obs = c(rda.ab$r2[1], rda.bc$r2[1], rda.abc$r2[1]), sim = cbind(rda.ab$r2, rda.bc$r2, rda.abc$r2)[-1,], names = c("ab", "bc", "abc"), call = match.call(), ...) 
    
    a.adj <- rda.abc$r2.adj[1] - rda.bc$r2.adj[1]
    c.adj <- rda.abc$r2.adj[1] - rda.ab$r2.adj[1]
    b.adj <- rda.abc$r2.adj[1]- a.adj - c.adj
    d.adj <- 1 - rda.abc$r2.adj[1]
    
    a <- rda.abc$r2[1] - rda.bc$r2[1]
    c <- rda.abc$r2[1] - rda.ab$r2[1]
    b <- rda.abc$r2[1]- a - c
    d <- 1 - rda.abc$r2[1]
    
    res <- list(test = test, R2 = c(a = a, b = b, c = c, d = d), R2.adj = c(a = a.adj, b = b.adj, c = c.adj, d = d.adj), call = match.call())
    class(res) <- c("varipart", "list")
    return(res)
}
