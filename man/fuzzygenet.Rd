\name{fuzzygenet}
\alias{fuzzygenet}
\title{ Reading a table of genetic data (diploid individuals) }
\description{
  Reads data like \code{char2genet} without a priori population
}
\usage{
fuzzygenet(X)
}
\arguments{
  \item{X}{ a data frame of strings of characters (individuals in row, locus in variables), the value coded '000000' or two alleles of 6 characters }
}
\details{
  In entry, a row is an individual, a variable is a locus and a value is a string of characters, for example, 
  012028 for a heterozygote carying alleles 012 and 028; 020020 for a homozygote carrying two alleles 020 and
  000000 for a not classified locus (missing data).
  
  In exit, a fuzzy array with the following encoding for a locus:\cr
  0 0   1   \dots   0 for a homozygote \cr
  0 0.5 0.5 \dots   0 for a heterozygote \cr
  p1    p2  p3  \dots   pm for an unknown where (p1 p2  p3  \dots   pm) is the observed allelic frequencies for all tha available data.
}
\value{
  returns a data frame with the 6 following attributs:
  \item{col.blocks }{a vector containing the number of alleles by locus}
  \item{all.names }{a vector containing the names of alleles}
  \item{loc.names }{a vector containing the names of locus}
  \item{row.w }{a vector containing the uniform weighting of rows}
  \item{col.freq }{a vector containing the global allelic frequencies}
  \item{col.num }{a factor ranking the alleles by locus}
}
\references{ ~put references to the literature/web site here ~ }
\author{ Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} }
\note{ In the exit data frame, the alleles are numbered 1, 2, 3, \dots by locus and the loci are called L01, L02, L03, \dots for the simplification of listing.
The original names are kept. 
}
\seealso{ \code{\link{char2genet}} if you have the a priori definition of the groups of individuals (populations). It may be used on the created object \code{dudi.fca}
}
\examples{
data(casitas)
casitas[1:5, ]
casitas <- fuzzygenet(casitas)
attributes(casitas)
rm(casitas)
}
\keyword{ multivariate }
