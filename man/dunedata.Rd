\name{dunedata}
\alias{dunedata}
\docType{data}
\title{Dune Meadow Data}
\description{
\code{dunedata} is a data set containing for 20 sites, environmental variables and plant species. 
}
\usage{data(dunedata)}
\format{
    \code{dunedata} is a list with 2 components.
    \describe{
        \item{envir}{is a data frame with 20 rows (sites) 5 columns (environnemental variables).}
        \item{veg}{is a data frame with 20 rows (sites) 30 columns (plant species).}
    }
}
\source{
 Jongman, R. H., ter Braak, C. J. F.  and van Tongeren, O. F. R.  (1987)
 \emph{Data analysis in community and landscape ecology}, Pudoc, Wageningen.
}
\examples{
data(dunedata)
summary(dunedata$envir)
is.ordered(dunedata$envir$use)
score(dudi.mix(dunedata$envir, scan = FALSE))
}
\keyword{datasets}
