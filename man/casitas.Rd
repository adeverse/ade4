\name{casitas}
\docType{data}
\alias{casitas}
\title{Enzymatic polymorphism in Mus musculus}
\description{
  This data set is a data frame with 74 rows (mice) and 15 columns (loci enzymatic polymorphism of the DNA mitochondrial). 
  Each value contains 6 characters coding for two allelles. The missing values are coding by '000000'.
} 
\usage{data(casitas)} 
\format{
The 74 individuals of  \code{casitas} belong to 4 groups:
  \describe{
    \item{1}{24 mice of the sub-species \emph{Mus musculus domesticus}}
    \item{2}{11 mice of the sub-species \emph{Mus musculus castaneus}}
    \item{3}{9 mice of the sub-species \emph{Mus musculus musculus}}
    \item{4}{30 mice from a population of the lake Casitas (California)}
  }
} 
\source{
Exemple du logiciel GENETIX.
Belkhir k. et al. GENETIX, logiciel sous WindowsTM pour la génétique des populations. 
Laboratoire Génome, Populations, Interactions CNRS UMR 5000, Université de Montpellier II, Montpellier (France). \cr
\url{https://kimura.univ-montp2.fr/genetix/}
}
\references{
Orth, A., T. Adama, W. Din and F. Bonhomme. (1998) Hybridation naturelle entre deux sous espèces de souris domestique 
\emph{Mus musculus domesticus} et \emph{Mus musculus castaneus} près de Lake Casitas (Californie). \emph{Genome}, \bold{41}, 104--110.
}
\examples{
data(casitas)
str(casitas)
names(casitas)
} 
\keyword{datasets}
