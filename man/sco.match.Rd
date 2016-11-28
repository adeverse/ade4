\name{sco.match}
\alias{sco.match}
\title{1D plot of a pair of numeric scores with labels}
\description{
Draws evenly spaced labels, each label linked to the corresponding values of two numeric score.
}
\usage{
sco.match(score1, score2, label = names(score1), clabel = 1, 
    horizontal = TRUE, reverse = FALSE, pos.lab = 0.5, wmatch = 3, 
    pch = 20, cpoint = 1, boxes = TRUE, lim = NULL, grid = TRUE, 
    cgrid = 1, include.origin = TRUE, origin = c(0, 0), sub = "", 
    csub = 1.25, possub = "bottomleft")
}
\arguments{
  \item{score1}{a numeric vector}
  \item{score2}{a numeric vector}
  \item{label}{labels for the score}
  \item{clabel}{a character size for the labels, used with
    \code{par("cex")*clabel}}
  \item{horizontal}{logical. If TRUE, the plot is horizontal}
  \item{reverse}{logical. If horizontal = TRUE and reverse=TRUE, the
    plot is at the bottom, if reverse = FALSE, the plot is at the top. If
    horizontal = FALSE, the plot is at the right (TRUE) or at the left
    (FALSE).}
   \item{pos.lab}{a values between 0 and 1 to manage the position of the
     labels.}
   \item{wmatch}{a numeric values to specify the width of the matching
     region in the plot. The width is equal to wmatch * the height of character}
   \item{pch}{an integer specifying the symbol or the single character to be used in plotting points}
  \item{cpoint}{a character size for plotting the points, used with \code{par("cex")*cpoint}. If zero, no points are drawn}
  \item{boxes}{if TRUE, labels are framed}
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
\author{Stéphane Dray \email{stephane.dray@univ-lyon1.fr}}
\examples{
sco.match(-5:5,2*(-5:5))
}
\keyword{multivariate}
\keyword{hplot}
