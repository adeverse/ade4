# Genetic/Environment and types of variables

This data set gives meristic, genetic and morphological data frame for
306 trouts.

## Usage

``` r
data(lascaux)
```

## Format

`lascaux` is a list of 9 components.

- riv:

  is a factor returning the river where 306 trouts are captured

- code:

  vector of characters : code of the 306 trouts

- sex:

  factor sex of the 306 trouts

- meris:

  data frame 306 trouts - 5 meristic variables

- tap:

  data frame of the total number of red and black points

- gen:

  factor of the genetic code of the 306 trouts

- morpho:

  data frame 306 trouts 37 morphological variables

- colo:

  data frame 306 trouts 15 variables of coloring

- ornem:

  data frame 306 trouts 15 factors (ornementation)

## Source

Lascaux, J.M. (1996) *Analyse de la variabilité morphologique de la
truite commune (Salmo trutta L.) dans les cours d'eau du bassin pyrénéen
méditerranéen*. Thèse de doctorat en sciences agronomiques, INP
Toulouse.

## References

See a data description at <http://pbil.univ-lyon1.fr/R/pdf/pps022.pdf>
(in French).

## Examples

``` r
data(lascaux)

if(adegraphicsLoaded()) {
  g1 <- s1d.barchart(dudi.pca(lascaux$meris, scan = FALSE)$eig, psub.text = "Meristic", 
    p1d.horizontal = FALSE, plot = FALSE)
  g2 <- s1d.barchart(dudi.pca(lascaux$colo, scan = FALSE)$eig, psub.text = "Coloration", 
    p1d.horizontal = FALSE, plot = FALSE)
  g3 <- s1d.barchart(dudi.pca(na.omit(lascaux$morpho), scan = FALSE)$eig, 
    psub.text = "Morphometric", p1d.horizontal = FALSE, plot = FALSE)
  g4 <- s1d.barchart(dudi.acm(na.omit(lascaux$orne), scan = FALSE)$eig, 
    psub.text = "Ornemental", p1d.horizontal = FALSE, plot = FALSE)
  
  G <- ADEgS(c(g1, g2, g3, g4), layout = c(2, 2))
  
} else {
  par(mfrow = c(2,2))
  barplot(dudi.pca(lascaux$meris, scan = FALSE)$eig)
  title(main = "Meristic")
  barplot(dudi.pca(lascaux$colo, scan = FALSE)$eig)
  title(main = "Coloration")
  barplot(dudi.pca(na.omit(lascaux$morpho), scan = FALSE)$eig)
  title(main = "Morphometric")
  barplot(dudi.acm(na.omit(lascaux$orne), scan = FALSE)$eig)
  title(main = "Ornemental")
  par(mfrow = c(1,1))
}
```
