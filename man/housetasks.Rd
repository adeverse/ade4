\name{housetasks}
\alias{housetasks}
\docType{data}
\title{Contingency Table}
\description{
The \code{housetasks} data frame gives 13 housetasks and their repartition in the couple. 
}
\usage{data(housetasks)}
\format{
  This data frame contains four columns : wife, alternating, husband and jointly.
  Each column is a numeric vector. 
}
\source{
Kroonenberg, P. M. and Lombardo, R. (1999)
Nonsymmetric correspondence analysis: a tool for analysing contingency tables with a dependence structure.
\emph{Multivariate Behavioral Research}, \bold{34}, 367--396
}
\examples{
data(housetasks)
nsc1 <- dudi.nsc(housetasks, scan = FALSE)

if(adegraphicsLoaded()) {
  s.label(nsc1$c1, plab.cex = 1.25)
  s.arrow(nsc1$li, add = TRUE, plab.cex = 0.75)
} else {
  s.label(nsc1$c1, clab = 1.25)
  s.arrow(nsc1$li, add.pl = TRUE, clab = 0.75) 
}}
\keyword{datasets}
