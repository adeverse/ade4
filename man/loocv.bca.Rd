\name{loocv.between}
\alias{loocv.between}
\title{
Leave-one-out cross-validation for a \code{bca}
}
\description{
Leave-one-out cross-validation to test the existence of spurious groups in \code{bca} in the case p (number of variables) > n (number of samples).
}
\usage{
\method{loocv}{between}(x, progress = FALSE, \dots)
}
\arguments{
  \item{x}{
the dudi of the \code{bca} on which cross-validation should be done
}
  \item{progress}{
logical to display a progress bar during computations (see the \code{progress} package)
}
 \item{\dots}{further arguments passed to or from other methods}
}
\details{
This function returns a list containing the cross-validated coordinates of the rows (the rows of the original analysis, not the rows of the \code{bca}). The analysis on which the \code{bca} was computed is redone after removing each row of the data table, one at a time. A \code{bca} is done on this new analysis and the coordinates of the missing row are computed by projection as supplementary element in the corresponding \code{bca}. This is mostly useful in the case p >> n (many variables and few samples), where \code{bca} graphs can show spurious groups (see Refs.)
}
\value{
{A list with the cross-validated row coordinates \code{XValCoord}, the Predicted Residual Error Sum (\code{PRESS}, for each row and \code{PRESSTot}, its sum for each \code{bca} axis), the Root Mean Square Error (\code{RMSE}) and the IQR-standardized RMSE (\code{RMSEIQR}) for each \code{bca} axis. 
}
}
\references{
Cardini A, O'Higgins P, Rohlf J. Seeing Distinct Groups Where There are None: Spurious Patterns from Between-Group PCA. Evolutionary Biology (2019) 46:303-316

Cardini A, Polly D. Cross-validated Between Group PCA Scatterplots: A Solution to Spurious Group Separation? Evolutionary Biology (2020) https://doi.org/10.1007/s11692-020-09494-x

Bookstein F. Pathologies of Between-Groups Principal Components Analysis in Geometric Morphometrics. Evolutionary Biology (2019) 46:271-302
}
\author{
Jean Thioulouse
}
\seealso{
\link{loocv.dudi}
\link{loocv.discrimin}
}
\examples{
# Data = meaudret
data(meaudret)
pca1 <- dudi.pca(meaudret$env, scannf = FALSE, nf = 3)
bca1 <- bca(pca1, meaudret$design$site, scannf = FALSE, nf = 3)
pst1 <- paste0("Meaudret BGA randtest: p=",
randtest(bca1)$pvalue, " ratio=", round(bca1$ratio, 2))

if(adegraphicsLoaded()){
    sc1 <- s.class(bca1$ls, meaudret$design$site, col = TRUE,
    psub.text = pst1, ellipseSize=0, chullSize=1, plot = FALSE)
    xbca1 <- loocv(bca1, progress = TRUE)
    sc2 <- s.class(xbca1$XValCoord, meaudret$design$site,
    col = TRUE, psub.text = "Meaudret cross-validation",
    ellipseSize=0, chullSize=1, plot = FALSE)
    ADEgS(list(sc1, sc2))
}
\dontrun{
# Data = rnorm()
set.seed(9)
fac1 <- as.factor(rep(1:3, each = 10))
tab <- as.data.frame(matrix(rnorm(10800), nrow = 30))
pca2 <- dudi.pca(tab, scannf = FALSE)
bca2 <- bca(pca2, fac1, scannf = FALSE)
pst2 <- paste0("rnorm spurious groups: p=",
randtest(bca2)$pvalue, " ratio=", round(bca2$ratio, 2))
sc3 <- s.class(bca2$ls, fac1, col = TRUE,
psub.text = pst2, ellipseSize=0, chullSize=1,
xlim = c(-8, 8), ylim = c(-8, 8), plot = FALSE)
xbca2 <- loocv(bca2, progress = TRUE)
sc4 <- s.class(xbca2$XValCoord, fac1, col = TRUE,
psub.text = "rnorm cross-validation", ellipseSize=0,
chullSize=1, xlim = c(-8, 8), ylim = c(-8, 8), plot = FALSE)
ADEgS(list(sc3, sc4))}}

\keyword{dplot}
\keyword{multivariate}
