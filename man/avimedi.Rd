\name{avimedi}
\alias{avimedi}
\docType{data}
\title{Fauna Table for Constrained Ordinations}
\description{
\code{avimedi} is a list containing the informations about 302 sites : \cr
frequencies of 51 bird species ; two factors (habitats and Mediterranean origin). 
}
\usage{data(avimedi)}
\format{
  This list contains the following objects:
  \describe{
    \item{fau}{is a data frame 302 sites - 51 species. }
    \item{plan}{is a data frame 302 sites - 2 factors. }
    \item{nomesp}{is a vector 51 latin names. }
  }
}
\source{
Blondel, J., Chessel, D., & Frochot, B. (1988)
Bird species impoverishment, niche expansion, and density inflation in mediterranean island habitats.
\emph{Ecology}, \bold{69}, 1899--1917
}
\examples{
\dontrun{
data(avimedi)
par(mfrow = c(2,2))
coa1 <- dudi.coa(avimedi$fau, scan = FALSE, nf = 3)
s.class(coa1$li,avimedi$plan$str:avimedi$plan$reg,
    sub = "Correspondences Analysis")
bet1 <- between(coa1, avimedi$plan$str, scan = FALSE)
s.class(bet1$ls, avimedi$plan$str,
    sub = "Between Analysis")
wit1 <- within(coa1, avimedi$plan$reg, scan=FALSE)
s.class(wit1$li, avimedi$plan$str,
    sub = "Within Analysis")
pcaiv1 <- pcaiv(coa1, avimedi$plan, scan = FALSE)
s.match(pcaiv1$li, pcaiv1$ls, clab = 0,
    sub = "Canonical Correspondences Analysis")
s.class(pcaiv1$li, avimedi$plan$str:avimedi$plan$reg, 
    add.plot = TRUE)
par(mfrow=c(1,1))
}}
\keyword{datasets}
