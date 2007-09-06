disc <- function(samples, dis = NULL, structures=NULL){
    # checking of user's data and initialization.
    if (!inherits(samples, "data.frame")) stop("Non convenient samples")
    if (any(samples < 0)) stop("Negative value in samples")
    if (any(apply(samples, 2, sum) < 1e-16)) stop("Empty samples")
    if (!is.null(dis)) {
        if (!inherits(dis, "dist")) stop("Object of class 'dist' expected for distance")
        if (!is.euclid(dis)) stop("Euclidean property is expected for distance")
        dis <- as.matrix(dis)
        if (nrow(samples)!= nrow(dis)) stop("Non convenient samples")
    }
    if (is.null(dis)) dis <- (matrix(1, nrow(samples), nrow(samples)) - diag(rep(1, nrow(samples)))) * sqrt(2)
    if (!is.null(structures)){
        if (!inherits(structures, "data.frame")) stop("Non convenient structures")
        m <- match(apply(structures, 2, function(x) length(x)), ncol(samples), 0 )
        if (length(m[m == 1]) != ncol(structures)) stop ("Non convenient structures")
        m <- match(tapply(1:ncol(structures), as.factor(1:ncol(structures)), function(x) is.factor(structures[, x])), TRUE , 0)
        if(length(m[m == 1]) != ncol(structures)) stop ("Non convenient structures")
    }
    # Intern functions :
    ##Diversity <- function(d2, nbhaplotypes, freq) {
    ##   div <- nbhaplotypes/2*(t(freq)%*%d2%*%freq)
    ##}
    Structutil <- function(dp2, Np, unit){    
        if (!is.null(unit)) {
            modunit <- model.matrix(~ -1 + unit)
            sumcol <- apply(Np, 2, sum)
            Ng <- modunit * sumcol
            lesnoms <- levels(unit)
        }
        else{
            Ng <- as.matrix(Np)
            lesnoms <- colnames(Np)
        }
        sumcol <- apply(Ng, 2, sum)
        Lg <- t(t(Ng) / sumcol)
        colnames(Lg) <- lesnoms
        Pg <- as.matrix(apply(Ng, 2, sum) / nbhaplotypes)
        rownames(Pg) <- lesnoms
        deltag <- as.matrix(apply(Lg, 2, function(x) t(x) %*% dp2 %*% x))
        ug <- matrix(1, ncol(Lg), 1)
        dg2 <- t(Lg) %*% dp2 %*% Lg - 1 / 2 * (deltag %*% t(ug) + ug %*% t(deltag))
        colnames(dg2) <- lesnoms
        rownames(dg2) <- lesnoms
        return(list(dg2 = dg2, Ng = Ng, Pg = Pg))
    }
    Diss <- function(dis, nbhaplotypes, samples, structures){
        structutil <- list(0)
        structutil[[1]] <- Structutil(dp2 = dis, Np = samples, NULL)
        diss <- list(sqrt(as.dist(structutil[[1]]$dg2)))
        if(!is.null(structures)){
            for(i in 1:length(structures)){
                structutil[[i+1]] <- Structutil(structutil[[1]]$dg2, structutil[[1]]$Ng, structures[,i])    
            }
            diss <- c(diss, tapply(1:length(structures), factor(1:length(structures)), function(x) sqrt(as.dist(structutil[[x + 1]]$dg2))))
        }
        return(diss)
    }
    # main procedure.
    nbhaplotypes <- sum(samples)    
    diss <- Diss(dis^2, nbhaplotypes, samples, structures)
    names(diss) <- c("samples", names(structures))
    # Interface.
    if (!is.null(structures)) {
        return(diss)
    }
    return(diss$samples)
}
