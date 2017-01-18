\name{olympic}
\alias{olympic}
\docType{data}
\title{Olympic Decathlon}
\description{
This data set gives the performances of 33 men's decathlon at the Olympic Games (1988).
}
\usage{data(olympic)}
\format{
    \code{olympic} is a list of 2 components.
    \describe{
    \item{tab}{is a data frame with 33 rows and 10 columns events of the decathlon: 100 meters (100), 
    long jump (long), shotput (poid), high jump (haut), 400 meters (400), 110-meter hurdles (110),
    discus throw (disq), pole vault (perc), javelin (jave) and 1500 meters (1500).}
    \item{score}{is a vector of the final points scores of the competition.}
    }
}
\source{
Example 357 in: \cr
Hand, D.J., Daly, F., Lunn, A.D., McConway, K.J. and Ostrowski, E. (1994) 
\emph{A handbook of small data sets}, Chapman & Hall, London. 458 p.

Lunn, A. D. and McNeil, D.R. (1991) \emph{Computer-Interactive Data Analysis}, Wiley, New York
}
\examples{
data(olympic)
pca1 <- dudi.pca(olympic$tab, scan = FALSE)

if(adegraphicsLoaded()) {
  if(requireNamespace("lattice", quietly = TRUE)) {
    g1 <- s1d.barchart(pca1$eig, p1d.hori = FALSE, plot = FALSE)
    g2 <- s.corcircle(pca1$co, plot = FALSE)
    g3 <- xyplot(pca1$l1[, 1] ~ olympic$score, type = c("p", "r"))
    g41 <- s.label(pca1$l1, plab.cex = 0.5, plot = FALSE)
    g42 <- s.arrow(2 * pca1$co, plot = FALSE)
    g4 <- superpose(g41, g42)
    G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  }
  
} else {
  par(mfrow = c(2, 2))
  barplot(pca1$eig)
  s.corcircle(pca1$co)
  plot(olympic$score, pca1$l1[, 1])
  abline(lm(pca1$l1[, 1] ~ olympic$score))
  s.label(pca1$l1, clab = 0.5)
  s.arrow(2 * pca1$co, add.p = TRUE)
  par(mfrow = c(1, 1))
}}

\keyword{datasets}
