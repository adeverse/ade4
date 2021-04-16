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
This function does a cross-validation of the row coordinates of a dudi. Each row is removed from the table one at a time, and its coordinates are computed by projection of this row in the analysis of the table with the removed row. This can be used to check the sensitivity of an analysis to outliers. The cross-validated and original coordinates can be compared with the \code{s.match} function (see example).
}
\value{
{A list with:

- \code{XValCoord}: 
the cross-validated row coordinates 

- \code{PRESS}: 
the Predicted Residual Error Sum for each row

- \code{PRESSTot}: 
the sum of \code{PRESS} for each \code{bca} axis 
}
}
\author{
Jean Thioulouse
}
\seealso{
\link{loocv.between}, \link{loocv.discrimin}, \link{suprow}, \link{s.match}
}
\examples{
data(meaudret)
envpca <- dudi.pca(meaudret$env, scannf = FALSE, nf = 3)
xvpca <- loocv(envpca)
s.match(envpca$li, xvpca$XValCoord)
}

\keyword{dplot}
\keyword{multivariate}
