# Transformation of a distance matrice to a Euclidean one

transforms a distance matrix in a Euclidean one.

## Usage

``` r
quasieuclid(distmat)
```

## Arguments

- distmat:

  an object of class `dist`

## Details

The function creates a distance matrice with the positive eigenvalues of
the Euclidean representation.  
Only for Euclidean distances which are not Euclidean for numeric
approximations (for examples, in papers as the following example).

## Value

object of class `dist` containing a Euclidean distance matrice

## Author

Daniel Chessel  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
data(yanomama)
geo <- as.dist(yanomama$geo)
is.euclid(geo) # FALSE
#> [1] FALSE
geo1 <- quasieuclid(geo)
is.euclid(geo1) # TRUE
#> [1] TRUE
par(mfrow = c(2,2))
lapply(yanomama, function(x) plot(as.dist(x), quasieuclid(as.dist(x))))
#> $geo
#> NULL
#> 
#> $gen
#> NULL
#> 
#> $ant
#> NULL
#> 

par(mfrow = c(1,1))
```
