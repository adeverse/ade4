# Is a Distance Matrix Euclidean?

Confirmation of the Euclidean nature of a distance matrix by the Gower's
theorem.  
`is.euclid` is used in `summary.dist`.  

## Usage

``` r
is.euclid(distmat, plot = FALSE, print = FALSE, tol = 1e-07)
# S3 method for class 'dist'
summary(object, ...)
```

## Arguments

- distmat:

  an object of class 'dist'

- plot:

  a logical value indicating whether the eigenvalues bar plot of the
  matrix of the term \\-\frac{1}{2} {d\_{ij}^2}\\ centred by rows and
  columns should be diplayed

- print:

  a logical value indicating whether the eigenvalues of the matrix of
  the term \\-\frac{1}{2} {d\_{ij}^2}\\ centred by rows and columns
  should be printed

- tol:

  a tolerance threshold : an eigenvalue is considered positive if it is
  larger than `-tol*lambda1` where `lambda1` is the largest eigenvalue.

- object:

  an object of class 'dist'

- ...:

  further arguments passed to or from other methods

## Value

returns a logical value indicating if all the eigenvalues are positive
or equal to zero

## References

Gower, J.C. and Legendre, P. (1986) Metric and Euclidean properties of
dissimilarity coefficients. *Journal of Classification*, **3**, 5–48.

## Author

Daniel Chessel  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
w <- matrix(runif(10000), 100, 100)
w <- dist(w)
summary(w)
#> Class: dist 
#> Distance matrix by lower triangle : d21, d22, ..., d2n, d32, ...
#> Size: 100 
#> Labels: 
#> call: dist(x = w)
#> method: euclidean 
#> Euclidean matrix (Gower 1966): TRUE 
is.euclid (w) # TRUE
#> [1] TRUE
w <- quasieuclid(w) # no correction need in: quasieuclid(w)
#> Warning: Euclidean distance found : no correction need
w <- lingoes(w) # no correction need in: lingoes(w)
#> Warning: Euclidean distance found : no correction need
w <- cailliez(w) # no correction need in: cailliez(w)
#> Warning: Euclidean distance found : no correction need
rm(w)
```
