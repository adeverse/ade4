## functions for anlyses with both row and column constraints
## dpcaiv
## plot.dpcaiv
## print.dpcaiv
## summary.dpcaiv
## randtest.dpcaiv
## dvaripart
## print.dvaripart


dpcaiv <- function (dudi,
                    dfR = NULL,
                    dfQ = NULL,
                    scannf = TRUE,
                    nf = 2)
{
    lm.pcaiv <- function(x, df, weights, use) {
        if (!inherits(df, "data.frame"))
            stop("data.frame expected")
        reponse.generic <- x
        begin <- "reponse.generic ~ "
        fmla <- stats::as.formula(paste(begin, paste(names(df), collapse = "+")))
        df <- cbind.data.frame(reponse.generic, df)
        lm0 <- stats::lm(fmla, data = df, weights = weights)
        if (use == 0)
            return(predict(lm0))
        else if (use == 1)
            return(stats::residuals(lm0))
        else if (use == -1)
            return(lm0)
        else
            stop("Non convenient use")
    }
    if (!inherits(dudi, "dudi"))
        stop("dudi is not a 'dudi' object")
    if (!is.null(dfR)) {
        dfR <- data.frame(dfR)
        if (!inherits(dfR, "data.frame"))
            stop("dfR is not a 'data.frame'")
        if (nrow(dfR) != length(dudi$lw))
            stop("Non convenient dimensions")
        
        isfactor1 <- unlist(lapply(as.list(dfR), is.factor))
        for (i in 1:ncol(dfR)) {
            if (!isfactor1[i])
                dfR[, i] <- scalewt(dfR[, i],
                                          wt = dudi$lw,
                                          scale = TRUE,
                                          center = TRUE)
        }
    }
    if (!is.null(dfQ)) {
        dfQ <- data.frame(dfQ)
        if (!inherits(dfQ, "data.frame"))
            stop("dfQ is not a 'data.frame'")
        if (nrow(dfQ) != length(dudi$cw))
            stop("Non convenient dimensions")
        
        isfactor2 <- unlist(lapply(as.list(dfQ), is.factor))
        for (i in 1:ncol(dfQ)) {
            if (!isfactor2[i])
                dfQ[, i] <- scalewt(dfQ[, i],
                                          wt = dudi$cw,
                                          scale = TRUE,
                                          center = TRUE)
        }
    }
    tab <- dudi$tab
    if (!is.null(dfR)) {
        tab <- data.frame(apply(
            dudi$tab,
            2,
            lm.pcaiv,
            df = dfR,
            use = 0,
            weights = dudi$lw
        ))
    }
    if (!is.null(dfQ)) {
        tab <- data.frame(apply(
            tab,
            1,
            lm.pcaiv,
            df = dfQ,
            use = 0,
            weights = dudi$cw
        ))
        tab <- as.data.frame(t(tab))
    }
    res <- as.dudi(
        tab,
        dudi$cw,
        dudi$lw,
        scannf = scannf,
        nf = nf,
        call = match.call(),
        type = "dpcaiv"
    )
    res$ratio <- sum(res$eig) / sum(dudi$eig)
    res$Y <- dudi$tab
    
    if (!is.null(dfR)) {
        res$dfR <- dfR
        U <- as.matrix(res$c1) * unlist(res$cw)
        U <- as.matrix(dudi$tab) %*% U
        U <- data.frame(U)
        row.names(U) <- row.names(dudi$tab)
        names(U) <- names(res$li)
        res$lsR <- U
        U <- as.matrix(res$c1) * unlist(res$cw)
        U <- data.frame(t(as.matrix(dudi$c1)) %*% U)
        row.names(U) <- names(dudi$li)
        names(U) <- names(res$li)
        res$asR <- U
        
        w <- apply(res$lsR, 2, function(x)
            stats::coefficients(lm.pcaiv(x, dfR, dudi$lw, -1)))
        w <- data.frame(w)
        names(w) <- names(res$l1)
        res$faR <- w
        fmla <- stats::as.formula(paste("~ ", paste(names(dfR), collapse = "+")))
        w <- scalewt(stats::model.matrix(fmla, data = dfR)[, -1], dudi$lw) * dudi$lw
        w <- t(w) %*% as.matrix(res$l1)
        w <- data.frame(w)
        res$corR <- w
        
    }
    
    if(!is.null(dfQ)) {
        res$dfQ <- dfQ
        U <- as.matrix(res$l1) * unlist(res$lw)
        U <- t(as.matrix(dudi$tab)) %*% U
        U <- data.frame(U)
        row.names(U) <- names(dudi$tab)
        names(U) <- names(res$co)
        res$lsQ <- U
        U <- as.matrix(res$l1) * unlist(res$lw)
        U <- data.frame(t(as.matrix(dudi$l1)) %*% U)
        row.names(U) <- names(dudi$co)
        names(U) <- names(res$co)
        res$asQ <- U
        
        w <- apply(res$lsQ, 2, function(x)
            stats::coefficients(lm.pcaiv(x, dfQ, dudi$cw, -1)))
        w <- data.frame(w)
        names(w) <- names(res$c1)
        res$faQ <- w
        fmla <- stats::as.formula(paste("~ ", paste(names(dfQ), collapse = "+")))
        w <- scalewt(stats::model.matrix(fmla, data = dfQ)[, -1], dudi$cw) * dudi$cw
        w <- t(w) %*% as.matrix(res$c1)
        w <- data.frame(w)
        res$corQ <- w
    }
    if (inherits(dudi, "coa")) 
        class(res) <- c("dcaiv", class(res))
    return(res)
}

"plot.dpcaiv" <- function (x, xax = 1, yax = 2, ...) {
    if (!inherits(x, "dpcaiv")) 
        stop("Use only with 'dpcaiv' objects")
    if (x$nf == 1) {
        warnings("One axis only : not yet implemented")
        return(invisible())
    }
    if (xax > x$nf) 
        stop("Non convenient xax")
    if (yax > x$nf) 
        stop("Non convenient yax")
    if(is.null(x$dfR) | is.null(x$dfQ))
        warnings("Only implemented for two constraints. Use `pcaiv` instead")
    
    def.par <- graphics::par(no.readonly = TRUE)
    on.exit(graphics::par(def.par))
    graphics::layout(matrix(c(1, 1, 3, 1, 1, 4, 2, 2,5,2,2,6,8,8,7), 3, 5), 
                     respect = TRUE)
    graphics::par(mar = c(0.1, 0.1, 0.1, 0.1))
    
    s.match(x$li, x$lsR, xax, yax, clabel = 1.5, sub = "Scores and predictions R", 
            csub = 2)
    s.match(x$co, x$lsQ, xax, yax, clabel = 1.5, sub = "Scores and predictions Q", 
            csub = 2)
    s.arrow(stats::na.omit(x$faR), xax, yax, sub = "Loadings R", csub = 2, 
            clabel = 1.25)
    s.corcircle(x$corR, xax, yax, sub = "Correlation R", csub = 2)
    s.arrow(stats::na.omit(x$faQ), xax, yax, sub = "Loadings R", csub = 2, 
            clabel = 1.25)
    s.corcircle(x$corR, xax, yax, sub = "Correlation Q", csub = 2)
    scatterutil.eigen(x$eig, wsel = c(xax, yax))
}

"print.dpcaiv" <- function (x, ...) {
    if (!inherits(x, "dpcaiv")) 
        stop("to be used with 'dpcaiv' object")
    if (inherits(x, "dcaiv"))
        cat("Dcouble canonical correspondence analysis\n")
    else
        cat("Double Principal Component Analysis with Instrumental Variables\n")
    cat("call: ")
    print(x$call)
    cat("class: ")
    cat(class(x), "\n")
    cat("\n$rank (rank)     :", x$rank)
    cat("\n$nf (axis saved) :", x$nf)
    cat("\n\neigen values: ")
    l0 <- length(x$eig)
    cat(signif(x$eig, 4)[1:(min(5, l0))])
    if (l0 > 5) 
        cat(" ...\n\n")
    else cat("\n\n")
    sumry <- array("", c(3, 4), list(rep("", 3), c("vector", 
                                                   "length", "mode", "content")))
    sumry[1, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
    sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), "row weigths (from dudi)")
    sumry[3, ] <- c("$cw", length(x$cw), mode(x$cw), "col weigths (from dudi)")
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(2, 4), list(rep("", 2), c("data.frame", 
                                                   "nrow", "ncol", "content")))
    sumry[1, ] <- c("$Y", nrow(x$Y), ncol(x$Y), "Dependant variables")
    sumry[2, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "modified array (predicted table)")
    if(!is.null(x$dfR))
        sumry <- rbind(sumry, c("$dfR", nrow(x$dfR), ncol(x$dfR), "Explanatory variables for rows"))
    if(!is.null(x$dfQ))
        sumry <- rbind(sumry, c("$dfQ", nrow(x$dfQ), ncol(x$dfQ), "Explanatory variables for columns"))
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(1, 4), list(rep("", 1), c("data.frame", 
                                                   "nrow", "ncol", "content")))
    sumry[1, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "Constrained Principal Axes (CPA)")
    if(!is.null(x$dfQ)){
        sumry <- rbind(sumry, c("$faQ", nrow(x$faQ), ncol(x$faQ), "Loadings for Q to build the CPA (linear combination)"))
        sumry <- rbind(sumry, c("$corQ", nrow(x$corQ), ncol(x$corQ), "Correlations between the CPA and Q"))
    }
    sumry <- rbind(sumry, c("$li", nrow(x$li), ncol(x$li), "Constrained (by R) row score (LC score)"))
    if(!is.null(x$dfR)){
        sumry <- rbind(sumry, c("$asR", nrow(x$asR), ncol(x$asR), "Principal axis of dudi$tab on CPA"))
        sumry <- rbind(sumry, c("$lsR", nrow(x$lsR), ncol(x$lsR), "Unconstrained row score (WA score)"))
    }
    
    print(sumry, quote = FALSE)
    cat("\n")
    sumry <- array("", c(1, 4), list(rep("", 1), c("data.frame", 
                                                   "nrow", "ncol", "content")))
    sumry[1, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "Constrained Principal Components (CPC)")
    if(!is.null(x$dfR)){
        sumry <- rbind(sumry, c("$faR", nrow(x$faR), ncol(x$faR), "Loadings for R to build the CPC (linear combination)"))
        sumry <- rbind(sumry, c("$corR", nrow(x$corR), ncol(x$corR), "Correlations between the CPC and R"))
    }
    sumry <- rbind(sumry, c("$co", nrow(x$co), ncol(x$co), "Constrained (by Q) column score (LC score)"))
    if(!is.null(x$dfQ)){
        sumry <- rbind(sumry, c("$asQ", nrow(x$asQ), ncol(x$asQ), "Principal component of dudi$tab on CPC"))
        sumry <- rbind(sumry, c("$lsQ", nrow(x$lsQ), ncol(x$lsQ), "Unconstrained column score (WA score)"))
    }
    
    print(sumry, quote = FALSE)
    cat("\n")
    
}

summary.dpcaiv <- function(object, ...){
    if (inherits(object, "dcaiv"))
        thetitle <- "Double canonical correspondence analysis"
    else
        thetitle <- "Double principal component analysis with instrumental variables"
    
    cat(thetitle)
    cat("\n\n")
    NextMethod()
    
    appel <- as.list(object$call)
    dudi <- eval.parent(appel$dudi)
    
    cat(paste("Total unconstrained inertia (", deparse(appel$dudi), "): ", sep = ""))
    cat(signif(sum(dudi$eig), 4))
    cat("\n\n")
    
    cat(paste("Inertia of", deparse(appel$dudi), "explained by", deparse(appel$dfR), "and", deparse(appel$dfQ), "(%): "))
    cat(signif(sum(object$eig) / sum(dudi$eig) * 100, 4))
    cat("\n\n")
    
}

randtest.dpcaiv <- function (xtest, nrepet = 99, ...) {
    if (!inherits(xtest, "dudi"))
        stop("Object of class dudi expected")
    if (!inherits(xtest, "dpcaiv"))
        stop("Type 'dpcaiv' expected")
    # Get call
    appel <- as.list(xtest$call)
    
    # Get parent analysis (CA)
    dudi1 <- eval.parent(appel$dudi)
    
    # Get predictor tables from call
    dfR <- data.frame(eval.parent(appel$dfR))
    dfQ <- data.frame(eval.parent(appel$dfQ))
    
    R2 <- getR2.dpcaiv(as.matrix(dudi1$tab), dfR, dfQ, dudi1$lw, dudi1$cw)
    
    isimR <- rep(NA, nrepet)
    isimQ <- rep(NA, nrepet)
    for (i in 1:nrepet) {
        isimR[i] <- getR2.dpcaiv(as.matrix(dudi1$tab), dfR[sample(nrow(dfR)), ], dfQ, dudi1$lw, dudi1$cw)
        isimQ[i] <- getR2.dpcaiv(as.matrix(dudi1$tab), dfR, dfQ[sample(nrow(dfQ)), ], dudi1$lw, dudi1$cw)
    }
    
    randR <- as.randtest(
        sim = isimR,
        obs = R2,
        call = match.call(),
        output = "full",
        ...
    )
    randQ <- as.randtest(
        sim = isimQ,
        obs = R2,
        call = match.call(),
        output = "full",
        ...
    )
    ## combine both tests (permutation of rows and columns)
    res <- as.krandtest(
        sim = cbind(Model2 = randR$sim, Model4 = randQ$sim),
        obs = c(randR$obs, randQ$obs),
        alter = c(randR$alter, randQ$alter),
        call = match.call(),
        p.adjust.method = "none",
        ...
    )
    res$comb.pvalue <- max(randR$pvalue, randQ$pvalue)
    
    return(res)
}


getR2.dpcaiv <- function(Y, dfR, dfQ, lw, cw) {
    ## function that returns R2 for dpcaiv
    
    # first model (Y predicted by R)
    fmla_R <- stats::as.formula(paste("Y ~", paste(names(dfR), collapse = "+")))
    mf_R <- stats::model.frame(fmla_R, data = cbind.data.frame(Y, dfR))
    mt_R <- attr(mf_R, "terms")
    mat_R <- stats::model.matrix(mt_R, mf_R)
    ## predict and transpose
    Y_predR <- t(lm.wfit(y = Y, x = mat_R, w = lw)$fitted.values) 
    
    ## model with Q (Y_predR predicted by Q)
    fmla_RQ <- stats::as.formula(paste("Y_predR ~", paste(names(dfQ), collapse = "+")))
    mf_RQ <- stats::model.frame(fmla_RQ, data = cbind.data.frame(Y_predR, dfQ))
    mt_RQ <- attr(mf_RQ, "terms")
    mat_Q <- stats::model.matrix(mt_RQ, mf_RQ)
    Y_predRQ <- lm.wfit(y = Y_predR, x = mat_Q, w = cw)$fitted.values
    
    wt <- outer(sqrt(lw), sqrt(cw))
    R2 <- sum((Y_predRQ * t(wt))^2) / sum((Y * wt)^2)
    return(R2)
}

getR2.pcaiv <- function(Y, dfX, lw, cw) {
    ## function that returns R2 for pcaiv
    
    # first model (Y predicted by R)
    fmla <- stats::as.formula(paste("Y ~", paste(names(dfX), collapse = "+")))
    mf <- stats::model.frame(fmla, data = cbind.data.frame(Y, dfX))
    mt <- attr(mf, "terms")
    mat <- stats::model.matrix(mt, mf)
    ## predict
    Y_pred <- lm.wfit(y = Y, x = mat, w = lw)$fitted.values
    
    wt <- outer(sqrt(lw), sqrt(cw))
    R2 <- sum((Y_pred * wt)^2) / sum((Y * wt)^2)
    return(R2)
}


dvaripart <- function(Y,
                      dfR,
                      dfQ,
                      nrepet = 999,
                      scale = FALSE,
                      ...) {
    
    if (!inherits(Y, "dudi")) {
        Y <- as.matrix(scalewt(Y, scale = scale))
        lw <- rep(1 / NROW(Y), NROW(Y))
        cw <- rep(1, NCOL(Y))
    } else {
        lw <- Y$lw
        cw <- Y$cw
        Y <- as.matrix(Y$tab)
    }
    
    dfR <- data.frame(dfR)
    dfQ <- data.frame(dfQ)
    
    test <- matrix(NA, nrow = nrepet + 1, ncol = 4)
    ## compute R2 for observed data
    test[1, 1] <- getR2.pcaiv(Y = Y, dfX = dfR, lw = lw, cw = cw)
    test[1, 2] <- getR2.pcaiv(Y = t(Y), dfX = dfQ, lw = cw, cw = lw)
    test[1, 3] <- test[1, 4] <- getR2.dpcaiv(Y = Y, dfR = dfR, dfQ = dfQ, lw = lw, cw = cw)
    
    ## compute R2 for permuted data
    for (i in 2:(nrepet + 1)){
        test[i, 1] <- getR2.pcaiv(Y = Y, dfX = dfR[sample(nrow(dfR)), ], lw = lw, cw = cw)
        test[i, 2] <- getR2.pcaiv(Y = t(Y), dfX = dfQ[sample(nrow(dfQ)), ], lw = cw, cw = lw)
        test[i, 3] <- getR2.dpcaiv(Y = Y, dfR = dfR[sample(nrow(dfR)), ], dfQ = dfQ, lw = lw, cw = cw)
        test[i, 4] <- getR2.dpcaiv(Y = Y, dfR = dfR, dfQ = dfQ[sample(nrow(dfQ)), ], lw = lw, cw = cw)
    }
    
    ## compute adjusted R2
    r2.adj.ab <- 1 - (1 - test[1, 1]) / (1 - mean(test[-1, 1]))
    r2.adj.bc <- 1 - (1 - test[1, 2]) / (1 - mean(test[-1, 2]))
    r2.adj.b <- 1 - (1 - test[1, 3]) / (1 - max(c(mean(test[-1, 3]), mean(test[-1, 4]))))
    
    
    a.adj <- r2.adj.ab - r2.adj.b
    b.adj <- r2.adj.b
    c.adj <- r2.adj.bc - r2.adj.b
    d.adj <- 1 - a.adj - b.adj - c.adj
    
    a <- test[1, 1] - test[1, 3]
    c <- test[1, 2] - test[1, 3]
    b <- test[1, 3]
    d <- 1 - a - b - c
    
    res <- list(
        R2 = c(
            a = a,
            b = b,
            c = c,
            d = d
        ),
        R2.adj = c(
            a = a.adj,
            b = b.adj,
            c = c.adj,
            d = d.adj
        )
    )
    if (nrepet > 0) {
        res[["test"]] <- as.krandtest(
            obs = test[1, ],
            sim = test[-1, ],
            names = c("ab(R)", "bc(Q)", "b(RQ)_Rperm", "b(RQ)_Qperm"),
            call = match.call(),
            ...
        )
    }
    
    res$call <- match.call()
    class(res) <- c("dvaripart", "list")
    return(res)
}

print.dvaripart <- function(x, ...) {
    if (!inherits(x, "dvaripart"))
        stop("to be used with 'varipart' object")
    cat("Variation Partitioning\n")
    cat("class: ")
    cat(class(x), "\n")
    cat("\nTest of fractions:\n")
    print(x$test)
    
    cat("\nIndividual fractions:\n")
    print(x$R2)
    cat("\nAdjusted fractions:\n")
    print(x$R2.adj)
}



