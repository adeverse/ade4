\name{s.match}
\alias{s.match}
\title{Plot of Paired Coordinates}
\description{
performs the scatter diagram for a paired coordinates. 
}
\usage{
s.match(df1xy, df2xy, xax = 1, yax = 2, pch = 20, cpoint = 1, 
    label = row.names(df1xy), clabel=1, edge = TRUE, xlim = NULL, 
    ylim = NULL, grid = TRUE, addaxes = TRUE, cgrid = 1, 
    include.origin = TRUE, origin = c(0,0), sub = "", csub = 1.25, 
    possub = "bottomleft", pixmap = NULL, contour = NULL, area = NULL, 
    add.plot = FALSE)
}
\arguments{
  \item{df1xy}{a data frame containing two columns from the first system}
  \item{df2xy}{a data frame containing two columns from teh second system}
  \item{xax}{the column number for the x-axis of both the two systems}
  \item{yax}{the column number for the y-axis of both the two systems}
  \item{pch}{if \code{cpoint} > 0, an integer specifying the symbol or the single character to be used in plotting points}
  \item{cpoint}{a character size for plotting the points, used with \code{par("cex")*cpoint}. If zero, no points are drawn }
  \item{label}{a vector of strings of characters for the couple labels}
  \item{clabel}{if not NULL, a character size for the labels, used with \code{par("cex")*clabel} }
  \item{edge}{If TRUE the arrows are plotted, otherwise only the segments are drawn}
  \item{xlim}{the ranges to be encompassed by the x axis, if NULL they are computed}
  \item{ylim}{the ranges to be encompassed by the y axis, if NULL they are computed}
  \item{grid}{a logical value indicating whether a grid in the background of the plot should be drawn}
  \item{addaxes}{a logical value indicating whether the axes should be plotted}
  \item{cgrid}{a character size, parameter used with par("cex")* \code{cgrid} to indicate the mesh of the grid}
  \item{include.origin}{a logical value indicating whether the point "origin" should be belonged to the graph space}
  \item{origin}{the fixed point in the graph space, for example c(0,0) the origin axes}
  \item{sub}{a string of characters to be inserted as legend}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{pixmap}{aan object \code{pixmap} displayed in the map background}
  \item{contour}{a data frame with 4 columns to plot the contour of the map : each row gives a line (x1,y1,x2,y2)}
  \item{area}{a data frame of class 'area' to plot a set of surface units in contour}
  \item{add.plot}{if TRUE uses the current graphics window}
}
\examples{
X <- data.frame(x = runif(50,-1,2), y = runif(50,-1,2))
Y <- X + rnorm(100, sd = 0.3)
par(mfrow = c(2,2))
s.match(X, Y)
s.match(X, Y, edge = FALSE, clab = 0)
s.match(X, Y, edge = FALSE, clab = 0)
s.label(X, clab = 1, add.plot = TRUE)
s.label(Y, clab = 0.75, add.plot = TRUE)
s.match(Y, X, clab = 0)
}
\keyword{multivariate}
\keyword{hplot}
