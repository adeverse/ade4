\name{kplot.foucart}
\alias{kplot.foucart}
\title{Multiple Graphs for the Foucart's Correspondence Analysis}
\description{
performs high level plots of a Foucart's Correspondence Analysis, 
using an object of class \code{foucart}.  
}
\usage{
kplot.foucart(object, xax = 1, yax = 2, mfrow = NULL, 
    which.tab = 1:length(object$blo), clab.r = 1, clab.c = 1.25, 
    csub = 2, possub = "bottomright", \dots)
}
\arguments{
  \item{object}{an object of class \code{foucart} }
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{mfrow}{a vector of the form 'c(nr,nc)', otherwise computed by as special own function \code{n2mfrow}}
  \item{which.tab}{vector of table numbers for analyzing}
  \item{clab.r}{a character size for the row labels}
  \item{clab.c}{a character size for the column labels}
  \item{csub}{a character size for the sub-titles used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{\dots}{further arguments passed to or from other methods}
}
\author{Daniel Chessel }
\examples{
data(bf88)
fou1 <- foucart(bf88, scann = FALSE, nf = 3)
kplot(fou1, clab.r = 0, clab.c = 2, csub = 3)
}
\keyword{multivariate}
\keyword{hplot}
