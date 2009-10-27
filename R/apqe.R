apqe <- function(samples, dis = NULL, structures = NULL){

    # checking of user's data and initialization.
    if (!inherits(samples, "data.frame")) stop("Non convenient samples")

    if (any(as.matrix(samples) <= -1e-8)) stop("Negative value in samples")

    nhap <- nrow(samples) ; nsam <- ncol(samples)

    if (!is.null(dis)) {
        if (!inherits(dis, "dist")) stop("Object of class 'dist' expected for distance")
        if (!is.euclid(dis)) stop("Euclidean property is expected for distance")
        dis <- as.matrix(dis)^2
        if (nrow(samples)!= nrow(dis)) stop("Non convenient samples")
    }
    if (is.null(dis)) dis <- (matrix(1, nhap, nhap) - diag(rep(1, nhap))) * 2
    if (!is.null(structures)) {
        if (!inherits(structures, "data.frame")) stop("Non convenient structures")
        m <- match(apply(structures, 2, function(x) length(x)), ncol(samples), 0)
        if (length(m[m == 1]) != ncol(structures)) stop("Non convenient structures")
        m <- match(tapply(1:ncol(structures), as.factor(1:ncol(structures)), function(x) is.factor(structures[, x])), TRUE , 0)
        if (length(m[m == 1]) != ncol(structures)) stop("Non convenient structures")
    }
    # intern functions (computations of the sums of squares and mean squares):
    Diversity <- function(d2, nbhaplotypes, freq){
        # diversity index according to Rao s quadratic entropy
        div <- nbhaplotypes / 2 * (t(freq) %*% d2 %*% freq)
    }    
    Ssd.util <- function(dp2, Np, unit){
        # Dissimilarity between two groups. Weight and composition of a group.      
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
    Ssd <- function(dis, nbhaplotypes, samples, structures) {
    # Computation of the sum of squared deviation.
        Ph <- as.matrix(apply(samples, 1, sum) / nbhaplotypes)
        ssdt <- nbhaplotypes / 2 * t(Ph) %*% dis %*% Ph
        ssdutil <- list(0)
        ssdutil[[1]] <- Ssd.util(dp2 = dis, Np = samples, NULL)
        if (!is.null(structures)) {
            for (i in 1:length(structures)) {
                if (i != 1) {
                    unit <- structures[(1:length(structures[, i]))[!duplicated(structures[, i - 1])], i]
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
    # main procedure.
    nbhaplotypes <- sum(samples)
    ssd <- Ssd(dis, nbhaplotypes, samples, structures) / nbhaplotypes
    # Interface.
    if (!is.null(structures)) {
        lesnoms1 <- rep("Between", ncol(structures) + 1)
        lesnoms2 <- c(names(structures)[ncol(structures):1], "samples")
        lesnoms3 <- c("", rep("Within", ncol(structures)))
        lesnoms4 <- c("", names(structures)[ncol(structures):1])
        lesnoms <- c(paste(lesnoms1, lesnoms2, lesnoms3, lesnoms4), "Within samples", "Total")
    }
    else lesnoms <- c("Between samples", "Within samples", "Total")    
    results <- data.frame(ssd)
    names(results) <- c("diversity")
    rownames(results) <- lesnoms
    sourceofvariation <- c(paste("Variations ", rownames(results)[1:(nrow(results) - 1)]), "Total variations")
    call <- match.call()
    res <- list(call = call, results = results, dis = as.dist(dis), samples = samples, structures = structures)    
    class(res) <- "apqe"
    return(res)
}

print.apqe <- function(x, full = FALSE, ...){
    if (full == TRUE) print(x)
    else print(x[-((length(x) - 2):length(x))])
}
