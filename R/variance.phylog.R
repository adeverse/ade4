"variance.phylog" <- function (phylog, z, bynames = TRUE, na.action = c("fail", "mean")) {
    if (!is.numeric(z)) 
        stop("z is not numeric")
    n <- length(z)
    if (!inherits(phylog, "phylog")) 
        stop("Object of class 'phylog' expected")
    if (n != length(phylog$leaves)) 
        stop("Non convenient dimension")
    if (bynames) {
        if (is.null(names(z))) 
            stop("names(z) is NULL & bynames = TRUE")
        w1 <- sort(names(z))
        w2 <- sort(names(phylog$leaves))
        if (!all(w1 == w2) & bynames) {
            stop("names(z) non convenient for 'phylog' : bynames = FALSE ?")
        }
        z <- z[names(phylog$leaves)]
    }
    if (any(is.na(z))) {
        if (na.action == "fail") 
            stop(" missing values in 'z'")
        else if (na.action == "mean") 
            z[is.na(z)] <- mean(na.omit(z))
        else stop("unknown method for 'na.action'")
    }
    labels <- names(phylog$leaves)
    res <- list()
    z <- (z - mean(z))/sqrt(var(z))
    w1 <- sort(names(z))
    w2 <- sort(names(phylog$leaves))
    if (!all(w1 == w2)) {
        warning("names(z) non convenient for 'phylog' : we use the names of the leaves in 'phylog'")
        names(z) <- names(phylog$leaves)
    }
    z <- z[names(phylog$leaves)]
    vecpro <- phylog$Ascores
    npro <- ncol(vecpro)
    df <- cbind.data.frame(z, phylog$Ascores[, 1:phylog$Adim])
    begin <- paste(names(df)[1], "~", sep = "")
    fmla <- as.formula(paste(begin, paste(names(df)[-1], collapse = "+")))
    lmnull <- lm(z ~ 1, data = df)
    lm0 <- lm(fmla, data = df)
    res$lm <- lm0
    res$anova <- anova(lm0)
    a1 <- sum(res$anova$"Sum Sq"[1:phylog$Adim])
    df1 <- phylog$Adim
    r1 <- a1/df1
    a2 <- res$anova$"Sum Sq"[1 + phylog$Adim]
    df2 <- res$anova$Df[1 + phylog$Adim]
    r2 <- a2/df2
    Fvalue <- r1/r2
    proba <- 1 - pf(Fvalue, df1, df2)
    dig1 <- max(getOption("digits") - 2, 3)
    sumry <- array("", c(2, 5), list(c("Phylogenetic", "Residuals"), 
        c("Df", "Sum Sq", "Mean Sq", "F value", "Pr(>F)")))
    sumry[1, ] <- round(c(df1, a1, r1, Fvalue, proba), digits = dig1)
    sumry[2, 1:3] <- round(c(df2, a2, r2), digits = dig1)
    class(sumry) <- "table"
    res$sumry <- sumry
    return(res)
}
