# Function to perform a test of dimensionality

This functions allow to test for the number of axes in multivariate
analysis. The procedure `testdim.pca` implements a method for principal
component analysis on correlation matrix. The procedure is based on the
computation of the RV coefficient.

## Usage

``` r
testdim(object, ...)
# S3 method for class 'pca'
testdim(object, nrepet = 99, nbax = object$rank, alpha = 0.05, ...)
```

## Arguments

- object:

  an object corresponding to an analysis (e.g. duality diagram, an
  object of class `dudi`)

- nrepet:

  the number of repetitions for the permutation procedure

- nbax:

  the number of axes to be tested, by default all axes

- alpha:

  the significance level

- ...:

  other arguments

## Value

An object of the class `krandtest`. It contains also:

- nb:

  The estimated number of axes to keep

- nb.cor:

  The number of axes to keep estimated using a sequential Bonferroni
  procedure

## References

Dray, S. (2008) On the number of principal components: A test of
dimensionality based on measurements of similarity between matrices.
*Computational Statistics and Data Analysis*, **Volume 52**, 2228–2237.
doi:10.1016/j.csda.2007.07.015

## Author

Stéphane Dray <stephane.dray@univ-lyon1.fr>

## See also

[`dudi.pca`](dudi.pca.md),
[`RV.rtest`](RV.rtest.md),[`testdim.multiblock`](testdim.multiblock.md)

## Examples

``` r
tab <- data.frame(matrix(rnorm(200),20,10))
pca1 <- dudi.pca(tab,scannf=FALSE)
test1 <- testdim(pca1)
test1
#> class: krandtest lightkrandtest 
#> Monte-Carlo tests
#> Call: testdim.pca(object = pca1)
#> 
#> Number of tests:   10 
#> 
#> Adjustment method for multiple comparisons:   none 
#> Permutation number:   99 
#>       Test       Obs     Std.Obs   Alter Pvalue
#> 1   Axis 1 0.6580329  1.32486919 greater   0.10
#> 2   Axis 2 0.6309330  0.26912909 greater   0.38
#> 3   Axis 3 0.6658111  0.50984403 greater   0.29
#> 4   Axis 4 0.6202781 -1.70717354 greater   0.97
#> 5   Axis 5 0.6196827 -0.13192691 greater   0.49
#> 6   Axis 6 0.6900110  0.03591369 greater   0.46
#> 7   Axis 7 0.8115369  3.16747215 greater   0.01
#> 8   Axis 8 0.8210232  1.47529292 greater   0.08
#> 9   Axis 9 0.9594895  5.58116968 greater   0.01
#> 10 Axis 10 1.0000000  5.36193350 greater   0.01
#> 
test1$nb
#> [1] 0
test1$nb.cor
#> [1] 0
data(doubs)
pca2 <- dudi.pca(doubs$env,scannf=FALSE)
test2 <- testdim(pca2)
test2
#> class: krandtest lightkrandtest 
#> Monte-Carlo tests
#> Call: testdim.pca(object = pca2)
#> 
#> Number of tests:   11 
#> 
#> Adjustment method for multiple comparisons:   none 
#> Permutation number:   99 
#>       Test       Obs    Std.Obs   Alter Pvalue
#> 1   Axis 1 0.9276029  9.9297925 greater   0.01
#> 2   Axis 2 0.8765561  6.0619974 greater   0.01
#> 3   Axis 3 0.8195407 -1.1215301 greater   0.88
#> 4   Axis 4 0.7130800  0.7551182 greater   0.24
#> 5   Axis 5 0.7621707  1.7438702 greater   0.04
#> 6   Axis 6 0.7781209  2.1766583 greater   0.04
#> 7   Axis 7 0.8316557  5.5496561 greater   0.01
#> 8   Axis 8 0.9641126  6.0739346 greater   0.01
#> 9   Axis 9 0.7978495  1.6458067 greater   0.08
#> 10 Axis 10 0.9701563  6.2886713 greater   0.01
#> 11 Axis 11 1.0000000  7.9859208 greater   0.01
#> 
test2$nb
#> [1] 2
test2$nb.cor
#> [1] 2
```
