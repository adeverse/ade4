\encoding{latin1}
\name{dist.prop}
\alias{dist.prop}
\title{Computation of Distance Matrices of Percentage Data
}
\description{
computes for percentage data some distance matrices. 
}
\usage{
dist.prop(df, method = NULL, diag = FALSE, upper = FALSE)
}
\arguments{
  \item{df}{a data frame containing only positive or null values, used as row percentages}
  \item{method}{an integer between 1 and 5. If NULL the choice is made with a console message. See details}
  \item{diag}{a logical value indicating whether the diagonal of the distance matrix should be printed by `print.dist'}
  \item{upper}{a logical value indicating whether the upper triangle of the distance matrix should be printed by `print.dist'}
}
\details{
  \describe{
\item{1 = Manly}{\eqn{d_1=\frac{1}{2} \sum_{i=1}^{K}{|{p_i-q_i}|}}{d1 = sum|p(i) - q(i)|/2}}
\item{2 = Overlap index Manly}{\eqn{d_2=1-\frac{\sum_{i=1}^{K}{p_i q_i}}{\sqrt{\sum_{i=1}^{K}{p_i^2}}{\sqrt{\sum_{i=1}^{K}{q_i^2}}}}}{d2 = 1 - Sum(p(i)q(i))/sqrt(Sum(p(i)^2))/sqrt(Sum(q(i)^2))}}
\item{3 = Rogers 1972 (one locus)}{\eqn{d_3=\sqrt{\frac{1}{2} \sum_{i=1}^{K}{(p_i-q_i)^2}}}{d3 = sqrt(0.5*Sum(p(i)-q(i)^2))}}
\item{4 = Nei 1972 (one locus)}{\eqn{d_4=\ln{\frac{\sum_{i=1}^{K}{p_i q_i}}{\sqrt{\sum_{i=1}^{K}{p_i^2}}{\sqrt{\sum_{i=1}^{K}{q_i^2}}}}}}{d4 = -ln(Sum(p(i)q(i))/sqrt(Sum(p(i)^2))/sqrt(Sum(q(i)^2)))}}
\item{5 = Edwards 1971 (one locus)}{\eqn{d_5=\sqrt{1-\sum_{i=1}^{K}{\sqrt{p_1 q_i}}}}{d5= sqrt (1 - (Sum(sqrt(p(i)q(i)))))}}
}
}
\value{
returns a distance matrix, object of class \code{dist}
}
\references{
Edwards, A. W. F. (1971) Distance between populations on the basis of gene frequencies. \emph{Biometrics}, \bold{27}, 
873--881. 

Manly, B. F. (1994) \emph{Multivariate Statistical Methods. A primer.}, Second edition. Chapman & Hall, London.

Nei, M. (1972) Genetic distances between populations. \emph{The American Naturalist}, \bold{106}, 283--292. 
}
\author{
Daniel Chessel  \cr
Stéphane Dray \email{stephane.dray@univ-lyon1.fr}
}
\examples{
data(microsatt)
w <- microsatt$tab[1:microsatt$loci.eff[1]]

if(adegraphicsLoaded()) {
  g1 <- scatter(dudi.pco(lingoes(dist.prop(w, 1)), scann = FALSE), plot = FALSE)
  g2 <- scatter(dudi.pco(lingoes(dist.prop(w, 2)), scann = FALSE), plot = FALSE)
  g3 <- scatter(dudi.pco(dist.prop(w, 3), scann = FALSE), plot = FALSE)
  g4 <- scatter(dudi.pco(lingoes(dist.prop(w, 4)), scann = FALSE), plot = FALSE)
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  
} else {
  par(mfrow = c(2, 2))
  scatter(dudi.pco(lingoes(dist.prop(w, 1)), scann = FALSE))
  scatter(dudi.pco(lingoes(dist.prop(w, 2)), scann = FALSE))
  scatter(dudi.pco(dist.prop(w, 3), scann = FALSE))
  scatter(dudi.pco(lingoes(dist.prop(w, 4)), scann = FALSE))
  par(mfrow = c(1, 1))
}}
\keyword{array}
\keyword{multivariate}
