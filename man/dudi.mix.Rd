\name{dudi.mix}
\alias{dudi.mix}
\title{Ordination of Tables mixing quantitative variables and factors}
\description{
performs a multivariate analysis with mixed quantitative variables and factors. 
}
\usage{
dudi.mix(df, add.square = FALSE, scannf = TRUE, nf = 2)
}
\arguments{
  \item{df}{a data frame with mixed type variables (quantitative, factor and ordered)}
  \item{add.square}{a logical value indicating whether the squares of quantitative variables should be added}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
}
\details{
If df contains only quantitative variables, this is equivalent to a normed PCA.\cr
If df contains only factors, this is equivalent to a MCA.\cr
Ordered factors are replaced by \code{poly(x,deg=2)}. \cr

This analysis generalizes the Hill and Smith method.\cr
The principal components of this analysis are centered and normed vectors maximizing the sum of the:\cr
	squared correlation coefficients with quantitative variables\cr
	squared multiple correlation coefficients with polynoms\cr
	correlation ratios with factors. \cr
}
\value{
Returns a list of class \code{mix} and \code{dudi} (see \link{dudi}) containing also 
  \item{index}{a factor giving the type of each variable : f = factor, o = ordered, q = quantitative}
  \item{assign}{a factor indicating the initial variable for each column of the transformed table}
  \item{cr}{a data frame giving for each variable and each score:\cr
	the squared correlation coefficients if it is a quantitative variable\cr
	the correlation ratios if it is a factor\cr
	the squared multiple correlation coefficients if it is ordered}
}
\references{Hill, M. O., and A. J. E. Smith. 1976. Principal component analysis of taxonomic data with multi-state discrete characters. \emph{Taxon}, \bold{25}, 249-255.\cr\cr
De Leeuw, J., J. van Rijckevorsel, and . 1980. HOMALS and PRINCALS - Some generalizations of principal components analysis. Pages 231-242 in E. Diday and Coll., editors. Data Analysis and Informatics II. Elsevier Science Publisher, North Holland, Amsterdam.\cr\cr
Kiers, H. A. L. 1994. Simple structure in component analysis techniques for mixtures of qualitative ans quantitative variables. \emph{Psychometrika}, \bold{56}, 197-212.
}
\examples{
data(dunedata)
dd1 <- dudi.mix(dunedata$envir, scann = FALSE)
scatter.dudi(dd1, clab.r = 1, clab.c = 1.5)

dd2 <- dudi.mix(dunedata$envir, scann = FALSE, add = TRUE)
scatter.dudi(dd2, clab.r = 1, clab.c = 1.5)
}
\keyword{multivariate}
