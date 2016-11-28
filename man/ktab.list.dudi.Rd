\name{ktab.list.dudi}
\alias{ktab.list.dudi}
\title{Creation of a K-tables from a list of duality diagrams}
\description{
creates a list of class \code{ktab} from a list of duality diagrams. 
}
\usage{
ktab.list.dudi(obj, rownames = NULL, colnames = NULL, tabnames = NULL)
}
\arguments{
  \item{obj}{a list of objects of class 'dudi'. Each element of the list must have the same row names for \code{$tab} and even for \code{$lw}}
  \item{rownames}{the row names of the K-tables (otherwise the row names of the \code{$tab})}
  \item{colnames}{the column names of the K-tables (otherwise the column names of the \code{$tab})}
  \item{tabnames}{the names of the arrays of the K-tables (otherwise the names of the \code{obj}  if they exist, or else "Ana1", "Ana2", \dots)}
}
\value{
returns a list of class \code{ktab}. See \code{\link{ktab}}
}
\author{
Daniel Chessel \cr
Anne-Béatrice Dufour \email{anne-beatrice.dufour@univ-lyon1.fr}
}
\examples{
data(euro123)
pca1 <- dudi.pca(euro123$in78, scale = FALSE, scann = FALSE)
pca2 <- dudi.pca(euro123$in86, scale = FALSE, scann = FALSE)
pca3 <- dudi.pca(euro123$in97, scale = FALSE, scann = FALSE)
ktabeuro <- ktab.list.dudi(list(pca1, pca2, pca3), 
    tabnames = c("1978", "1986", "1997"))
if(adegraphicsLoaded()) {
  kplot(sepan(ktabeuro))
} else {
  kplot(sepan(ktabeuro), mfr = c(2, 2), clab.c = 1.5)
}

data(meaudret)
w1 <- split(meaudret$env,meaudret$design$season)
ll <- lapply(w1, dudi.pca, scann = FALSE)
kta <- ktab.list.dudi(ll, rownames <- paste("Site", 1:5, sep = ""))
if(adegraphicsLoaded()) {
  kplot(sepan(kta), row.plab.cex = 1.5, col.plab.cex = 0.75)
} else {
  kplot(sepan(kta), clab.r = 1.5, clab.c = 0.75)
}

data(jv73)
w <- split(jv73$poi, jv73$fac.riv)
wjv73poi <- lapply(w, dudi.pca, scal = FALSE, scan = FALSE)
wjv73poi <- lapply(wjv73poi, t)
wjv73poi <- ktab.list.dudi(wjv73poi)
kplot(sepan(wjv73poi), permut = TRUE, traj = TRUE)
}
\keyword{multivariate}
