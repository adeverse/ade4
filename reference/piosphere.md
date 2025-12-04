# Plant traits response to grazing

Plant species cover, traits and environmental parameters recorded around
livestock watering points in different habitats of central Namibian
farmlands. See the Wesuls et al. (2012) paper for a full description of
the data set.

## Usage

``` r
data(piosphere)
```

## Format

`piosphere` is a list of 4 components.

- veg:

  is a data frame containing plant species cover

- traits:

  is a data frame with plant traits

- env:

  is a data frame with environmental variables

- habitat:

  is a factor describing habitat/years for each site

## Source

Wesuls, D., Oldeland, J. and Dray, S. (2012) Disentangling plant trait
responses to livestock grazing from spatio-temporal variation: the
partial RLQ approach. *Journal of Vegetation Science*, **23**, 98–113.

## Examples

``` r
data(piosphere)
names(piosphere)
#> [1] "veg"     "traits"  "env"     "habitat"
afcL <- dudi.coa(log(piosphere$veg + 1), scannf = FALSE)
acpR <- dudi.pca(piosphere$env, scannf = FALSE, row.w = afcL$lw)
acpQ <- dudi.hillsmith(piosphere$traits, scannf = FALSE, row.w = afcL$cw)
rlq1 <- rlq(acpR, afcL, acpQ, scannf = FALSE)
plot(rlq1)
#> Error in s.label(dfxy = rlq1$lR, xax = 1, yax = 2, plot = FALSE, storeData = TRUE,     pos = -3, psub = list(text = "R row scores"), plabels = list(        cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
