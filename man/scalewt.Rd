\name{scalewt}
\alias{covwt}
\alias{varwt}
\alias{scalewt}
\alias{meanfacwt}
\alias{varfacwt}
\alias{covfacwt}
\alias{scalefacwt}
\title{Compute or scale data using (weighted) means, variances and
  covariances (possibly for the levels of a factor)}
\description{
These utility functions compute (weighted) means, variances and covariances for
  dataframe partitioned by a factor. The scale transforms a numeric matrix in a centred and scaled matrix for any weighting. 
}
\usage{
covwt(x, wt, na.rm = FALSE)
varwt(x, wt, na.rm = FALSE)
scalewt(df, wt = rep(1/nrow(df), nrow(df)), center = TRUE, scale = TRUE)
meanfacwt(df, fac = NULL, wt = rep(1/nrow(df), nrow(df)), drop = FALSE)
varfacwt(df, fac = NULL, wt = rep(1/nrow(df), nrow(df)), drop = FALSE)
covfacwt(df, fac = NULL, wt = rep(1/nrow(df), nrow(df)), drop = FALSE)
scalefacwt(df, fac = NULL, wt = rep(1/nrow(df), nrow(df)), scale = TRUE, drop = FALSE)

}
\arguments{
  \item{x}{a numeric vector (\code{varwt}) or a matrix (\code{covwt})
    containg the data.}
  \item{na.rm}{a logical value indicating whether NA values should be stripped before the computation proceeds.}
  \item{df}{a matrix or a dataframe containing the data.}
  \item{fac}{a factor partitioning the data.}
  \item{wt}{a numeric vector of weights.}
  \item{drop}{a logical value indicating whether unused levels should be kept.}
  \item{scale}{a logical value indicating whether data should be scaled or not.}
  \item{center}{a logical value indicating whether data should be centered or not.}
}

\details{
Functions returns biased estimates of variances and covariances
(i.e. divided by n and not n-1)
}
\value{
For \code{varwt}, the weighted variance. For \code{covwt},
the matrix of weighted co-variances. For \code{scalewt}, the scaled
dataframe. For other function a list (if \code{fac} is not null) of dataframes with approriate values
}

\author{Stéphane Dray \email{stephane.dray@univ-lyon1.fr}}
\examples{
data(meau)
w <- rowSums(meau$spe)
varwt(meau$env, w)
varfacwt(meau$env, wt = w)
varfacwt(meau$env, wt = w, fac = meau$design$season)
covfacwt(meau$env, wt = w, fac = meau$design$season)
scalewt(meau$env, wt = w)
}
\keyword{utilities}
