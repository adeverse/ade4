########## mantelkdist ###############
########## RVkdist ###################
########## print.corkdist ############
########## summary.corkdist ##########
########## plot.corkdist #############

"mantelkdist" <- function(kd, nrepet = 999) {
    if (!inherits(kd,"kdist")) stop ("Object of class 'kdist' expected")
    res <- list()
    ndist <- length(kd)
    nind <- attr(kd, "size")
    if (nrepet<=99) nrepet <- 99
    w <- matrix(0,ndist,ndist)
    numrow <- row(w)[row(w)>col(w)]
    numcol <- col(w)[row(w)>col(w)]
    w <- cbind.data.frame(I = numrow,J = numcol)
    numrow <- attr(kd, "names")[numrow]
    numcol <- attr(kd, "names")[numcol]
    cha <- paste(numrow,numcol,sep="-")
    row.names(w) <- cha
    attr(res,"design") <- w
    
    kdistelem2dist    <- function (i) {
        m1 <- matrix(0, nind, nind)
        m1[row(m1) > col(m1)] <- kd[[i]]
        m1 <- m1 + t(m1)
        m1 <- as.dist(m1)
        m1
    }
    k <- 0
    for(i in 1:(ndist-1)) {
        m1 <- kdistelem2dist(i)
        for(j in (i+1):ndist) {
            m2 <- kdistelem2dist(j)
            k <- k+1
            w <- mantel.randtest (m1, m2, nrepet)
            w$call <- match.call()
            res[[k]] <- w
        }
    }    
    names (res) <- cha
    attr (res,"call") <- match.call()
    attr (res,"test") <- "Mantel's tests"
    class(res) <- c("corkdist","list")
    return(res)
}

"RVkdist" <- function(kd, nrepet = 999) {
    if (!inherits(kd,"kdist")) stop ("Object of class 'kdist' expected")
    if (any(!attr(kd,"euclid"))) stop ("Euclidean matrices expected")
    res=list()
    ndist <- length(kd)
    nind <- attr(kd, "size")
    if (nrepet<=99) nrepet <- 99
    w <- matrix(0,ndist,ndist)
    numrow <- row(w)[row(w)>col(w)]
    numcol <- col(w)[row(w)>col(w)]
    w <- cbind.data.frame(I = numrow,J = numcol)
    numrow <- attr(kd, "names")[numrow]
    numcol <- attr(kd, "names")[numcol]
    cha <- paste(numrow,numcol,sep="-")
    row.names(w) <- cha
    attr(res,"design") <- w
    
    kdistelem2dist    <- function (i) {
        m1 <- matrix(0, nind, nind)
        m1[row(m1) > col(m1)] <- kd[[i]]
        m1 <- m1 + t(m1)
        m1 <- as.dist(m1)
        m1
    }
    k <- 0
    for(i in 1:(ndist-1)) {
        m1 <- kdistelem2dist(i)
        for(j in (i+1):ndist) {
            m2 <- kdistelem2dist(j)
            k <- k+1
            w <- RVdist.randtest (m1, m2, nrepet)
            w$call <- match.call()
            res[[k]] <- w
        }
    }    
    names (res) <- cha
    attr (res,"call") <- match.call()
    attr (res,"test") <- "RV tests"
    class(res) <- c("corkdist","list")
    return(res)
}

"print.corkdist" <- function (x, ...) {
    if (!inherits(x,"corkdist")) stop ("Object 'corkdist' expected")
    cat(attr (x,"test"),"for 'kdist' object\n")
    cat("class: ") ; cat(class(x),"\n")
    cat ("Call: ") ; print(attr (x,"call"))
    cat("\n") ; cat(names(x)[1],"\n")
    print.randtest (x[[1]])
    if (length(x)>2) {
        cat("\n") ; cat(names(x)[2],"\n")
        print.randtest (x[[2]])
     }
     if (length(x)==3) {
        cat("\n") ; cat(names(x)[3],"\n")
        print.randtest (x[[3]])
     }
     if (length(x)>33) {
        cat("...\n")
     }
   cat("list of",length (x), "'randtest' objects\n")
}

summary.corkdist <- function (object, ...) {
    if (!inherits(object,"corkdist")) stop ("Object 'corkdist' expected")
    design <- attr(object, "design")
    cat(attr (object,"test"),"for 'kdist' object\n")  
    cat ("Call: ") ; print(attr (object,"call"))
    ndig0 <- nchar(as.character(as.integer(object[[1]]$rep)))
    pval <- round(unlist(lapply(object, function(x) x$pvalue)), digits = ndig0)
    ndist <- max(design$I)
    res=matrix(0,ndist,ndist)
    res[row(res) <= col(res)] <- NA
    dist.names <- names(eval.parent(as.list(attr(object,"call"))$kd))
    dimnames(res) <- list(dist.names, as.character(1:length(dist.names)))
    res[row(res) > col(res)] <- pval
    cat("Simulated p-values:\n")
    print(res, na = "-", ...)
}


plot.corkdist <- function (x, whichinrow=NULL, whichincol=NULL, gap=4, nclass = 10, coeff = 1, ...) {
    "hist.simul.util" <- function(sim, obs, nclass, coeff, title="") {
        r0 <- c(sim, obs)
        h0 <- hist(sim, plot = FALSE, nclass = nclass, xlim = xlim0)
        y0 <- max(h0$counts)
        l0 <- max(sim) - min(sim)
        w0 <- l0/(log(length(sim), base = 2) + 1)
        w0 <- w0 * coeff
        xlim0 <- range(r0) + c( - w0, w0)
        hist(sim, plot = TRUE, nclass = nclass, xlim = xlim0, main=title, col=grey(0.9))
        lines(c(obs, obs), c(y0/2, 0))
        points(obs, y0/2, pch = 18, cex = 2)
    }
    kdistelem2delta    <- function (i) {
        m1 <- matrix(0, nind, nind)
        m1[row(m1) > col(m1)] <- kd[[i]]
        m1 <- m1 + t(m1)
        m1 <- -m1*m1/2
        m1 <- bicenter.wt(m1)
        return(m1[row(m1) > col(m1)])
    }

    if (!inherits(x,"corkdist")) stop ("Object of class 'corkdist' expected")
    kd <- eval.parent(as.list(attr(x,"call"))$kd)
    design <- attr(x, "design")
    ndist <- length (kd)
    if (is.null(whichinrow)) whichinrow <- 1:ndist
    if (is.null(whichincol)) whichincol <- 1:ndist
    labels = names(kd)
    nind <- attr(kd, "size")
    old.par <- par(no.readonly = TRUE)
    on.exit(par(old.par))
    oma <- c(2, 2, 1, 1)
    par(mfrow = c(length(whichinrow), length(whichincol)), mar = rep(gap/2, 4), oma = oma)
    for (i in whichinrow) {
        for (j in whichincol) {
            if (i==j) {
                plot.default(0,0,type="n",asp=1, xlab="", ylab="",xaxt="n",yaxt="n",
                xlim=c(0,1), ylim=c(0,1), xaxs="i", yaxs="i", frame.plot=FALSE)
                l.wid <- strwidth(labels, "user")
                cex.labels <- max(0.8, min(2, 0.9/max(l.wid)))
                text(0.5, 0.5, labels[i], cex = cex.labels, font = 1)
            } else if (i>j) {
                n0 <- (1:nrow(design))[design$I==i & design$J==j]
                sim <- x[[n0]]$sim
                obs <- x[[n0]]$obs
                titre <- row.names(design)[n0]
                hist.simul.util(sim,obs,title=titre,nclass=nclass,coeff=coeff)
            } else if (j>i) {
                if (attr(x,"test")=="Mantel's tests")
                    plot(kd[[i]],kd[[j]])
                else {
                    plot(kdistelem2delta(i),kdistelem2delta(j))
                    
                }
            }
        }
    }
}


