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
    \item{logo}{is a list of pixmap objects, each one symbolizing a capital}
    }
}
\source{
 \url{http://www.euro.gouv.fr/jeunes/eurocollege/tableaucarte.htm}
}
\examples{
 if (require(pixmap, quiet = TRUE)) {
         data(capitales)
         attr(capitales$dist, "Labels")
         index <- pmatch(tolower(attr(capitales$dist, "Labels")), names(capitales$logo))
         w1 <- capitales$area
         par(mfrow=c(2,2))
         s.label(capitales$xy, lab = attr(capitales$dist, "Labels")) 
         area.plot(w1)
	 rect(min(w1$x), min(w1$y), max(w1$x), max(w1$y), col = "lightblue")
	 invisible(lapply(split(w1, w1$id), function(x) polygon(x[, -1],col = "white")))
	 s.logo(capitales$xy, capitales$logo, klogo = index, add.plot = TRUE,clogo=.5) # depends on pixmap
         table.dist(capitales$dist, lab = attr(capitales$dist, "Labels")) # depends on mva
    	 s.logo(pcoscaled(lingoes(capitales$dist)),capitales$logo,klogo=index,clogo=.5) #depends on pixmap
}	
}
\keyword{datasets}
