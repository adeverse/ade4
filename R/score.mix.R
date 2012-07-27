"score.mix" <- function (x, xax = 1, csub = 2, mfrow = NULL, which.var = NULL, ...) {
    if (!inherits(x, "mix")) 
        stop("For 'mix' object")
    if (x$nf == 1) 
        xax <- 1
    lm.pcaiv <- function(x, df, weights, use) {
        if (!inherits(df, "data.frame")) 
            stop("data.frame expected")
        reponse.generic <- x
        begin <- "reponse.generic ~ "
        fmla <- as.formula(paste(begin, paste(names(df), collapse = "+")))
        df <- cbind.data.frame(reponse.generic, df)
        lm0 <- lm(fmla, data = df, weights = weights)
        if (use == 0) 
            return(predict(lm0))
        else if (use == 1) 
            return(residuals(lm0))
        else if (use == -1) 
            return(lm0)
        else stop("Non convenient use")
    }
    def.par <- par(no.readonly = TRUE)
    on.exit(par(def.par))
    oritab <- eval.parent(as.list(x$call)[[2]])
    nvar <- length(x$index)
    if (is.null(which.var)) 
        which.var <- (1:nvar)
    index <- as.character(x$index)
    if (is.null(mfrow)) 
        par(mfrow = n2mfrow(length(which.var)))
    if (prod(par("mfrow")) < length(which.var)) 
        par(ask = TRUE)
    sub <- names(oritab)
    par(mar = c(2.6, 2.6, 1.1, 1.1))
    score <- x$l1[, xax]
    for (i in which.var) {
        type.var <- index[i]
        col.var <- which(x$assign == i)
        if (type.var == "q") {
            if (length(col.var) == 1) {
                y <- x$tab[, col.var]
                plot(score, y, type = "n")
                points(score, y, pch = 20)
                abline(lm(y ~ score), lwd = 2)
            }
            else {
                y <- x$tab[, col.var]
                plot(score, y[, 1], type = "n")
                points(score, y[, 1], pch = 20)
                score.est <- lm.pcaiv(score, y, w = rep(1, nrow(y))/nrow(y), 
                  use = 0)
                ord0 <- order(y[, 1])
                lines(score.est[ord0], y[, 1][ord0], lwd = 2)
            }
        }
        else if (type.var == "f") {
            y <- oritab[, i]
            moy <- unlist(tapply(score, y, mean))
            plot(score, score, type = "n")
            h <- (max(score) - min(score))/40
            abline(h = moy)
            segments(score, moy[y] - h, score, moy[y] + h)
            abline(0, 1)
            scatterutil.eti(moy, moy, label = as.character(levels(y)), 
                clabel = 1)
        }
        else if (type.var == "o") {
            y <- x$tab[, col.var]
            plot(score, y[, 1], type = "n")
            points(score, y[, 1], pch = 20)
            score.est <- lm.pcaiv(score, y, w = rep(1, nrow(y))/nrow(y), 
                use = 0)
            ord0 <- order(y[, 1])
            lines(score.est[ord0], y[, 1][ord0])
        }
        scatterutil.sub(sub[i], csub, "topleft")
    }
}
