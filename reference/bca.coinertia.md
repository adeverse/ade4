# Between-class coinertia analysis

Performs a between-class analysis after a coinertia analysis

## Usage

``` r
# S3 method for class 'coinertia'
bca(x, fac, scannf = TRUE, nf = 2, ...)
```

## Arguments

- x:

  a coinertia analysis (object of class [coinertia](coinertia.md))
  obtained by the function [coinertia](coinertia.md)

- fac:

  a factor partitioning the rows in classes

- scannf:

  a logical value indicating whether the eigenvalues barplot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

- ...:

  further arguments passed to or from other methods

## Value

An object of the class `betcoi`. Outputs are described by the `print`
function

## Details

This analysis is equivalent to do a between-class analysis on each
initial dudi, and a coinertia analysis on the two between analyses. This
function returns additional outputs for the interpretation.

## References

Franquet E., Doledec S., and Chessel D. (1995) Using multivariate
analyses for separating spatial and temporal effects within
species-environment relationships. *Hydrobiologia*, **300**, 425–431.

## Note

To avoid conflict names with the `base:::within` function, the function
`within` is now deprecated and removed. To be consistent, the
`betweencoinertia` function is also deprecated and is replaced by the
method `bca.coinertia` of the new generic `bca` function.

## Author

Stéphane Dray <stephane.dray@univ-lyon1.fr> and Jean Thioulouse
<jean.thioulouse@univ-lyon1.fr>

## See also

[`coinertia`](coinertia.md), [`bca`](bca.md)

## Examples

``` r
data(meaudret)
pca1 <- dudi.pca(meaudret$env, scan = FALSE, nf = 4)
pca2 <- dudi.pca(meaudret$spe, scal = FALSE, scan = FALSE, nf = 4)
   
bet1 <- bca(pca1, meaudret$design$site, scan = FALSE, nf = 2)
bet2 <- bca(pca2, meaudret$design$site, scan = FALSE, nf = 2)
coib <- coinertia(bet1, bet2, scannf = FALSE)

coi <- coinertia(pca1, pca2, scannf = FALSE, nf = 3)
coi.b <- bca(coi,meaudret$design$site, scannf = FALSE)
## coib and coi.b are equivalent

plot(coi.b)
#> Error in s.arrow(dfxy = coi.b$aX, xax = 1, yax = 2, plot = FALSE, storeData = TRUE,     pos = -3, psub = list(text = "Unconstrained axes (X)"), plabels = list(        cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
