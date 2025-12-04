# Phylogeny and trait of bacteria

This data set describes the phylogeny of 36 bacteria as reported by
Perrière and Gouy (1996). It also gives the GC rate corresponding to
these 36 species.

## Usage

``` r
data(njplot)
```

## Format

`njplot` is a list containing the 2 following objects:

- tre:

  is a character string giving the fission tree in Newick format.

- tauxcg:

  is a numeric vector that gives the CG rate of the 36 species.

## Source

Data were obtained by Manolo Gouy <manolo.gouy@univ-lyon1.fr>

## References

Perrière, G. and Gouy, M. (1996) WWW-Query : an on-line retrieval system
for biological sequence banks. *Biochimie*, **78**, 364–369.

## Examples

``` r
data(njplot)
njplot.phy <- newick2phylog(njplot$tre)
par(mfrow = c(2,1))
tauxcg0 <- njplot$tauxcg - mean(njplot$tauxcg)
symbols.phylog(njplot.phy, squares = tauxcg0)
symbols.phylog(njplot.phy, circles = tauxcg0)

par(mfrow = c(1,1))
```
