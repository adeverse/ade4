\encoding{latin1}
\name{as.taxo}
\alias{as.taxo}
\alias{dist.taxo}
\title{Taxonomy}
\description{
The function \code{as.taxo} creates an object of class \code{taxo} that is a sub-class of \code{data.frame}.
Each column of the data frame must be a factor corresponding to a level \emph{j} of the taxonomy (genus, family, \dots).
The levels of factor \emph{j} define some classes that must be completly included in classes of factor \emph{j+1}.\cr
A factor with exactly one level is not allowed. A factor with exactly one individual in each level is not allowed.
The function \code{dist.taxo} compute taxonomic distances.
}
\usage{
as.taxo(df)
dist.taxo(taxo)
}
\arguments{
\item{df}{a data frame}
\item{taxo}{a data frame of class \code{taxo}}
}
\value{
\code{as.taxo} returns a data frame of class \code{taxo}.
\code{dist.taxo} returns a numeric of class \code{dist}.
}
\author{Daniel Chessel  \cr
Sébastien Ollier \email{sebastien.ollier@u-psud.fr}
}
\seealso{\code{\link{taxo2phylog}} to transform an object of class \code{taxo} into an object of class \code{phylog}
}
\examples{
data(taxo.eg)
tax <- as.taxo(taxo.eg[[1]])
tax.phy <- taxo2phylog(as.taxo(taxo.eg[[1]]),add.tools=TRUE)
par(mfrow = c(1,2))
plot(tax.phy, clabel.l = 1.25, clabel.n = 1.25, f = 0.75)
plot(taxo2phylog(as.taxo(taxo.eg[[1]][sample(15),])),
 clabel.l = 1.25, clabel.n = 1.25, f = 0.75)
par(mfrow = c(1,1))
all(dist.taxo(tax)==tax.phy$Wdist)
}
\keyword{manip}
