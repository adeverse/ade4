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
    \item{df}{is a data frame containing the road distances between 15 European capitals. }
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
         names(capitales$df)
         # [1] "Madrid"     "Paris"      "Londres"    "Dublin"     "Rome"      
         # [6] "Bruxelles"  "Amsterdam"  "Berlin"     "Copenhague" "Stokholm"  
         #[11] "Luxembourg" "Helsinki"   "Vienne"     "Athenes"    "Lisbonne"

         index <- unlist(lapply(1:15,function(i) which(names(capitales$logo)==tolower(rownames(capitales$df)[i])) ))
         w1 <- capitales$area
         par(mfrow=c(2,2))
         s.label(capitales$xy, lab = names(capitales$df)) 
         area.plot(w1)
	 rect(min(w1$x), min(w1$y), max(w1$x), max(w1$y), col = "lightblue")
	 invisible(lapply(split(w1, w1$id), function(x) polygon(x[, -1],col = "white")))
	 s.logo(capitales$xy, capitales$logo, klogo = index, add.plot = TRUE,clogo=.5) # depends on pixmap
         table.dist(as.dist(capitales$df), lab = names(capitales$df)) # depends on mva
    	 s.logo(pcoscaled(lingoes(as.dist(capitales$df))),capitales$logo,klogo=index,clogo=.5) #depends on pixmap
}	
}
\keyword{datasets}
