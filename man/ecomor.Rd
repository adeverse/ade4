\name{ecomor}
\alias{ecomor}
\docType{data}
\title{Ecomorphological Convergence}
\description{
This data set gives ecomorphological informations about 129 bird species. 
}
\usage{data(ecomor)}
\format{
	\code{ecomor} is a list of 7 components.
	\enumerate{
		\item{habitat}{is a data frame with 129 species, 16 dummy variables (the habitats). 
		These variables indicate the species presence (1) or the species absence (0) in a given habitat.}
		\item{forsub}{is a data frame with 129 species, 6 variables (the feeding place classes): 
		foliage, ground , twig , bush, trunk and aerial feeders. These dummy variables indicate the use (1) 
		or  no use (0) of a given feeding place by a species. }
		\item{morpho}{is a data frame with 129 species abd 8 morphological variables: wingl (Wing length, mm), 
		taill (Tail length, mm), culml (Culmen length, mm), bilh (Bill height, mm), bilw (Bill width, mm), 
		tarsl (Tarsus length, mm), midtl (Middle toe length, mm) and weig (Weight, g).}
		\item{diet}{is a data frame with 129 species and 8 variables (diet types): Gr (granivorous: seeds), 
		Fr (frugivorous: berries, acorns, drupes), Ne (frugivorous: nectar), Fo (folivorous: leaves), 
		In (invertebrate feeder: insects, spiders, myriapods, isopods, snails, worms), 
		Ca (carnivorous: flesh of small vertebrates), Li (limnivorous: invertebrates in fresh water),
		and Ch (carrion feeder). These dummy variables indicate the use (1) 
		or  no use (0) of a given diet type by a species.}
		\item{codes}{is a data frame with 129 species, 2 factors : 'forsub' summarizing the feeding place and 
		'diet' the diet type. }
		\item{tax}{is a data frame with 129 species and 3 factors: Genus, Family and Order.
		'tax' is a data frame of class \code{taxo}: the variables are factors giving nested classifications.}
		\item{species.names}{is a vector of the names of species.}
	}
}
\source{
Blondel, J., Vuilleumier, F., Marcus, L.F., and Terouanne, E. (1984).\cr
Is there ecomorphological convergence among mediterranean bird communities of Chile, California, and France.\cr
In \emph{Evolutionary Biology} (eds M.K. Hecht, B. Wallace & R.J. MacIntyre),\cr
141--213, Vol. 18. Plenum Press, New York.
}
\examples{
data(ecomor)
ric <- apply(ecomor$habitat, 2, sum)
s.corcircle(dudi.pca(log(ecomor$morpho), scan = FALSE)$co)

forsub <- data.frame(t(apply(ecomor$forsub, 1, function (x) x/sum(x))))
pca1 <- dudi.pca(forsub, scan = FALSE, scale = FALSE)
s.arrow(pca1$c1)
w <- as.matrix(forsub)%*%as.matrix(pca1$c1)
s.label(w, clab = 0, add.p = TRUE, cpoi = 2)

diet <- data.frame(t(apply(ecomor$diet, 1, function (x) x/sum(x))))
pca2 <- dudi.pca(diet, scan = FALSE, scale = FALSE)
s.arrow(pca2$c1)
w <- as.matrix(diet)%*%as.matrix(pca2$c1)
s.label(w, clab = 0, add.p = TRUE, cpoi = 2)

dmorpho <- dist.quant(log(ecomor$morpho), 3)
dhabitat <- dist.binary(ecomor$habitat, 1)

mantel.randtest(dmorpho, dhabitat)
RV.rtest(pcoscaled(dmorpho), pcoscaled(dhabitat), 999)
procuste.randtest(pcoscaled(dmorpho), pcoscaled(dhabitat))
}
\keyword{datasets}
