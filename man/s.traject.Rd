\name{s.traject}
\alias{s.traject}
\title{Trajectory Plot}
\description{
performs the scatter diagram with trajectories. 
}
\usage{
s.traject(dfxy, fac = factor(rep(1, nrow(dfxy))), 
    ord = (1:length(fac)),  xax = 1, yax = 2, label = levels(fac), 
    clabel = 1, cpoint = 1, pch = 20, xlim = NULL, ylim = NULL, 
    grid = TRUE, addaxes = TRUE, edge = TRUE, origin = c(0,0), 
    include.origin = TRUE, sub = "", csub = 1, possub = "bottomleft", 
    cgrid = 1, pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE)
}
\arguments{
  \item{dfxy}{a data frame containing two columns for the axes}
  \item{fac}{a factor partioning the rows of the data frame in classes}
  \item{ord}{a vector of length equal to fac. The trajectory is drawn in an ascending order of the ord values}
  \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{label}{a vector of strings of characters for the point labels}
  \item{clabel}{if not NULL, a character size for the labels, used with \code{par("cex")*clabel}}
  \item{cpoint}{a character size for plotting the points, used with \code{par("cex")*cpoint}. If zero, no points are drawn}
  \item{pch}{if \code{cpoint} > 0, an integer specifying the symbol or the single character to be used in plotting points}
  \item{xlim}{the ranges to be encompassed by the x, if NULL they are computed}
  \item{ylim}{the ranges to be encompassed by the y, if NULL they are computed}
  \item{grid}{a logical value indicating whether a grid in the background of the plot should be drawn}
  \item{addaxes}{a logical value indicating whether the axes should be plotted}
  \item{edge}{if TRUE the arrows are plotted, otherwhise only the segments}
  \item{origin}{the fixed point in the graph space, for example c(0,0) the origin axes}
  \item{include.origin}{a logical value indicating whether the point "origin" should be belonged to the graph space}
  \item{sub}{a string of characters to be inserted as legend}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft","topright","bottomleft","bottomright")}
  \item{cgrid}{a character size, parameter used with \code{par("cex")*cgrid} to indicate the mesh of the grid}
  \item{pixmap}{aan object 'pixmap' displayed in the map background}
  \item{contour}{a data frame with 4 columns to plot the contour of the map : each row gives a line (x1,y1,x2,y2)}
  \item{area}{a data frame of class 'area' to plot a set of surface units in contour}
  \item{add.plot}{if TRUE uses the current graphics window}
}
\examples{
rw <- function(a){
    x <- 0
    for(i in 1:49) x <- c(x,x[length(x)] + runif(1,-1,1))
    x
}
y <- unlist(lapply(1:5, rw))
x <- unlist(lapply(1:5, rw))
z <- gl(5,50)
s.traject(data.frame(x,y), z, edge = FALSE)
}
\keyword{multivariate}
\keyword{hplot}
