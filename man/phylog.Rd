\encoding{latin1}
\name{phylog}
\alias{phylog}
\alias{print.phylog}
\alias{phylog.extract}
\alias{phylog.permut}
\title{Phylogeny}
\description{
Create and use objects of class \code{phylog}. \cr
\code{phylog.extract} returns objects of class \code{phylog}. It extracts sub-trees from a tree. \cr
\code{phylog.permut} returns objects of class \code{phylog}. It creates the different representations compatible with tree topology.
}
\usage{
\method{print}{phylog}(x, ...)
phylog.extract(phylog, node, distance = TRUE)
phylog.permut(phylog, list.nodes = NULL, distance = TRUE)
}
\arguments{
  \item{x, phylog}{: an object of class \code{phylog}}
  \item{\dots}{: further arguments passed to or from other methods}
  \item{node}{: a string of characters giving a node name. The functions extracts the tree rooted at this node.}
  \item{distance}{: if TRUE, both functions retain branch lengths. If FALSE, they returns tree with arbitrary branch lengths (each branch length equals one)}
  \item{list.nodes}{: a list which elements are vectors of string of character corresponding to direct descendants of nodes. This list defines one representation compatible with tree topology among the set of possibilities.}
}
\value{
Returns a list of class \code{phylog} :
    \item{tre}{: a character string of the phylogenetic tree in Newick format whithout branch length values}
    \item{leaves}{: a vector which names corresponds to leaves and values gives the distance between leaves and nodes closest to these leaves}
    \item{nodes}{: a vector which names corresponds to nodes and values gives the distance between nodes and nodes closest to these leaves}
    \item{parts}{: a list which elements gives the direct descendants of each nodes}
    \item{paths}{: a list which elements gives the path leading from the root to taxonomic units (leaves and nodes)}
    \item{droot}{: a vector which names corresponds to taxonomic units and values gives distance between taxonomic units and the root}
    \item{call}{: call} 
    \item{Wmat}{: a phylogenetic link matrix, generally called the covariance matrix. Matrix values \eqn{Wmat_{ij}}{Wmat_ij} correspond to path length that lead from root to the first common ancestor of the two leaves i and j}
    \item{Wdist}{: a phylogenetic distance matrix of class \code{'dist'}. Matrix values \eqn{Wdist_{ij}}{Wdist_ij} correspond to \eqn{\sqrt{d_{ij}}} where \eqn{d_{ij}}{d_ij} is the classical distance between two leaves i and j}
    \item{Wvalues}{: a vector with the eigen values of Wmat}
    \item{Wscores}{: a data frame with eigen vectors of Wmat. This data frame defines an orthobasis that could be used to calculate the orthonormal decomposition of a biological trait on a tree.}
    \item{Amat}{: a phylogenetic link matrix stemed from Abouheif's test and defined in Ollier et al. (submited)}
    \item{Avalues}{: a vector with the eigen values of Amat}
    \item{Adim}{: number of positive eigen values}
    \item{Ascores}{: a data frame with eigen vectors of Amat. This data frame defines an orthobasis that could be used to calculate the orthonormal decomposition of a biological trait on a tree.}
    \item{Aparam}{: a data frame with attributes associated to nodes.}
    \item{Bindica}{: a data frame giving for some taxonomic units the partition of leaves that is associated to its}
    \item{Bscores}{: a data frame giving an orthobasis defined by Ollier et al. (submited) that could be used to calculate the orthonormal decomposition of a biological trait on a tree.}
    \item{Bvalues}{: a vector giving the degree of phylogenetic autocorrelation for each vectors of Bscores (Moran's form calculated with the matrix Wmat)}
    \item{Blabels}{: a vector giving for each nodes the name of the vector of Bscores that is associated to its}    
}
\references{
Ollier, S., Couteron, P. and Chessel, D. (2005) Orthonormal transforms to detect and describe 
phylogenetic autocorrelation. \emph{Biometrics} (in press).
}
\author{Daniel Chessel  \cr
S?bastien Ollier \email{sebastien.ollier@u-psud.fr}
}
\seealso{\code{\link{newick2phylog}}, \code{\link{plot.phylog}}}
\examples{
marthans.tre <- NULL
marthans.tre[1] <-"((((1:4,2:4)a:5,(3:7,4:7)b:2)c:2,5:11)d:2,"
marthans.tre[2] <- "((6:5,7:5)e:4,(8:4,9:4)f:5)g:4);"
marthans.phylog <- newick2phylog(marthans.tre)
marthans.phylog

if(requireNamespace("ape", quietly=TRUE)) {
  marthans.phylo <- ape::read.tree(text = marthans.tre)
  marthans.phylo

  par(mfrow =c (1,2))
  plot(marthans.phylog, cnode = 3, f = 0.8, cle = 3)
  plot(marthans.phylo)
  par(mfrow = c(1,1))
}
}
\keyword{manip}
