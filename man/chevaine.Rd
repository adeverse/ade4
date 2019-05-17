\name{chevaine}
\docType{data}
\alias{chevaine}
\title{Enzymatic polymorphism in Leuciscus cephalus}
\description{
  This data set contains a list of three components: spatial map, allellic profiles and sample sizes.
} 
\usage{data(chevaine)} 
\format{
This data set is a list of three components:
  \describe{
    \item{tab}{ a data frame with 27 populations and 9 allelic frequencies (4 locus)}
    \item{coo}{ a list containing all the elements to build a spatial map}
    \item{eff}{ a numeric containing the numbers of fish samples per station}
  }
} 
\references{
Guinand B., Bouvet Y. and Brohon B. (1996) Spatial aspects of genetic differentiation of the European 
chub in the Rhone River basin. \emph{Journal of Fish Biology}, \bold{49}, 714--726.

See a data description at \url{http://pbil.univ-lyon1.fr/R/pdf/pps054.pdf} (in French).
}
\examples{
data(chevaine)
names(chevaine)
str(chevaine)
} 
\keyword{datasets}
