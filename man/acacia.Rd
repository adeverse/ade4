\name{acacia}
\alias{acacia}
\docType{data}
\title{Spatial pattern analysis in plant communities}
\description{
Counts of individuals of \emph{Acacia ehrenbergiana} from five parallel transects of 32 quadrats.
}
\usage{data(acacia)}
\format{
\code{acacia} is a data frame with 15 variables : \cr
  \enumerate{
    \item{se.T1}{a numeric vector containing quadrats counts of seedlings from transect 1}
    \item{se.T2}{a numeric vector containing quadrats counts of seedlings from transect 2}
    \item{se.T3}{a numeric vector containing quadrats counts of seedlings from transect 3}
    \item{se.T4}{a numeric vector containing quadrats counts of seedlings from transect 4}
    \item{se.T5}{a numeric vector containing quadrats counts of seedlings from transect 5}
    \item{sm.T1}{a numeric vector containing quadrats counts of small trees (crown < 1 \eqn{m^{2}}{m^2} in canopy) of transect 1}
    \item{sm.T2}{a numeric vector containing quadrats counts of small trees (crown < 1 \eqn{m^{2}}{m^2} in canopy) of transect 2}
    \item{sm.T3}{a numeric vector containing quadrats counts of small trees (crown < 1 \eqn{m^{2}}{m^2} in canopy) of transect 3}
    \item{sm.T4}{a numeric vector containing quadrats counts of small trees (crown < 1 \eqn{m^{2}}{m^2} in canopy) of transect 4}
    \item{sm.T5}{a numeric vector containing quadrats counts of small trees (crown < 1 \eqn{m^{2}}{m^2} in canopy) of transect 5}
    \item{la.T1}{a numeric vector containing quadrats counts of trees with large crown (crown > 1 \eqn{m^{2}}{m^2} in canopy) of transect 1}
    \item{la.T2}{a numeric vector containing quadrats counts of trees with large crown (crown > 1 \eqn{m^{2}}{m^2} in canopy) of transect 2}
    \item{la.T3}{a numeric vector containing quadrats counts of trees with large crown (crown > 1 \eqn{m^{2}}{m^2} in canopy) of transect 3}
    \item{la.T4}{a numeric vector containing quadrats counts of trees with large crown (crown > 1 \eqn{m^{2}}{m^2} in canopy) of transect 4}
    \item{la.T5}{a numeric vector containing quadrats counts of trees with large crown (crown > 1 \eqn{m^{2}}{m^2} in canopy) of transect 5}
  }
}
\references{
Greig-Smith, P. and Chadwick, M.J. (1965) Data on pattern within plant communities. III. \emph{Acacia-Capparis} semi-desert scrub in the Sudan. \cr \emph{Journal of Ecology} \bold{53}, 465--474. \cr

Hill, M.O. (1973) The intensity of spatial pattern in plant communities. \emph{Journal of Ecology}, \bold{61}, 225--235.
}
\examples{
data(acacia)
par(mfcol=c(5,3))
par(mar = c(2,2,2,2))
for(k in 1:15) {
    barplot(acacia[,k],ylim=c(0,20),col=grey(0.8))
    scatterutil.sub(names(acacia)[k],1.5,"topleft")
}
}
\keyword{datasets}
