\name{ardeche}
\alias{ardeche}
\non_function{}
\title{Fauna Table with double (row and column) partitioning}
\description{
  This data set gives informations about species in different sites and dates. 
}
\usage{data(ardeche)}
\format{
  'ardeche' is a list with 6 components. \cr
  \describe{
    \item{tab}{is a data frame containing fauna table with 43 species (rows) and 35 sites (columns).}\cr
    \item{col.blocks}{is a vector containing the number of columns in the 6 groups.}\cr
    \item{row.blocks}{is a vector containing the number of rows in the 4 groups.}\cr
    \item{dat.fac}{is a dates factor for samples (6 dates).}\cr
    \item{sta.fac}{is a sites factor for samples (6 sites).}\cr
    \item{esp.fac}{is a species order factor (Ephemeroptera, Plecoptera, Coleoptera, Trichoptera).}
  }
}
\source{
 Cazes, P., Chessel, D., and Dolédec, S. (1988) L'analyse des correspondances internes d'un tableau partitionné :
 son usage en hydrobiologie. \emph{Revue de Statistique Appliquée} \bold{36}, 39--54.
}
\examples{
data(ardeche)
dudi1 <- dudi.coa(ardeche$tab, scan=FALSE)
s.class(dudi1$co, ardeche$dat.fac)
s.label(dudi1$co, clab=0.5, add.p=TRUE)
}
\keyword{datasets}
