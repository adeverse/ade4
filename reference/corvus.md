# Corvus morphology

This data set gives a morphological description of 28 species of the
genus Corvus split in two habitat types and phylogeographic stocks.

## Usage

``` r
data(corvus)
```

## Format

`corvus` is data frame with 28 observations (the species) and 4
variables :

- wing:

  : wing length (mm)

- bill:

  : bill length (mm)

- habitat:

  : habitat with two levels `clos` and `open`

- phylog:

  : phylogeographic stock with three levels `amer`(America),
  `orien`(Oriental-Australian), `pale`(Paleoarctic-African)

## References

Laiolo, P. and Rolando, A. (2003) The evolution of vocalisations in the
genus Corvus: effects of phylogeny, morphology and habitat.
*Evolutionary Ecology*, **17**, 111–123.

## Examples

``` r
data(corvus)

if(adegraphicsLoaded()) {
  g1 <- s.label(corvus[, 1:2], plab.cex = 0, porigin.include = FALSE, pgrid.draw = FALSE, 
    paxes.draw = TRUE, paxes.asp = "full", xlab = names(corvus)[2], 
    ylab = names(corvus)[2], plot = FALSE)
  g2 <- s.class(corvus[, 1:2], corvus[, 4]:corvus[, 3], plot = FALSE)
  G <- superpose(g1, g2, plot = TRUE)

} else {
  plot(corvus[, 1:2])
  s.class(corvus[, 1:2], corvus[, 4]:corvus[, 3], add.p = TRUE)
}
```
