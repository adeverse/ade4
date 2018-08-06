varipart <- function(Y, X, W = NULL, nrepet = 999, type = c("simulated", "parametric"), scale = FALSE, ...){
    
    type <- match.arg(type)
    if (!inherits(Y, "dudi")) {
        response.generic <- as.matrix(scalewt(Y, scale = scale))
        lw <- rep(1/NROW(Y), NROW(Y))
        sqlw <- sqrt(lw)
        sqcw <- sqrt(rep(1, NCOL(Y)))
        wt <- outer(sqlw, sqcw)
        inertot <- sum((response.generic * wt)^2)
        param.ok <- TRUE
    } else {
        inertot <- sum(Y$eig)
        lw <- Y$lw
        sqlw <- sqrt(lw)
        sqcw <- sqrt(Y$cw)
        param.ok <- dudi.type(Y$call) %in% c(4, 5)
        response.generic <- as.matrix(Y$tab)
        wt <- outer(sqlw, sqcw)
    }
    
    # fast computation of R2/adjusted
    R2test.QR <- function(df){
        df <- data.frame(df)
        mf <- model.matrix(~., df)
        x <- scalewt(mf[, -1, drop = FALSE], scale = FALSE, wt = lw) * sqrt(lw)
        response.generic = response.generic * wt
        Q <- qr(x, tol = 1e-06)
        Yfit.X <- qr.fitted(Q, response.generic)
        obs <- sum(Yfit.X^2)
        
        isim <- c()
    
        for (i in 1:nrepet)
            isim[i] <- sum(qr.fitted(Q, response.generic[sample(length(lw)),])^2) 
        
        r2 <- c(obs, isim) / inertot
        
        ## adjustment
        p <- Q$rank
        if (type == "parametric") {
            if (param.ok) {
                r2.adj <- 1 - (1 - r2) / (1 - p / (nrow(x) - 1))
            } else
                stop("parametric correction can only be used for objects created by dudi.pca with center = TRUE")
        } else if (type == "simulated")
            r2.adj <- 1 - (1 - r2) / (1 - mean(r2[-1]))
        
        return(list(r2 = r2, r2.adj = r2.adj))
    } 
    
    R2test.lmwfit <- function(df){ 
        df <- data.frame(df)
        fmla <- as.formula(paste("response.generic ~", paste(names(df), collapse = "+")))
        mf <- model.frame(fmla, data = cbind.data.frame(response.generic,df))
        mt <- attr(mf,"terms")
        x <- model.matrix(mt, mf)
        
        ## Fast function for computing sum of squares of the fitted table
        obs <- sum((lm.wfit(y = response.generic, x = x, w = lw)$fitted.values * wt)^2) 
        isim <- c()
        for (i in 1:nrepet)
            isim[i] <- sum((lm.wfit(y = response.generic, x = x[sample(nrow(x)),], w = lw)$fitted.values * wt)^2) 
        
        r2 <- c(obs, isim) / inertot
        
        ## adjustment
        p <- ncol(x) - 1 ## we remove 1 for the intercept
        if (type == "parametric") {
            if (param.ok) {
                r2.adj <- 1 - (1 - r2) / (1 - p / (nrow(x) - 1))
            } else
                stop("parametric correction can only be used for objects created by dudi.pca with center = TRUE")
        } else if (type == "simulated")
            r2.adj <- 1 - (1 - r2) / (1 - mean(r2[-1]))
        
        return(list(r2 = r2, r2.adj = r2.adj))
    }
    
    R2test <- R2test.lmwfit
    if (identical(all.equal(lw, rep(1/length(lw), length(lw))), TRUE))
        R2test <- R2test.QR
    
    rda.ab <- R2test(X)
    if (is.null(W)) {
        res <- list(R2.adj = rda.ab$r2.adj[1])
        if (nrepet > 0) {
            test <- as.randtest(obs = rda.ab$r2[1], sim = rda.ab$r2[-1], call = match.call(), ...)
            res[["test"]] <- test
        }
    } else {
        rda.bc <- R2test(W)
        rda.abc <- R2test(cbind(X, W))
        
        a.adj <- rda.abc$r2.adj[1] - rda.bc$r2.adj[1]
        c.adj <- rda.abc$r2.adj[1] - rda.ab$r2.adj[1]
        b.adj <- rda.abc$r2.adj[1] - a.adj - c.adj
        d.adj <- 1 - rda.abc$r2.adj[1]
        
        a <- rda.abc$r2[1] - rda.bc$r2[1]
        c <- rda.abc$r2[1] - rda.ab$r2[1]
        b <- rda.abc$r2[1] - a - c
        d <- 1 - rda.abc$r2[1]
 
        res <- list(R2 = c(a = a, b = b, c = c, d = d), R2.adj = c(a = a.adj, b = b.adj, c = c.adj, d = d.adj))
        if (nrepet > 0) {       
        test <- as.krandtest(obs = c(rda.ab$r2[1], rda.bc$r2[1], rda.abc$r2[1]), sim = cbind(rda.ab$r2, rda.bc$r2, rda.abc$r2)[-1,], names = c("ab", "bc", "abc"), call = match.call(), ...) 
        res[["test"]] <- test
        }
        
    }
    res$call <- match.call()
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
