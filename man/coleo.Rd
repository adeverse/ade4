\name{coleo}
\alias{coleo}
\docType{data}
\title{Table of Fuzzy Biological Traits }
\description{
This data set coleo (coleoptera) is a a fuzzy biological traits table.  
}
\usage{data(coleo)}
\format{
\code{coleo} is a list of 5 components.
\describe{
    \item{tab}{is a data frame with 110 rows (species) and 32 columns (categories).}
    \item{species.names}{is a vector of species names.}
    \item{moda.names}{is a vector of fuzzy variables names.}
    \item{families}{is a factor species family.}
    \item{col.blocks}{is a vector containing the number of categories of each trait.}
    }
}
\source{
Bournaud, M., Richoux, P. and Usseglio-Polatera, P. (1992)
An approach to the synthesis of qualitative ecological information from aquatic coleoptera communities.
\emph{Regulated rivers: Research and Management}, \bold{7}, 165--180.
}
\examples{
data(coleo)
op <- par(no.readonly = TRUE) 
coleo.fuzzy <- prep.fuzzy.var(coleo$tab, coleo$col.blocks)
fca1 <- dudi.fca(coleo.fuzzy, sca = FALSE, nf = 3)
par(mfrow = c(3,3))
indica <- factor(rep(names(coleo$col), coleo$col))
for (j in levels(indica)) s.distri (fca1$l1,
    coleo$tab[,which(indica==j)], clab = 1.5, sub = as.character(j), 
    cell = 0, csta = 0.5, csub = 3, 
    label = coleo$moda.names[which(indica == j)])
par(op)
par(mfrow = c(1,1))
}
\keyword{datasets}
