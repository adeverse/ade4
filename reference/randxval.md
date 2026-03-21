# Two-fold cross-validation

Functions and classes to manage outputs of two-fold cross-validation for
one (class `randxval`) or several (class `krandxval`) statistics

## Usage

``` r
as.krandxval(RMSEc, RMSEv, quantiles = c(0.25, 0.75), names =
colnames(RMSEc), call = match.call())
# S3 method for class 'krandxval'
print(x, ...)
as.randxval(RMSEc, RMSEv, quantiles = c(0.25, 0.75), call =
match.call())
# S3 method for class 'randxval'
print(x, ...)
```

## Arguments

- RMSEc:

  a vector (class `randxval`) or a matrix (class `krandxval`) with the
  root-mean-square error of calibration (statistics as columns and
  repetions as rows)

- RMSEv:

  a vector (class `randxval`) or a matrix (class `krandxval`) with the
  root-mean-square error of validation (statistics as columns and
  repetions as rows)

- quantiles:

  a vector indicating the lower and upper quantiles to compute

- names:

  a vector of names for the statistics

- call:

  the matching call

- x:

  an object of class `randxval` or `krandxval`

- ...:

  other arguments to be passed to methods

## Value

an object of class `randxval` or `krandxval`

## References

Stone M. (1974) Cross-validatory choice and assessment of statistical
predictions. *Journal of the Royal Statistical Society*, 36, 111-147

## Author

Stéphane Dray (<stephane.dray@univ-lyon1.fr>)

## See also

[`testdim.multiblock`](testdim.multiblock.md)

## Examples

``` r
## an example corresponding to 10 statistics and 100 repetitions
cv <- as.krandxval(RMSEc = matrix(rnorm(1000), nrow = 100), RMSEv =
matrix(rnorm(1000, mean = 1), nrow = 100))
cv
#> Two-fold cross-validation
#> Call: as.krandxval(RMSEc = matrix(rnorm(1000), nrow = 100), RMSEv = matrix(rnorm(1000, 
#>     mean = 1), nrow = 100))
#> 
#> Results for 10 statistics
#> 
#> Root mean square error of calibration:
#>    N.rep         Mean        25%       75%
#> 1    100 -0.098517007 -0.9044874 0.7085006
#> 2    100  0.187887544 -0.4690730 0.7683470
#> 3    100 -0.097821435 -0.8455230 0.5227684
#> 4    100 -0.016930020 -0.6118716 0.5523678
#> 5    100 -0.008703411 -0.6611219 0.7492250
#> 6    100 -0.009132057 -0.6647049 0.7527617
#> 7    100 -0.120464929 -0.7229090 0.5336600
#> 8    100  0.060226961 -0.6112861 0.7203614
#> 9    100  0.087163952 -0.6456198 0.8251002
#> 10   100 -0.046160196 -0.9765887 0.7575037
#> 
#> Root mean square error of validation:
#>    N.rep      Mean       25%      75%
#> 1    100 0.9734614 0.2888309 1.794599
#> 2    100 0.9583750 0.2670244 1.592121
#> 3    100 0.9909371 0.2521885 1.820505
#> 4    100 1.0747043 0.5333455 1.665367
#> 5    100 1.1617837 0.3777541 1.882557
#> 6    100 1.1515438 0.5127271 1.814210
#> 7    100 0.9013025 0.4333520 1.470389
#> 8    100 1.0719820 0.4483819 1.844397
#> 9    100 1.1757492 0.5738827 1.726985
#> 10   100 1.0590324 0.4998413 1.597177
if(adegraphicsLoaded())
plot(cv) 
```
