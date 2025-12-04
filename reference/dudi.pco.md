# Principal Coordinates Analysis

`dudi.pco` performs a principal coordinates analysis of a Euclidean
distance matrix and returns the results as objects of class `pco` and
`dudi`.

## Usage

``` r
dudi.pco(d, row.w = "uniform", scannf = TRUE, nf = 2, 
    full = FALSE, tol = 1e-07)
# S3 method for class 'pco'
scatter(x, xax = 1, yax = 2, clab.row = 1, posieig = "top", 
    sub = NULL, csub = 2, ...)
```

## Arguments

- d:

  an object of class `dist` containing a Euclidean distance matrix.

- row.w:

  an optional distance matrix row weights. If not NULL, must be a vector
  of positive numbers with length equal to the size of the distance
  matrix

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

- full:

  a logical value indicating whether all the axes should be kept

- tol:

  a tolerance threshold to test whether the distance matrix is Euclidean
  : an eigenvalue is considered positive if it is larger than
  `-tol*lambda1` where `lambda1` is the largest eigenvalue.

  
  

- x:

  an object of class `pco`

- xax:

  the column number for the x-axis

- yax:

  the column number for the y-axis

- clab.row:

  a character size for the row labels

- posieig:

  if "top" the eigenvalues bar plot is upside, if "bottom" it is
  downside, if "none" no plot

- sub:

  a string of characters to be inserted as legend

- csub:

  a character size for the legend, used with `par("cex")*csub`

- ...:

  further arguments passed to or from other methods

## Value

`dudi.pco` returns a list of class `pco` and `dudi`. See
[`dudi`](dudi.md)

## References

Gower, J. C. (1966) Some distance properties of latent root and vector
methods used in multivariate analysis. *Biometrika*, **53**, 325–338.

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(yanomama)
gen <- quasieuclid(as.dist(yanomama$gen))
geo <- quasieuclid(as.dist(yanomama$geo))
ant <- quasieuclid(as.dist(yanomama$ant))
geo1 <- dudi.pco(geo, scann = FALSE, nf = 3)
gen1 <- dudi.pco(gen, scann = FALSE, nf = 3)
ant1 <- dudi.pco(ant, scann = FALSE, nf = 3)
plot(coinertia(ant1, gen1, scann = FALSE))
#> Error in s.corcircle(dfxy = coinertia(ant1, gen1, scann = FALSE)$aX, xax = 1,     yax = 2, plot = FALSE, storeData = TRUE, pos = -3, psub = list(        text = "Unconstrained axes (X)"), pbackground = list(        box = FALSE), plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
