\name{bwca.dpcoa}
\alias{bwca.dpcoa}
\alias{bca.dpcoa}
\alias{wca.dpcoa}
\alias{randtest.betwit}
\alias{summary.betwit}
\alias{print.witdpcoa}
\alias{print.betdpcoa}

\title{
Between- and within-class double principal coordinate analysis
}
\description{
These functions allow to study the variations in diversity among communities (as in dpcoa) taking into account a partition in classes 
}
\usage{
bwca.dpcoa(x, fac, cofac, scannf = TRUE, nf = 2, ...)
\method{bca}{dpcoa}(x, fac, scannf = TRUE, nf = 2, \dots) 
\method{wca}{dpcoa}(x, fac, scannf = TRUE, nf = 2, \dots) 
\method{randtest}{betwit}(xtest, nrepet = 999, ...)
\method{summary}{betwit}(object, ...)
\method{print}{witdpcoa}(x, ...)
\method{print}{betdpcoa}(x, ...)
}

\arguments{
  \item{x}{an object of class \code{\link{dpcoa}}}
  \item{fac}{a factor partitioning the collections in classes}
  \item{scannf}{a logical value indicating whether the eigenvalues barplot should be displayed}
  \item{nf}{if scannf FALSE, a numeric value indicating the number of kept axes}
  \item{\dots}{further arguments passed to or from other methods}
  \item{cofac}{a cofactor partitioning the collections in classes used as a covariable}
  \item{nrepet}{the number of permutations}
  \item{xtest, object}{an object of class \code{betwit} created by a call to the function \code{bwca.dpcoa}}
}

\value{
Objects of class \code{betdpcoa}, \code{witdpcoa} or \code{betwit}
}
\references{
Dray, S., Pavoine, S. and Aguirre de Carcer, D. (2015) Considering external information to improve the phylogenetic comparison of microbial communities: a new approach based on constrained Double Principal Coordinates Analysis (cDPCoA). \emph{Molecular Ecology Resources}, in press.
}
\author{
Stéphane Dray \email{stephane.dray@univ-lyon1.fr}
}

\seealso{
\code{\link{dpcoa}}
}
\examples{
\dontrun{

## First example of Dray et al (2015) paper

con <- url("ftp://pbil.univ-lyon1.fr/pub/datasets/dray/MER2014/soilmicrob.rda")
load(con)
close(con)

## Partial CCA
coa <- dudi.coa(soilmicrob$OTU, scannf = FALSE)
wcoa <- wca(coa, soilmicrob$env$pH, scannf = FALSE)
wbcoa <- bca(wcoa,soilmicrob$env$VegType, scannf = FALSE)

## Classical DPCoA
dp <- dpcoa(soilmicrob$OTU, soilmicrob$dphy, RaoDecomp = FALSE, scannf = FALSE)

## Between DPCoA (focus on the effect of vegetation type)
bdp <- bca(dp, fac = soilmicrob$env$VegType , scannf = FALSE)
bdp$ratio ## 0.2148972
randtest(bdp) ## p = 0.001

## Within DPCoA (remove the effect of pH)
wdp <- wca(dp, fac = soilmicrob$env$pH, scannf = FALSE)
wdp$ratio ## 0.5684348

## Between Within-DPCoA (remove the effect of pH and focus on vegetation type)
wbdp <- bwca.dpcoa(dp, fac = soilmicrob$env$VegType, cofac =  soilmicrob$env$pH, scannf = FALSE)
wbdp$ratio ## 0.05452813
randtest(wbdp) ## p = 0.001
}
}

\keyword{multivariate}