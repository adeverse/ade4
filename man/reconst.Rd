\name{reconst}
\alias{reconst}
\alias{reconst.pca}
\title{Reconstitution of Data from a Duality Diagram}
\description{
Generic Function. Nowadays just reconst.pca
}
\usage{
reconst (dudi, ...)
reconst.pca (dudi, nf = 1, ...) 
}
\arguments{
  \item{dudi}{an object used to select a method}
  \item{\dots}{\code{\dots} further arguments passed to or from other methods}
  
  \item{nf}{an integer indicating the number of kept axes}
}
\value{
a data frame reconstituting the data
}
\references{Gabriel, K.R. (1978) Least-squares approximation of matrices by additive and multiplicative models. \emph{Journal of the Royal Statistical Society}, B , \bold{40}, 186--196.
}
\examples{
data(rhone)
dd1 <- dudi.pca(rhone$tab, nf = 2, scann = FALSE)
rh1 <- reconst(dd1, 1)
rh2 <- reconst(dd1, 2)
par(mfrow = c(4,4))
par(mar = c(2.6,2.6,1.1,1.1))
for (i in 1:15) {
    plot(rhone$date, rhone$tab[,i])
    lines(rhone$date, rh1[,i], lty = 2)
    lines(rhone$date, rh2[,i], lty = 1)
    scatterutil.sub(names(rhone$tab)[i], 2, "topright")
}
par(mfrow = c(1,1))
}
\keyword{multivariate}
