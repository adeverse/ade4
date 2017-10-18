\name{variance.phylog}
\alias{variance.phylog}
\title{The phylogenetic ANOVA}
\description{
This function performs the variance analysis of a trait on eigenvectors associated to a phylogenetic tree.
}
\usage{
variance.phylog(phylog, z, bynames = TRUE,
 na.action = c("fail", "mean"))
}
\arguments{
  \item{phylog}{: an object of class \code{phylog}}
  \item{z}{: a numeric vector of the values corresponding to the variable}
  \item{bynames}{: if TRUE checks if \code{z} labels are the same as \code{phylog} leaves label, possibly in a different order. If FALSE the check is not made and \code{z} labels must be in the same order than \code{phylog} leaves label}
  \item{na.action}{: if 'fail' stops the execution of the current expression when \code{z} contains any missing value. If 'mean' replaces any missing values by mean(\code{z})}
}
\details{
\code{phylog$Amat} defines a set of orthonormal vectors associated the each nodes of the phylogenetic tree. \cr
\code{phylog$Adim} defines the dimension of the subspace \bold{A} defined by 
the first \code{phylog$Adim} vectors of \code{phylog$Amat} that corresponds to phylogenetic inertia. \cr
\code{variance.phylog} performs the linear regression of \code{z} on \bold{A}.
}
\value{
Returns a list containing
  \item{lm}{: an object of class \code{lm} that corresponds to the linear regression of \code{z} on \bold{A}.}
  \item{anova}{: an object of class \code{anova} that corresponds to the anova of the precedent model.}
  \item{smry}{: an object of class \code{anova} that is a summary of the precedent object.}
}
\references{
Grafen, A. (1989) The phylogenetic regression. \emph{Philosophical Transactions of the Royal Society London B}, \bold{326}, 119--156.

Diniz-Filho, J. A. F., Sant'Ana, C.E.R. and Bini, L.M. (1998) An eigenvector method for estimating phylogenetic inertia. \emph{Evolution}, \bold{52}, 1247--1262.
}
\author{Sébastien Ollier \email{sebastien.ollier@u-psud.fr} \cr
Daniel Chessel 
}
\seealso{\code{\link{phylog}}, \code{\link{lm}}}

\examples{
data(njplot)
njplot.phy <- newick2phylog(njplot$tre)
variance.phylog(njplot.phy,njplot$tauxcg)
par(mfrow = c(1,2))
table.phylog(njplot.phy$Ascores, njplot.phy, clabel.row = 0,
  clabel.col = 0.1, clabel.nod = 0.6, csize = 1)
dotchart.phylog(njplot.phy, njplot$tauxcg, clabel.nodes = 0.6)
if (requireNamespace("adephylo", quietly = TRUE) & requireNamespace("ape", quietly = TRUE)) {
  tre <- ape::read.tree(text = njplot$tre)
  adephylo::orthogram(njplot$tauxcg, tre = tre)
}
}
\keyword{models}
