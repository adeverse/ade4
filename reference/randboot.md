# Bootstrap simulations

Functions and classes to manage outputs of bootstrap simulations for one
(class `randboot`) or several (class `krandboot`) statistics

## Usage

``` r
as.krandboot(obs, boot, quantiles = c(0.025, 0.975), names =
colnames(boot), call = match.call())
# S3 method for class 'krandboot'
print(x, ...)
as.randboot(obs, boot, quantiles = c(0.025, 0.975), call = match.call())
# S3 method for class 'randboot'
print(x, ...)
randboot(object, ...)
```

## Arguments

- obs:

  a value (class `randboot`) or a vector (class `krandboot`) with
  observed statistics

- boot:

  a vector (class `randboot`) or a matrix (class `krandboot`) with the
  bootstrap values of the statistics

- quantiles:

  a vector indicating the lower and upper quantiles to compute

- names:

  a vector of names for the statistics

- call:

  the matching call

- x:

  an object of class `randboot` or `krandboot`

- object:

  an object on which bootstrap should be perform

- ...:

  other arguments to be passed to methods

## Value

an object of class `randboot` or `krandboot`

## References

Carpenter, J. and Bithell, J. (2000) Bootstrap confidence intervals:
when, which, what? A practical guide for medical
statisticians.*Statistics in medicine*, 19, 1141-1164

## Author

Stéphane Dray (<stephane.dray@univ-lyon1.fr>)

## See also

[`randboot.multiblock`](randboot.multiblock.md)

## Examples

``` r
## an example corresponding to 10 statistics and 100 repetitions
bt <- as.krandboot(obs = rnorm(10), boot = matrix(rnorm(1000), nrow = 100))
bt
#> Multiple bootstrap
#> Call: as.krandboot(obs = rnorm(10), boot = matrix(rnorm(1000), nrow = 100))
#> 
#> Number of statistics:   10 
#> 
#> Confidence Interval:
#>    N.rep         Obs       2.5%      97.5%
#> 1    100 -0.73533744 -3.1306777  0.4894295
#> 2    100 -1.30451372 -4.5188586 -0.8829928
#> 3    100 -0.41024522 -2.5282929  1.4211298
#> 4    100  0.07678222 -1.7009010  2.3755973
#> 5    100  1.22904081  0.5342562  3.9934041
#> 6    100 -2.02706503 -5.7018067 -2.2144681
#> 7    100  1.49635733  1.1491791  5.3584039
#> 8    100 -0.44957751 -2.8080532  0.8080414
#> 9    100 -1.74675102 -5.4125807 -1.0619493
#> 10   100 -0.57117198 -3.1137657  0.2149117
if(adegraphicsLoaded())
plot(bt) 
```
