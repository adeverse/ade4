\name{s.chull}
\alias{s.chull}
\title{Plot of the factorial maps with polygons of contour by level of a factor}
\description{
performs the scatter diagrams with polygons of contour by level of a factor. 
}
\usage{
s.chull(dfxy, fac, xax = 1, yax = 2, 
    optchull = c(0.25, 0.5, 0.75, 1), label = levels(fac), clabel = 1, 
    cpoint = 0, col = rep(1, length(levels(fac))), xlim = NULL, ylim = NULL,
    grid = TRUE, addaxes = TRUE, origin = c(0,0), include.origin = TRUE, sub = "",
    csub = 1, possub = "bottomleft", cgrid = 1, pixmap = NULL, contour = NULL, 
    area = NULL, add.plot = FALSE)
}
\arguments{
  \item{dfxy}{a data frame containing the two columns for the axes}
  \item{fac}{a factor partioning the rows of the data frame in classes}
  \item{xax}{the column number of x in \code{dfxy}}
  \item{yax}{the column number of y in \code{dfxy}}
  \item{optchull}{the number of convex hulls and their interval}
  \item{label}{a vector of strings of characters for the point labels}
  \item{clabel}{if not NULL, a character size for the labels, used with  \code{par("cex")*clabel}}
  \item{cpoint}{a character size for plotting the points, used with \code{par("cex")*cpoint}. If zero, no points are drawn}
  \item{col}{a vector of colors used to draw each class in a different color}
  \item{xlim}{the ranges to be encompassed by the x axis, if NULL, they are computed}
  \item{ylim}{the ranges to be encompassed by the y axis, if NULL they are computed}
  \item{grid}{a logical value indicating whether a grid in the background of the plot should be drawn}
  \item{addaxes}{a logical value indicating whether the axes should be plotted}
  \item{origin}{the fixed point in the graph space, for example c(0,0) the origin axes}
  \item{include.origin}{a logical value indicating whether the point "origin" should be belonged to the graph space}
  \item{sub}{a string of characters to be inserted as legend}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{cgrid}{a character size, parameter used with par("cex")* \code{cgrid} to indicate the mesh of the grid}
  \item{pixmap}{an object 'pixmap' displayed in the map background}
  \item{contour}{a data frame with 4 columns to plot the contour of the map : each row gives a line (x1,y1,x2,y2)}
  \item{area}{a data frame of class 'area' to plot a set of surface units in contour}
  \item{add.plot}{if TRUE uses the current graphics window}
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}}
\examples{
xy <- cbind.data.frame(x = runif(200,-1,1), y = runif(200,-1,1))
posi <- factor(xy$x > 0) : factor(xy$y > 0)
coul <- c("black", "red", "green", "blue")
s.chull(xy, posi, cpoi = 1.5, col = coul)
}
\keyword{multivariate}
\keyword{hplot}
