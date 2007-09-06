\name{scatter.acm} 
\alias{scatter.acm}
\title{Plot of the factorial maps in a Multiple Correspondence Analysis}
\description{
performs the scatter diagrams of a Multiple Correspondence Analysis. 
}
\usage{
scatter.acm(x, xax = 1, yax = 2, mfrow=NULL, csub = 2, possub = "topleft", ...)
}
\arguments{
  \item{x}{an object of class \code{acm}}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{mfrow}{a vector of the form "c(nr,nc)", if NULL (the default) is 
  computed by \code{n2mfrow}}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the legend position ("topleft", 
    "topright", "bottomleft", "bottomright") in a array of figures}
  \item{\dots}{further arguments passed to or from other methods}
}
\author{Daniel Chessel }
\examples{
data(lascaux)
scatter(dudi.acm(lascaux$ornem, sca = FALSE), csub = 3)
}
\keyword{multivariate}
\keyword{hplot}
