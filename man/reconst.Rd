\name{reconst}
\alias{reconst}
\alias{reconst.pca}
\alias{reconst.coa}
\title{Reconstitution of Data from a Duality Diagram}
\description{
Generic Function for the reconstitution of data from 
a principal component analysis or
a correspondence analysis
}
\usage{
reconst (dudi, ...)
\method{reconst}{pca}(dudi, nf = 1, ...) 
\method{reconst}{coa}(dudi, nf = 1, ...) 
}
\arguments{
  \item{dudi}{an object of class \code{dudi} used to select a method: pca or coa}
  \item{nf}{an integer indicating the number of kept axes for the reconstitution}
  \item{\dots}{further arguments passed to or from other methods}
}
\value{
returns a data frame containing the reconstituted data
}
\references{Gabriel, K.R. (1978) Least-squares approximation of matrices by additive and multiplicative models. \emph{Journal of the Royal Statistical Society}, B , \bold{40}, 186--196.
}
\author{
Daniel Chessel \cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr}
}
\examples{
data(rhone)
dd1 <- dudi.pca(rhone$tab, nf = 2, scann = FALSE)
rh1 <- reconst(dd1, 1)
rh2 <- reconst(dd1, 2)
par(mfrow = c(4,4))
par(mar = c(2.6,2.6,1.1,1.1))
for (i in 1:15) {
    plot(rhone$date, rhone$tab[,i])
    lines(rhone$date, rh1[,i], lty = 2)
    lines(rhone$date, rh2[,i], lty = 1)
    scatterutil.sub(names(rhone$tab)[i], 2, "topright")}

data(chats)
chatsw <- data.frame(t(chats))
chatscoa <- dudi.coa(chatsw, scann = FALSE)
model0 <- reconst(chatscoa, 0)
round(model0,3)
round(chisq.test(chatsw)$expected,3)
chisq.test(chatsw)$statistic
sum(((chatsw-model0)^2)/model0)
effectif <- sum(chatsw)
sum(chatscoa$eig)*effectif
model1 <- reconst(chatscoa, 1)
round(model1, 3)
sum(((chatsw-model1)^2)/model0)
sum(chatscoa$eig[-1])*effectif
}
\keyword{multivariate}
