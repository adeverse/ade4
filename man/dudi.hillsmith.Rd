\name{dudi.hillsmith}
\alias{dudi.hillsmith}

\title{ Ordination of Tables mixing quantitative variables and factors }
\description{ performs a multivariate analysis with mixed quantitative variables and factors.}
\usage{dudi.hillsmith(df, row.w = rep(1, nrow(df))/nrow(df), scannf = TRUE, nf = 2)}

\arguments{
  \item{df}{ a data frame with mixed type variables (quantitative and factor) }
  \item{row.w}{ a vector of row weights, by default uniform row weights are used }
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
}
\details{
If df contains only quantitative variables, this is equivalent to a normed PCA.\cr
If df contains only factors, this is equivalent to an MCA.\cr

This analysis is the Hill and Smith method and is very similar to \code{dudi.mix} function. 
The differences are that \code{dudi.hillsmith} allow to use various row weights, while
\code{dudi.mix} deals with ordered variables.\cr
The principal components of this analysis are centered and normed vectors maximizing the sum of :\cr
    squared correlation coefficients with quantitative variables\cr
    correlation ratios with factors\cr
}
\value{
Returns a list of class \code{mix} and \code{dudi} (see \link{dudi}) containing also 
  \item{index}{a factor giving the type of each variable : f = factor, q = quantitative}
  \item{assign}{a factor indicating the initial variable for each column of the transformed table}
  \item{cr}{a data frame giving for each variable and each score:\cr
    the squared correlation coefficients if it is a quantitative variable\cr
    the correlation ratios if it is a factor
    }
}
}
\references{ Hill, M. O., and A. J. E. Smith. 1976. Principal component analysis of taxonomic data with multi-state discrete characters. \emph{Taxon}, \bold{25}:249-255. }
\author{ Stephane Dray <dray@biomserv.univ-lyon1.fr>}

\seealso{ dudi.mix }
\examples{
     data(dunedata)
     attributes(dunedata$envir$use)$class <- "factor"   # use dudi.mix for ordered data
     dd1 <- dudi.hillsmith(dunedata$envir, scann = FALSE)
     scatter.dudi(dd1, clab.r = 1, clab.c = 1.5)

  }
}

\keyword{multivariate}

