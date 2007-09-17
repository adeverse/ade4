\encoding{latin1}
\name{withinpca}
\alias{withinpca}
\title{Normed within Principal Component Analysis}
\description{
performs a normed within Principal Component Analysis. 
}
\usage{
withinpca(df, fac, scaling = c("partial", "total"), 
    scannf = TRUE, nf = 2)
}
\arguments{
  \item{df}{a data frame with quantitative variables}
  \item{fac}{a factor distributing the rows of df in classes}
  \item{scaling}{a string of characters as a scaling option : \cr
    if "partial", for each factor level, the sub-array is centred and normed.\cr
    If "total", for each factor level, the sub-array is centred and the total array is then normed.}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
}
\value{
returns a list of the sub-class \code{within} of class \code{dudi'}. See \code{\link{within}}
}
\references{Bouroche, J. M. (1975) \emph{Analyse des données ternaires: la double analyse en composantes principales}. 
 Thèse de 3ème cycle, Université de Paris VI.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(meaudret)
wit1 <- withinpca(meaudret$mil, meaudret$plan$dat, 
    scan = FALSE, scal = "partial")
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5"), 4))
unclass(kta1)
# See pta
plot(wit1)
}
\keyword{multivariate}
