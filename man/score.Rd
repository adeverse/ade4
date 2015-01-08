\name{score}
\alias{score}
\alias{scoreutil.base}
\title{Graphs for One Dimension}
\description{
 score is a generic function. It proposes methods for the objects 'coa', 'acm', 'mix', 'pca'.}
\usage{
score(x, ...)
scoreutil.base(y, xlim, grid, cgrid, include.origin, origin, sub, csub) 
}
\arguments{
  \item{x}{an object used to select a method}
  \item{\dots}{further arguments passed to or from other methods}
  \item{y}{a numeric vector}
  \item{xlim}{the ranges to be encompassed by the x axis, if NULL they are computed}
  \item{grid}{a logical value indicating whether the scale vertical lines should be drawn}
  \item{cgrid}{a character size, parameter used with \code{par("cex")*cgrid} to indicate the mesh of the scale}
  \item{include.origin}{a logical value indicating whether the point "origin" should be belonged to the graph space}
  \item{origin}{the fixed point in the graph space, for example 0 the origin axis}
  \item{sub}{a string of characters to be inserted as legend}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
}
\details{
  \code{scoreutil.base} is a utility function - not for the user - to define the bottom of the layout of all \code{score}.
}
\seealso{\code{\link{sco.boxplot}}, \code{\link{sco.distri}}, \code{\link{sco.quant}}
}
\author{Daniel Chessel }
\examples{
\dontrun{
par(mar = c(1, 1, 1, 1))
ade4:::scoreutil.base (runif(20, 3, 7), xlim = NULL, grid = TRUE, cgrid = 0.8, 
  include.origin = TRUE, origin = 0, sub = "Uniform", csub = 1)}
# returns the value of the user coordinate of the low line.  
# The user window id defined with c(0,1) in ordinate.
# box()
}
\keyword{multivariate}
\keyword{hplot}
