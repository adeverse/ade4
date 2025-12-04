# Wine Tasting

The `macon` data frame has 8 rows-wines and 25 columns-tasters. Each
column is a classification of 8 wines (Beaujolais, France).

## Usage

``` r
data(macon)
```

## Source

Foire Nationale des Vins de France, Mâcon, 1985

## Examples

``` r
data(macon)
s.corcircle(dudi.pca(macon, scan = FALSE)$co)
```
