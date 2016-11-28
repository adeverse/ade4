\name{steppe}
\alias{steppe}
\docType{data}
\title{Transect in the Vegetation}
\description{
This data set gives the presence-absence of 37 species on 515 sites. 
}
\usage{data(steppe)}
\format{
    \code{steppe} is a list of 2 components.
    \describe{
        \item{tab}{is a data frame with 512 rows (sites) and 37 variables (species) in presence-absence.}
        \item{esp.names}{is a vector of the species names.}
    }
}
\source{
Estève, J. (1978) Les méthodes d'ordination : éléments pour une discussion.
in J. M. Legay and R. Tomassone, editors. 
\emph{Biométrie et Ecologie}, Société Française de Biométrie, Paris, 223--250. 
}
\examples{
par(mfrow = c(3,1))
data(steppe)
w1 <- col(as.matrix(steppe$tab[,1:15]))
w1 <- as.numeric(w1[steppe$tab[,1:15] > 0])
w2 <- row(as.matrix(steppe$tab[,1:15]))
w2 <- as.numeric(w2[steppe$tab[,1:15] > 0])
plot(w2, w1, pch = 20)
plot(dudi.pca(steppe$tab, scan = FALSE, scale = FALSE)$li[,1],
    pch = 20, ylab = "PCA", xlab = "", type = "b")
plot(dudi.coa(steppe$tab, scan = FALSE)$li[,1], pch = 20, 
    ylab = "COA", xlab = "", type = "b")
par(mfrow = c(1,1))
}
\keyword{datasets}
