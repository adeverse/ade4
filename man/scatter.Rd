\name{scatter}
\alias{scatter}
\alias{biplot.dudi}
\alias{screeplot.dudi}
\title{Graphical representation of the outputs of a multivariate analysis}
\description{
\code{scatter} is a generic function that has methods for the classes
\code{coa}, \code{dudi}, \code{fca}, \code{acm} and \code{pco}.
It plots the outputs of a multivariate analysis by representing
simultaneously the rows and the colums of the original table
(biplot). The function \code{biplot} returns exactly the same
representation. \cr
The function \code{screeplot} represents the amount of inertia (usually
variance) associated to each dimension.
}
\usage{
scatter(x, \dots)
\method{biplot}{dudi}(x, \dots)
\method{screeplot}{dudi}(x, npcs = length(x$eig), type = c("barplot", "lines"), 
    main = deparse(substitute(x)), col = c(rep("black", x$nf), rep("grey", npcs - x$nf)), \dots)
}
\arguments{
  \item{x}{an object of the class \code{dudi} containing the outputs of
    a multivariate analysis}
  \item{npcs}{the number of components to be plotted}
  \item{type}{the type of plot}
  \item{col}{a vector of colors}
  \item{\dots}{further arguments passed to or from other methods}
}
\seealso{\code{\link{s.arrow}}, \code{\link{s.chull}}, \code{\link{s.class}}, 
\code{\link{s.corcircle}}, \code{\link{s.distri}}, \code{\link{s.label}}, 
\code{\link{s.match}}, \code{\link{s.traject}}, \code{\link{s.value}}, \code{\link{add.scatter}}
}
\author{Daniel Chessel \cr
Stephane Dray \email{stephane.dray@univ-lyon1.fr}}
\examples{
data(rpjdl)
rpjdl.coa <- dudi.coa(rpjdl$fau, scannf = FALSE, nf = 4)
screeplot(rpjdl.coa)
biplot(rpjdl.coa)
}
\keyword{multivariate}
\keyword{hplot}
