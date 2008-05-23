randtest.amova <- function(xtest, nrepet = 99, ...) {
    if (!inherits(xtest, "amova")) stop("Object of class 'amova' expected for xtest")
    if (nrepet <= 1) stop("Non convenient nrepet")
    distances <- as.matrix(xtest$distances) / 2
    samples <- as.matrix(xtest$samples)
    structures <- xtest$structures
    ddl <- xtest$results$Df
    ddl[1:(length(ddl) - 1)] <- ddl[(length(ddl) - 1):1]
    sigma <- xtest$componentsofcovariance$Sigma
    lesss <- xtest$results$"Sum Sq"
    if (is.null(structures)) {
        structures <- cbind.data.frame(rep(1, nrow(samples)))
        indic <- 0
    }
    else {
        for (i in 1:ncol(structures)) {
            structures[, i] <- factor(as.numeric(structures[, i]))
        }
        indic <- 1
    }
    if (indic != 0) {
        longueurresult <- nrepet * (length(sigma) - 1)
        res <- testamova(distances, nrow(distances), nrow(distances), samples, nrow(samples), ncol(samples), structures, nrow(structures), ncol(structures), indic, sum(samples), nrepet, lesss[length(lesss)] / sum(samples), ddl, longueurresult)
        restests <- matrix(res, nrepet, length(sigma) - 1, byrow = TRUE)
        
        permutationtests <- as.krandtest(sim=restests,obs=sigma[(length(sigma) - 1):1],names= paste("Variations", c("within samples", "between samples", paste("between", names(structures)))),alter=c("less","greater","greater"),call=match.call())
    }
    else {
        longueurresult <- nrepet * (length(sigma) - 2)
        res <- testamova(distances, nrow(distances), nrow(distances), samples, nrow(samples), ncol(samples), structures, nrow(structures), ncol(structures), indic, sum(samples), nrepet, lesss[length(lesss)] / sum(samples), ddl, longueurresult)
        permutationtests <- as.randtest(res, sigma[1])
    }
    return(permutationtests)
}
