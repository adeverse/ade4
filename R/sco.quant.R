"sco.quant" <- function (score, df, fac = NULL, clabel = 1, abline = FALSE,
    sub = names(df), csub = 2, possub = "topleft") 
{
    if (!is.vector(score)) 
        stop("vector expected for score")
    if (!is.numeric(score)) 
        stop("numeric expected for score")
    if (!is.data.frame(df)) 
        stop("data.frame expected for df")
    if (nrow(df) != length(score)) 
        stop("Not convenient dimensions")
    if (!is.null(fac)) {
        fac <- factor(fac)
        if (length(fac) != length(score)) 
            stop("Not convenient dimensions")
    }
    opar <- par(mar = par("mar"), mfrow = par("mfrow"))
    on.exit(par(opar))
    par(mar = c(2.6, 2.6, 1.1, 1.1))
    nfig <- ncol(df)
    par(mfrow = n2mfrow(nfig))
    for (i in 1:nfig) {
        plot(score, df[, i], type = "n")
        if (!is.null(fac)) {
            s.class(cbind.data.frame(score, df[, i]), fac, 
                axesell = FALSE, add.plot = TRUE, clabel = clabel)
        }
        else points(score, df[, i])
        if (abline) {
            abline(lm(df[, i] ~ score))
        }
        scatterutil.sub(sub[i], csub, possub)
    }
}
