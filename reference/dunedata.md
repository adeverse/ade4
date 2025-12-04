# Dune Meadow Data

`dunedata` is a data set containing for 20 sites, environmental
variables and plant species.

## Usage

``` r
data(dunedata)
```

## Format

`dunedata` is a list with 2 components.

- envir:

  is a data frame with 20 rows (sites) 5 columns (environnemental
  variables).

- veg:

  is a data frame with 20 rows (sites) 30 columns (plant species).

## Source

Jongman, R. H., ter Braak, C. J. F. and van Tongeren, O. F. R. (1987)
*Data analysis in community and landscape ecology*, Pudoc, Wageningen.

## Examples

``` r
data(dunedata)
summary(dunedata$envir)
#>        A1            moisture       manure           use    management
#>  Min.   : 2.800   Min.   :1.0   Min.   :0.00   hayfield:7   BF:3      
#>  1st Qu.: 3.500   1st Qu.:1.0   1st Qu.:0.00   both    :8   HF:5      
#>  Median : 4.200   Median :2.0   Median :2.00   grazing :5   NM:6      
#>  Mean   : 4.850   Mean   :2.9   Mean   :1.75                SF:6      
#>  3rd Qu.: 5.725   3rd Qu.:5.0   3rd Qu.:3.00                          
#>  Max.   :11.500   Max.   :5.0   Max.   :4.00                          
is.ordered(dunedata$envir$use)
#> [1] TRUE
score(dudi.mix(dunedata$envir, scan = FALSE))
```
