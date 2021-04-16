\name{loocv.discrimin}
\alias{loocv.discrimin}
\title{
Leave-one-out cross-validation for a \code{discrimin} analysis
}
\description{
Leave-one-out cross-validation to test the existence of groups in a \code{discrimin} analysis.
}
\usage{
loocv.discrimin(x, progress = FALSE)
}
\arguments{
  \item{x}{
the \code{discrimin} analysis on which cross-validation should be done
}
\item{nax}{
list of axes for mean overlap index computation (0 = all axes)
}
\item{progress}{
logical to display a progress bar during computations (see the \code{progress} package)
}
}
\details{
This function returns a list containing the cross-validated coordinates of the rows. The analysis on which the \code{discrimin} was computed is redone after removing each row of the data table, one at a time. A \code{discrimin} analysis is done on this new analysis and the coordinates of the missing row are computed by projection as supplementary element in the new \code{discrimin} analysis. This can be useful to check that the groups evidenced by the \code{discrimin} analysis are supported.
}
\value{
{A list with:

- \code{XValCoord}: 
the cross-validated row coordinates 

- \code{PRESS}: 
the Predicted Residual Error Sum for each row

- \code{PRESSTot}: 
the sum of \code{PRESS} for each \code{bca} axis 

- \code{sPRESS}: 
the standardized PRESSTot 

- \code{Oij_disc}: 
the mean overlap index for the discriminant analysis

- \code{Oij_XVal}: 
the mean overlap index for cross-validation
}
}
\author{
Jean Thioulouse
}
\seealso{
\link{loocv.dudi}
\link{loocv.bca}
}
\examples{
\dontrun{
# Data = skulls
data(skulls)
pcaskul <- dudi.pca(skulls, scan = FALSE)
facskul <- gl(5,30)
diskul <- discrimin(pcaskul, facskul, scan = FALSE)
xdiskul <- loocv(diskul, progress = TRUE)
oijdisc <- xdiskul$Oij_disc
oijxval <- xdiskul$Oij_XVal
Doij <- (oijxval - oijdisc)/0.5*100
pst1 <- paste0("Skulls discrimin randtest: p=", round(randtest(diskul)$pvalue, 4), ", Oij = ", round(oijdisc,2))
pst2 <- paste0("Skulls cross-validation: Oij = ", round(oijxval,2), ", dOij = ", round(Doij), "\%")
if (adegraphicsLoaded()) {
	sc1 <- s.class(diskul$li, facskul, col = TRUE, psub.text = pst1, ellipseSize=0,
	chullSize=1, plot = FALSE)
	sc2 <- s.class(xdiskul$XValCoord, facskul, col = TRUE, psub.text = pst2,
	ellipseSize=0, chullSize=1, plot = FALSE)
	ADEgS(list(sc1, sc2), layout=c(2,2))
} else {
	par(mfrow=c(2,2))
	s.class(diskul$li, facskul, sub = pst1)
	s.class(xdiskul$XValCoord, facskul, sub = pst2)
}
data(chazeb)
pcacz <- dudi.pca(chazeb$tab, scan = FALSE)
discz <- discrimin(pcacz, chazeb$cla, scan = FALSE)
xdiscz <- loocv(discz, progress = TRUE)
oijdiscz <- xdiscz$Oij_disc
oijxvalz <- xdiscz$Oij_XVal
Doijz <- (oijxvalz - oijdiscz)/0.5*100
pst1 <- paste0("Chazeb discrimin randtest: p=", round(randtest(discz)$pvalue, 4), ", Oij = ", round(oijdiscz,2))
pst2 <- paste0("Chazeb cross-validation: Oij = ", round(oijxvalz,2), ", dOij = ", round(Doijz), "%")
if (adegraphicsLoaded()) {
	tabi <- cbind(discz$li, pcacz$tab)
	gr1 <- s.class(tabi, xax=1, yax=2:7, chazeb$cla, col = TRUE, plot = FALSE)
	for (i in 1:6) gr1[[i]] <- update(gr1[[i]], psub.text = names(tabi)[i+1],
	plot = FALSE)
	pos1 <- gr1@positions
	pos1[,1] <- c(0, .3333, .6667, 0, .3333, .6667)
	pos1[,2] <- c(.6667, .6667, .6667, .3333, .3333, .3333)
	pos1[,3] <- c(.3333, .6667, 1, .3333, .6667, 1)
	pos1[,4] <- c(1, 1, 1, .6667, .6667, .6667)
	gr1@positions <- pos1
	sc1 <- s1d.gauss(discz$li, chazeb$cla, col = TRUE, psub.text = pst1,
	plot = FALSE)
	sc2 <- s1d.gauss(xdiscz$XValCoord, chazeb$cla, col = TRUE, psub.text = pst2,
	plot = FALSE)
	ADEgS(list(gr1[[1]], gr1[[2]], gr1[[3]], gr1[[4]], gr1[[5]], gr1[[6]], sc1, sc2))
} else {
	plot(discz)
	sco.gauss(discz$li[,1], as.data.frame(chazeb$cla), sub = pst1,
	legen = FALSE)
	sco.gauss(xdiscz$XValCoord[,1], as.data.frame(chazeb$cla), sub = pst2,
	legen = FALSE)
}
}}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~dplot }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~bca }% __ONLY ONE__ keyword per line
\keyword{ ~multivariate }% __ONLY ONE__ keyword per line
