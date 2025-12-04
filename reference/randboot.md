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
#>    N.rep         Obs        2.5%     97.5%
#> 1    100 -0.76278812 -3.51748249 0.7966103
#> 2    100  0.85397764  0.28478387 3.3023528
#> 3    100  0.51680901 -0.99036841 2.7685163
#> 4    100  1.09401737  0.57896491 4.2609446
#> 5    100  0.73304685 -0.40343203 3.5030764
#> 6    100 -0.01193333 -1.83911214 2.2211043
#> 7    100  0.06527588 -1.92976878 1.9234330
#> 8    100 -0.82803558 -3.58631744 0.1801371
#> 9    100  0.87056501 -0.01212261 3.5892404
#> 10   100 -0.23716897 -2.50485763 1.3559333
if(adegraphicsLoaded())
plot(bt) 
```
