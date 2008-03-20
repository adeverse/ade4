\name{sco.class}
\alias{sco.class}
\title{1D plot of a numeric score and a factor with labels}
\description{
Draws evenly spaced labels, each label linked to the corresponding
values of the levels of a factor.
}
\usage{
sco.class(score, fac, label = levels(fac), clabel = 1, horizontal = TRUE, 
    reverse = FALSE, pos.lab = 0.5, pch = 20, cpoint = 1, boxes = TRUE, 
    col = rep(1, length(levels(fac))), lim = NULL, grid = TRUE, 
    cgrid = 1, include.origin = TRUE, origin = c(0, 0), sub = "", 
    csub = 1.25, possub = "bottomleft")
}
\arguments{
  \item{score}{a numeric vector}
  \item{fac}{a factor}
  \item{label}{labels for the levels of the factor}
  \item{clabel}{a character size for the labels, used with
    \code{par("cex")*clabel}}
  \item{horizontal}{logical. If TRUE, the plot is horizontal}
  \item{reverse}{logical. If horizontal = TRUE and reverse=TRUE, the
    plot is at the bottom, if reverse = FALSE, the plot is at the top. If
    horizontal = FALSE, the plot is at the right (TRUE) or at the left
    (FALSE).}
  \item{pos.lab}{a values between 0 and 1 to manage the position of the
    labels.}
  \item{pch}{an integer specifying the symbol or the single character to be used in plotting points}
  \item{cpoint}{a character size for plotting the points, used with \code{par("cex")*cpoint}. If zero, no points are drawn}
  \item{boxes}{if TRUE, labels are framed}
  \item{col}{a vector of colors used to draw each class in a different color}
  \item{lim}{the range for the x axis or y axis (if horizontal = FALSE), if NULL, they are computed}
  \item{grid}{a logical value indicating whether a grid in the background of the plot should be drawn}
  \item{cgrid}{a character size, parameter used with par("cex")* \code{cgrid} to indicate the mesh of the grid}
  \item{include.origin}{a logical value indicating whether the point "origin" should belong to the plot}
  \item{origin}{the fixed point in the graph space, for example c(0,0) the origin axes}
  \item{sub}{a string of characters to be inserted as legend}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
}
\value{
The matched call.
}
\author{Stephane Dray \email{dray@biomserv.univ-lyon1.fr}}
\examples{
data(meau)
acpmil <- dudi.pca(meau$mil, scannf=FALSE)
par(mfrow=c(2,1))
sco.class(acpmil$li[,1],meau$plan$sta, col = 1:6)
sco.class(acpmil$li[,1],meau$plan$dat, col = 1:4, reverse = TRUE)
}
\keyword{multivariate}
\keyword{hplot}
