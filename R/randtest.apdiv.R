randtest.apdiv <- function(xtest, nrepet = 99, ...) {
    if (!inherits(xtest, "apdiv")) stop("Object of class 'apdiv' expected for xtest")
    if (nrepet <= 1) stop("Non convenient nrepet")
    distance <- as.matrix(xtest$dis) / 2
    samples <- as.matrix(xtest$samples)
    if (any(samples != round(samples))) stop("samples should contain abundances or presences/absences")
    structures <- xtest$structures
    lesss <- xtest$results$diversity * sum(samples)
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
    Restests2 <- function(restests, lesss) {
        tests <- as.list(as.data.frame(t(cbind.data.frame(lesss[(length(lesss) - 2):1] / lesss[(length(lesss) - 1):2], t(restests)))))
        class(tests) <- "krandtest"
        return(tests)
    }
    longueurresult <- nrepet * (length(lesss) - 2)
    res <- testapdiv(distance, nrow(distance), nrow(distance), samples, nrow(samples), ncol(samples), structures, nrow(structures), ncol(structures), indic, sum(samples), nrepet, lesss[length(lesss)] / sum(samples), longueurresult)
    if (indic != 0) {
        restests <- matrix(res, nrepet, length(lesss) - 2, byrow = TRUE)
        permutationtests <- Restests2(restests, lesss)
        names(permutationtests) <- paste("Variations", c("between samples", paste("between", names(structures))))
    }
    else {
        random.values <- res
        obs.value <- lesss[1] / lesss[2]
        permutationtests <- as.randtest(sim = random.values, obs = obs.value)
    }
    return(permutationtests)
}
