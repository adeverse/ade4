\name{microsatt}
\alias{microsatt}
\docType{data}
\title{Genetic Relationships between cattle breeds with microsatellites}
\description{
This data set gives genetic relationships between cattle breeds with microsatellites. 
}
\usage{data(microsatt)}
\format{
	\code{microsatt} is a list of 4 components. 
	\enumerate{
		\item{tab}{contains the allelic frequencies for 18 cattle breeds (taurine or zebu,french or african) and 9 microsatellites.}
		\item{loci.names}{is a vector of the names of loci.}
		\item{loci.eff}{is a vector of the number of alleles per locus.}
		\item{alleles.names}{is a vector of the names of alleles.}
	}
}
\source{
Extract of data prepared by D. Laloe \email{ugendla@dga2.jouy.inra.fr} from data used in:\cr\cr

Moazami-Goudarzi, K., D. Laloe, J. P. Furet, and F. Grosclaude. 1997.\cr
Analysis of genetic relationships between 10 cattle breeds with 17 microsatellites.\cr
\emph{Animal Genetics}, \bold{28}, 338--345.\cr\cr

Souvenir Zafindrajaona, P.,Zeuh V. ,Moazami-Goudarzi K., Laloe D., Bourzat D., Idriss A., and Grosclaude F. (1999)\cr
Etude du statut phylogénétique du bovin Kouri du lac Tchad à l'aide de marqueurs moléculaires.\cr
\emph{Revue d'Elevage et de Médecine Vétérinaire des pays Tropicaux}, \bold{55}, 155--162.\cr\cr

Moazami-Goudarzi, K., Belemsaga D. M. A., Ceriotti G., Laloe D. , Fagbohoun F., Kouagou N. T., Sidibé I., Codjia V., Crimella M. C., Grosclaude F. and Touré S. M. (2001)\cr
Caractérisation de la race bovine Somba à l'aide de marqueurs moléculaires.\cr
\emph{Revue d'Elevage et de Médecine Vétérinaire des pays Tropicaux}, \bold{54}, 1--10
}
\examples{
data(microsatt)
fac <- factor(rep(microsatt$loci.names, microsatt$loci.eff))
w <- dudi.coa(data.frame(t(microsatt$tab)), scann = FALSE)
wit <- within(w, fac, scann = FALSE)
microsatt.ktab <- ktab.within(wit)

plot(sepan(microsatt.ktab)) # 9 separated correspondence analyses
plot(mcoa(microsatt.ktab, scan = FALSE))
plot(mfa(microsatt.ktab, scan = FALSE))
plot(statis(microsatt.ktab, scan = FALSE))
}
\keyword{datasets}
