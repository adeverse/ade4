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
    opar <- graphics::par(mar = graphics::par("mar"), mfrow = graphics::par("mfrow"))
    on.exit(graphics::par(opar))
    graphics::par(mar = c(2.6, 2.6, 1.1, 1.1))
    nfig <- ncol(df)
    graphics::par(mfrow = grDevices::n2mfrow(nfig))
    for (i in 1:nfig) {
        graphics::plot(score, df[, i], type = "n")
        if (!is.null(fac)) {
            s.class(cbind.data.frame(score, df[, i]), fac, 
                axesell = FALSE, add.plot = TRUE, clabel = clabel)
        }
        else graphics::points(score, df[, i])
        if (abline) {
            graphics::abline(stats::lm(df[, i] ~ score))
        }
        scatterutil.sub(sub[i], csub, possub)
    }
}
