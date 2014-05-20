\name{EH}
\alias{EH}
\title{Amount of Evolutionary History
}
\description{
computes the sum of branch lengths on an ultrametric phylogenetic tree.
}
\usage{
EH(phyl, select = NULL)
}
\arguments{
  \item{phyl}{an object of class phylog}
  \item{select}{a vector containing the numbers of the leaves (species) which must be considered 
  in the computation of the amount of Evolutionary History. This parameter allows the calculation 
  of the amount of Evolutionary History for a subset of species. }
}
\value{
returns a real value.
}
\references{
Nee, S. and May, R.M. (1997) Extinction and the loss of evolutionary history. \emph{Science},  
\bold{278}, 692--694.
}
\author{
Sandrine Pavoine \email{pavoine@mnhn.fr}
}
\examples{
data(carni70)
carni70.phy <- newick2phylog(carni70$tre)
EH(carni70.phy)
EH(carni70.phy, select = 1:15) # Felidae
}
\keyword{multivariate}
