\name{ecomor}
\alias{ecomor}
\docType{data}
\title{Ecomorphological Convergence}
\description{
This data set gives ecomorphological informations about 129 bird species. 
}
\usage{data(ecomor)}
\format{
	\code{ecomor} is a list of 7 components.
	\enumerate{
		\item{habitat}{is a data frame with 129 species, 16 states.}
		\item{forsub}{is a data frame with 129 species, 6 classes.}
		\item{morpho}{is a data frame with 129 species, 8 variables.}
		\item{diet}{is a data frame with 129 species, 8 classes.}
		\item{codes}{is a data frame with 129 species, 2 factors}
		\item{species.names}{is a vector of the names of species.}
		\item{families}{is a factor distributing species by families.}
	}
}
\source{
Blondel, J., Vuilleumier, F., Marcus, L.F., and Terouanne, E. (1984).\cr
Is there ecomorphological convergence among mediterranean bird communities of Chile, California, and France.\cr
In \emph{Evolutionary Biology} (eds M.K. Hecht, B. Wallace & R.J. MacIntyre),\cr
141--213, Vol. 18. Plenum Press, New York.
}
\examples{
data(ecomor)
}
\keyword{datasets}
