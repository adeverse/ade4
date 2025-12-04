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
#> Ax1     10 0.4808811 0.4559512 0.4998504
#> Ax2     10 0.4632197 0.4381106 0.4805959
#> Ax3     10 0.4497868 0.4246251 0.4681808
#> Ax4     10 0.4404904 0.4172963 0.4573525
#> Ax5     10 0.4380844 0.4149688 0.4551250
#> Ax6     10 0.4366853 0.4134101 0.4538078
#> Ax7     10 0.4356629 0.4124978 0.4527273
#> Ax8     10 0.4351353 0.4119052 0.4522888
#> Ax9     10 0.4347693 0.4115028 0.4520213
#> Ax10    10 0.4345150 0.4112195 0.4517682
#> Ax11    10 0.4343820 0.4111346 0.4515911
#> Ax12    10 0.4342955 0.4110578 0.4515424
#> Ax13    10 0.4342525 0.4110174 0.4515139
#> Ax14    10 0.4342285 0.4109935 0.4514964
#> Ax15    10 0.4342139 0.4109801 0.4514849
#> Ax16    10 0.4342063 0.4109749 0.4514804
#> Ax17    10 0.4342038 0.4109727 0.4514797
#> Ax18    10 0.4342032 0.4109721 0.4514795
#> Ax19    10 0.4342031 0.4109720 0.4514794
#> Ax20     5 0.4267427 0.3946571 0.4482028
#> 
#> Root mean square error of validation:
#>      N.rep      Mean       25%       75%
#> Ax1     10 0.4618815 0.4206995 0.5283911
#> Ax2     10 0.4567520 0.4214333 0.5079143
#> Ax3     10 0.4509181 0.4161685 0.5012664
#> Ax4     10 0.4449344 0.4060783 0.4965349
#> Ax5     10 0.4453665 0.4100381 0.4933505
#> Ax6     10 0.4475269 0.4156165 0.4943984
#> Ax7     10 0.4482343 0.4174005 0.4948910
#> Ax8     10 0.4484115 0.4172629 0.4961006
#> Ax9     10 0.4485677 0.4173005 0.4958341
#> Ax10    10 0.4482960 0.4183679 0.4960453
#> Ax11    10 0.4488419 0.4186622 0.4959981
#> Ax12    10 0.4491075 0.4187084 0.4961340
#> Ax13    10 0.4490621 0.4186281 0.4963740
#> Ax14    10 0.4490437 0.4187082 0.4962377
#> Ax15    10 0.4490554 0.4189520 0.4962988
#> Ax16    10 0.4490994 0.4190693 0.4962688
#> Ax17    10 0.4490980 0.4190799 0.4962901
#> Ax18    10 0.4490960 0.4190645 0.4962901
#> Ax19    10 0.4491043 0.4190672 0.4963037
#> Ax20     5 0.4613130 0.4239826 0.5242322
if(adegraphicsLoaded())
plot(test)
```
