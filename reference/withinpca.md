# Normed within principal component analysis

Performs a normed within Principal Component Analysis.

## Usage

``` r
withinpca(df, fac, scaling = c("partial", "total"), 
    scannf = TRUE, nf = 2)
```

## Arguments

- df:

  a data frame with quantitative variables

- fac:

  a factor partitioning the rows of df in classes

- scaling:

  a string of characters as a scaling option :  
  if "partial", the sub-table corresponding to each class is centred and
  normed.  
  If "total", the sub-table corresponding to each class is centred and
  the total table is then normed.

- scannf:

  a logical value indicating whether the eigenvalues bar plot should be
  displayed

- nf:

  if scannf FALSE, an integer indicating the number of kept axes

## Details

This functions implements the 'Bouroche' standardization. In a first
step, the original variables are standardized (centred and normed).
Then, a second transformation is applied according to the value of the
`scaling` argument. For "partial", variables are standardized in each
sub-table (corresponding to each level of the factor). Hence, variables
have null mean and unit variance in each sub-table. For "total",
variables are centred in each sub-table and then normed globally. Hence,
variables have a null mean in each sub-table and a global variance equal
to one.

## Value

returns a list of the sub-class `within` of class `dudi`. See
[`wca`](wca.md)

## References

Bouroche, J. M. (1975) *Analyse des données ternaires: la double analyse
en composantes principales*. Thèse de 3ème cycle, Université de Paris
VI.

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(meaudret)
wit1 <- withinpca(meaudret$env, meaudret$design$season, scannf = FALSE, scaling = "partial")
kta1 <- ktab.within(wit1, colnames = rep(c("S1", "S2", "S3", "S4", "S5"), 4))
unclass(kta1)
#> $spring
#>                 S1         S2          S3         S4         S5
#> Temp -1.372813e+00 -0.3922323 -0.39223227  0.5883484  1.5689291
#> Flow -1.615156e+00 -0.4251482 -0.01830782  0.8157149  1.2428973
#> pH    2.041241e-01 -1.8371173  0.20412415  1.2247449  0.2041241
#> Cond  9.457838e-17  1.9069252 -0.47673129 -0.4767313 -0.9534626
#> Bdo5 -9.621078e-01  1.9351487 -0.41545565 -0.3061252 -0.2514600
#> Oxyd -6.364382e-01  1.9923283 -0.49808208 -0.4980821 -0.3597259
#> Ammo -7.376580e-01  1.9837018 -0.45854414 -0.4087024 -0.3787973
#> Nitr -5.281643e-01 -1.6155614  0.40389035  0.4038903  1.3359450
#> Phos -1.047323e+00  1.6189391 -1.06650488  0.1419449  0.3529441
#> 
#> $summer
#>              S1         S2         S3          S4         S5
#> Temp -1.1666667 -1.1666667  0.5000000  1.33333333  0.5000000
#> Flow -1.2683846 -0.7763389 -0.2296214  0.86381368  1.4105312
#> pH    0.9354143 -1.4031215 -0.7349684 -0.06681531  1.2694909
#> Cond -1.5297323  0.9448347  1.1697953  0.04499213 -0.6298898
#> Bdo5 -1.0875080  1.4231586  0.6175971  0.21481639 -1.1680641
#> Oxyd -0.7664063  1.9508524 -0.2786932 -0.20901990 -0.6967330
#> Ammo -1.1379075  1.3255250  0.8424990  0.07982640 -1.1099429
#> Nitr -0.8553618 -1.4868370  0.4936988  0.69462267  1.1538773
#> Phos -1.6393299  0.6112322  1.1546918  0.48335936 -0.6099535
#> 
#> $autumn
#>              S1          S2          S3          S4         S5
#> Temp -1.6035675  1.06904497 -0.26726124  1.06904497 -0.2672612
#> Flow -1.8766905 -0.08487545  0.66957300  0.95249116  0.3395018
#> pH    0.5619515 -1.31122014 -0.84292723  0.09365858  1.4985373
#> Cond -0.7012869  1.87009833  0.11688115 -0.35064344 -0.9350492
#> Bdo5 -0.6044785  1.97542987 -0.19199318 -0.57447961 -0.6044785
#> Oxyd -0.7363901  1.97092649 -0.23102435 -0.41151212 -0.5919999
#> Ammo -0.6470895  1.95761335 -0.09597377 -0.57374709 -0.6408030
#> Nitr -0.5674453 -1.62198962  1.13991221  0.83861383  0.2109089
#> Phos -1.1374069  1.70830946  0.47677844 -0.44686983 -0.6008112
#> 
#> $winter
#>              S1         S2          S3         S4         S5
#> Temp  0.5000000  0.5000000 0.500000000  0.5000000 -2.0000000
#> Flow -1.5362076 -0.4891485 0.003125549  1.4330644  0.5891661
#> pH   -1.8864844  0.6859943 0.685994341  0.6859943 -0.1714986
#> Cond -0.9819805  0.9274260 1.472970759 -0.7092081 -0.7092081
#> Bdo5 -1.0927369  1.2659029 1.027053299 -0.1373385 -1.0628807
#> Oxyd -0.9763927  1.2666716 1.134726600 -0.4486128 -0.9763927
#> Ammo -1.1833898  1.0449484 1.310452499 -0.3584306 -0.8135805
#> Nitr -1.9709202  0.4077766 0.577683516  0.2378697  0.7475904
#> Phos -1.0886790  0.4133145 1.744869109 -0.4175755 -0.6519291
#> 
#> $lw
#> [1] 1 1 1 1 1 1 1 1 1
#> 
#> $cw
#>  [1] 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2
#> [20] 0.2
#> 
#> $blo
#> spring summer autumn winter 
#>      5      5      5      5 
#> 
#> $TL
#>         T    L
#> 1  spring Temp
#> 2  spring Flow
#> 3  spring   pH
#> 4  spring Cond
#> 5  spring Bdo5
#> 6  spring Oxyd
#> 7  spring Ammo
#> 8  spring Nitr
#> 9  spring Phos
#> 10 summer Temp
#> 11 summer Flow
#> 12 summer   pH
#> 13 summer Cond
#> 14 summer Bdo5
#> 15 summer Oxyd
#> 16 summer Ammo
#> 17 summer Nitr
#> 18 summer Phos
#> 19 autumn Temp
#> 20 autumn Flow
#> 21 autumn   pH
#> 22 autumn Cond
#> 23 autumn Bdo5
#> 24 autumn Oxyd
#> 25 autumn Ammo
#> 26 autumn Nitr
#> 27 autumn Phos
#> 28 winter Temp
#> 29 winter Flow
#> 30 winter   pH
#> 31 winter Cond
#> 32 winter Bdo5
#> 33 winter Oxyd
#> 34 winter Ammo
#> 35 winter Nitr
#> 36 winter Phos
#> 
#> $TC
#>         T  C
#> 1  spring S1
#> 2  spring S2
#> 3  spring S3
#> 4  spring S4
#> 5  spring S5
#> 6  summer S1
#> 7  summer S2
#> 8  summer S3
#> 9  summer S4
#> 10 summer S5
#> 11 autumn S1
#> 12 autumn S2
#> 13 autumn S3
#> 14 autumn S4
#> 15 autumn S5
#> 16 winter S1
#> 17 winter S2
#> 18 winter S3
#> 19 winter S4
#> 20 winter S5
#> 
#> $T4
#>         T 4
#> 1  spring 1
#> 2  spring 2
#> 3  spring 3
#> 4  spring 4
#> 5  summer 1
#> 6  summer 2
#> 7  summer 3
#> 8  summer 4
#> 9  autumn 1
#> 10 autumn 2
#> 11 autumn 3
#> 12 autumn 4
#> 13 winter 1
#> 14 winter 2
#> 15 winter 3
#> 16 winter 4
#> 
#> $call
#> ktab.within(dudiwit = wit1, colnames = rep(c("S1", "S2", "S3", 
#>     "S4", "S5"), 4))
#> 
#> $tabw
#> spring summer autumn winter 
#>   0.25   0.25   0.25   0.25 
#> 

# See pta
plot(wit1)
#> Error in s.arrow(dfxy = wit1$c1, xax = 1, yax = 2, plot = FALSE, storeData = TRUE,     pos = -3, psub = list(text = "Loadings"), plabels = list(        cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
