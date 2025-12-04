# Simplified Analysis in Principal Coordinates

performs a simplified analysis in principal coordinates, using an object
of class `dist`.

## Usage

``` r
pcoscaled(distmat, tol = 1e-07)
```

## Arguments

- distmat:

  an object of class `dist`

- tol:

  a tolerance threshold, an eigenvalue is considered as positive if it
  is larger than `-tol*lambda1` where `lambda1` is the largest
  eigenvalue

## Value

returns a data frame containing the Euclidean representation of the
distance matrix with a total inertia equal to 1

## References

Gower, J. C. (1966) Some distance properties of latent root and vector
methods used in multivariate analysis. *Biometrika*, **53**, 325–338.

## Author

Daniel Chessel

## Examples

``` r
    a <- 1 / sqrt(3) - 0.2
    w <- matrix(c(0,0.8,0.8,a,0.8,0,0.8,a,
        0.8,0.8,0,a,a,a,a,0),4,4)
    w <- as.dist(w)
    w <- cailliez(w)
    w
#>           1         2         3
#> 2 1.0000000                    
#> 3 1.0000000 1.0000000          
#> 4 0.5773503 0.5773503 0.5773503
    pcoscaled(w)
#>              C1            C2
#> 1  1.154701e+00  0.000000e+00
#> 2 -5.773503e-01  1.000000e+00
#> 3 -5.773503e-01 -1.000000e+00
#> 4 -1.922963e-16  1.379608e-16
    dist(pcoscaled(w)) # w
#>          1        2        3
#> 2 2.000000                  
#> 3 2.000000 2.000000         
#> 4 1.154701 1.154701 1.154701
    dist(pcoscaled(2 * w)) # the same
#>          1        2        3
#> 2 2.000000                  
#> 3 2.000000 2.000000         
#> 4 1.154701 1.154701 1.154701
    sum(pcoscaled(w)^2) # unity
#> [1] 4
```
