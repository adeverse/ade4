\encoding{latin1}
\name{withinpca}
\alias{withinpca}
\title{Normed within principal component analysis}
\description{
Performs a normed within Principal Component Analysis. 
}
\usage{
withinpca(df, fac, scaling = c("partial", "total"), 
    scannf = TRUE, nf = 2)
}
\arguments{
  \item{df}{a data frame with quantitative variables}
  \item{fac}{a factor partitioning the rows of df in classes}
  \item{scaling}{a string of characters as a scaling option : \cr
    if "partial", the sub-table corresponding to each class is centred and normed.\cr
    If "total", the sub-table corresponding to each class is centred and the total table is then normed.}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
}

\details{
This functions implements the 'Bouroche' standardization. In a first
step, the original variables are standardized (centred and normed). Then, a second
transformation is applied according to the value of the \code{scaling}
argument. For "partial", variables are standardized in each sub-table
(corresponding to each level of the factor). Hence, variables have null
mean and unit variance in each sub-table. For "total", variables are
centred in each sub-table and then normed globally. Hence, variables
have a null mean in each sub-table and a global variance equal to one.
}
\value{
returns a list of the sub-class \code{within} of class \code{dudi}. See \code{\link{within}}
}
\references{Bouroche, J. M. (1975) \emph{Analyse des données ternaires: la double analyse en composantes principales}. 
 Thèse de 3ème cycle, Université de Paris VI.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(meaudret)
wit1 <- withinpca(meaudret$env, meaudret$design$season, 
    scannf = FALSE, scaling = "partial")
kta1 <- ktab.within(wit1, colnames = rep(c("S1","S2","S3","S4","S5"), 4))
unclass(kta1)
# See pta
plot(wit1)
}
\keyword{multivariate}
