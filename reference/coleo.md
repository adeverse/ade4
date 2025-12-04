# Table of Fuzzy Biological Traits

This data set coleo (coleoptera) is a a fuzzy biological traits table.

## Usage

``` r
data(coleo)
```

## Format

`coleo` is a list of 5 components.

- tab:

  is a data frame with 110 rows (species) and 32 columns (categories).

- species.names:

  is a vector of species names.

- moda.names:

  is a vector of fuzzy variables names.

- families:

  is a factor species family.

- col.blocks:

  is a vector containing the number of categories of each trait.

## Source

Bournaud, M., Richoux, P. and Usseglio-Polatera, P. (1992) An approach
to the synthesis of qualitative ecological information from aquatic
coleoptera communities. *Regulated rivers: Research and Management*,
**7**, 165–180.

## Examples

``` r
data(coleo)
op <- par(no.readonly = TRUE) 
coleo.fuzzy <- prep.fuzzy.var(coleo$tab, coleo$col.blocks)
#> 2 missing data found in block 1 
#> 1 missing data found in block 3 
#> 2 missing data found in block 4 
fca1 <- dudi.fca(coleo.fuzzy, sca = FALSE, nf = 3)
indica <- factor(rep(names(coleo$col), coleo$col))

if(adegraphicsLoaded()) {
  glist <- list()
  for(i in levels(indica)) {
    df <- coleo$tab[, which(indica == i)]
    names(df) <- coleo$moda.names[which(indica == i)]
    glist[i] <- s.distri(fca1$l1, df, psub.text = as.character(i), ellipseSize = 0, 
      starSize = 0.5, plot = FALSE, storeData = TRUE)
  }
  G <- ADEgS(glist, layout = c(3, 3))
  
} else {
  par(mfrow = c(3, 3))
  for(j in levels(indica)) 
    s.distri(fca1$l1, coleo$tab[, which(indica == j)], clab = 1.5, sub = as.character(j), 
      cell = 0, csta = 0.5, csub = 3, label = coleo$moda.names[which(indica == j)])
  par(op)
  par(mfrow = c(1, 1))
}
```
