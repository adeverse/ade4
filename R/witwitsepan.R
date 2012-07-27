witwitsepan <- function (ww, mfrow = NULL, csub = 2, plot = TRUE) {
    if (!inherits(ww, "witwit")) stop ("witwit object expected")
    appel <- as.list(ww$call)
    rowblo <- eval.parent(appel[[3]])
    colblo <- eval.parent(appel[[4]])
    anal <- eval.parent(appel[[2]])
    tab <- eval.parent(as.list(anal$call)[[2]])

    rowfac=as.factor(rep(1:length(rowblo),rowblo))
    if (is.null(names(rowblo))) names(rowblo) <- as.character(1:length(rowblo))
    levels(rowfac)=names(rowblo) 
    
    colfac=as.factor(rep(1:length(colblo),colblo))
    if (is.null(names(colblo))) names(colblo) <- as.character(1:length(colblo))
    levels(colfac)=names(colblo) 
    
    listblocrow = split(tab,rowfac)
    listbloc = NULL
    lapply(listblocrow, function(x)
         listbloc <<- c(listbloc,split(as.data.frame(t(x)),colfac)))    

    fun1 <- function(x) {
        x <- data.frame(x)
        if (nrow(x) <2) return (NULL)
        if (ncol(x) <2) return (NULL)
        sumlig <- apply(x,1,sum)
        if (sum(sumlig>0)<2) return (NULL)
        sumcol <- apply(x,2,sum)
        if (sum(sumcol>0)<2) return (NULL)
        return(dudi.coa(x, scannf = FALSE)$eig)
    }
    
    names(listbloc) <- t(outer(names(rowblo),names(colblo),function(x,y) paste(x,y,sep="/")))

    result <- lapply(listbloc,fun1)
    if (!plot) return(result)
    
    opar <- par(ask = par("ask"), mfrow = par("mfrow"), mar = par("mar"))
    on.exit(par(opar))
    par(mar = c(0.6, 2.6, 0.6, 0.6))
    nbloc <- length(result)
    if (is.null(mfrow)) 
        mfrow <- n2mfrow(nbloc)
    par(mfrow = mfrow)
    if (nbloc > prod(mfrow)) 
        par(ask = TRUE)
    neig <- max(unlist(lapply(result,length)))
    maxeig <- max(unlist(result))
    for (ianal in 1:nbloc) {
        w <- result[[ianal]]
        su0 <- names(result)[ianal]
        scatterutil.eigen(w, xmax = neig, ymax = maxeig, wsel = 0, 
            sub = su0, csub = csub, possub = "topright",yaxt="s")
    }
    return(invisible(result))

}
