\name{s.logo}
\alias{s.logo}
\alias{scatterutil.logo}
\title{Representation of an object in a graph by a picture}
\description{
performs the scatter diagrams using pictures to represent the points
}
\usage{
s.logo(dfxy, listlogo, klogo=NULL, clogo=1, rectlogo=TRUE,
    xax = 1, yax = 2, neig = NULL, cneig = 1, xlim = NULL, ylim = NULL, 
    grid = TRUE, addaxes = TRUE, cgrid = 1, include.origin = TRUE, 
    origin = c(0, 0), sub = "", csub = 1.25, possub = "bottomleft", 
    pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE) 
}
\arguments{
  \item{dfxy}{a data frame with at least two coordinates}
  \item{listlogo}{a list of pixmap pictures}
  \item{klogo}{a numeric vector giving the order in which pictures of listlogo are used; if NULL, the order is the same than the rows of dfxy}
  \item{clogo}{a numeric vector giving the size factor applied to each picture}
  \item{rectlogo}{a logical to decide whether a rectangle should be drawn around the picture (TRUE) or not (FALSE)}
   \item{xax}{the column number for the x-axis}
  \item{yax}{the column number for the y-axis}
  \item{neig}{a neighbouring graph}
  \item{cneig}{a size for the neighbouring graph lines used with par("lwd")*\code{cneig}}
  \item{xlim}{the ranges to be encompassed by the x axis, if NULL, they are computed}
  \item{ylim}{the ranges to be encompassed by the y axis, if NULL, they are computed}
  \item{grid}{a logical value indicating whether a grid in the background of the plot should be drawn}
  \item{addaxes}{a logical value indicating whether the axes should be plotted}
  \item{cgrid}{a character size, parameter used with par("cex")* \code{cgrid} to indicate the mesh of the grid}
  \item{include.origin}{a logical value indicating whether the point "origin" should be belonged to the graph space}
  \item{origin}{the fixed point in the graph space, for example c(0,0) the origin axes}
  \item{sub}{a string of characters to be inserted as legend}
  \item{csub}{a character size for the legend, used with \code{par("cex")*csub}}
  \item{possub}{a string of characters indicating the sub-title position ("topleft", "topright", "bottomleft", "bottomright")}
  \item{pixmap}{an object 'pixmap' displayed in the map background}
  \item{contour}{a data frame with 4 columns to plot the contour of the map : each row gives a segment (x1,y1,x2,y2)}
  \item{area}{a data frame of class 'area' to plot a set of surface units in contour}
  \item{add.plot}{if TRUE uses the current graphics window}
}
\value{
The matched call.
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} and Thibaut Jombart \email{jombart@biomserv.univ-lyon1.fr}}
\examples{
if(require(pixmap, quiet=TRUE)){
	data(ggtortoises)
	a1 <- ggtortoises$area
	area.plot(a1)
	rect(min(a1$x), min(a1$y), max(a1$x), max(a1$y), col = "lightblue")
	invisible(lapply(split(a1, a1$id), function(x) polygon(x[, -1],col = "white")))
	s.label(ggtortoises$misc, grid=FALSE,include.ori=FALSE,addaxes=FALSE,add.p=TRUE)
	listico <- ggtortoises$ico[as.character(ggtortoises$pop$carap)]
	s.logo(ggtortoises$pop,listico,add.p=TRUE)

	data(capitales)
	index <- unlist(lapply(1:15,function(i) which(names(capitales$logo)==tolower(rownames(capitales$df)[i])) ))
	w1 <- capitales$area
	area.plot(w1)
	rect(min(w1$x), min(w1$y), max(w1$x), max(w1$y), col = "lightblue")
	invisible(lapply(split(w1, w1$id), function(x) polygon(x[, -1],col = "white")))
	s.logo(capitales$xy, capitales$logo, klogo=index, add.plot=TRUE,clogo=1) # depends on pixmap
}
}
\keyword{multivariate}
\keyword{hplot}
