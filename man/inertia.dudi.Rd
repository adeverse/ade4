\name{inertia.dudi}
\alias{inertia.dudi}
\title{Statistics of inertia in a one-table analysis}
\description{
Prints of the statistics of inertia in a one-table analysis
}
\usage{
inertia.dudi(dudi, row.inertia = FALSE, col.inertia = FALSE)
}
\arguments{
  \item{dudi}{a duality diagram, object of class \code{dudi}}
  \item{row.inertia}{if TRUE, returns the statistics of the decomposition of inertia for the rows}
  \item{col.inertia}{if TRUE, returns the statistics of the decomposition of inertia for the columns}
}
\value{
a list containing :
\item{TOT}{repartition of the total inertia between axes}
\item{row.abs}{absolute contributions of the decomposition of inertia for the rows}
\item{row.rel}{relative contributions of the decomposition of inertia for the rows}
\item{row.cum}{cumulative relative contributions of the decomposition of inertia for the rows}
\item{col.abs}{absolute contributions of the decomposition of inertia for the columns}
\item{col.rel}{relative contributions of the decomposition of inertia for the columns}
\item{col.cum}{cumulative relative contributions of the decomposition of inertia for the columns}
}
\references{
Lebart, L., Morineau, A. and Tabart, N. (1977) \emph{Techniques de la description statistique, méthodes et logiciels pour la description des grands tableaux}, Dunod, Paris, 61--62.\cr\cr
Volle, M. (1981) \emph{Analyse des données}, Economica, Paris, 89--90 and 118\cr\cr
Lebart, L., Morineau, L. and Warwick, K.M. (1984) \emph{Multivariate descriptive analysis: correspondence and related techniques for large matrices}, John Wiley and Sons, New York.\cr\cr
Greenacre, M. (1984) \emph{Theory and applications of correspondence analysis}, Academic Press, London, 66.\cr\cr
Rouanet, H. and Le Roux, B. (1993) \emph{Analyse des données multidimensionnelles},  Dunod, Paris, 143--144.\cr\cr
Tenenhaus, M. (1994) \emph{Méthodes statistiques en gestion},  Dunod, Paris, p. 160, 161, 166, 204.\cr\cr
Lebart, L., Morineau, A. and Piron, M. (1995) \emph{Statistique exploratoire multidimensionnelle}, Dunod, Paris,  p. 56,95-96.\cr
}
\details{Contributions are printed in 1/10000 and the sign is the sign of the coordinate
}
\examples{
data(housetasks)
coa1 <- dudi.coa(housetasks, scann = FALSE)
inertia.dudi(coa1, col = TRUE, row = FALSE)$col.rel
}
\keyword{multivariate}
