# Transformation of a Distance Matrix for becoming Euclidean

transforms a distance matrix in a Euclidean one.

## Usage

``` r
lingoes(distmat, print = FALSE, tol = 1e-07, cor.zero = TRUE)
```

## Arguments

- distmat:

  an object of class `dist`

- print:

  if TRUE, prints the eigenvalues of the matrix

- tol:

  a tolerance threshold for zero

- cor.zero:

  if TRUE, zero distances are not modified

## Value

returns an object of class `dist` with a Euclidean distance

## References

Lingoes, J.C. (1971) Some boundary conditions for a monotone analysis of
symmetric matrices. *Psychometrika*, **36**, 195–203.

## Details

The function uses the smaller positive constant k which transforms the
matrix of \\\sqrt{d\_{ij}^2 + 2 \ast k}\\ in an Euclidean one

## Author

Daniel Chessel  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
data(capitales)
d0 <- capitales$dist
is.euclid(d0) # FALSE
#> [1] FALSE
d1 <- lingoes(d0, TRUE)
#> Lingoes constant = 2120982 
# Lingoes constant = 2120982
is.euclid(d1) # TRUE
#> [1] TRUE
plot(d0, d1)
x0 <- sort(unclass(d0))
lines(x0, sqrt(x0^2 + 2 * 2120982), lwd = 3)

 
is.euclid(sqrt(d0^2 + 2 * 2120981), tol = 1e-10) # FALSE
#> [1] FALSE
is.euclid(sqrt(d0^2 + 2 * 2120982), tol = 1e-10) # FALSE
#> [1] FALSE
is.euclid(sqrt(d0^2 + 2 * 2120983), tol = 1e-10) 
#> [1] TRUE
    # TRUE the smaller constant
```
