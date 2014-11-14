mdpcoa <- function(msamples, mdistances = NULL, method = c("mcoa", "statis", "mfa"), option = c("inertia", "lambda1", "uniform", "internal"), scannf = TRUE, nf = 3, full = TRUE, nfsep = NULL, tol = 1e-07)
{
    if(!is.null(mdistances)){
        if(length(msamples) != length(mdistances)) stop("uncorrect data")
    }
    method <- method[1]
    nbloci <- length(msamples)
    npop <- ncol(msamples[[1]])
    if(nbloci == 1) stop("multiloci data are needed")
    if(any(nfsep < 2)) stop("The number of axes kept for the separated analyses should be higher than 1")
    YesY <- list()
    YesX <- list()
    option <- option[1]
    valoption <- rep(0, nbloci)
    if (option == "internal") {
        if (is.null(msamples$tabw) && is.null(mdistances$tabw)) {
            warning("Internal weights not found: uniform weigths are used")
            option <- "uniform"
        }
        else{
            if (is.null(msamples$tabw) || is.null(mdistances$tabw))
                valinternal <- c(msamples$tabw, mdistances$tabw)
            else{
                valinternal <- msamples$tabw
            }
        }
            
    }
    if(full == TRUE || !is.null(nfsep))
        scansep <- FALSE
    else
        scansep <- TRUE
    for(i in 1:nbloci)
    {
        if(!is.null(nfsep[i])){
            nf1 <- nfsep[i]
        }
        else
            nf1 <- 2
        dpcoasep <- dpcoa(data.frame(t(msamples[[i]])), mdistances[[i]], scannf = scansep, full = full, nf = nf1, tol = tol)
        YesY[[i]] <- dpcoasep$li
        YesX[[i]] <- dpcoasep$dls
        
        if (option == "lambda1")
            valoption[i] <- 1/(dpcoasep$eig[1])
        
        else if (option == "inertia") {
            valoption[i] <- 1/sum(dpcoasep$eig)
        }
        else if (option == "uniform") {
            valoption[i] <- 1
        }
        else if (option == "internal") 
            valoption[i] <- valinternal[i]  
    }
    names(YesY) <- names(msamples)
    names(YesX) <- names(msamples)
    
    weig1 <- as.vector(apply(msamples[[1]], 2, sum))
    sum1 <- sum(msamples[[1]])

    for(i in 2:nbloci)
    {
        weig1 <- weig1 + as.vector(apply(msamples[[i]], 2, sum))
        sum1 <- sum1 + sum(msamples[[i]])

    }
    weig1 <- weig1/sum1

    YesY <- ktab.list.df(YesY, w.row = weig1, w.col = lapply(YesY, function(x) rep(1, ncol(x))))

    coord <- list()

    if(method == "mcoa")
    {
        mdpcoa1 <- mcoa(YesY, option[1], scannf = scannf, nf = nf)
        nf <- mdpcoa1$nf
        increm <- lapply(YesY, ncol)
        increm <- c(0, cumsum(as.vector(unlist(increm))))
              
        for(i in 1:nbloci)
        {
            X <- mdpcoa1$Tli[(1:npop) + npop * (i - 1), ]
            norm <- apply(X * X * YesY$lw, 2, sum)
            norm[norm <= tol * max(norm)] <- 1
            coord[[i]] <- sqrt(valoption[i]) * (as.matrix(YesX[[i]]) %*% as.matrix(mdpcoa1$axis[(increm[i]+1):increm[i+1], ])) %*% diag(1/sqrt(norm))
        }
        coordX <- t(cbind.data.frame(lapply(coord,t)))
        mdpcoa1$cosupX <- coordX
        mdpcoa1$nX <- as.vector(unlist(lapply(YesX, nrow)))
        class(mdpcoa1) <- c("mdpcoa", "mcoa")
    }

    if(method == "statis")
    {
        mdpcoa1 <- statis(YesY, scannf = scannf, nf = nf)
        nf <- mdpcoa1$C.nf
        coY <- list()
        coX <- list()
        norm <- apply(mdpcoa1$C.li * mdpcoa1$C.li * YesY$lw, 2, sum)
        norm[norm <= tol * max(norm)] <- 1
        for(i in 1:nbloci)
        {
            coY[[i]] <- as.matrix(YesY[[i]])%*%t(YesY[[i]])%*%diag(YesY$lw)%*%as.matrix(mdpcoa1$C.li[, 1:nf])%*%diag(1/norm)
            coX[[i]] <- as.matrix(YesX[[i]])%*%t(YesY[[i]])%*%diag(YesY$lw)%*%as.matrix(mdpcoa1$C.li[, 1:nf])%*%diag(1/norm)
        }
        coordY <- t(cbind.data.frame(lapply(coY,t)))
        coordX <- t(cbind.data.frame(lapply(coX,t)))
        mdpcoa1$cosupY <- coordY
        mdpcoa1$cosupX <- coordX
        mdpcoa1$nX <- as.vector(unlist(lapply(YesX, nrow)))
        class(mdpcoa1) <- c("mdpcoa", "statis")
    }

    if(method == "mfa")
    {
        mdpcoa1 <- mfa(YesY, option[1], scannf = scannf, nf = nf)
        nf <- mdpcoa1$nf
        for(i in 1:nbloci)
        {
            interm <- (valoption[i]* t(YesY[[i]]))
            interm2 <- as.matrix(mdpcoa1$l1) * mdpcoa1$lw
            coord[[i]] <- (as.matrix(YesX[[i]])%*% interm)%*% interm2
        }
        coordX <- t(cbind.data.frame(lapply(coord,t)))
        mdpcoa1$nX <- as.vector(unlist(lapply(YesX, nrow)))
        mdpcoa1$cosupX <- coordX
        class(mdpcoa1) <- c("mdpcoa", "mfa")
    }
    
    return(mdpcoa1)

}


kplotX.mdpcoa <- function(object, xax = 1, yax = 2, mfrow = NULL, 
         which.tab = 1:length(object$nX), includepop = FALSE, clab = 0.7, cpoi = 0.7, 
         unique.scale = FALSE, csub = 2, possub = "bottomright")
{


    if (!inherits(object, "mdpcoa")) 
        stop("Object of type 'mdpcoa' expected")

    opar <- par(ask = par("ask"), mfrow = par("mfrow"), mar = par("mar"))

    on.exit(par(opar))
    if (is.null(mfrow)) 
        mfrow <- n2mfrow(length(which.tab))
    par(mfrow = mfrow)
    if (length(which.tab) > prod(mfrow)) 
        par(ask = TRUE)
    nbloc <- length(object$nX)

    increm <- rep(1:nbloc, object$nX)
        
    nf <- ncol(object$cosupX)
    if (xax > nf) 
        stop("Non convenient xax")
    if (yax > nf) 
        stop("Non convenient yax")
    cootot <- object$cosupX[, c(xax, yax)]
    label <- TRUE
    if(inherits(object, "mcoa"))
        namloci <- rownames(object$cov2)
    else 
        namloci <- object$tab.names
    for (ianal in which.tab) {
        coocol <- cootot[increm == ianal, ]
        if (unique.scale) 
            s.label(cootot, clabel = 0, cpoint = 0, sub = namloci[ianal], 
                possub = possub, csub = csub)
        else s.label(coocol, clabel = 0, cpoint = 0, sub = namloci[ianal], 
            possub = possub, csub = csub)
        if (label) 
            s.label(coocol, clabel = ifelse(includepop, 0, clab), cpoint = cpoi, add.plot = TRUE)
        if (includepop)
        {
            if(inherits(object, "mcoa"))
                s.label(object$Tl1[object$TL[, 1] == levels(object$TL[,1])[ianal], c(xax, yax)], clabel = clab, cpoint = 0, add.plot = TRUE)
            else if (inherits(object, "statis")){
                npop <- nrow(object$C.li)
                s.label(object$cosupY[(1:npop) + npop * (ianal - 1), c(xax, yax)], clabel = clab, cpoint = 0, add.plot = TRUE)
                }
            else if (inherits(object, "mfa")){
                npop <- nrow(object$li)
                s.label(object$lisup[(1:npop) + npop * (ianal - 1), c(xax, yax)], clabel = clab, cpoint = 0, add.plot = TRUE)
                }
        }
    }

}

prep.mdpcoa <- function(dnaobj, pop, model, ...)
{
    
        if(!is.factor(pop)) stop("pop should be a factor")

        fun1 <- function(x){
            sam1 <- model.matrix(~ -1 + pop)
            colnames(sam1) <- levels(pop)
            sam1 <- as.data.frame(sam1)        
            dis1 <- ape::dist.dna(dnaobj[[x]], model[x], ...)                      
            prep <- lapply(dnaobj[[x]], paste, collapse=  "")
            prep <- unlist(prep)
            lprep <- length(prep)
            prepind <- (1:lprep)[!duplicated(prep)]
            fprep <- factor(prep, levels = unique(prep))        
            sam1 <- apply(sam1, 2, function(x) tapply(x, fprep, sum))
            sam1 <- as.data.frame(sam1)
            rownames(sam1) <- paste("a", 1:nrow(sam1), sep="")           
            dis1 <- as.dist(as.matrix(dis1)[prepind, prepind])            
            attributes(dis1)$Labels <- rownames(sam1)
            alleleseq <- dnaobj[[x]][!duplicated(prep)]
            names(alleleseq) <- rownames(sam1)
            res <- list(pop = sam1, dis = dis1, alleleseq = alleleseq)
            return(res)
        }

        sauv <- lapply(1:length(dnaobj), fun1)       
        sam <- lapply(sauv, function(x) x[[1]])
        dis <- lapply(sauv, function(x) x[[2]])
        alleleseq <- lapply(sauv, function(x) x[[3]])
        names(dis) <- names(alleleseq) <- names(sam) <- names(dnaobj)
        return(list(sam = sam, dis = dis, alleleseq = alleleseq))      
}
