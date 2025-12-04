# Phylogeny and quantitative traits of carnivora

This data set describes the phylogeny of 70 carnivora as reported by
Diniz-Filho and Torres (2002). It also gives the geographic range size
and body size corresponding to these 70 species.

## Usage

``` r
data(carni70)
```

## Format

`carni70` is a list containing the 2 following objects:

- tre:

  is a character string giving the phylogenetic tree in Newick format.
  Branch lengths are expressed as divergence times (millions of years)

- tab:

  is a data frame with 70 species and two traits: size (body size (kg))
  ; range (geographic range size (km)).

## Source

Diniz-Filho, J. A. F., and N. M. Tôrres. (2002) Phylogenetic comparative
methods and the geographic range size-body size relationship in new
world terrestrial carnivora. *Evolutionary Ecology*, **16**, 351–367.

## Examples

``` r
if (FALSE) { # \dontrun{
if (requireNamespace("adephylo", quietly = TRUE) & requireNamespace("ape", quietly = TRUE)) {
  data(carni70)
  carni70.phy <- newick2phylog(carni70$tre)
  plot(carni70.phy)
  
  size <- scalewt(log(carni70$tab))[,1]
  names(size) <- row.names(carni70$tab)
  symbols.phylog(carni70.phy,size)
  
  tre <- ape::read.tree(text = carni70$tre)
  adephylo::orthogram(size, tre = tre)
  
  yrange <- scalewt(carni70$tab[,2])
  names(yrange) <- row.names(carni70$tab)
  symbols.phylog(carni70.phy,yrange)
  adephylo::orthogram(as.vector(yrange), tre = tre)
  
  if(adegraphicsLoaded()) {
    g1 <- s.label(cbind.data.frame(size, yrange), plabel.cex = 0)
    g2 <- addhist(g1)
  } else {
    s.hist(cbind.data.frame(size, yrange), clabel = 0)
  }
}} # }
```
