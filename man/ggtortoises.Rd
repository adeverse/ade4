\name{ggtortoises}
\alias{ggtortoises}
\docType{data}
\title{Microsatellites of Galapagos tortoises populations}
\description{
This data set gives genetic relationships between Galapagos tortoises populations with 10 microsatellites. 
}
\usage{data(ggtortoises)}
\format{
    \code{ggtortoises} is a list of 6 components. 
    \describe{
        \item{area}{is a data frame designed to be used in area.plot function.}
        \item{ico}{is a list of three pixmap icons representing the tortoises morphotypes.}
        \item{pop}{is a data frame containing meta informations about populations.}
        \item{misc}{is a data frame containing the coordinates of the island labels.}
        \item{loc}{is a numeric vector giving the number of alleles by marker.}
        \item{tab}{is a data frame containing the number of alleles by populations for 10 microsatellites.} 
    }
}
\source{
M.C. Ciofi, C. Milinkovitch, J.P. Gibbs, A. Caccone, and J.R. Powell (2002) Microsatellite analysis of genetic divergence among populations of giant galapagos tortoises.
\emph{Molecular Ecology} \bold{11}: 2265-2283.
}
\references{
M.C. Ciofi, C. Milinkovitch, J.P. Gibbs, A. Caccone, and J.R. Powell (2002) Microsatellite analysis of genetic divergence among populations of giant galapagos tortoises.
\emph{Molecular Ecology} \bold{11}: 2265-2283.

See a data description at \url{http://pbil.univ-lyon1.fr/R/pps/pps069.pdf} (in French).
}
\examples{
data(ggtortoises)
a1 <- ggtortoises$area
area.plot(a1)
rect(min(a1$x), min(a1$y), max(a1$x), max(a1$y), col = "lightblue")
invisible(lapply(split(a1, a1$id), function(x) polygon(x[, -1],col = "white")))
s.label(ggtortoises$misc, ,grid=F,include.ori=F,addaxes=F,add.p=T)
listico <- ggtortoises$ico[as.character(ggtortoises$pop$carap)]
s.logo(ggtortoises$pop,listico,add.p=T)
}
\keyword{datasets}
