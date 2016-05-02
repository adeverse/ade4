\name{inertia.dudi}
\alias{inertia}
\alias{inertia.dudi}
\alias{print.inertia}
\alias{summary.inertia}
\title{Decomposition of inertia (i.e. contributions) in multivariate methods}
\description{
Computes the decomposition of inertia to measure the contributions of row and/or columns in multivariate methods
}
\usage{
\method{inertia}{dudi}(x, row.inertia = FALSE, col.inertia = FALSE, ...)
\method{print}{inertia}(x, ...)
\method{summary}{inertia}(object, subset = 5, ...)
}
\arguments{
  \item{x, object}{a duality diagram, object of class \code{dudi} for \code{inertia.dudi}. An object of class \code{inertia} for the methods \code{print} and \code{summary}}
  \item{row.inertia}{if TRUE, returns the decomposition of inertia for the rows}
  \item{col.inertia}{if TRUE, returns the decomposition of inertia for the columns}
  \item{subset}{the number of rows and/or columns to display in the summary}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
An object of class \code{inertia}, i.e. a list containing :
\item{TOT}{repartition of the total inertia between axes}
\item{row.contrib}{contributions of the rows to the total inertia}
\item{row.abs}{absolute contributions of the rows (i.e. decomposition per axis)}
\item{row.rel}{relative contributions of the rows}
\item{row.cum}{cumulative relative contributions of the rows (i.e. decomposition per row)}
\item{col.contrib}{contributions of the columns to the total inertia}
\item{col.abs}{absolute contributions of the columns (i.e. decomposition per axis)}
\item{col.rel}{relative contributions of the columns}
\item{col.cum}{cumulative relative contributions of the columns (i.e. decomposition per column)}
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
\details{Contributions are printed in percentage and the sign is the sign of the coordinates}
\author{
Daniel Chessel \cr
Stephane Dray \email{stephane.dray@univ-lyon1.fr}\cr
Anne B Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}
}
\examples{
data(housetasks)
coa1 <- dudi.coa(housetasks, scann = FALSE)
res <- inertia(coa1, col = TRUE, row = FALSE)
res
summary(res)
}
\keyword{multivariate}
