\name{as.taxo}
\alias{as.taxo}
\title{Taxonomy}
\description{
This function creates an object of class \code{taxo} that is a sub-class of \code{data.frame}. Each column of the data frame must be a factor corresponding to a level \emph{j} of the taxonomy (genus, family, \dots).
The levels of factor \emph{j} define some classes that must be completly included in classes of factor \emph{j+1}.
}
\usage{
as.taxo(df)
}
\arguments{
\item{df}{a data frame}
}
\value{
Returns a data.frame of class \code{taxo}.
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} \
S�bastien Ollier \email{ollier@biomserv.univ-lyon1.fr}
}
\seealso{\code{\link{taxo2phylog}} to transform an object of class \code{taxo} into an object of class \code{phylog}}.
\examples{
data(taxo.eg)
tax <- as.taxo(taxo.eg[[1]])
tax.phy <- taxo2phylog(as.taxo(taxo.eg[[1]]))
par(mfrow = c(1,2))
plot.phylog(tax.phy, clabel.l = 1.25, clabel.n = 1.25, f = 0.75)
plot.phylog(taxo2phylog(as.taxo(taxo.eg[[1]][sample(15),])),
 clabel.l = 1.25, clabel.n = 1.25, f = 0.75)
par(mfrow = c(1,1))
}
\keyword{manip}