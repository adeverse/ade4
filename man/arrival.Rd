\name{arrival}
\alias{arrival}
\docType{data}
\title{Arrivals at an intensive care unit}
\description{
This data set gives arrival times of 254 patients at an intensive care unit during one day.
}
\usage{data(arrival)}
\format{
\code{arrival} is a list containing the 2 following objects : \cr   
        \item{times}{is a vector giving the arrival times in the form HH:MM} 
        \item{hours}{is a vector giving the number of arrivals per hour for the day considered}
}
\source{
Data taken from the logiciel Oriana developped by Warren L. Kovach \email{sales@kovcomp.com} starting from \url{http://www.kovcomp.com/oriana/index.html}.
}
\references{
Fisher, N. I. (1993) \emph{Statistical Analysis of Circular Data}. Cambridge University Press. 
}
\examples{
data(arrival)
dotcircle(arrival$hours,pi/2+pi/12)
}
\keyword{datasets}
\keyword{chron}
