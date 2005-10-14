\name{ggtortoises}
\alias{ggtortoises}
\docType{data}
\title{Genetic Relationships among giant Galapagos tortoises with microsatellites}
\description{
This data set gives genetic relationships among giant Galapagos tortoises with microsatellites. 
}
\usage{data(ggtortoises)}
\format{
    \code{ggtortoises} is a list of 4 components. 
    \describe{
        \item{tab}{contains the allelic frequencies for 17 populations of giant tortoises  
        belonging to six Galapagos islands and 10 microsatellites.}
        \item{loci.names}{is a vector of the names of loci.}
        \item{loci.eff}{is a vector of the number of alleles per locus.}
        \item{pop.islands}{is a factor of the six islands concerned : Isabela, Santa_Cruz, Pinzon,
        Santiago, San_Cristobal and Espanola.}
    }
}
\source{
Ciofi C., Milinkovitch M.C., Gibbs J.P., Caccone A. and Powell J.R. (2002)
Microsatellite analysis of genetic divergence among populations of giant Galapagos tortoises.
\emph{Molecular Ecology}, \bold{11}, 2265--2283.
}
\examples{
\dontrun{
data(ggtortoises)
fac <- factor(rep(ggtortoises$loci.names, ggtortoises$loci.eff))
w <- dudi.coa(data.frame(t(ggtortoises$tab)), scann = FALSE)
wit <- within(w, fac, scann = FALSE)
ggtortoises.ktab <- ktab.within(wit)

plot(sepan(ggtortoises.ktab)) # 10 separated correspondence analyses
plot(mcoa(ggtortoises.ktab, scan = FALSE))
plot(mfa(ggtortoises.ktab, scan = FALSE))
plot(statis(ggtortoises.ktab, scan = FALSE))
}}
\keyword{datasets}
