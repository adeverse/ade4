\name{mafragh}
\alias{mafragh}
\non_function{}
\title{Phyto-Ecological Survey}
\description{
This data set gives environmental and spatial informations about species and sites. 
}
\usage{data(mafragh)}
\format{
	\code{mafragh} is a list of 6 components.
	\enumerate{
		\item{xy}{are the coordinates of 97 sites.}
		\item{flo}{is a data frame with 97 sites and 56 species.}
		\item{espnames}{is a vector of the names of species.}
		\item{neig}{is the neighbourhood graph of the 97 sites (an object of class 'neig').}
		\item{mil}{is a data frame with 97 sites and 11 environmental variables.}
		\item{partition}{is a factor classifying the 97 sites in 5 classes.}
	}
}
\source{
Belair, G.d. and Bencheikh-Lehocine, M. (1987)\cr
Composition et déterminisme de la végétation d'une plaine côti"re marécageuse : La Mafragh (Annaba, Algérie).\cr
\emph{Bulletin d'Ecologie}, \bold{18}, 393--407.
}
\examples{
data(mafragh)
par(mfrow = c(3,2))
s.label(mafragh$xy, inc = FALSE, neig = mafragh$neig, 
    sub = "Samples & Neighbourhood graph")
coa1 <- dudi.coa(mafragh$flo, scan = FALSE)
s.value(mafragh$xy, coa1$li[,1], sub = "Axis 1 - COA")
pca1 <- dudi.pca(mafragh$xy, scan = FALSE)
s.value(mafragh$xy, pca1$li[,1], sub = "Axis 1 - PCA")
s.class(pca1$li, mafragh$partition, sub = "Plane 1-2 - PCA")
s.class(coa1$li, mafragh$partition, sub = "Plane 1-2 - COA")
s.chull(mafragh$xy, mafragh$partition, optchull = 1)
par(mfrow = c(1,1))
}
\keyword{datasets}
