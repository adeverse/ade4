\name{mstree}
\alias{mstree}
\title{ Minimal Spanning Tree }
\description{
  Minimal Spanning Tree
}
\usage{
mstree(xdist, ngmax = 1)
}
\arguments{
  \item{xdist}{ an object of class \code{dist} containing an observed dissimilarity }
  \item{ngmax}{ a component number (default=1). Select 1 for getting classical MST. To add n supplementary edges k times: select k+1. }
}
\value{
returns an object of class \code{neig}
}
\author{ Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} }
\examples{
data(mafragh)
maf.coa = dudi.coa(mafragh$flo, scan = FALSE)
maf.mst = mstree(dist.dudi(maf.coa), 1)
s.label(maf.coa$li, clab = 0, cpoi = 2, neig = maf.mst, cnei = 1)

xy = data.frame(x = runif(20), y = runif(20))
par(mfrow = c(2,2))
for (k in 1:4) {
    neig = mstree (dist.quant(xy,1), k)
    s.label(xy, xlim = c(0,1), ylim = c(0,1), addax = FALSE, neig = neig)
 }
}
\keyword{ utilities }
