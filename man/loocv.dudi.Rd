\name{loocv.dudi}
\alias{loocv.dudi}
\alias{loocv}
\title{
Leave-one-out cross-validation for a \code{dudi}
}
\description{
Leave-one-out cross-validation to check the dispersion of row coordinates in a \code{dudi}.
}
\usage{
\method{loocv}{dudi}(x, progress = FALSE, \dots)
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
This function returns a list with two elements: \code{$XValCoord} and  \code{$lsFac}, the cross-validated row coordinates and a factor to plot them. The analysis is redone after removing each row of the data table, one at a time. The coordinates of the missing row are computed by projection as supplementary element in the \code{dudi} space. This can be used to check the dispersion of the coordinates of one point and it's sensitivity to outliers.
}
\value{
{a list with two elements: \code{$XValCoord} and \code{$lsFac} containing the cross-validated row coordinates and the factor to plot them using the \code{s.class} (see example).}
}
\author{
Jean Thioulouse
}
\seealso{
\link{suprow}
}
\examples{
data(meaudret)
envpca <- dudi.pca(meaudret$env, scannf = FALSE, nf = 3)
xvpca <- loocv(envpca)
s.match(envpca$li, xvpca$XValCoord)
}

\keyword{ ~dplot }
\keyword{ ~multivariate }
