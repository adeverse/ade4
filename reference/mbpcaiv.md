# Multiblock principal component analysis with instrumental variables

Function to perform a multiblock redundancy analysis of several
explanatory blocks \\(X_1, \dots, X_k)\\, defined as an object of class
`ktab`, to explain a dependent dataset \$Y\$, defined as an object of
class `dudi`

## Usage

``` r
mbpcaiv(dudiY, ktabX, scale = TRUE, option = c("uniform", "none"), scannf = TRUE, nf = 2)
```

## Arguments

- dudiY:

  an object of class `dudi` containing the dependent variables

- ktabX:

  an object of class `ktab` containing the blocks of explanatory
  variables

- scale:

  logical value indicating whether the explanatory variables should be
  standardized

- option:

  an option for the block weighting. If `uniform`, the block weight is
  equal to \$1/K\$ for \\(X_1, \dots, X_K)\\ and to \$1\$ for \$X\$ and
  \$Y\$. If `none`, the block weight is equal to the block inertia

- scannf:

  logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  integer indicating the number of kept dimensions

## Value

A list containing the following components is returned:

- call:

  the matching call

- tabY:

  data frame of dependent variables centered, eventually scaled (if
  scale=TRUE) and weighted (if option="uniform")

- tabX:

  data frame of explanatory variables centered, eventually scaled (if
  scale=TRUE) and weighted (if option="uniform")

- TL, TC:

  data frame useful to manage graphical outputs

- nf:

  numeric value indicating the number of kept dimensions

- lw:

  numeric vector of row weights

- X.cw:

  numeric vector of column weighs for the explanalatory dataset

- blo:

  vector of the numbers of variables in each explanatory dataset

- rank:

  maximum rank of the analysis

- eig:

  numeric vector containing the eigenvalues

- lX:

  matrix of the global components associated with the whole explanatory
  dataset (scores of the individuals)

- lY:

  matrix of the components associated with the dependent dataset

- Yc1:

  matrix of the variable loadings associated with the dependent dataset

- Tli:

  matrix containing the partial components associated with each
  explanatory dataset

- Tl1:

  matrix containing the normalized partial components associated with
  each explanatory dataset

- Tfa:

  matrix containing the partial loadings associated with each
  explanatory dataset

- cov2:

  squared covariance between lY and Tl1

- Yco:

  matrix of the regression coefficients of the dependent dataset onto
  the global components

- faX:

  matrix of the regression coefficients of the whole explanatory dataset
  onto the global components

- XYcoef:

  list of matrices of the regression coefficients of the whole
  explanatory dataset onto the dependent dataset

- bip:

  block importances for a given dimension

- bipc:

  cumulated block importances for a given number of dimensions

- vip:

  variable importances for a given dimension

- vipc:

  cumulated variable importances for a given number of dimensions

## References

Bougeard, S., Qannari, E.M. and Rose, N. (2011) Multiblock Redundancy
Analysis: interpretation tools and application in epidemiology. *Journal
of Chemometrics*, **23**, 1-9

Bougeard, S. and Dray S. (2018) Supervised Multiblock Analysis in R with
the ade4 Package. *Journal of Statistical Software*, **86** (1), 1-17.
[doi:10.18637/jss.v086.i01](https://doi.org/10.18637/jss.v086.i01)

## Author

Stéphanie Bougeard (<stephanie.bougeard@anses.fr>) and Stéphane Dray
(<stephane.dray@univ-lyon1.fr>)

## See also

[`mbpls`](mbpls.md), [`testdim.multiblock`](testdim.multiblock.md),
[`randboot.multiblock`](randboot.multiblock.md)

## Examples

``` r
data(chickenk)
Mortality <- chickenk[[1]]
dudiY.chick <- dudi.pca(Mortality, center = TRUE, scale = TRUE, scannf =
FALSE)
ktabX.chick <- ktab.list.df(chickenk[2:5])
resmbpcaiv.chick <- mbpcaiv(dudiY.chick, ktabX.chick, scale = TRUE,
option = "uniform", scannf = FALSE)
summary(resmbpcaiv.chick)
#> Multiblock principal component analysis with instrumental variables
#> 
#> Class: multiblock mbpcaiv
#> Call: mbpcaiv(dudiY = dudiY.chick, ktabX = ktabX.chick, scale = TRUE, 
#>     option = "uniform", scannf = FALSE)
#> 
#> Total inertia: 125.8
#> 
#> Eigenvalues:
#>     Ax1     Ax2     Ax3     Ax4     Ax5 
#>  44.144  26.332  23.758  19.672   5.364 
#> 
#> Projected inertia (%):
#>     Ax1     Ax2     Ax3     Ax4     Ax5 
#>  35.103  20.939  18.893  15.643   4.265 
#> 
#> Cumulative projected inertia (%):
#>     Ax1   Ax1:2   Ax1:3   Ax1:4   Ax1:5 
#>   35.10   56.04   74.93   90.58   94.84 
#> 
#> (Only 5 dimensions (out of 20) are shown)
#> 
#> Inertia explained by the global latent, i.e., resmbpcaiv.chick$lX (in %): 
#> 
#> dudiY.chick$tab and ktabX.chick: 
#>     varY varYcum varX varXcum
#> Ax1 41.2    41.2 6.94    6.94
#> Ax2 21.5    62.7 7.31   14.25
#> 
#> FarmStructure:
#>     varXk varXkcum
#> Ax1  4.68     4.68
#> Ax2  5.02     9.70
#> 
#> OnFarmHistory:
#>     varXk varXkcum
#> Ax1  6.81     6.81
#> Ax2  9.10    15.91
#> 
#> FlockCharacteristics:
#>     varXk varXkcum
#> Ax1 12.38     12.4
#> Ax2  4.13     16.5
#> 
#> CatchingTranspSlaught:
#>     varXk varXkcum
#> Ax1  3.88     3.88
#> Ax2 11.01    14.88
if(adegraphicsLoaded())
plot(resmbpcaiv.chick)
```
