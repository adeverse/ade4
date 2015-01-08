\name{capitales}
\alias{capitales}
\docType{data}
\title{Road Distances}
\description{
This data set gives the road distances between 15 European capitals and their coordinates. 
}
\usage{data(capitales)}
\format{
This list contains the following objects:
    \describe{
    \item{dist}{is dist object the road distances between 15 European capitals. }
    \item{xy}{is a data frame containing the coordinates of capitals. }
    \item{area}{is a data frame containing three variables, designed to be used in area.plot function.}
    \item{logo}{is a list of pixmap objects, each one symbolizing a
      capital}
     \item{Spatial}{is a SpatialPolygons object containing the map}
    }
}
\source{
 \url{http://www.euro.gouv.fr/jeunes/eurocollege/tableaucarte.htm}
}
\examples{

data(capitales)
attr(capitales$dist, "Labels")
index <- pmatch(tolower(attr(capitales$dist, "Labels")), names(capitales$logo))
w1 <- capitales$area

if(adegraphicsLoaded()) {
  if(require(sp, quiet = TRUE)) {
    g1 <- s.label(capitales$xy, lab = rownames(capitales$xy), pori.incl = F, plot = F)
    g2 <- s.logo(capitales$xy[sort(rownames(capitales$xy)), ], capitales$logo, 
      Sp = capitales$Spatial, pback.col = "lightblue", pSp.col = "white", pgrid.draw = FALSE, 
      plot = F)
    g3 <- table.value(capitales$dist, ptable.margin = list(b = 5, l = 5, t = 15, r = 15), 
      ptable.x.tck = 3, ptable.y.tck = 3, plot = F)
    g4 <- s.logo(pcoscaled(lingoes(capitales$dist)), capitales$logo[index], plot = F) 
    
    G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  }
  
} else {
  if(require(pixmap, quiet = TRUE)) {
    par(mfrow = c(2, 2))
    s.label(capitales$xy, lab = attr(capitales$dist, "Labels"), include.origin = FALSE)
    area.plot(w1)
  	rect(min(w1$x), min(w1$y), max(w1$x), max(w1$y), col = "lightblue")
  	invisible(lapply(split(w1, w1$id), function(x) polygon(x[, -1], col = "white")))
  	s.logo(capitales$xy, capitales$logo, klogo = index, add.plot = TRUE, 
  	 include.origin = FALSE, clogo = 0.5) # depends on pixmap
    table.dist(capitales$dist, lab = attr(capitales$dist, "Labels")) # depends on mva
    s.logo(pcoscaled(lingoes(capitales$dist)), capitales$logo, klogo = index, clogo = 0.5) 
      # depends on pixmap
    par(mfrow = c(1, 1))
  }
}

}
\keyword{datasets}
