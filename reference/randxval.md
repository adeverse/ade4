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
#>    N.rep        Mean        25%       75%
#> 1    100 -0.02696284 -0.7361177 0.5888360
#> 2    100  0.09032550 -0.5002461 0.5452448
#> 3    100  0.17082273 -0.4494000 0.7430513
#> 4    100 -0.01924157 -0.7276047 0.6248826
#> 5    100 -0.07635087 -0.6092265 0.5419279
#> 6    100  0.02084293 -0.5889042 0.7812515
#> 7    100  0.06222205 -0.5889446 0.9141202
#> 8    100  0.01643932 -0.5888750 0.6724972
#> 9    100 -0.08409289 -0.9066959 0.6649879
#> 10   100  0.08044706 -0.5313701 0.5827132
#> 
#> Root mean square error of validation:
#>    N.rep      Mean       25%      75%
#> 1    100 0.8577505 0.2094997 1.513781
#> 2    100 1.0524984 0.3188293 1.784864
#> 3    100 1.0712937 0.3178318 1.874005
#> 4    100 1.1070485 0.5393782 1.648372
#> 5    100 1.1066287 0.2792434 1.876980
#> 6    100 1.0255428 0.3284189 1.610546
#> 7    100 1.0064095 0.3955722 1.700900
#> 8    100 1.0392005 0.2898142 1.629777
#> 9    100 0.9962083 0.1280009 1.767080
#> 10   100 1.0346484 0.3224993 1.738972
if(adegraphicsLoaded())
plot(cv) 
```
