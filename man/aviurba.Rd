\name{aviurba}
\alias{aviurba}
\non_function{}
\title{Ecological Tables Triplet}
\description{
This data set is a list of informations about 51 sites : species and environmental variables. \cr
For each species, a data frame contains biological traits. 
}
\usage{data(aviurba)}
\format{
	This list contains the following objects:
	\describe{
		\item{fau}{is a data frame 51 sites 40 species. }
		\item{mil}{is a data frame 51 sites 11 environmental variables. }
		\item{traits}{is a data frame 40 species 4 biological traits.}
		\item{species.names.fr}{is a vector species names in french. }
		\item{species.names.la}{is a vector species names in latin. }
		\item{species.family}{is a factor : the species families. }
	}
}
\source{
Dolédec, S., Chessel, D., Ter Braak,C. J. F.  and Champely S. (1996)\cr
Matching species traits to environmental variables: a new three-table ordination method.\cr
\emph{Environmental and Ecological Statistics}, \bold{3}, 143--166.
}
\examples{
data(aviurba)
a1 <- dudi.coa(aviurba$fau, scan = FALSE, nf=4)
a2 <- dudi.acm(aviurba$mil, row.w = a1$lw, scan = FALSE, nf = 4)
plot(coinertia(a1, a2, scan = FALSE))
}
\keyword{datasets}
