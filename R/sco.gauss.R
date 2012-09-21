################################
# Gauss curves on score categories
################################
# Takes one vector containing quantitative values and one dataframe of factors
# giving categories to wich these values belong. Computes the mean and variance
# of the values in each category for each factor, and draws a Gauss curve with
# the same mean and variance for each category and each factor.
# Can optionaly set the start and end point of the curves (xlim) and the number # of segments. 
################################
"sco.gauss" <- function(score, df, xlim = NULL, steps = 200, ymax = NULL, sub = names(df), csub = 1.25, possub = "topleft", legen = TRUE, label = row.names(df), clabel = 1, grid = TRUE, cgrid = 1, include.origin = TRUE, origin = c(0,0) ) {	
  if (!is.vector(score)) 
    stop("score should be a vector")
  if (!is.numeric(score)) 
    stop("score should be numeric")
  if (!is.data.frame(df)) 
    stop("df should be a data.frame")
  if (nrow(df) != length(score)) 
    stop("Wrong dimensions for df and score")
  if (!all(unlist(lapply(df, is.factor)))) 
    stop("All variables in df must be factors")
  opar <- par(mar = par("mar"), mfrow = par("mfrow"))
  on.exit(par(opar))
  par(mar=rep(0.1, 4))
  nfig <- ncol(df)
  par(mfrow = n2mfrow(nfig+1))
  if (legen){
    par(mfrow = n2mfrow(nfig+1))
    sco.label(score = score, label = label, clabel = clabel, grid = grid, cgrid = cgrid, include.origin = include.origin, origin = origin )
  } else {
    par(mfrow = n2mfrow(nfig)) 
  }
  
  
  for (i in 1:nfig) {
    res <- scatterutil.sco(score = score, lim = xlim, grid = grid, cgrid = cgrid, include.origin = include.origin, origin = origin, sub = sub[i], csub = csub, horizontal = TRUE, reverse = FALSE)
    nlevs <- nlevels(df[,i])
    means <- by(score, df[,i], mean)
    sds <- by(score, df[,i], sd)
    xi <- seq(res[1], res[2], by=(res[2]-res[1])/steps)
    yi <- lapply(1:nlevs,function(x) dnorm(xi, means[[x]], sds[[x]]))
    if(is.null(ymax)){
      maxy <- (max(unlist(yi))) * 1.15
    } else {
      maxy <- ymax
    }
    for (j in 1:nlevs) {
     
      lines(xi, yi[[j]] * (1 - res[3])/maxy + res[3])
      xmaxi <- xi[which.max(yi[[j]])]
      ymaxi <- max(yi[[j]])
      text(xmaxi, ymaxi * (1 - res[3])/maxy + res[3], levels(df[,i])[j], pos=3, offset=.2, cex=clabel * par("cex"))
    }
    
  }
  invisible(match.call())
}

