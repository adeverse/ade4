\name{friday87}
\alias{friday87}
\docType{data}
\title{Faunistic K-tables}
\description{
This data set gives informations about sites, species and environmental variables
}
\usage{data(friday87)}
\format{
    \code{friday87} is a list of 4 components.
    \enumerate{
    \item{fau}{is a data frame containing a faunistic table with 16 sites and 91 species.}
    \item{mil}{is a data frame with 16 sites and 9 environmental variables.}
    \item{fau.blo}{is a vector of the number of species per group.}
    \item{tab.names}{is the name of each group of species.}
    }
}
\source{
Friday, L.E. (1987) The diversity of macroinvertebrate and macrophyte communities in ponds.,\emph{Freshwater Biology}, \bold{18}, 87--104.
}
\examples{
data(friday87)
wfri <- data.frame(scale(friday87$fau, scal = FALSE))
wfri <- ktab.data.frame(wfri, friday87$fau.blo, 
    tabnames = friday87$tab.names)
kplot(sepan(wfri), clab.r = 2, clab.c = 1)
}
\keyword{datasets}
