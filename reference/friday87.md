# Faunistic K-tables

This data set gives informations about sites, species and environmental
variables.

## Usage

``` r
data(friday87)
```

## Format

`friday87` is a list of 4 components.

- fau:

  is a data frame containing a faunistic table with 16 sites and 91
  species.

- mil:

  is a data frame with 16 sites and 11 environmental variables.

- fau.blo:

  is a vector of the number of species per group.

- tab.names:

  is the name of each group of species.

## Source

Friday, L.E. (1987) The diversity of macroinvertebrate and macrophyte
communities in ponds, *Freshwater Biology*, **18**, 87–104.

## Examples

``` r
data(friday87)
wfri <- data.frame(scale(friday87$fau, scal = FALSE))
wfri <- ktab.data.frame(wfri, friday87$fau.blo, 
    tabnames = friday87$tab.names)

if(adegraphicsLoaded()) {    
  g1 <- kplot(sepan(wfri), row.plabels.cex = 2)
} else {
  kplot(sepan(wfri), clab.r = 2, clab.c = 1)
}
#> Error in s.label(dfxy = sepan(wfri)$Li, labels = sepan(wfri)$TL[, 2],     facets = sepan(wfri)$TL[, 1], xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(position = "bottomright"),     samelimits = FALSE, clab = list(r = 2, c = 1)): non convenient selection for dfxy (can not be converted to dataframe)
```
