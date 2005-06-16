\name{score.coa}
\alias{score.coa}
\title{Graphs to analyse a factor in a correspondence analysis}
\description{
performs the canonical graph of a correspondence analysis. 
}
\usage{
score.coa (x, xax = 1, dotchart = FALSE, clab.r = 1, clab.c = 1, 
    csub = 1, cpoi = 1.5, cet = 1.5, ...)
}
\arguments{
  \item{x}{an object of class \code{coa}}
  \item{xax}{the column number for the used axis}
  \item{dotchart}{if TRUE the graph gives a "dual scaling", if FALSE a "reciprocal scaling"}
  \item{clab.r}{a character size for row labels}
  \item{clab.c}{a character size for column labels}
  \item{csub}{a character size for the sub-titles, used with \code{par("cex")*csub}}
  \item{cpoi}{a character size for the points}
  \item{cet}{a coefficient for the size of segments in standard deviation}
  \item{\dots}{further arguments passed to or from other methods}
}
\details{
In a "reciprocal scaling", the reference score is a numeric code centred and normalized of the non zero cells of the array which both maximizes the variance of means by row and by column. The bars are drawn with half the length of this standard deviation.
}
\references{Thioulouse, J. and Chessel D. (1992) A method for reciprocal scaling of species tolerance and sample diversity. \emph{Ecology}, \bold{73}, 670--680.
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}}
\examples{
layout(matrix(c(1,1,2,3), 2, 2), resp = FALSE)
data(aviurba)
dd1 <- dudi.coa(aviurba$fau, scan = FALSE)
score(dd1, clab.r = 0, clab.c = 0.75)
abline(v = 1, lty = 2, lwd = 3)
sco.distri(dd1$l1[,1], aviurba$fau)
sco.distri(dd1$c1[,1], data.frame(t(aviurba$fau)))

# 1 reciprocal scaling correspondence score -> species amplitude + sample diversity
# 2 sample score -> averaging -> species amplitude
# 3 species score -> averaging -> sample diversity

layout(matrix(c(1,1,2,3), 2, 2), resp = FALSE)
data(rpjdl)
rpjdl1 <- dudi.coa(rpjdl$fau, scan = FALSE)
score(rpjdl1, clab.r = 0, clab.c = 0.75)
if (require(MASS, quietly = TRUE)) {
   data(caith)
   score(dudi.coa(caith, scan = FALSE), clab.r = 1.5, clab.c = 1.5, cpoi = 3)
   data(housetasks)
   score(dudi.coa(housetasks, scan = FALSE), clab.r = 1.25, clab.c = 1.25, 
        csub = 0, cpoi = 3)
}
par(mfrow = c(1,1))
score(rpjdl1, dotchart = TRUE, clab.r = 0)
}
\keyword{multivariate}
\keyword{hplot}
