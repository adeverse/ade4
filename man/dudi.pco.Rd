\name{dudi.pco}
\alias{dudi.pco}
\alias{scatter.pco}
\title{Principal Coordinates Analysis}
\description{
\code{dudi.pco} performs a principal coordinates analysis of a Euclidean distance matrix
and returns the results as objects of class \code{pco} and \code{dudi}. 
}
\usage{
dudi.pco(d, row.w = "uniform", scannf = TRUE, nf = 2, 
    full = FALSE, tol = 1e-07)
scatter.pco (x, xax = 1, yax = 2, clab.row = 1, posieig = "top", 
    sub = NULL, csub = 2, \dots) 
}
\arguments{
  \item{d}{an object of class 'dist' containing an Euclidean distance matrix.}
  \item{row.w}{an optional distance matrix row weights. 
  If not null, must be a vector of positive numbers with length equal to the size of the distance matrix}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{full}{a logical value indicating whether all the axes should be kept}
  \item{tol}{a tolerance threshold to test whether the distance matrix is Euclidean :
    an eigenvalue is considered positive if it is larger than 
  \code{-tol*lambda1} where \code{lambda1} is the largest eigenvalue.}\cr\cr
      
  \item{x}{an object of class \code{pco}}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{clab.row}{a character size for the row labels}
  \item{posieig}{if "top" the eigenvalues bar plot is upside,
    if "bottom" it is downside, if "none" no plot}
  \item{sub}{a string of characters to be inserted as legend}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
\code{dudi.pco} returns a list of class \code{pco} and \code{dudi}. See \code{\link{dudi}}
}
\references{Gower, J. C. (1966) Some distance properties of latent root and vector methods used in multivariate analysis. \emph{Biometrika}, \bold{53}, 325--338.
}
\author{
Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}
}
\examples{
data(yanomama)
gen <- quasieuclid(as.dist(yanomama$gen))
geo <- quasieuclid(as.dist(yanomama$geo))
ant <- quasieuclid(as.dist(yanomama$ant))
geo1 <- dudi.pco(geo, scann = FALSE, nf = 3)
gen1 <- dudi.pco(gen, scann = FALSE, nf = 3)
ant1 <- dudi.pco(ant, scann = FALSE, nf = 3)
plot(coinertia(ant1, gen1, scann = FALSE))
}
\keyword{array}
\keyword{multivariate}
