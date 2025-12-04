# Allelic frequencies in ten honeybees populations at eight microsatellites loci

This data set gives the occurences for the allelic form on 8 loci in 10
populations of honeybees.

## Usage

``` r
data(apis108)
```

## Format

A data frame containing 180 rows (allelic forms on 8 loci) and 10
columns (populations of honeybees : El.Hermel, Al.Hoceima, Nimba,
Celinda, Pretoria, Chalkidiki, Forli, Valenciennes, Umea and Seville).

## Source

Franck P., Garnery L., Solignac M. and Cornuet J.M. (2000) Molecular
confirmation of a fourth lineage in honeybees from the Near-East.
*Apidologie*, **31**, 167–180.

## Examples

``` r
data(apis108)
str(apis108)
#> 'data.frame':    180 obs. of  10 variables:
#>  $ El.Hermel   : num  0 0 0 0 0 4 17 0 4 17 ...
#>  $ Al.Hoceima  : num  0 0 11 0 1 4 5 0 25 0 ...
#>  $ Nimba       : num  0 2 1 0 5 2 10 0 6 3 ...
#>  $ Chelinda    : num  1 0 0 2 8 4 9 1 10 1 ...
#>  $ Pretoria    : num  2 2 1 0 5 5 4 0 7 5 ...
#>  $ Chalkidiki  : num  0 0 0 0 0 0 0 0 46 0 ...
#>  $ Forli       : num  0 0 0 0 0 0 0 0 18 0 ...
#>  $ Valenciennes: num  0 10 0 0 0 0 0 0 2 0 ...
#>  $ Umea        : num  0 1 0 0 0 0 0 0 0 0 ...
#>  $ Seville     : num  0 1 0 0 0 0 0 0 0 1 ...
names(apis108)
#>  [1] "El.Hermel"    "Al.Hoceima"   "Nimba"        "Chelinda"     "Pretoria"    
#>  [6] "Chalkidiki"   "Forli"        "Valenciennes" "Umea"         "Seville"     
```
