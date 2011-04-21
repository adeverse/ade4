\name{sco.label}
\alias{sco.label}
\title{1D plot of a numeric score with labels}
\description{
Draws evenly spaced labels, each label linked to the corresponding value of a numeric score.
}
\usage{
sco.label(score, label = names(score), clabel = 1, horizontal = TRUE,
reverse = FALSE, pos.lab = 0.5, pch = 20, cpoint = 1, boxes = TRUE, lim
= NULL, grid = TRUE, cgrid = 1, include.origin = TRUE, origin = c(0, 0),
sub = "", csub = 1.25, possub = "bottomleft")
}
\arguments{
  \item{score}{a numeric vector}
  \item{label}{labels for the score}
  \item{clabel}{a character size for the labels, used with
    \code{par("cex")*clabel}}
  \item{horizontal}{logical. If TRUE, the plot is horizontal}
  \item{reverse}{logical. If horizontal = TRUE and reverse=TRUE, the
    plot is at the bottom, if reverse = FALSE, the plot is at the top. If
    horizontal = FALSE, the plot is at the right (TRUE) or at the left
    (FALSE).}
   \item{pos.lab}{a values between 0 and 1 to manage the position of the labels.}
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
\author{Stephane Dray \email{dray@biomserv.univ-lyon1.fr}, Jean Thioulouse }
\examples{
data(meau)
envpca <- dudi.pca(meau$env, scannf=FALSE)
par(mfrow=c(2,1))
sco.label(envpca$l1[,1], row.names(envpca$l1), lim=c(-1,3.5))
sco.label(envpca$co[,1], row.names(envpca$co), reverse = TRUE, lim=c(-1,3.5))
}
\keyword{multivariate}
\keyword{hplot}
