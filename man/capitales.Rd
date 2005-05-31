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

    capitales.pnm <- read.pnm(system.file("pictures/capitales.pnm", package = "ade4"))
    # plot(capitales.pnm) # depends of pixmap
    # xy <- locator(15) # funny
    data(capitales)
    par(mfrow = c(2,2))
    s.label(capitales$xy, lab = names(capitales$df)) 
    s.label(capitales$xy, lab = names(capitales$df), pixmap = capitales.pnm, inc = FALSE)
    table.dist(as.dist(capitales$df), lab = names(capitales$df)) # depends of mva
    s.label(pcoscaled(lingoes(as.dist(capitales$df))))
    par(mfrow = c(1,1))
}
}
\keyword{datasets}
