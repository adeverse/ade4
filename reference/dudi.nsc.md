# Non symmetric correspondence analysis

performs a non symmetric correspondence analysis.

## Usage

``` r
dudi.nsc(df, scannf = TRUE, nf = 2)
```

## Arguments

- df:

  a data frame containing positive or null values

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

## Value

Returns a list of class `nsc` and `dudi` (see [`dudi`](dudi.md))
containing also

- N:

  sum of the values of the initial table

## References

Kroonenberg, P. M., and Lombardo R. (1999) Nonsymmetric correspondence
analysis: a tool for analysing contingency tables with a dependence
structure. *Multivariate Behavioral Research*, **34**, 367–396.

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(housetasks)
nsc1 <- dudi.nsc(housetasks, scan = FALSE)
if(adegraphicsLoaded()) {
  g1 <- s.label(nsc1$c1, plab.cex = 1.25)
  g2 <- s.arrow(nsc1$li, add = TRUE, plab.cex = 0.75)
} else {
  s.label(nsc1$c1, clab = 1.25)
  s.arrow(nsc1$li, add.pl = TRUE, clab = 0.75) # see ref p.383
}
```
