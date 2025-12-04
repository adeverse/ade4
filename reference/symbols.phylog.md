# Representation of a quantitative variable in front of a phylogenetic tree

`symbols.phylog` draws the phylogenetic tree and represents the values
of the variable by symbols (squares or circles) which size is
proportional to value. White symbols correspond to values which are
below the mean, and black symbols correspond to values which are over.

## Usage

``` r
symbols.phylog(phylog, circles, squares, csize = 1, clegend = 1,
 sub = "", csub = 1, possub = "topleft")
```

## Arguments

- phylog:

  an object of class `phylog`

- circles:

  a vector giving the radii of the circles

- squares:

  a vector giving the length of the sides of the squares

- csize:

  a size coefficient for symbols

- clegend:

  a character size for the legend used by `par("cex")*clegend`

- sub:

  a string of characters to be inserted as legend

- csub:

  a character size for the legend, used with `par("cex")*csub`

- possub:

  a string of characters indicating the sub-title position ("topleft",
  "topright", "bottomleft", "bottomright")

## Author

Daniel Chessel  
Sébastien Ollier <sebastien.ollier@u-psud.fr>

## See also

[`table.phylog`](table.phylog.md) and
[`dotchart.phylog`](dotchart.phylog.md) for many variables

## Examples

``` r
data(mjrochet)
mjrochet.phy <- newick2phylog(mjrochet$tre)
tab0 <- data.frame(scalewt(log(mjrochet$tab)))
par(mfrow=c(3,2))
for (j in 1:6) {
    w <- tab0[,j]
    symbols.phylog(phylog = mjrochet.phy, w, csi = 1.5, cleg = 1.5,
     sub = names(tab0)[j], csub = 3)
}

par(mfrow=c(1,1))
```
