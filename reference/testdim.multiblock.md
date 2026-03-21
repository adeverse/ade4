# Selection of the number of dimension by two-fold cross-validation for multiblock methods

Function to perform a two-fold cross-validation to select the optimal
number of dimensions of multiblock methods, *i.e.*, multiblock principal
component analysis with instrumental Variables or multiblock partial
least squares

## Usage

``` r
# S3 method for class 'multiblock'
testdim(object, nrepet = 100, quantiles = c(0.25, 0.75), ...)
```

## Arguments

- object:

  an object of class multiblock created by [`mbpls`](mbpls.md) or
  [`mbpcaiv`](mbpcaiv.md)

- nrepet:

  integer indicating the number of repetitions

- quantiles:

  a vector indicating the lower and upper quantiles to compute

- ...:

  other arguments to be passed to methods

## Value

An object of class `krandxval`

## References

Stone M. (1974) Cross-validatory choice and assessment of statistical
predictions. *Journal of the Royal Statistical Society*, **36**,
111-147.

Bougeard, S. and Dray S. (2018) Supervised Multiblock Analysis in R with
the ade4 Package. *Journal of Statistical Software*, **86** (1), 1-17.
[doi:10.18637/jss.v086.i01](https://doi.org/10.18637/jss.v086.i01)

## Author

Stéphanie Bougeard (<stephanie.bougeard@anses.fr>) and Stéphane Dray
(<stephane.dray@univ-lyon1.fr>)

## See also

[`mbpcaiv`](mbpcaiv.md), [`mbpls`](mbpls.md),
[`randboot.multiblock`](randboot.multiblock.md),
[`as.krandxval`](randxval.md)

## Examples

``` r
data(chickenk)
Mortality <- chickenk[[1]]
dudiY.chick <- dudi.pca(Mortality, center = TRUE, scale = TRUE, scannf =
FALSE)
ktabX.chick <- ktab.list.df(chickenk[2:5])
resmbpcaiv.chick <- mbpcaiv(dudiY.chick, ktabX.chick, scale = TRUE,
option = "uniform", scannf = FALSE)
## nrepet should be higher for a real analysis
test <- testdim(resmbpcaiv.chick, nrepet = 10)
test
#> Two-fold cross-validation
#> Call: testdim.multiblock(object = resmbpcaiv.chick, nrepet = 10)
#> 
#> Results for 20 statistics
#> 
#> Root mean square error of calibration:
#>      N.rep      Mean       25%       75%
#> Ax1     10 0.4800278 0.4577067 0.4998504
#> Ax2     10 0.4622629 0.4423598 0.4798993
#> Ax3     10 0.4487986 0.4261174 0.4681808
#> Ax4     10 0.4391072 0.4182371 0.4569759
#> Ax5     10 0.4367340 0.4159418 0.4547777
#> Ax6     10 0.4353728 0.4145631 0.4534843
#> Ax7     10 0.4343581 0.4133363 0.4522562
#> Ax8     10 0.4338121 0.4128262 0.4517915
#> Ax9     10 0.4334326 0.4124050 0.4514605
#> Ax10    10 0.4331831 0.4121284 0.4511975
#> Ax11    10 0.4330470 0.4119644 0.4509967
#> Ax12    10 0.4329571 0.4118653 0.4509040
#> Ax13    10 0.4329159 0.4118245 0.4508621
#> Ax14    10 0.4328939 0.4117987 0.4508412
#> Ax15    10 0.4328817 0.4117906 0.4508279
#> Ax16    10 0.4328750 0.4117825 0.4508182
#> Ax17    10 0.4328725 0.4117798 0.4508159
#> Ax18    10 0.4328719 0.4117788 0.4508155
#> Ax19    10 0.4328718 0.4117788 0.4508154
#> Ax20     4 0.4350394 0.4164291 0.4545549
#> 
#> Root mean square error of validation:
#>      N.rep      Mean       25%       75%
#> Ax1     10 0.4642044 0.4206995 0.5096576
#> Ax2     10 0.4593146 0.4214333 0.5049101
#> Ax3     10 0.4530373 0.4161685 0.4965937
#> Ax4     10 0.4483065 0.4070909 0.4931721
#> Ax5     10 0.4490717 0.4112277 0.4934000
#> Ax6     10 0.4506686 0.4156648 0.4927764
#> Ax7     10 0.4513055 0.4174005 0.4941666
#> Ax8     10 0.4514172 0.4172629 0.4941858
#> Ax9     10 0.4513912 0.4173005 0.4933258
#> Ax10    10 0.4515917 0.4183679 0.4945103
#> Ax11    10 0.4520613 0.4187949 0.4943629
#> Ax12    10 0.4522141 0.4193897 0.4933823
#> Ax13    10 0.4521306 0.4193297 0.4934508
#> Ax14    10 0.4521061 0.4193716 0.4936688
#> Ax15    10 0.4520766 0.4195855 0.4935959
#> Ax16    10 0.4520984 0.4196786 0.4936010
#> Ax17    10 0.4520822 0.4196766 0.4935720
#> Ax18    10 0.4521012 0.4196869 0.4936085
#> Ax19    10 0.4521086 0.4196883 0.4936120
#> Ax20     4 0.4454647 0.4071066 0.4889322
if(adegraphicsLoaded())
plot(test)
```
