\name{dudi.fca}
\alias{dudi.fca}
\alias{prep.fuzzy.var}
\title{Fuzzy Correspondence Analysis}
\description{
 This function analyses a table of fuzzy variables.\cr\cr
 A fuzzy variable takes values of type \eqn{a=(a_1,\dots,a_k)}{a=(a1,\dots,ak)} 
 giving the importance of k categories.\cr\cr
 A missing data is denoted (0,...,0).\cr
 Only the profile a/sum(a) is used, and missing data are replaced by
 the mean profile of the others in the function \code{prep.fuzzy.var}. See ref. for details.
}
\usage{
prep.fuzzy.var (df, col.blocks, row.w = rep(1, nrow(df)))
dudi.fca(df, scannf = TRUE, nf = 2)
}
\arguments{
  \item{df}{a data frame containing positive or null values}
  \item{col.blocks}{a vector containing the number of categories for each fuzzy variable}
  \item{row.w}{a vector of row weights}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
}
\value{
The function \code{prep.fuzzy.var} returns a data frame with attribute \code{col.blocks}
The function \code{dudi.fca} returns a list of class \code{fca} and \code{dudi} (see \link{dudi}) containing also
\item{cr}{a data frame which rows are the blocs, columns are the kept axes, and values are correlation ratios.}
}
\references{Chevenet, F., Dolédec, S. and Chessel, D. (1994) A fuzzy coding approach for the analysis of 
long-term ecological data. \emph{Freshwater Biology}, \bold{31}, 295--309. 
}
\examples{
w1 <- matrix(c(1,0,0,2,1,1,0,2,2,0,1,0,1,1,1,0,1,3,1,0), 4, 5)
w1 <- data.frame(w1)
w2 <- prep.fuzzy.var(w1, c(2,3))
w1
w2
attributes(w2)

data(bsetal97)
w <- prep.fuzzy.var(bsetal97$biol, bsetal97$biol.blo)
scatter(dudi.fca(w, scann = FALSE, nf = 3), csub = 3, clab.moda = 1.5)

 w1 <- prep.fuzzy.var(bsetal97$biol, bsetal97$biol.blo)
w2 <- prep.fuzzy.var(bsetal97$ecol, bsetal97$ecol.blo)
d1 <- dudi.fca(w1, scann = FALSE, nf = 3)
d2 <- dudi.fca(w2, scann = FALSE, nf = 3)
plot(coinertia(d1, d2, scann = FALSE))
}
\keyword{multivariate}
