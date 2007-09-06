\name{s.kde2d}
\alias{s.kde2d}
\title{ Scatter Plot with Kernel Density Estimate }
\description{
  performs a scatter of points without labels by a kernel Density Estimation in One or Two Dimensions
}
\usage{
s.kde2d(dfxy, xax = 1, yax = 2, pch = 20, cpoint = 1, neig = NULL, cneig = 2, 
    xlim = NULL, ylim = NULL, grid = TRUE, addaxes = TRUE, cgrid = 1, 
    include.origin = TRUE, origin = c(0, 0), sub = "", csub = 1.25, 
    possub = "bottomleft", pixmap = NULL, contour = NULL, 
    area = NULL, add.plot = FALSE)
}
\arguments{
  \item{dfxy}{ a data frame with at least two coordinates }
  \item{xax}{ the column number for the x-axis }
  \item{yax}{ the column number for the y-axis}
  \item{pch}{ if \code{cpoint} > 0, an integer specifying the symbol or the
          single character to be used in plotting points }
  \item{cpoint}{ a character size for plotting the points, used with
          \code{par("cex")*cpoint}. If zero, no points are drawn }
  \item{neig}{ a neighbouring graph }
  \item{cneig}{ a size for the neighbouring graph lines used with
          par("lwd")*\code{cneig} }
  \item{xlim}{ the ranges to be encompassed by the x axis, if NULL, they are
          computed }
  \item{ylim}{ the ranges to be encompassed by the y axis, if NULL, they are
          computed }
  \item{grid}{ a logical value indicating whether a grid in the background
          of the plot should be drawn }
  \item{addaxes}{ a logical value indicating whether the axes should be plotted }
  \item{cgrid}{ a character size, parameter used with par("cex")* 'cgrid' to
          indicate the mesh of the grid }
  \item{include.origin}{ a logical value indicating whether the point "origin"
          should be belonged to the graph space }
  \item{origin}{ the fixed point in the graph space, for example c(0,0) the
          origin axes }
  \item{sub}{ a string of characters to be inserted as legend }
  \item{csub}{ a character size for the legend, used with \code{par("cex")*csub} }
  \item{possub}{ a string of characters indicating the sub-title position
          ("topleft", "topright", "bottomleft", "bottomright") }
  \item{pixmap}{ an object \code{pixmap} displayed in the map background }
  \item{contour}{ a data frame with 4 columns to plot the contour of the map :
          each row gives a segment (x1,y1,x2,y2) }
  \item{area}{ a data frame of class 'area' to plot a set of surface units
          in contour }
  \item{add.plot}{ if TRUE uses the current graphics window }
}
\value{
The matched call.
}
\author{ Daniel Chessel  
}
\examples{
# To recognize groups of points
data(casitas)
casitas.fuz = fuzzygenet(casitas)
casitas.pop <- as.factor(rep(c("dome", "cast", "musc", "casi"), c(24,11,9,30)))
casitas.pca = dudi.pca(casitas.fuz, scannf = FALSE, scale = FALSE)
if (require(MASS, quiet=TRUE)) {s.kde2d(casitas.pca$li)
s.class(casitas.pca$li,casitas.pop, cell = 0, add.p = TRUE)
}
}
\keyword{multivariate}
\keyword{ hplot }
