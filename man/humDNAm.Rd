\name{humDNAm}
\alias{humDNAm}
\docType{data}
\title{human mitochondrial DNA restriction data}
\description{
This data set gives the frequencies of haplotypes of mitochondrial DNA restriction data in ten populations all over the world./cr
It gives also distances among the haplotypes. 
}
\usage{data(humDNAm)}
\format{
    \code{humDNAm} is a list of 3 components.
\enumerate{
    \item{distances}{is an object of class \code{dist} with 56 haplotypes.
    These distances are computed by counting the number of differences in restriction sites between two haplotypes.}
    \item{samples}{is a data frame with 56 haplotypes, 10 abundance variables (populations). 
    These variables give the haplotype abundance in a given population.}
    \item{structures}{is a data frame with 10 populations, 1 variable (classification).
    This variable gives the name of the continent in which a given population is located}
}}
\source{
  Excoffier, L., Smouse, P.E. and Quattro, J.M. (1992) Analysis of molecular variance inferred from metric distances
  among DNA haplotypes: application to human mitochondrial DNA restriction data. \emph{Genetics}, \bold{131}, 479--491.
}
\examples{
data(humDNAm)
dpcoahum <- dpcoa(humDNAm$samples, sqrt(humDNAm$distances), scan = FALSE, nf = 2)
plot(dpcoahum)
}
\keyword{datasets}
