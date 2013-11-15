# kdist #                création jeudi, avril 3, 2003 at 13:57
# as.data.frame.kdist #  création jeudi, avril 3, 2003 at 13:57
# print.kdist #          création jeudi, avril 3, 2003 at 13:57
# [.kdist #              création jeudi, avril 3, 2003 at 13:57
# c.kdist #              création jeudi, avril 3, 2003 at 13:57
#################### kdist #################################
"kdist" <- function (..., epsi = 1e-07, upper=FALSE) {
    is.dist <- function(x) {
        if (!inherits(x,"dist")) return (FALSE)
        else return (TRUE)
    }
    is.matrix.dist <- function(m) {
        m <- as.matrix(m)
        n <- ncol(m) ; p <- nrow(m)
        if (any(is.na(m))) return ("NA values not allowed in m")
            if (n != p) return  ("Square matrix expected")
            if (sum(diag(m)^2) != 0) return ("0 in diagonal expected")
            if (min(m) < 0) return ("non negative value expected")
            if (sum((t(m) - m)^2) != 0) return ("Symetric matrice expected")
            return (NULL)
    }

    triinftodist <- function(x) {
        n0 <- length(x)
        n <- sqrt(1 + 8 * n0)
        n <- (1 + n)/2
        a <- matrix(0, ncol = n, nrow = n)
        a[row(a) > col(a)] <- x
        a <- a+t(a)
        return(a)
    } 
    trisuptodist <- function(x) {
        n0 <- length(x)
        n <- sqrt(1 + 8 * n0)
        n <- (1 + n)/2
        a <- matrix(0, ncol = n, nrow = n)
        a[row(a) < col(a)] <- x
        a <- a+t(a)
        return(a)
    }
    vecttovect <- function(x,upper) {
        attributes(x) <- NULL
        if (upper) {
            m <- trisuptodist(x)
            return(m[row(m) > col(m)])
        } else {
           return (x)
        }
    }

    as.kdist.dist <- function(list.obj) {
        # une liste d'objets de la classe dist
        f1 <- function(x) {
            attributes(x) <- NULL
            return(as.vector(x))
        }
        n <- length(list.obj)
        res <- lapply(list.obj,is.dist)
        size <- unlist(lapply(list.obj,function(x) attr(x,"Size")))
        if (any(size!=size[1])) stop ("Non equal dimension")
        size <- unique(size)
        retval <- lapply(list.obj, f1)
        res <- unlist(lapply(list.obj,is.euclid ,tol=epsi))
        if (is.null(names(retval))) {
            names(retval) <- as.character(1:n)
        }
        attr(retval, "size") <- size
        attr(retval, "labels") <- attr(list.obj[[1]],"Labels")
	if(is.null(attr(retval, "labels"))) attr(retval, "labels") <- as.character(1:size)
        attr(retval, "euclid") <- res
        return(retval)
    }
        
    as.kdist.matrix <- function(list.obj) {
        # une liste d'objets de la classe matrix
        n <- length(list.obj)
        res <- lapply(list.obj,is.matrix.dist)
        for (i in 1:n) {
            if (!is.null(res[[i]])) 
                stop (paste ("object",i,"(",res[[i]],")"))
        }
        size <- unlist(lapply(list.obj,ncol))
        if (any(size!=size[1])) stop ("Non equal dimension")
        list.obj =lapply(list.obj,as.dist)
        return (as.kdist.dist(list.obj))
     }

    as.kdist.vector <- function(list.obj,upper=upper) {
        n <- length(list.obj)
        w <- unlist(lapply(list.obj,length))
        if (any(w!=w[1])) stop ("Non equal length")
        w <- unique(w)
        size <- 0.5*(1+sqrt(1+8*w))
        if (size!=as.integer(size)) stop ("Non convenient dimension")
        retval <- lapply(list.obj, vecttovect, upper=upper)
        attr(retval, "size") <- size
        attr(retval, "labels") <- as.character(1:size)
        euclid <- logical(n)
        for (i in 1:n) {
            euclid[i] <- is.euclid(as.dist(triinftodist(retval[[i]])),tol = epsi)
        }
        if (is.null(names(retval))) {
            names(retval) <- as.character(1:length(list.obj))
        }
        attr(retval, "euclid") <- euclid
        return(retval)
    }

    list.obj <- list(...)
    compo.names <- as.character(substitute(list(...)))[-1]
    for (j in 1:length(list.obj)) {
        X <- list.obj[[j]]
        if (is.data.frame(X)) {
            init.names <- names(X)
            X <- as.matrix(X)
            X <- split(X,col(X))
        } else if (is.list(X)) {
            init.names <- names(X) 
        } else {
            X <- list(X)
            init.names <- compo.names[j]
        }
        if (all(unlist(lapply(X, is.dist)))) 
            list.obj[[j]] <- as.kdist.dist(X)
        else if (all(unlist(lapply(X, is.matrix)))) 
            list.obj[[j]] <- as.kdist.matrix(X)
        else if (all(unlist(lapply(X, is.vector)))) 
            list.obj[[j]] <- as.kdist.vector(X,upper=upper)
        else stop("Non convenient data")
        if (length(list.obj[[j]])==length(init.names) )
            names(list.obj[[j]]) <- init.names
        names(list.obj[[j]]) <- make.names(names(list.obj[[j]]))
    }
    n <- length(list.obj)
    size <- attr(list.obj[[1]],"size")
    compo.eff <- unlist(lapply(list.obj,length))
    dist.names <- unlist(lapply(list.obj,names))
    if (any(unlist(lapply(list.obj,function(x) attr(x,"size")))!=size))
        stop ("arguments imply differing size")
    euclid <-  unlist(lapply(list.obj,function(x) attr(x,"euclid")))
    labels <- attr(list.obj[[1]],"labels")
    retval <- list(NULL)
    k <- 0
    for (i in 1:n) {
        lab <- attr(list.obj[[i]],"labels")
        if( any(lab!=labels) ) stop ("arguments imply differing labels")
        w <- list.obj[[i]]
        attributes(w) <- NULL
        for (j in 1:compo.eff[[i]]) {
            k <- k+1
            retval[[k]] <- w[[j]]
        }
    }
    names(retval) <- dist.names
    attr(retval,"size") <- size
    attr(retval, "labels") <- labels
    attr(retval, "euclid") <- euclid
    attr(retval, "call") <- match.call()
    class(retval) <- "kdist"
    return(retval)
}

############# as.data.frame.kdist ######################
"as.data.frame.kdist" <- function(x, row.names=NULL, optional=FALSE,...) {
    if (!inherits (x, "kdist")) stop ("object 'kdist' expected")
    res <- as.data.frame(unclass(x))
    nind <- attr(x,"size")
    w <- matrix(0,nind,nind)
    numrow <- row(w)[row(w)>col(w)]
    numcol <- col(w)[row(w)>col(w)]
    numrow <- attr(x, "labels")[numrow]
    numcol <- attr(x, "labels")[numcol]
    cha <- paste(numrow,numcol,sep="-")
    row.names(res) <- cha
    return(res)
}

########## print.kdist #################################
"print.kdist" <- function(x,print.matrix.dist=FALSE,...) 
{
    cat("List of distances matrices\n")
    cat("call: ")
    print(attr(x,"call"))
    cat(paste("class:",class(x)))
    n <- length(x)
    cat(paste("\nnumber of distances:",n))
    npoints <- attr(x,"size")
    cat(paste("\nsize:", npoints))
    cat("\nlabels:\n")
    labels <- attr(x,"labels")
    print(labels)
    euclid <- attr(x,"euclid")
    print1 <- function (x,size,labels,...) 
    # modif error sur CRAN DAILY 18/11:2004
    # from print.dist de stats
    {
        df <- matrix(0, size, size)
        df[row(df) > col(df)] <- x
        df <- format(df)
        df[row(df) <= col(df)] <- ""
        dimnames(df) <- list(labels, labels)
        print(df, quote = FALSE, ...)
    }
    for (i in 1:n) {
        w <- x[[i]]
        cat(names(x)[i])
        if (euclid[i]) cat(": euclidean distance\n")
        else cat(": non euclidean distance\n")
        if (print.matrix.dist) {
            print1(w,npoints,labels,...)
            cat("\n")
        }
    }
}

######################## [.kdist #######################
"[.kdist" <- function(object,selection) {
    retval <- unclass(object)[selection]
    n <- attr(object,"size")
    labels <- attr(object,"labels")
    euclid <- attr(object,"euclid")
    euclid <- euclid[selection]
    attr(retval, "size") <- n
    attr(retval, "labels") <- labels
      attr(retval, "euclid") <- euclid
    attr(retval, "call") <- match.call()
    class(retval) <- "kdist"
    return(retval)
}
######################## c.kdist ###########################
c.kdist <- function(...) {
    x <- list(...)
    n <- length(x)
    compo.names <- as.character(substitute(list(...)))[-1]
    compo.eff <- unlist(lapply(x,length))
    dist.names <- unlist(lapply(x,names))
    rep.names <- paste(rep(compo.names,compo.eff),dist.names,sep=".")
    
       if (any(lapply(x,class)!="kdist")) 
           stop ("arguments imply object without 'kdist' class")
    size <- attr(x[[1]],"size")
       if (any(unlist(lapply(x,function(x) attr(x,"size")))!=size))
           stop ("arguments imply differing size")
    euclid <-  unlist(lapply(x,function(x) attr(x,"euclid")))
    labels <- attr(x[[1]],"labels")
    if (length(unique(dist.names))!=length(dist.names))
        dist.names <- rep.names
    names(euclid) <- dist.names
    retval <- list(NULL)
    k <- 0
    for (i in 1:n) {
        lab <- attr(x[[i]],"labels")
        if( any(lab!=labels) ) stop ("arguments imply differing labels")
        w <- x[[i]]
        attributes(w) <- NULL
        for (j in 1:compo.eff[[i]]) {
            k <- k+1
            retval[[k]] <- w[[j]]
           }
       }
    attr(retval,"names") <- dist.names
    attr(retval,"size") <- size
    attr(retval, "labels") <- labels
    attr(retval, "euclid") <- euclid
    attr(retval, "call") <- match.call()
    class(retval) <- "kdist" 
    return(retval)
}

