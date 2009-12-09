\encoding{latin1}
\name{monde84}
\alias{monde84}
\docType{data}
\title{Global State of the World in 1984}
\usage{data(monde84)}
\description{
The \code{monde84} data frame gives five demographic variables 
for 48 countries in the world. 
}
\format{
  This data frame contains the following columns:
  \enumerate{
    \item pib: Gross Domestic Product
    \item croipop: Growth of the population
    \item morta: Infant Mortality
    \item anal: Literacy Rate
    \item scol: Percentage of children in full-time education
  }
}
\source{
Geze, F. and Coll., eds. (1984)
\emph{L'état du Monde 1984 : annuaire économique et géopolitique mondial}. La Découverte, Paris.
}
\examples{
data(monde84)
X <- cbind.data.frame(lpib = log(monde84$pib), monde84$croipop)
Y <- cbind.data.frame(lmorta = log(monde84$morta), 
    lanal = log(monde84$anal + 1), rscol = sqrt(100 - monde84$scol))
pcaY <- dudi.pca(Y, scan = FALSE)
pcaiv1 <- pcaiv(pcaY, X0 <- scale(X), scan = FALSE)
sum(cor(pcaiv1$l1[,1], Y0 <- scale(Y))^2)
pcaiv1$eig[1] #the same
}
\keyword{datasets}
