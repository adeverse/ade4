\name{s.match.class}
\alias{s.match.class}
\title{Scatterplot of two sets of coordinates and a partionning into classes}
\description{
Performs a graphical representation of two sets of coordinates
(different colors and symbols) and a partitionning  into classes
}
\usage{
s.match.class(df1xy, df2xy, fac, wt = rep(1/nrow(df1xy), nrow(df1xy)),
xax = 1, yax = 2, pch1 = 16, pch2 = 15, col1 = rep("lightgrey",
nlevels(fac)), col2 = rep("darkgrey", nlevels(fac)), cpoint = 1, label =
levels(fac), clabel = 1, cstar = 1, cellipse = 0, axesell = TRUE, xlim =
NULL, ylim = NULL, grid = TRUE, addaxes = TRUE, cgrid = 1,
include.origin = TRUE, origin = c(0, 0), sub = "", csub = 1.25, possub =
"bottomleft", pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE)
}

\arguments{
  \item{df1xy}{a dataframe with the first system of coordinates}
  \item{df2xy}{a dataframe with the secocnd system of coordinates}
  \item{fac}{a factor partitioning the rows of the data frame in classes}
  \item{wt}{a vector of weights}
  \item{xax}{a number indicating which column should be plotted on the x-axis}
  \item{yax}{a number indicating which column should be plotted on the x-axis}
  \item{pch1}{if \code{cpoint} > 0, an integer specifying the symbol or the single character to be used for plotting points}
  \item{pch2}{if \code{cpoint} > 0, an integer specifying the symbol or the single character to be used for plotting points}
  \item{col1}{a color for symbols}
  \item{col2}{a color for symbols}
  \item{cpoint}{a character size for plotting the points, used with \code{par("cex")*cpoint}. If zero, no points are drawn}
  \item{label}{a vector of strings of characters for the couple labels}
  \item{clabel}{if not NULL, a character size for the labels, used with \code{par("cex")*clabel}}
  \item{cstar}{a number between 0 and 1 which defines the length of the star size}
  \item{cellipse}{a positive coefficient for the inertia ellipse size}
  \item{axesell}{a logical value indicating whether the ellipse axes should be drawn}
  \item{xlim}{the ranges to be encompassed by the x axis, if NULL they are computed}
  \item{ylim}{the ranges to be encompassed by the y axis, if NULL they are computed}
  \item{grid}{a logical value indicating whether a grid in the background of the plot should be drawn}
  \item{addaxes}{a logical value indicating whether the axes should be plotted}
  \item{cgrid}{a character size, parameter used with par("cex")* \code{cgrid} to indicate the mesh of the grid}
  \item{include.origin}{a logical value indicating whether the point "origin" should belong to the graph space}
  \item{origin}{a fixed point in the graph space, for example c(0,0) for
  the origin of axes}
  \item{sub}{a string of characters to be inserted as legend}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{pixmap}{a \code{pixmap} object}
  \item{contour}{a dataframe with 4 columns to plot the contour of the map : each row gives a segment (x1,y1,x2,y2)}
  \item{area}{a dataframe of class 'area' to plot an areal map}
  \item{add.plot}{if TRUE, add the plot to the current graphic device}
}

\value{
The matched call.
}

\author{
Stephane Dray \email{stephane.dray@univ-lyon1.fr}
}

\seealso{
\code{\link{s.class}}, \code{\link{s.match}}
}
\examples{
xy <- data.frame(matrix(rnorm(100),50,2))
xy[,1] <- xy[,1] + rep(seq(0,12,by=3),rep(10,5))
xy[,2] <- xy[,2] + rep(seq(0,12,by=3),rep(10,5))
fac <- gl(5,10)
xy2<-xy + matrix(rnorm(100),50,2) + 1
s.match.class(xy,xy2,fac)

}
\keyword{multivariate}
\keyword{hplot}

