# Moran's I and Geary'c randomization tests for spatial and phylogenetic autocorrelation

This function performs Moran's I test using phylogenetic and spatial
link matrix (binary or general). It uses neighbouring weights so Moran's
I and Geary's c randomization tests are equivalent.

## Usage

``` r
gearymoran(bilis, X, nrepet = 999, alter=c("greater", "less", "two-sided"))
```

## Arguments

- bilis:

  : a *n* by *n* link matrix where *n* is the row number of X

- X:

  : a data frame with continuous variables

- nrepet:

  : number of random vectors for the randomization test

- alter:

  a character string specifying the alternative hypothesis, must be one
  of "greater" (default), "less" or "two-sided"

## Details

`bilis` is a squared symmetric matrix which terms are all positive or
null.

`bilis` is firstly transformed in frequency matrix A by dividing it by
the total sum of data matrix : \$\$a\_{ij} =
\frac{bilis\_{ij}}{\sum\_{i=1}^{n}\sum\_{j=1}^{n}bilis\_{ij}}\$\$ The
neighbouring weights is defined by the matrix \\D = diag(d_1,d_2,
\ldots)\\ where \\d_i = \sum\_{j=1}^{n}bilis\_{ij}\\. For each vector x
of the data frame X, the test is based on the Moran statistic
\\x^{t}Ax\\ where x is D-centred.

## Value

Returns an object of class `krandtest` (randomization tests).

## References

Cliff, A. D. and Ord, J. K. (1973) *Spatial autocorrelation*, Pion,
London.

Thioulouse, J., Chessel, D. and Champely, S. (1995) Multivariate
analysis of spatial patterns: a unified approach to local and global
structures. *Environmental and Ecological Statistics*, **2**, 1–14.

## Author

Sébastien Ollier <sebastien.ollier@u-psud.fr>  
Daniel Chessel

## See also

[`moran.test`](https://r-spatial.github.io/spdep/reference/moran.test.html)
and
[`geary.test`](https://r-spatial.github.io/spdep/reference/geary.test.html)
for classical versions of Moran's test and Geary's one

## Examples

``` r
# a spatial example
data(mafragh)
tab0 <- (as.data.frame(scalewt(mafragh$env)))
bilis0 <- neig2mat(nb2neig(mafragh$nb))
gm0 <- gearymoran(bilis0, tab0, 999)
gm0
#> class: krandtest lightkrandtest 
#> Monte-Carlo tests
#> Call: as.krandtest(sim = matrix(res$result, ncol = nvar, byrow = TRUE), 
#>     obs = res$obs, alter = alter, names = test.names)
#> 
#> Number of tests:   11 
#> 
#> Adjustment method for multiple comparisons:   none 
#> Permutation number:   999 
#>            Test        Obs   Std.Obs   Alter Pvalue
#> 1          Clay 0.42436873  7.188935 greater  0.001
#> 2          Silt 0.33796853  5.604470 greater  0.001
#> 3          Sand 0.09947991  1.986724 greater  0.033
#> 4           K2O 0.27277951  4.641801 greater  0.001
#> 5          Mg++ 0.18577104  3.211976 greater  0.001
#> 6      Na+/100g 0.26673592  4.450748 greater  0.002
#> 7            K+ 0.66106701 11.027058 greater  0.001
#> 8  Conductivity 0.29969555  5.012424 greater  0.001
#> 9     Retention 0.20099816  3.656422 greater  0.001
#> 10        Na+/l 0.24300034  4.079808 greater  0.001
#> 11    Elevation 0.59526831  9.727258 greater  0.001
#> 
plot(gm0, nclass = 20)


if (FALSE) { # \dontrun{
# a phylogenetic example
data(mjrochet)
mjr.phy <- newick2phylog(mjrochet$tre)
mjr.tab <- log(mjrochet$tab)
gearymoran(mjr.phy$Amat, mjr.tab)
gearymoran(mjr.phy$Wmat, mjr.tab)

if(adegraphicsLoaded()) {
  g1 <- table.value(mjr.phy$Wmat, ppoints.cex = 0.35, nclass = 5,
    axis.text = list(cex = 0), plot = FALSE)
  g2 <- table.value(mjr.phy$Amat, ppoints.cex = 0.35, nclass = 5,
    axis.text = list(cex = 0), plot = FALSE)
  G <- cbindADEg(g1, g2, plot = TRUE)
  
} else {
  par(mfrow = c(1, 2))
  table.value(mjr.phy$Wmat, csi = 0.25, clabel.r = 0)
  table.value(mjr.phy$Amat, csi = 0.35, clabel.r = 0)
  par(mfrow = c(1, 1))
}
} # }
```
