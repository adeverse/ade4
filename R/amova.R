amova <- function(samples, distances = NULL, structures = NULL) {
    # checking of user's data and initialization.
    if (!inherits(samples, "data.frame")) stop("Non convenient samples")
    if (any(samples < 0)) stop("Negative value in samples")
    nhap <- nrow(samples) ;
    if (!is.null(distances)) {
        if (!inherits(distances, "dist")) stop("Object of class 'dist' expected for distances")
        if (!is.euclid(distances)) stop("Euclidean property is expected for distances")
        distances <- as.matrix(distances)^2
        if (nrow(samples)!= nrow(distances)) stop("Non convenient samples")
    }
    if (is.null(distances)) distances <- (matrix(1, nhap, nhap) - diag(rep(1, nhap))) * 2
    if (!is.null(structures)) {
        if (!inherits(structures, "data.frame")) stop("Non convenient structures")
        m <- match(apply(structures, 2, function(x) length(x)), ncol(samples), 0)
        if (length(m[m == 1]) != ncol(structures)) stop("Non convenient structures")
        m <- match(tapply(1:ncol(structures), as.factor(1:ncol(structures)), function(x) is.factor(structures[, x])), TRUE , 0)
        if (length(m[m == 1]) != ncol(structures)) stop("Non convenient structures")
    }        
    # intern functions (computations of the sums of squares and mean squares) :
    #Diversity <- function(d2, nbhaplotypes, freq) {
    # diversity index according to Rao s quadratic entropy
    #    div <- nbhaplotypes / 2 * (t(freq) %*% d2 %*% freq)
    #    return(div)
    #}      
    Ssd.util <- function(dp2, Np, unit) {
    # Deductions of the distances between two groups.
    # Deductions of the weight and composition of a group.
        if (!is.null(unit)) {
            modunit <- model.matrix(~ -1 + unit)
            sumcol <- apply(Np, 2, sum)
            Ng <- modunit * sumcol
            lesnoms <- levels(unit)
        }
        else {
            Ng <- as.matrix(Np)
            lesnoms <- colnames(Np)
        }
        sumcol <- apply(Ng, 2, sum)
        Lg <- t(t(Ng)/sumcol)
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
    Ssd <- function(distances, nbhaplotypes, samples, structures) {
    # Computation of the sum of squared deviation.
        Ph <- as.matrix(apply(samples, 1, sum) / nbhaplotypes)
        ssdt <- nbhaplotypes / 2 * t(Ph) %*% distances %*% Ph
        ssdutil <- list(0)
        ssdutil[[1]] <- Ssd.util(dp2 = distances, Np = samples, NULL)
        if (!is.null(structures)) {
            for (i in 1:length(structures)) {
                if (i != 1) {
                    unit <- structures[(1:length(structures[, i])) [!duplicated(structures[, i - 1])], i]
                    unit <- factor(unit, levels = unique(unit))
                }
                else unit <- factor(structures[, i], levels = unique(structures[, i]))
                ssdutil[[i + 1]] <- Ssd.util(ssdutil[[i]]$dg2, ssdutil[[i]]$Ng, unit)        
            }
        }    
        diversity <- c(ssdt, unlist(lapply(ssdutil, function(x) nbhaplotypes / 2 * t(x$Pg) %*% x$dg2 %*% x$Pg)))
        diversity2 <- c(diversity[-1], 0)
                ssdtemp <- diversity - diversity2
                ssd <- c(ssdtemp[length(ssdtemp):1], ssdt)     
                return(ssd)
    }
    Nbunits <- function(structures2) {
        # nb of units in each levels.
        return(apply(structures2, 2, function(x) length(levels(as.factor(x)))))
    }
    Ddl <- function(nbunits, nbhaplotypes) {
        # degrees of freedom.
        ddl1 <- c(nbunits, nbhaplotypes, nbhaplotypes)
        ddl2 <- c(1, nbunits, 1)
        ddl <- ddl1 - ddl2
        return(as.vector(ddl))
    }
    N <- function(structures, samples, nbhaplotypes, ddl) {
        # n values.
        nbind1temp <- apply(samples, 2, sum)
        nbind1 <- rep(nbind1temp, nbind1temp)
        nbhapl <- rep(nbhaplotypes, nbhaplotypes)
        if (!is.null(structures)) {
            nbind <- lapply(as.list(structures), function(x) tapply(nbind1temp, x, sum)[as.numeric(x)])
            nbind <- lapply(nbind, function(x) rep(x, nbind1temp))
            nbind <- c(list(nbhapl), nbind[length(nbind):1], list(nbind1))
        }
        else nbind <- c(list(nbhapl), list(nbind1))
        n1 <- as.vector(tapply((2:length(nbind)), as.factor(2:length(nbind)), function(x) (nbhaplotypes - (sum((nbind[[x]]) / nbind[[x-1]])))))
        ddlutil <- ddl[(length(ddl) - 2):1]        
        if (!is.null(structures)) {
            N2 <- function(x) {
                tapply((x + 1):length(nbind), as.factor((x + 1):length(nbind)), function(i) sum(nbind[[i]] * (1 / nbind[[x]] - 1 / nbind[[x - 1]])))
            }
            n <- rep(0, sum(1:(dim(structures)[2] + 1)))
            n1 <- n1[length(n1):1]
            n[cumsum(1:(dim(structures)[2] + 1))] <- n1        
            if ((length(nbind) - 1) >= 2) {
                n2 <- as.vector(unlist(tapply(2:(length(nbind) - 1), as.factor(2:(length(nbind) - 1)), N2)))
                n2 <- n2[length(n2):1]
                n[-(cumsum(1:(dim(structures)[2] + 1)))] <- n2
            }
            ddlutil <- ddlutil[rep(1:(dim(structures)[2] + 1), 1:(dim(structures)[2] + 1))]
        }            
        else n <- n1                
        n <- n / ddlutil
        return(n)
    }
    Cm <- function(ssd, ddl) {
        # mean squares.
        return(c(ssd / ddl))
    }
    Sigma <- function(cm, n) {
        # covariance components.
        cmutil <- cm[(length(cm) - 1):1]
        sigma2W <- cmutil[1]
        res <- rep(0, length(cm) - 1)
        res[1] <- sigma2W
        res[2] <- (cmutil[2] - sigma2W) / n[1]
        if (length(res) > 2) {
            for (i in 3:(length(cm) - 1)) {
                index <- cumsum(c(2, (2:(length(cm) - 1))))
                ni <- n[index[i - 2]:(index[i - 1] - 2)]
                nj <- n[index[i - 1] - 1]
                si <- ni * res[2:(i - 1)]
                res[i] <- (cmutil[i] - sigma2W - sum(si)) / nj
           }
        }
        sigma2t <- sum(res)
        return(c(res[length(res):1], sigma2t))
    }
    Pourcent <- function(sigma) {
        # covariance percentages.
        return(sigma / sigma[length(sigma)] * 100)
    }
    Procedure <- function(distances, nbhaplotypes, samples, structures, ddl) {
        ssd <- Ssd(distances, nbhaplotypes, samples, structures)
        cm <- Cm(ssd, ddl)
        n <- N(structures, samples, nbhaplotypes, ddl)
        sigma <- Sigma(cm, n)
        return(list(ssd = ssd, cm = cm, sigma = sigma, n = n))
    }
    Statphi <- function(sigma) {
        # Phi-statistics.
        f <- rep(0, length(sigma) - 1)
        if (length(sigma) == 3) {
            f <- rep(0, 1)
        }
        f[1] <- (sigma[length(sigma)] - sigma[length(sigma) - 1]) / sigma[length(sigma)]
        if (length(f) > 1) {
            s1 <- cumsum(sigma[(length(sigma) - 1):2])[-1]
            s2 <- sigma[(length(sigma) - 2):2]
            f[length(f)] <- sigma[1] / sigma[length(sigma)]        
            f[2:(length(f) - 1)] <- s2 / s1
        }
        return(f)
    }        
    # main procedure.
    nbhaplotypes <- sum(samples)
    if (!is.null(structures)) {
        structures2 <- cbind.data.frame(structures[length(structures):1], as.factor(colnames(samples, do.NULL = FALSE)))
    }
    else structures2 <- as.data.frame(as.factor(colnames(samples, do.NULL = FALSE)))
    nbunits <- Nbunits(structures2)
    ddl <- Ddl(nbunits, nbhaplotypes)
    proc <- Procedure(distances, nbhaplotypes, samples, structures, ddl)
    ssd <- proc$ssd
    cm <- proc$cm
    sigma <- proc$sigma

    # Interface.
    if (!is.null(structures)) {
        lesnoms1 <- rep("Between", ncol(structures) + 1)
        lesnoms2 <- c(names(structures)[ncol(structures):1], "samples")
        lesnoms3 <- c("", rep("Within", ncol(structures)))
        lesnoms4 <- c("", names(structures)[ncol(structures):1])
        lesnoms <- c(paste(lesnoms1, lesnoms2, lesnoms3, lesnoms4), "Within samples", "Total")
    }
    else lesnoms <- c("Between samples", "Within samples", "Total")
    pourcent <- Pourcent(sigma)        
    results <- data.frame(ddl, ssd, cm)
    names(results) <- c("Df", "Sum Sq", "Mean Sq")
    rownames(results) <- lesnoms
    sourceofvariation <- c(paste("Variations ", rownames(results)[1:(nrow(results) - 1)]), "Total variations")
    componentsofcovariance <- data.frame(sigma, pourcent)
    names(componentsofcovariance) <- c("Sigma", "%")
    rownames(componentsofcovariance) <- sourceofvariation
    call <- match.call()
    res <- list(call = call, results = results, componentsofcovariance = componentsofcovariance, distances = as.dist(distances), samples = samples, structures = structures)
    f <- Statphi(sigma)
    statphi <- as.data.frame(f)
    names(statphi) <- "Phi"
    lesnoms1 <- c(rep("Phi", length(f)))
    if (length(f) == 1) {
        lesnoms2 <- c("samples")
        lesnoms3 <- c("total")
    }
    else {
        lesnoms2 <- c(rep("samples", 2), names(structures))
        lesnoms3 <- c("total", names(structures), "total")
    }
    rownames(statphi) <- paste(lesnoms1, lesnoms2, lesnoms3, sep = "-")
    res <- list(call = call, results = results, componentsofcovariance = componentsofcovariance, statphi = statphi, distances = as.dist(distances), samples = samples, structures = structures)
    class(res) <- "amova"
    return(res)
}

print.amova <- function(x, full = FALSE, ...) {
    if (full == TRUE) print(x)
    else print(x[-((length(x) - 2):length(x))])
}
