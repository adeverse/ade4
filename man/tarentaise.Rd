\name{tarentaise}
\alias{tarentaise}
\docType{data}
\title{Mountain Avifauna}
\description{
This data set gives informations between sites, species, environmental and biolgoical variables. 
}
\usage{data(tarentaise)}
\format{
	\code{tarentaise} is a list of 5 components.
	\enumerate{
		\item{ecol}{is a data frame with 376 sites and 98 bird species.}
		\item{frnames}{is a vector of the 98 French names of the species.}
		\item{alti}{is a vector giving the altitude of the 376 sites in m.}
		\item{envir}{is a data frame with 14 environmental variables.}
		\item{traits}{is a data frame with 29 biological variables of the 98 species.}
	}
}
\details{
The attribute \code{col.blocks} of the data frame \code{tarentaise$traits} indicates it is composed of 6 units of variables.
}
\source{
Original data from Hubert Tournier, University of Savoie and Philippe Lebreton, University of Lyon 1.
}
\references{
Lebreton, P., Tournier H. and Lebreton J. D. (1976)\cr
Etude de l'avifaune du Parc National de la Vanoise\cr
VI Recherches d'ordre quantitatif sur les Oiseaux forestiers de Vanoise.\cr
\emph{Travaux Scientifiques du parc National de la vanoise}, \bold{7}, 163--243.\cr\cr

Lebreton, Ph. and Martinot, J.P. (1998)\cr
Oiseaux de Vanoise. Guide de l'ornithologue en montagne.\cr
\emph{Libris}, Grenoble. 1--240.\cr\cr

Lebreton, Ph., Lebrun, Ph., Martinot, J.P., Miquet, A. and Tournier, H. (1999)\cr
Approche écologique de l'avifaune de la Vanoise.\cr
\emph{Travaux scientifiques du Parc national de la Vanoise}, \bold{21}, 7--304.
}
\examples{
data(tarentaise)
coa1 <- dudi.coa(tarentaise$ecol, sca = FALSE, nf = 2)
s.class(coa1$li, tarentaise$envir$alti, wt = coa1$lw)

acm1 <- dudi.acm(tarentaise$envir, sca = FALSE, nf = 2)
s.class(acm1$li, tarentaise$envir$alti)
}
\keyword{datasets}
