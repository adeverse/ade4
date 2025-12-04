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
#>       Test       Obs    Std.Obs   Alter Pvalue
#> 1   Axis 1 0.5570477 -1.0757637 greater   0.88
#> 2   Axis 2 0.5787471 -0.7853241 greater   0.77
#> 3   Axis 3 0.6508501  0.3988549 greater   0.37
#> 4   Axis 4 0.6589775  0.1652640 greater   0.44
#> 5   Axis 5 0.6368085 -0.5087175 greater   0.65
#> 6   Axis 6 0.7563664  1.2178194 greater   0.14
#> 7   Axis 7 0.8464656  3.0624920 greater   0.01
#> 8   Axis 8 0.9130082  6.7610745 greater   0.01
#> 9   Axis 9 0.8550816  2.5678211 greater   0.01
#> 10 Axis 10 1.0000000  9.2027679 greater   0.01
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
#> 1   Axis 1 0.9276029  9.1427097 greater   0.01
#> 2   Axis 2 0.8765561  6.0660714 greater   0.01
#> 3   Axis 3 0.8195407 -1.1600615 greater   0.92
#> 4   Axis 4 0.7130800  0.8252687 greater   0.20
#> 5   Axis 5 0.7621707  2.0772142 greater   0.03
#> 6   Axis 6 0.7781209  2.4413907 greater   0.02
#> 7   Axis 7 0.8316557  4.5964103 greater   0.01
#> 8   Axis 8 0.9641126  5.1590387 greater   0.01
#> 9   Axis 9 0.7978495  1.6243849 greater   0.09
#> 10 Axis 10 0.9701563  6.3310252 greater   0.01
#> 11 Axis 11 1.0000000  8.1467307 greater   0.01
#> 
test2$nb
#> [1] 2
test2$nb.cor
#> [1] 2
```
