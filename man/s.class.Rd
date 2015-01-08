\name{s.class}
\alias{s.class}
\title{Plot of factorial maps with representation of point classes}
\description{
performs the scatter diagrams with representation of point classes. 
}
\usage{
s.class(dfxy, fac, wt = rep(1, length(fac)), xax = 1, 
    yax = 2, cstar = 1, cellipse = 1.5, axesell = TRUE, 
    label = levels(fac), clabel = 1, cpoint = 1, pch = 20, 
    col = rep(1, length(levels(fac))), xlim = NULL, ylim = NULL, 
    grid = TRUE, addaxes = TRUE, origin = c(0,0), 
    include.origin = TRUE, sub = "", csub = 1, possub = "bottomleft", 
    cgrid = 1, pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE)
}
\arguments{
  \item{dfxy}{a data frame containing the two columns for the axes}
  \item{fac}{a factor partitioning the rows of the data frame in classes}
  \item{wt}{a vector of the point weightings of the data frame used for computing the means (star centers) and the ellipses of dispersion}
  \item{xax}{the column number of x in \code{dfxy}}
  \item{yax}{the column number of y in \code{dfxy}}
  \item{cstar}{a number between 0 and 1 which defines the length of the star size}
  \item{cellipse}{a positive coefficient for the inertia ellipse size}
  \item{axesell}{a logical value indicating whether the ellipse axes should be drawn}
  \item{label}{a vector of strings of characters for the point labels}
  \item{clabel}{if not NULL, a character size for the labels, used with \code{par("cex")*clabel}}
  \item{cpoint}{a character size for plotting the points, used with \code{par("cex")*cpoint}. If zero, no points are drawn}
  \item{pch}{if \code{cpoint} > 0, an integer specifying the symbol or the single character to be used in plotting points}
  \item{col}{a vector of colors used to draw each class in a different color}
  \item{xlim}{the ranges to be encompassed by the x, if NULL they are computed}
  \item{ylim}{the ranges to be encompassed by the y, if NULL they are computed}
  \item{grid}{a logical value indicating whether a grid in the background of the plot should be drawn}
  \item{addaxes}{a logical value indicating whether the axes should be plotted}
  \item{origin}{the fixed point in the graph space, for example c(0,0) the origin axes}
  \item{include.origin}{a logical value indicating whether the point "origin" should be belonged to the graph space}
  \item{sub}{a string of characters to be inserted as legend}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{cgrid}{a character size, parameter used with par("cex")* \code{cgrid} to indicate the mesh of the grid}
  \item{pixmap}{an object 'pixmap' displayed in the map background}
  \item{contour}{a data frame with 4 columns to plot the contour of the map : each row gives a segment (x1,y1,x2,y2)}
  \item{area}{a data frame of class 'area' to plot a set of surface units in contour}
  \item{add.plot}{if TRUE uses the current graphics window}
}
\value{
The matched call.
}
\author{Daniel Chessel}
\examples{
if(!adegraphicsLoaded()) {
  xy <- cbind.data.frame(x = runif(200, -1, 1), y = runif(200, -1, 1))
  posi <- factor(xy$x > 0) : factor(xy$y > 0)
  coul <- c("black", "red", "green", "blue")
  par(mfrow = c(2, 2))
  s.class(xy, posi, cpoi = 2)
  s.class(xy, posi, cell = 0, cstar = 0.5)
  s.class(xy, posi, cell = 2, axesell = FALSE, csta = 0, col = coul)
  s.chull(xy, posi, cpoi = 1)
  par(mfrow = c(1, 1))
  
  \dontrun{
  data(banque)
  dudi1 <- dudi.acm(banque, scannf = FALSE)
  coul = rainbow(length(levels(banque[, 20])))
  par(mfrow = c(2, 2))
  s.label(dudi1$li, sub = "Factorial map from ACM", csub = 1.5, 
    possub = "topleft")
  s.class(dudi1$li, banque[, 20], sub = names(banque)[20], 
    possub = "bottomright", cell = 0, cstar = 0.5, cgrid = 0, csub = 1.5)
  s.class(dudi1$li, banque[, 20], csta = 0, cell = 2, cgrid = 0, 
    clab = 1.5)
  s.class(dudi1$li, banque[, 20], sub = names(banque)[20], 
    possub = "topright", cgrid = 0, col = coul)
  par(mfrow = c(1, 1))
  
  par(mfrow = n2mfrow(ncol(banque)))
  for(i in 1:(ncol(banque)))
    s.class(dudi1$li, banque[, i], clab = 1.5, sub = names(banque)[i], 
      csub = 2, possub = "topleft", cgrid = 0, csta = 0, cpoi = 0)
  s.label(dudi1$li, clab = 0, sub = "Common background")
  par(mfrow = c(1, 1))
}
}}
\keyword{multivariate}
\keyword{hplot}
