\name{corkdist}
\alias{corkdist}
\alias{mantelkdist}
\alias{RVkdist}
\alias{print.corkdist}
\alias{summary.corkdist}
\alias{plot.corkdist}
\title{Tests of randomization between distances applied to 'kdist' objetcs}
\description{
The mantelkdist and RVkdist functions apply to blocks of distance matrices the mantel.rtest et RV.rtest functions.
}
\usage{
mantelkdist (kd, nrepet = 999)
RVkdist (kd, nrepet = 999)
plot.corkdist (x, whichinrow = NULL, whichincol = NULL, 
   gap = 4, nclass = 10, coeff = 1,\dots)
}
\arguments{
  \item{kd}{a list of class \code{kdist}}
  \item{nrepet}{the number of permutations}
  \item{x}{an objet of class \code{corkdist}, coming from RVkdist or mantelkdist}
  \item{whichinrow}{a vector of integers to select the graphs in rows (if NULL all the graphs are computed)}
  \item{whichincol}{a vector of integers to select the graphs in columns (if NULL all the graphs are computed)}
  \item{gap}{an integer to determinate the space between two graphs}
  \item{nclass}{a number of intervals for the histogram}
  \item{coeff}{an integer to fit the magnitude of the graph}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
a list of class \code{corkdist} containing for each pair of distances an object of class \code{randtest} (permutation tests).
}
\details{
The \code{corkdist} class has some generic functions \code{print}, \code{plot} and \code{summary}. The plot shows bivariate scatterplots between semi-matrices of distances or histograms of simulated values with an error position.
}
\author{
Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}\cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(friday87)
fri.w <- ktab.data.frame(friday87$fau, friday87$fau.blo, 
    tabnames = friday87$tab.names)
fri.kc <- lapply(1:10, function(x) dist.binary(fri.w[[x]],10))
names(fri.kc) <-  substr(friday87$tab.names,1,4)
fri.kd <- kdist(fri.kc)
 fri.mantel = mantelkdist(kd = fri.kd, nrepet = 999)
 plot(fri.mantel,1:5,1:5)
 plot(fri.mantel,1:5,6:10)
 plot(fri.mantel,6:10,1:5)
 plot(fri.mantel,6:10,6:10)
s.corcircle (dudi.pca(as.data.frame(fri.kd), scan = FALSE)$co)
plot(RVkdist(fri.kd),1:5,1:5)

data(yanomama)
m1 <- mantelkdist(kdist(yanomama),999)
m1
summary(m1)
plot(m1)
}
\keyword{nonparametric}
