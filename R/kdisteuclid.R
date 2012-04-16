kdisteuclid <- function(obj,method=c("lingoes","cailliez","quasi")) {

    if (is.null(class(obj))) stop ("Object of class 'kdist' expected")
    if (class(obj)!="kdist") stop ("Object of class 'kdist' expected")
    
    choice <- match.arg(method)
    
    lingo.1 <- function(x,size) {
        mat <- matrix(0, size, size)
        mat[row(mat) > col(mat)] <- x
        mat <- mat + t(mat)
        delta <- -0.5 * bicenter.wt(mat*mat)
        lambda <- eigen(delta, symmetric = TRUE, only.values = TRUE)$values
        lder <- lambda[ncol(mat)]
        mat <- sqrt(mat * mat + 2 * abs(lder))
        mat <- unclass(mat[row(mat) > col(mat)])
        print(paste("Lingoes constant =", abs(lder)))
        return(mat)
    }

    quasi.1 <- function(x,size) {
        mat <- matrix(0, size, size)
        mat[row(mat) > col(mat)] <- x
        mat <- mat + t(mat)
        delta <- -0.5 * bicenter.wt(mat*mat)
        eig <- eigen(delta, symmetric = TRUE)
        ncompo <- sum(eig$value>0)
        tabnew <- t( t(eig$vectors[,1:ncompo])*sqrt(eig$values[1:ncompo]) )
        mat <- unclass(dist.quant(tabnew,1))
        print(paste("First ev =", eig$value[1], "Last ev =", eig$value[size]))
        return(mat)
    }
    
    cailliez.1 <- function(x,size) {
        mat <- matrix(0, size, size)
            mat[row(mat) > col(mat)] <- x
            mat <- mat + t(mat)
            m1 <- matrix(0,size,size)
            m1 <- rbind(m1,-diag(size))
        m2 <- -bicenter.wt(mat*mat)
            m2 <- rbind(m2, 2*bicenter.wt(mat))
            m1 <- cbind(m1,m2)
            lambda <- eigen(m1,only.values = TRUE)$values
        c <- max(Re(lambda)[Im(lambda)<1e-08])
        print(paste("Cailliez constant =", c))
        return(x+c)
    }

    n <- attr(obj,"size")
    ndist <- length(obj)
    euclid <- attr(obj,"euclid")
    for (i in 1:ndist) {
        if (!euclid[i]) {
        if (choice=="lingoes") obj[[i]] <- lingo.1(obj[[i]],n) 
            else if (choice=="cailliez") obj[[i]] <- cailliez.1(obj[[i]],n)
            else if (choice=="quasi") obj[[i]] <- quasi.1(obj[[i]],n)
            else (stop ("unknown method"))
        }
    }
    attr(obj, "euclid") <- rep(TRUE, ndist)
    attr(obj, "call") <- match.call()
    return(obj)
}

