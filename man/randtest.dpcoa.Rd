\name{randtest.dpcoa}
\alias{randtest.dpcoa}
\title{
Permutation test for double principal coordinate analysis (DPCoA)
}
\description{
\code{randtest.dpcoa} calculates the ratio of beta to gamma diversity associated with DPCoA and compares the observed value to values obtained by permuting data.
}

\usage{
\method{randtest}{dpcoa}(xtest, model = c("1p","1s"), nrepet = 99,
alter = c("greater", "less", "two-sided"), ...)
}
\arguments{
  \item{xtest}{an object of class \code{dpcoa}}
  \item{model}{either "1p", "1s", or the name of a function, (see details)}
  \item{nrepet}{the number of permutations to perform, the default is 99}
  \item{alter}{a character string specifying the alternative hypothesis, must be one of "greater" (default), "less" or "two-sided"}
  \item{\dots}{further arguments passed to or from other methods}
  }
\details{
Model 1p permutes the names of the columns of the abundance matrix.
Model 1s permutes the abundances of the categories (columns of the abundance matrix, usually species) within collections (rows of the abundance matrix, usually communities). Only the categories with positive abundances are permuted. 
The null models were introduced in Hardy (2008).

Other null model can be used by entering the name of a function. For example, loading the \code{picante} package of R, if \code{model=randomizeMatrix}, then the permutations will follow function \code{randomizeMatrix} available in picante. Any function can be used provided it returns an abundance matrix of similar size as the observed abundance matrix. Parameters of the chosen function can be added to \code{randtest.dpcoa}. For example, using parameter \code{null.model} of \code{randomizeMatrix}, the following command can be used:
\code{randtest.dpcoa(xtest, model = randomizeMatrix, null.model = "trialswap")}
}
\value{
an object of class \code{randtest}
}
\references{
Hardy, O. (2008) Testing the spatial phylogenetic structure of local communities: statistical performances of different null models and test statistics on a locally neutral community. \emph{Journal of Ecology}, \bold{96}, 914--926
}
\author{
Sandrine Pavoine \email{pavoine@mnhn.fr}
}
\seealso{
\code{\link{dpcoa}}
}
\examples{
data(humDNAm)
dpcoahum <- dpcoa(data.frame(t(humDNAm$samples)), sqrt(humDNAm$distances), scan = FALSE, nf = 2)
randtest(dpcoahum)
}
