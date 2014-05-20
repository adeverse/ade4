\name{dudi.nsc}
\alias{dudi.nsc}
\title{Non symmetric correspondence analysis}
\description{
performs a non symmetric correspondence analysis. 
}
\usage{
dudi.nsc(df, scannf = TRUE, nf = 2)
}
\arguments{
  \item{df}{a data frame containing positive or null values}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
}
\value{
Returns a list of class \code{nsc} and \code{dudi} (see \code{\link{dudi}}) containing also
  \item{N}{sum of the values of the initial table}
}
\references{Kroonenberg, P. M., and Lombardo  R. (1999) Nonsymmetric correspondence analysis: 
a tool for analysing contingency tables with a dependence structure. \emph{Multivariate Behavioral Research}, \bold{34}, 367--396.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}
}
\examples{
data(housetasks)
nsc1 <- dudi.nsc(housetasks, scan = FALSE)
s.label(nsc1$c1, clab = 1.25)
s.arrow(nsc1$li, add.pl = TRUE, clab = 0.75) # see ref p.383
}
\keyword{multivariate}
