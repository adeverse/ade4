################################
# Evenly spaced labels for a score
################################
# Can be used as a legend for the Gauss curve function under.
# Takes one vector of quantitative values (abscissae) and draws lines connecting
# these abscissae to evenly spaced labels. 
################################
"sco.label" <- function(score, label) {
    if (!is.vector(score)) 
        stop("score should be a vector")
    if (!is.numeric(score)) 
        stop("score should be numeric")
    if (!is.vector(label)) 
        stop("label should be a vector")
    if (!is.character(label)) 
        stop("label should be of type character")
	nelem <- length(score)
	xmin <- min(score)
	xmax <- max(score)
	xi <- seq(xmin, xmax, by=(xmax-xmin)/(nelem-1))
	xpi <- score
	yi <- 50
	ymin <- 0
	ymax <- 100
	plot(0, type="n", xlab="", ylab="", xlim=c(xmin, xmax), ylim=c(ymin, ymax))
	rug(score)
	ord1 <- order(xpi)
	for (i in 1:nelem) {
		text(xi[i], yi, label[ord1[i]], srt=90, adj=c(0,0.7))
		lines(c(xi[i], xpi[ord1[i]]), c(49,0))
	}
	invisible(match.call())
}

################################
# Gauss curves on score categories
################################
# Takes one vector containing quantitative values and one dataframe of factors
# giving categories to wich these values belong. Computes the mean and variance
# of the values in each category for each factor, and draws a Gauss curve with
# the same mean and variance for each category and each factor.
# Can optionaly set the start and end point of the curves and the number of
# segments. The max ordinate (ymax) can also be set arbitrarily to set a common
# max for all factors (else the max is for each factor).
################################
"sco.gauss" <- function(score, fac, startp = min(score), endp = max(score), steps = 200, ymax = 0,
	sub = names(fac), csub = 2, possub = "topleft", legen = TRUE, label = row.names(fac)) {	
    if (!is.vector(score)) 
        stop("score should be a vector")
    if (!is.numeric(score)) 
        stop("score should be numeric")
    if (!is.data.frame(fac)) 
        stop("fac should be a data.frame")
    if (nrow(fac) != length(score)) 
        stop("Wrong dimensions for fac and score")
    if (!all(unlist(lapply(fac, is.factor)))) 
        stop("All variables in fac must be factors")
    opar <- par(mar = par("mar"), mfrow = par("mfrow"))
    on.exit(par(opar))
    par(mar = c(2.6, 2.6, 1.1, 1.1))
    nfig <- ncol(fac)
    par(mfrow = n2mfrow(nfig+1))
	if (legen) sco.label(score, label)
    for (i in 1:nfig) {
		nlevs <- nlevels(fac[,i])
		means <- by(score, fac[,i], mean)
		vars <- by(score, fac[,i], var)
		xi <- seq(startp, endp, by=(endp-startp)/steps)
		xmin <- min(xi)
		xmax <- max(xi)
		yi <- dnorm(xi, means[[1]], vars[[1]])
		ymin <- min(yi)
		if (ymax == 0) ymax1 <- max(yi)
		for (j in 1:nlevs) {
			yi <- dnorm(xi, means[[j]], vars[[j]])
			ymin <- min(ymin, min(yi))
			if (ymax == 0) ymax1 <- max(ymax1, max(yi))
		}
		if (ymax == 0) plot(0, type="n", xlab="", ylab="", xlim=c(xmin, xmax), ylim=c(ymin, ymax1))
			else plot(0, type="n", xlab="", ylab="", xlim=c(xmin, xmax), ylim=c(ymin, ymax))
		for (j in 1:nlevs) {
			yi <- dnorm(xi, means[[j]], vars[[j]])
			lines(xi, yi)
			ymaxi <- max(yi)
			xmaxi <- xi[yi==ymaxi]
			text(xmaxi, ymaxi, levels(fac[,i])[j], pos=3, offset=.2)
		}
		scatterutil.sub(sub[i], csub, possub)
	}
	invisible(match.call())
}

