\name{discrimin}
\alias{discrimin}
\alias{plot.discrimin}
\alias{print.discrimin}
\title{Linear Discriminant Analysis (descriptive statistic)}
\description{
performs a linear discriminant analysis. 
}
\usage{
discrimin(dudi, fac, scannf = TRUE, nf = 2)
\method{plot}{discrimin}(x, xax = 1, yax = 2, \dots) 
\method{print}{discrimin}(x, \dots) 
}
\arguments{
  \item{dudi}{a duality diagram, object of class \code{dudi}}
  \item{fac}{a factor defining the classes of discriminant analysis}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \cr

  \item{x}{an object of class 'discrimin'}
  \item{xax}{the column number of the x-axis}
  \item{yax}{the column number of the y-axis}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
returns a list of class 'discrimin' containing :
  \item{nf}{a numeric value indicating the number of kept axes}
  \item{eig}{a numeric vector with all the eigenvalues}
  \item{fa}{a matrix with the loadings: the canonical weights}
  \item{li}{a data frame which gives the canonical scores}
  \item{va}{a matrix which gives the cosines between the variables and the canonical scores}
  \item{cp}{a matrix which gives the cosines between the components and the canonical scores}
  \item{gc}{a data frame which gives the class scores}
}
\seealso{\code{lda} in package \code{MASS}
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}
}
\examples{
data(chazeb)
dis1 <- discrimin(dudi.pca(chazeb$tab, scan = FALSE), chazeb$cla, 
    scan = FALSE)
dis1
plot(dis1)

data(skulls)
plot(discrimin(dudi.pca(skulls, scan = FALSE), gl(5,30), 
    scan = FALSE))
}
\keyword{multivariate}
