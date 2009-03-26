\name{supcol}
\alias{supcol}
\alias{supcol.coa}
\alias{supcol.default}
\title{Projections of Supplementary Columns}
\description{
performs projections of supplementary columns. 
}
\usage{
supcol(x, \dots)
\method{supcol}{default}(x, Xsup, \dots) 
\method{supcol}{coa}(x, Xsup, \dots) 
}
\arguments{
  \item{x}{an object used to select a method}
  \item{Xsup}{an array with the supplementary columns (\code{Xsup} and \code{x$tab} have the same row number)}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{
If \code{supcol.default} is used, the column vectors of \code{Xsup} are projected without prior modification onto the principal components of dudi with the scalar product associated to the row weightings of dudi.
}
\value{A list of two components:
    \item{\code{tabsup}}{data frame containing the array with the supplementary columns transformed or not}
    \item{\code{cosup}}{data frame containing the coordinates of the supplementary projections}
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(rpjdl)
rpjdl.coa <- dudi.coa(rpjdl$fau, scan = FALSE, nf = 4)
rpjdl.coa$co[1:3,]
supcol (rpjdl.coa,rpjdl$fau[,1:3])$cosup # the same

data(doubs)
dudi1 <- dudi.pca(doubs$poi, scal = FALSE, scan = FALSE)
s.arrow(dudi1$co)
s.arrow(supcol.default(dudi1,data.frame(scalewt(doubs$mil)))$cosup,
    add.p = TRUE, clab = 2)
symbols(0, 0, circles = 1, inches = FALSE, add = TRUE)
}
\keyword{multivariate}
