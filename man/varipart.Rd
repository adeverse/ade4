\name{varipart}
\alias{varipart}
\alias{print.varipart}
\title{Partition of the variation of a response multivariate table by 2 explanatory tables}
\usage{
varipart(Y, X, W = NULL, nrepet = 999, type = c("simulated", "parametric"),
scale = FALSE, \dots)
\method{print}{varipart}(x, \dots)
}
\arguments{
\item{Y}{a vector, matrix or data frame or an object of class \code{dudi}. If not a \code{dudi} object, the data are trated by a principal component analysis (\code{dudi.pca}).}

\item{X, W}{dataframes or matrices of explanatory (co)variables (numeric and/or factor
variables). By default, no covariables are considered (\code{W} is \code{NULL}) and this case corresponds to simple caonical ordination.}

\item{nrepet}{an integer indicating the number of permutations
.}

\item{type}{a character specifying the algorithm which should be used to adjust R-squared (either \code{"simulated"} or \code{"parametric"}).}

\item{scale}{If \code{Y} is not a dudi, a \code{logical} indicating if variables should be scaled}

\item{\dots}{further arguments passed to \code{as.krandtest} or \code{as.randtest} (if no covariables are considered) for function \code{varipart}.}

\item{x}{an object of class \code{varipart}}
}

\value{
It returns an object of class \code{varipart}. It is a \code{list} with:

\describe{
\item{\code{test}}{the significance test of fractions [ab], [bc], and [abc] based on randomization procedure. An object of class \code{krandtest}}

\item{\code{R2}}{unadjusted estimations of fractions [a], [b], [c], and [d]}

\item{\code{R2.adj}}{adjusted estimations of fractions [a], [b], [c], and [d]}

\item{\code{call}}{the matched call}
}
}
\description{
The function partitions the variation of a response table (usually community data) with respect to two
explanatory tables. The function performs the variation partitioning based on
redundancy analysis (RDA, if \code{dudiY} is obtained by \code{dudi.pca}) or canonical correspondance analysis (CCA, if \code{dudiY} is obtained by \code{dudi.coa}) 
and computes 
unadjusted and adjusted R-squared. 
The significance of R-squared are evaluated by a randomization procedure
where the rows of the explanatory tables are permuted.
}
\details{
Two types of algorithm are provided to adjust R-squared. The "simulated" procedure 
estimates the unadjusted R-squared expected under the null hypothesis H0 and uses it to adjust the
observed R-squared as follows: R2.adj = 1 - (1 - R2) / (1 - E(R2|H0)) with R2.adj the
adjusted R-squared and R2 the unadjusted R-squared.
The "parametric" procedure performs the Ezequiel's adjustement on the unadjusted R-squared as: 
R2.adj = 1 - (1 - R2) / (1 - p / (n - 1)) where n is the number of sites, and p the number of
predictors.
}
\examples{

data(mafragh)

# PCA on response table Y
Y <- mafragh$flo
dudiY <- dudi.pca(Y, scannf = FALSE, scale = FALSE)

# Variation partitioning based on RDA
# without covariables
vprda <- varipart(dudiY,  mafragh$env)
vprda
# Variation partitioning based on RDA
# with covariables and parametric estimation
vprda <- varipart(dudiY,  mafragh$env, mafragh$xy, type = "parametric")
vprda
names(vprda)
}
\references{
Borcard, D., P. Legendre, and P. Drapeau. 1992. Partialling out the spatial component
of ecological variation. Ecology 73:1045. 

Peres-Neto, P. R., P. Legendre, S. Dray, and D. Borcard. 2006. Variation partitioning of
species data matrices: estimation and comparison of fractions. Ecology 87:2614-2625.
}
\seealso{
\code{\link{pcaiv}}
}
\author{
Stephane Dray \email{stephane.dray@univ-lyon1.fr} and Sylvie Clappe \email{sylvie.clappe@univ-lyon1.fr}
}
