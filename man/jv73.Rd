\name{jv73}
\alias{jv73}
\docType{data}
\title{K-tables Multi-Regions}
\description{
This data set gives physical and physico-chemical variables, fish species, spatial coordinates about 92 sites. 
}
\usage{data(jv73)}
\format{
    \code{jv73} is a list of 6 components.
    \enumerate{
    \item{morpho}{is a data frame with 92 sites and 6 physical variables.}
    \item{phychi}{is a data frame with 92 sites and 12 physico-chemical variables.}
    \item{poi}{is a data frame with 92 sites and 19 fish species.}
    \item{xy}{is a data frame with 92 sites and 2 spatial coordinates.}
    \item{contour}{is a data frame for mapping.}
    \item{fac.riv}{is a factor distributing the 92 sites on 12 rivers.}
    }
}
\source{
Verneaux, J. (1973) Cours d'eau de Franche-Comté (Massif du Jura).\cr
Recherches écologiques sur le réseau hydrographique du Doubs.\cr
Essai de biotypologie. Thèse d'état, Besançon.
}
\examples{
data(jv73)
s.label(jv73$xy, contour = jv73$contour, incl = FALSE, 
    clab = 0.75)
s.class(jv73$xy, jv73$fac.riv, add.p = TRUE, cell = 0,
    axese = FALSE, csta = 0, cpoi = 0, clab = 1.25)

w <- split(jv73$morpho, jv73$fac.riv)
w <- lapply(w, function(x) t(dudi.pca(x, scann = FALSE)))
w <- ktab.list.dudi(w)
kplot(sepan(w), perm = TRUE, clab.r = 0, clab.c = 2, show = FALSE)
}
\keyword{datasets}
