# Multiblock partial least squares

Function to perform a multiblock partial least squares (PLS) of several
explanatory blocks \\(X_1, \dots, X_k)\\ defined as an object of class
`ktab`, to explain a dependent dataset \$Y\$ defined as an object of
class `dudi`

## Usage

``` r
mbpls(dudiY, ktabX, scale = TRUE, option = c("uniform", "none"), scannf = TRUE, nf = 2)
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

- cov2:

  squared covariance between lY and TlX

- Tc1:

  matrix containing the partial loadings associated with each
  explanatory dataset (unit norm)

- TlX:

  matrix containing the partial components associated with each
  explanatory dataset

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

Bougeard, S., Qannari, E.M., Lupo, C. and Hanafi, M. (2011). From
multiblock partial least squares to multiblock redundancy analysis. A
continuum approach. *Informatica*, 22(1), 11-26

Bougeard, S. and Dray S. (2018) Supervised Multiblock Analysis in R with
the ade4 Package. *Journal of Statistical Software*, **86** (1), 1-17.
[doi:10.18637/jss.v086.i01](https://doi.org/10.18637/jss.v086.i01)

## Author

Stéphanie Bougeard (<stephanie.bougeard@anses.fr>) and Stéphane Dray
(<stephane.dray@univ-lyon1.fr>)

## See also

`mbpls`, [`testdim.multiblock`](testdim.multiblock.md),
[`randboot.multiblock`](randboot.multiblock.md)

## Examples

``` r
data(chickenk)
Mortality <- chickenk[[1]]
dudiY.chick <- dudi.pca(Mortality, center = TRUE, scale = TRUE, scannf =
FALSE)
ktabX.chick <- ktab.list.df(chickenk[2:5])
resmbpls.chick <- mbpls(dudiY.chick, ktabX.chick, scale = TRUE,
option = "uniform", scannf = FALSE)
summary(resmbpls.chick)
#> Multiblock partial least squares
#> 
#> Class: multiblock mbpls
#> Call: mbpls(dudiY = dudiY.chick, ktabX = ktabX.chick, scale = TRUE, 
#>     option = "uniform", scannf = FALSE)
#> 
#> Total inertia: 1944
#> 
#> Eigenvalues:
#>     Ax1     Ax2     Ax3     Ax4     Ax5 
#>  802.46  458.43  339.86  200.32   53.87 
#> 
#> Projected inertia (%):
#>     Ax1     Ax2     Ax3     Ax4     Ax5 
#>  41.285  23.585  17.485  10.306   2.771 
#> 
#> Cumulative projected inertia (%):
#>     Ax1   Ax1:2   Ax1:3   Ax1:4   Ax1:5 
#>   41.29   64.87   82.36   92.66   95.43 
#> 
#> (Only 5 dimensions (out of 20) are shown)
#> 
#> Inertia explained by the global latent, i.e., resmbpls.chick$lX (in %): 
#> 
#> dudiY.chick$tab and ktabX.chick: 
#>     varY varYcum varX varXcum
#> Ax1 38.3    38.3 7.64    7.64
#> Ax2 20.3    58.6 7.95   15.59
#> 
#> FarmStructure:
#>     varXk varXkcum
#> Ax1  3.82     3.82
#> Ax2  5.84     9.66
#> 
#> OnFarmHistory:
#>     varXk varXkcum
#> Ax1  9.82     9.82
#> Ax2 12.16    21.98
#> 
#> FlockCharacteristics:
#>     varXk varXkcum
#> Ax1 11.74     11.7
#> Ax2  4.36     16.1
#> 
#> CatchingTranspSlaught:
#>     varXk varXkcum
#> Ax1  5.16     5.16
#> Ax2  9.44    14.60
if(adegraphicsLoaded())
plot(resmbpls.chick)
```
