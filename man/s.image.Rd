\name{s.image}
\alias{s.image}
\title{ Graph of a variable using image and contour }
\description{
  performs a scatterplot
}
\usage{
s.image(dfxy, z, xax = 1, yax = 2, span = 0.5, xlim = NULL, ylim = NULL, kgrid = 2, scale = TRUE, grid = FALSE, addaxes = FALSE, cgrid = 0, include.origin = FALSE, origin = c(0, 0), sub = "", csub = 1, possub = "topleft", neig = NULL, cneig = 1, image.plot = TRUE, contour.plot = TRUE, pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE)
}
\arguments{
  \item{dfxy}{ a data frame containing the two columns for the axes }
  \item{z}{ a vector of values on the \code{dfxy} rows }
  \item{xax}{ the column number of x in \code{dfxy} }
  \item{yax}{ the column number of y in \code{dfxy} }
  \item{span}{ the parameter alpha which controls the degree of smoothing }
  \item{xlim}{ the ranges to be encompassed by the x-axis, if NULL they are computed }
  \item{ylim}{ the ranges to be encompassed by the y-axis, if NULL they are computed }
  \item{kgrid}{ ~~Describe \code{kgrid} here~~ }
  \item{scale}{ ~~Describe \code{scale} here~~ }
  \item{grid}{ ~~Describe \code{grid} here~~ }
  \item{addaxes}{ a logical value indicating whether the axes should be plotted }
  \item{cgrid}{ a character size, parameter used with par("cex")* \code{cgrid} to indicate the mesh of the grid }
  \item{include.origin}{ a logical value indicating whether the point "origin" should be belonged to the graph space }
  \item{origin}{ the fixed point in the graph space, for example c(0,0) the origin axes }
  \item{sub}{ a string of characters to be inserted as legend }
  \item{csub}{ a character size for the legend, used with \code{par("cex")*csub} }
  \item{possub}{ a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright") }
  \item{neig}{ ~~Describe \code{neig} here~~ }
  \item{cneig}{ ~~Describe \code{cneig} here~~ }
  \item{image.plot}{ ~~Describe \code{image.plot} here~~ }
  \item{contour.plot}{ ~~Describe \code{contour.plot} here~~ }
  \item{pixmap}{ an object 'pixmap' displayed in the map background }
  \item{contour}{ a data frame with 4 columns to plot the contour of the map : each row gives a line (x1,y1,x2,y2) }
  \item{area}{ a data frame of class 'area' to plot a set of surface units in contour }
  \item{add.plot}{ if TRUE uses the current graphics window }
}
\examples{
    data(t3012)
    par(mfrow=c(4,4))
    for(k in 1:12)  s.image(t3012$xy,scalewt(t3012$temp[,k]),kgrid=3)
    
    data(elec88)
par(mfrow=c(4,4))
for(k in 1:12)
    s.image(t3012$xy,scalewt(t3012$temp[,k]),kgrid=3,sub=names(t3012$temp)[k],
        csub=3,area=elec88$area)


}
\keyword{hplot}
