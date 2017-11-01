\name{dagnelie.test}
\alias{dagnelie.test}
\title{Dagnelie multinormality test}
\usage{
dagnelie.test(x)
}
\arguments{
\item{x}{Multivariate data table (\code{matrix} or \code{data.frame}).}
}

\description{
Compute Dagnelie test of multivariate normality on a data table of n objects (rows) and p variables (columns), with n > (p+1).
}

\value{A list containing the following results: 
\item{Shapiro.Wilk}{W statistic and p-value}
\item{dim}{dimensions of the data matrix, n and p}
\item{rank}{the rank of the covariance matrix}
\item{D}{Vector containing the Mahalanobis distances of the objects to the multivariate centroid}
}
\details{
Dagnelie's goodness-of-fit test of multivariate normality is applicable to 
 multivariate data. Mahalanobis generalized distances are computed between each object and the multivariate centroid of all objects. Dagnelie’s approach is that, for multinormal data, the generalized distances should be normally distributed. The function computes a Shapiro-Wilk test of normality of the Mahalanobis distances; this is our improvement of Dagnelie’s method. 
The null hypothesis (H0) is that the data are multinormal, a situation where the Mahalanobis distances should be normally distributed. In that case, the test should not reject H0, subject to type I error at the selected significance level. \cr

 Numerical simulations by D. Borcard have shown that the test had correct levels of type I error for values of n between 3p and 8p, where n is the number of objects and p is the number of variables in the data 
 matrix (simulations with 1 <= p <= 100). Outside that range of n values, the results were too liberal, meaning that the test rejected too often the null hypothesis of normality. For p = 2, the simulations showed the test to be valid for 6 <= n <= 13 and too liberal outside that range. If H0 is not rejected in a situation where the test is too liberal, the result is trustworthy.\cr

Calculation of the Mahalanobis distances requires that n > p+1 (actually, n > rank+1). With fewer objects (n), all points are at equal Mahalanobis distances from the centroid in the resulting space, which has \code{min(rank,(n-1))} dimensions. For data matrices that happen to be collinear, the function uses \code{ginv} for inversion.\cr

This test is not meant to be used with univariate data; in simulations, the type I error rate was higher than the 5\% significance level for all values of n. Function \code{shapiro.test} should be used in that situation.
}
\examples{

 # Example 1: 2 variables, n = 100
 n <- 100; p <- 2
 mat <- matrix(rnorm(n*p), n, p)
 (out <- dagnelie.test(mat))

 # Example 2: 10 variables, n = 50
 n <- 50; p <- 10
 mat <- matrix(rnorm(n*p), n, p)
 (out <- dagnelie.test(mat))

 # Example 3: 10 variables, n = 100
 n <- 100; p <- 10
 mat <- matrix(rnorm(n*p), n, p)
 (out <- dagnelie.test(mat))
 # Plot a histogram of the Mahalanobis distances
hist(out$D)

 # Example 4: 10 lognormal random variables, n = 50
 n <- 50; p <- 10
 mat <- matrix(round(exp(rnorm((n*p), mean = 0, sd = 2.5))), n, p)
 (out <- dagnelie.test(mat))
 # Plot a histogram of the Mahalanobis distances
 hist(out$D)

}
\references{
Dagnelie, P. 1975. L'analyse statistique a plusieurs variables. 
 Les Presses agronomiques de Gembloux, Gembloux, Belgium.\cr

 Legendre, P. and L. Legendre. 2012. Numerical ecology, 3rd English
 edition. Elsevier Science BV, Amsterdam, The Netherlands.\cr
}
\author{
Daniel Borcard and Pierre Legendre
}
