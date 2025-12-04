# Transformation to make Euclidean a distance matrix

This function computes the smallest positive constant that makes
Euclidean a distance matrix and applies it.

## Usage

``` r
cailliez(distmat, print = FALSE, tol = 1e-07, cor.zero = TRUE)
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

an object of class `dist` containing a Euclidean distance matrix.

## References

Cailliez, F. (1983) The analytical solution of the additive constant
problem. *Psychometrika*, **48**, 305–310.  

Legendre, P. and Anderson, M.J. (1999) Distance-based redundancy
analysis: testing multispecies responses in multifactorial ecological
experiments. *Ecological Monographs*, **69**, 1–24.  

Legendre, P., and Legendre, L. (1998) *Numerical ecology*, 2nd English
edition edition. Elsevier Science BV, Amsterdam.  

## Author

Daniel Chessel  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
data(capitales)
d0 <- capitales$dist
is.euclid(d0) # FALSE
#> [1] FALSE
d1 <- cailliez(d0, TRUE)
#> Cailliez constant = 2429.87867 
# Cailliez constant = 2429.87867 
is.euclid(d1) # TRUE
#> [1] TRUE
plot(d0, d1)
abline(lm(unclass(d1)~unclass(d0)))

print(coefficients(lm(unclass(d1)~unclass(d0))), dig = 8) # d1 = d + Cte
#> (Intercept) unclass(d0) 
#>   2429.8787      1.0000 
is.euclid(d0 + 2428) # FALSE
#> [1] FALSE
is.euclid(d0 + 2430) # TRUE the smallest constant
#> [1] TRUE
```
