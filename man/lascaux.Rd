\name{lascaux}
\alias{lascaux}
\non_function{}
\title{Genetic/Environment and types of variables}
\description{
This data set gives meristic, genetic and morphological data frame 
for 306 trouts.  
}
\usage{data(lascaux)}
\format{
	\code{lascaux} is a list of 9 components.
	\enumerate{
		\item{riv}{is a factor returning the river where 306 trouts are captured}
		\item{code}{vector of characters : code of the 306 trouts}
		\item{sex}{factor sex of the 306 trouts}
		\item{meris}{data frame 306 trouts - 5 meristic variables}
		\item{tap}{data frame of the total number of red and black points}
		\item{gen}{factor of the genetic code of the 306 trouts}
		\item{morpho}{data frame 306 trouts 37 morphological variables}
		\item{colo}{data frame 306 trouts 15 variables of coloring}
		\item{ornem}{data frame 306 trouts 15 factors (ornementation)}
	}
}
\source{
Lascaux, J.M. (1996)\cr
Analyse de la variabilité morphologique de la truite commune (Salmo trutta L.) dans les cours d'eau du bassin pyrénéen méditerranéen.\cr
Th"se de doctorat en sciences agronomiques, INP Toulouse.
}
\examples{
data(lascaux)
par(mfrow = c(2,2))
barplot(dudi.pca(lascaux$meris, scan = FALSE)$eig)
title(main = "Meristic")
barplot(dudi.pca(lascaux$colo, scan = FALSE)$eig)
title(main = "Coloration")
barplot(dudi.pca(na.omit(lascaux$morpho), scan = FALSE)$eig)
title(main = "Morphometric")
barplot(dudi.acm(na.omit(lascaux$orne), scan = FALSE)$eig)
title(main = "Ornemental")
par(mfrow = c(1,1))
}
\keyword{datasets}
