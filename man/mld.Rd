\name{mld}
\alias{mld}
\alias{haar2level}
\title{Multi Level Decomposition of unidimensional data}
\description{
The function \code{mld} performs an additive decomposition of the input vector \code{x} onto sub-spaces associated 
to an orthonormal orthobasis. The sub-spaces are defined by levels of the input factor \code{level}.
The function \code{haar2level} builds the factor \code{level} such that the multi level decomposition corresponds exactly to a multiresolution analysis performed with the haar basis.
}
\usage{
mld(x, orthobas, level, na.action = c("fail", "mean"),
 plot = TRUE, dfxy = NULL, phylog = NULL, ...)
haar2level(x)
}
\arguments{
  \item{x}{is a vector or a time serie containing the data to be decomposed. This must be a dyadic length vector (power of 2) for the function \code{haar2level}.}
  \item{orthobas}{is a data frame containing the vectors of the orthonormal basis.}
  \item{level}{is a factor which levels define the sub-spaces on which the function \code{mld} performs the additive decomposition.}
  \item{na.action}{ if 'fail' stops the execution of the current expression when \code{x} contains any missing value. If 'mean' replaces any missing values by mean(\code{x}).}
  \item{plot}{if TRUE plot \code{x} and the components resulting from the decomposition.}
  \item{dfxy}{is a data frame with two coordinates.}
  \item{phylog}{is an object of class \code{phylog}.}
  \item{\dots}{further arguments passed to or from other methods.}
}
\value{
A data frame with the components resulting from the decomposition.
}
\references{
Mallat, S. G. (1989) A theory for multiresolution signal decomposition: the wavelet representation. 
\emph{IEEE Transactions on Pattern Analysis and Machine Intelligence}, \bold{11}, 7, 674--693.

Percival, D. B. and Walden, A. T. (2000) \emph{Wavelet Methods for Time Series Analysis}, Cambridge University Press.
}
\author{Sébastien Ollier \email{ollier@biomserv.univ-lyon1.fr} \cr
Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}
}
\seealso{\code{\link{gridrowcol}}, \code{\link{orthobasis}}, \code{\link{orthogram}}, \code{\link[waveslim]{mra}} for multiresolution analysis with various families of wavelets}
\examples{
# decomposition of a time serie
data(co2)
x <- log(co2)
orthobas <- orthobasis.line(length(x))
level<-rep("D", 467)
level[1:3]<-rep("A", 3)
level[c(77,78,79,81)]<-rep("B", 4)
level[156]<-"C"
level<-as.factor(level)
res <- mld(x, orthobas, level)
sum(scale(x, scale = FALSE) - apply(res, 1, sum))

# decomposition of a biological trait on a phylogeny
data(palm)
vfruit<-palm$traits$vfruit
vfruit<-scalewt(vfruit)   
palm.phy<-newick2phylog(palm$tre)
level <- rep("F", 65)
level[c(4, 21, 3, 6, 13)] <- LETTERS[1:5]
level <- as.factor(level)
res <- mld(as.vector(vfruit), palm.phy$Bscores, level,
 phylog = palm.phy, clabel.nod = 0.7, f.phylog=0.8,
  csize = 2, clabel.row = 0.7, clabel.col = 0.7)

}
\keyword{ts}
\keyword{spatial}
