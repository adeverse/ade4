\name{dunedata}
\alias{dunedata}
\non_function{}
\title{Dune Meadow Data}
\description{
\code{dunedata} is a data set containing for 30 sites, environmental variables and plant species. 
}
\usage{data(dunedata)}
\format{
	\code{dunedata} is a list with 2 components.
	\enumerate{
		\item{envir}{is a data frame with 30 rows (sites) 5 columns (environnemental variables).}
		\item{veg}{is a data frame with 30 rows (sites) 20 columns (plant species).}
	}
}
\source{
 Jongman, R. H., ter Braak, C. J. F.  and van Tongeren, O. F. R.  (1987)\cr
 \emph{Data analysis in community and landscape ecology}, Pudoc, Wageningen.
}
\examples{
data(dunedata)
summary(dunedata$envir)
is.ordered(dunedata$envir$use)
score(dudi.mix(dunedata$envir, scan = FALSE))
}
\keyword{datasets}
