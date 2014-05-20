\name{optimEH}
\alias{optimEH}
\title{Nee and May's optimizing process
}
\description{
performs Nee and May's optimizing scheme. When branch lengths in an ultrametric phylogenetic 
tree are expressed as divergence times, the total sum of branch lengths in that 
tree expresses the amount of evolutionary history. Nee and May's algorithm 
optimizes the amount of evolutionary history preserved if only k species out 
of n were to be saved. The k-1 closest-to-root nodes are selected, which 
defines k clades; one species from each clade is picked. At this last step, 
we decide to select the most original species of each from the k clades. 

}
\usage{
optimEH(phyl, nbofsp, tol = 1e-8, give.list = TRUE) 
}
\arguments{
  \item{phyl}{an object of class phylog}
  \item{nbofsp}{an integer indicating the number of species saved (k).}
  \item{tol}{a tolerance threshold for null values (a value less than \code{tol} in absolute terms is considered as NULL). }
  \item{give.list}{logical value indicating whether a list of optimizing species should be provided. If \code{give.list = TRUE}, 
  \code{optimEH} provides the list of the k species which optimize the amount of evolutionary history preserved 
  and are the most original species in their clades. If \code{give.list = FALSE}, \code{optimEH} returns directly the real 
  value giving the amount of evolutionary history preserved.}
}
\value{
Returns a list containing: 
  \item{value}{a real value providing the amount of evolutionary history preserved.}
  \item{selected.sp}{a data frame containing the list of the k species which optimize the amount of evolutionary history preserved 
  and are the most original species in their clades.}
}
\references{
Nee, S. and May, R.M. (1997) Extinction and the loss of evolutionary history. \emph{Science} 
\bold{278}, 692--694.

Pavoine, S., Ollier, S. and Dufour, A.-B. (2005)  
Is the originality of a species measurable? 
\emph{Ecology Letters}, \bold{8}, 579--586.
}
\author{
Sandrine Pavoine \email{pavoine@mnhn.fr}
}
\seealso{\code{\link{randEH}}
}
\examples{
data(carni70)
carni70.phy <- newick2phylog(carni70$tre)
optimEH(carni70.phy, nbofsp = 7, give.list = TRUE) 
}
\keyword{multivariate}
