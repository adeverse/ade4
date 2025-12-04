# Projections of Supplementary Columns

performs projections of supplementary columns.

## Usage

``` r
supcol(x, ...)
# S3 method for class 'dudi'
supcol(x, Xsup, ...) 
# S3 method for class 'coa'
supcol(x, Xsup, ...)
```

## Arguments

- x:

  an object used to select a method

- Xsup:

  an array with the supplementary columns (`Xsup` and `x$tab` have the
  same row number)

- ...:

  further arguments passed to or from other methods

## Details

If `supcol.dudi` is used, the column vectors of `Xsup` are projected
without prior modification onto the principal components of dudi with
the scalar product associated to the row weightings of dudi.

## Value

A list of two components:

- `tabsup`:

  data frame containing the array with the supplementary columns
  transformed or not

- `cosup`:

  data frame containing the coordinates of the supplementary projections

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(rpjdl)
rpjdl.coa <- dudi.coa(rpjdl$fau, scan = FALSE, nf = 4)
rpjdl.coa$co[1:3, ]
#>         Comp1      Comp2       Comp3     Comp4
#> AR  1.3906689 -0.4366455 -0.08999631 0.4036248
#> CP -0.8298783 -0.2134175 -0.99500547 0.8763367
#> ST -0.6045373  0.1035953 -0.68205770 0.4254950
supcol(rpjdl.coa, rpjdl$fau[, 1:3])$cosup  #the same
#>         Comp1      Comp2       Comp3     Comp4
#> AR  1.3906689 -0.4366455 -0.08999631 0.4036248
#> CP -0.8298783 -0.2134175 -0.99500547 0.8763367
#> ST -0.6045373  0.1035953 -0.68205770 0.4254950

data(doubs)
dudi1 <- dudi.pca(doubs$fish, scal = FALSE, scan = FALSE)
if(adegraphicsLoaded()) {
  g1 <- s.arrow(dudi1$co, plot = FALSE)
  g2 <- s.arrow(supcol(dudi1, data.frame(scalewt(doubs$env)))$cosup, plab.cex = 2, plot = FALSE)
  G <- superpose(g1, g2, plot = TRUE)
  
} else {
  s.arrow(dudi1$co)
  s.arrow(supcol(dudi1, data.frame(scalewt(doubs$env)))$cosup, add.p = TRUE, clab = 2)
  symbols(0, 0, circles = 1, inches = FALSE, add = TRUE)
}
```
