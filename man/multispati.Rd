\name{multispati}
\alias{multispati}
\alias{plot.multispati}
\alias{summary.multispati}
\alias{print.multispati}
\title{Multivariate spatial analysis}
\description{
This function ensures a multivariate extension of the univariate method of spatial autocorrelation analysis.
By accounting for the spatial dependence of data observations and their multivariate covariance simultaneously, 
complex interactions among many variables are analysed. Using a methodological scheme borrowed from duality diagram 
analysis, a strategy for the exploratory analysis of spatial pattern in the multivariate is developped.
}
\usage{
multispati(dudi, listw, scannf = TRUE, nfposi = 2, nfnega = 0)
plot.multispati(x, xax = 1, yax = 2, ...) 
summary.multispati(object, ...) 
print.multispati(x, ...)
}
\arguments{
  \item{dudi}{an object of class \code{dudi} for the duality diagram analysis}
  \item{listw}{an object of class \code{listw} for the spatial dependence of data observations}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nfposi}{an integer indicating the number of kept positive axes}
  \item{nfnega}{an integer indicating the number of kept negative axes}
  \item{x, object}{an object of class \code{multispati}}
  \item{xax, yax}{the numbers of the x-axis and the y-axis}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{
This analysis generalizes the Wartenberg's multivariate spatial
correlation analysis to various duality diagrams created by the
functions (\code{dudi.pca}, \code{dudi.coa}, \code{dudi.acm}, \code{dudi.mix}...)
If \emph{dudi} is a duality diagram created by the function \code{dudi.pca} 
and \emph{listw} gives spatial weights created by a row normalized coding scheme,
the analysis is equivalent to Wartenberg's analysis. 

We note X the data frame with the variables, Q the column weights matrix 
and D the row weights matrix associated to the duality diagram \emph{dudi}.
We note L the neighbouring weights matrix associated to  \emph{listw}.
Then, the \code{'multispati'} analysis gives principal axes v that maximize
the spatial autocorrelation : \deqn{I(XQv) = \frac{v^{t}Q^{t}X^{t}DLXQv}{v^{t}Q^{t}X^{t}DXQv}}{I(XQv) = t(v)t(Q)t(X)DLXQv / t(v)t(Q)t(X)DXQv}
}
\value{
Returns an object of class \code{multispati}.
}
\references{
Grunsky, E. C. and Agterberg, F. P. (1988) Spatial and multivariate analysis of geochemical data from metavolcanic rocks in the Ben Nevis area, Ontario. \emph{Mathematical Geology}, \bold{20}, 825--861.

Switzer, P. and Green, A.A. (1984) Min/max autocorrelation factors for multivariate spatial imagery. Tech. rep. 6, Stanford University.

Thioulouse, J., Chessel, D. and Champely, S. (1995) Multivariate analysis of spatial patterns: a unified approach to local and global structures. \emph{Environmental and Ecological Statistics}, \bold{2}, 1--14.

Wartenberg, D. E. (1985) Multivariate spatial correlation: a method for exploratory geographical analysis. \emph{Geographical Analysis}, \bold{17}, 263--283.
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr} \cr
Sébastien Ollier \email{ollier@biomserv.univ-lyon1.fr}
}
\seealso{\code{\link{dudi}},\code{\link[spdep]{listw}}}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}}
\examples{
if (require(maptools, quiet = TRUE) & require(spdep, quiet = TRUE)) {
    data(mafragh)
    maf.xy <- mafragh$xy
    maf.flo <- mafragh$flo
    maf.listw <- nb2listw(neig2nb(mafragh$neig))
    s.label(maf.xy, neig = mafragh$neig, clab = 0.75)
    maf.coa <- dudi.coa(maf.flo,scannf = FALSE)
    multispati.randtest(maf.coa, maf.listw)
    maf.coa.ms <- multispati(maf.coa, maf.listw, scannf = FALSE, nfposi = 2, nfnega = 2)
    summary(maf.coa.ms)
    par(mfrow = c(1,3))
    barplot(maf.coa$eig)
    barplot(maf.coa.ms$eig) 
    s.corcircle(maf.coa.ms$as)
 
    par(mfrow = c(2,2))
    s.value(maf.xy, -maf.coa$li[,1])
    s.value(maf.xy, -maf.coa$li[,2])
    s.value(maf.xy, maf.coa.ms$li[,1])
    s.value(maf.xy, maf.coa.ms$li[,2])
    par(mfrow = c(1,1))

    par(mfrow = c(1,2))
    w1 <- -maf.coa$li[,1:2]
    w1m <- apply(w1, 2, lag.listw, x = maf.listw)
    s.match(w1, w1m, clab = 0.75)
    w1.ms <- maf.coa.ms$li[,1:2]
    w1.msm <- apply(w1.ms, 2, lag.listw, x = maf.listw)
    s.match(w1.ms, w1.msm, clab = 0.75)
    par(mfrow = c(1,1))

    maf.pca <- dudi.pca(mafragh$mil, scannf = FALSE)
    multispati.randtest(maf.pca, maf.listw)
    maf.pca.ms <- multispati(maf.pca, maf.listw, scannf=FALSE)
    plot(maf.pca.ms)
}
}
\keyword{multivariate}
\keyword{spatial}
