"plot.krandtest" <- function (x, mfrow=NULL, nclass= NULL, main.title = names(x), ...) {
    if (!inherits(x, "krandtest")) 
        stop("to be used with 'krandtest' object")
    ntest <- length(x)
    nrepet <- length(x[[1]])-1
    if (is.null(mfrow)) mfrow=n2mfrow(ntest)
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    par(mfrow=mfrow)
    par(mar = c(3.1, 2.5, 2.1, 2.1))
    if (length(main.title)!=length(names(x))) 
        main.title <- names(x)
    for (k in 1:ntest) {
        y <- x[[k]]
        plot.randtest (as.randtest (y[-1],y[1],call=match.call()),main = main.title[k],nclass=nclass)
    }
}

"print.krandtest" <- function (x, ...) {
    if (!inherits(x, "krandtest")) 
        stop("to be used with 'krandtest' object")
    cat("class:", class(x), "\n")
    ntest <- length(x)
    nrepet <- length(x[[1]])-1
    dig0 =ceiling (log(nrepet)/log(10))
    cat("test number:  ", ntest, "\n")
    cat("permutation number:  ", nrepet, "\n")
    sumry <- array("", c(ntest, 4), list(1:ntest, c("test", 
        "obs", "P(X<=obs)", "P(X>=obs)")))
    for (i in 1:ntest) {
        y <- x[[i]]
        obs <- y[1]
        y <- y[-1]
        sumry[i,1] <- names(x)[i]
        sumry[i,2] <- round(obs,dig=dig0)
        n <- (sum(y <= obs) + 1)/nrepet
        if (n>1) n <- 1
        if (n<0) n <- 0
        sumry[i,3] <- round(n, dig=dig0)
        n <- (sum(y >= obs) + 1)/nrepet
        if (n>1) n <- 1
        if (n<0) n <- 0
        sumry[i,4] <- round(n, dig=dig0)
     }
    class(sumry) <- "table"
    print(sumry)
    cat("\n")
}

