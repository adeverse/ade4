# Double Weighted Centring

This function creates a doubly centred matrix.

## Usage

``` r
bicenter.wt(X, row.wt = rep(1, nrow(X)), col.wt = rep(1, ncol(X)))
```

## Arguments

- X:

  a matrix with n rows and p columns

- row.wt:

  a vector of positive or null weights of length n

- col.wt:

  a vector of positive or null weights of length p

## Value

returns a doubly centred matrix

## Author

Daniel Chessel

## Examples

``` r
w <- matrix(1:6, 3, 2)
bicenter.wt(w, c(0.2,0.6,0.2), c(0.3,0.7))
#>      [,1] [,2]
#> [1,]    0    0
#> [2,]    0    0
#> [3,]    0    0

w <- matrix(1:20, 5, 4)
sum(bicenter.wt(w, runif(5), runif(4))^2)
#> [1] 1.972152e-29
```
