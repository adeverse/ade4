\name{dudi.acm}
\alias{dudi.acm}
\alias{acm.burt}
\alias{acm.disjonctif}
\alias{boxplot.acm}
\title{Multiple Correspondence Analysis}
\description{
\code{dudi.acm} performs the multiple correspondence analysis of a factor table.\cr
\code{acm.burt} an utility giving the crossed Burt table of two factors table.\cr
\code{acm.disjonctif} an utility giving the complete disjunctive table of a factor table.\cr
\code{boxplot.acm} a graphic utility to interpret axes.\cr
}
\usage{
dudi.acm (df, row.w = rep(1, nrow(df)), scannf = TRUE, nf = 2)
acm.burt (df1, df2, counts = rep(1, nrow(df1))) 
acm.disjonctif (df) 
boxplot.acm (x, xax = 1, \dots) 
}
\arguments{
  \item{df, df1, df2}{data frames containing only factors}
  \item{row.w, counts}{vector of row weights, by default, uniform weighting}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
  \item{x}{an object of class \code{acm}}
  \item{xax}{the number of factor to display}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
\code{dudi.acm} returns a list of class \code{acm} and \code{dudi} (see \link{dudi}) containing  
\item{cr}{ a data frame which rows are the variables, columns are the kept scores and the values
are the correlation ratios}
}
\references{
Tenenhaus, M. & Young, F.W. (1985) An analysis and synthesis of multiple correspondence analysis, 
optimal scaling, dual scaling, homogeneity analysis ans other methods for quantifying categorical multivariate data. 
\emph{Psychometrika}, \bold{50}, 1, 91-119.

Lebart, L., A. Morineau, and M. Piron. 1995. Statistique exploratoire multidimensionnelle. Dunod, Paris.
}
\seealso{
    \code{\link{s.chull}}, \code{\link{s.class}}
}
\author{
Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}
}
\examples{
data(banque)
banque.acm <- dudi.acm(banque, scann = FALSE, nf = 3)
scatter.dudi(banque.acm)

apply(banque.acm$cr, 2, mean)
banque.acm$eig[1:banque.acm$nf] # the same thing
boxplot.acm(banque.acm)

scatter(banque.acm)

s.value(banque.acm$li, banque.acm$li[,3])

bb <- acm.burt(banque, banque)
bbcoa <- dudi.coa(bb, scann = FALSE)
plot(banque.acm$c1[,1], bbcoa$c1[,1])
# mca and coa of Burt table. Lebart & coll. section 1.4

bd <- acm.disjonctif(banque)
bdcoa <- dudi.coa(bd, scann = FALSE)
plot(banque.acm$li[,1], bdcoa$li[,1]) 
# mca and coa of disjonctive table. Lebart & coll. section 1.4
plot(banque.acm$co[,1], dudi.coa(bd, scann = FALSE)$co[,1]) 
}
\keyword{multivariate}
