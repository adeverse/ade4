# Examples of taxonomy

This data sets contains two taxonomies.

## Usage

``` r
data(taxo.eg)
```

## Format

`taxo.eg` is a list containing the 2 following objects:

- taxo.eg\[\[1\]\]:

  is a data frame with 15 species and 3 columns.

- taxo.eg\[\[2\]\]:

  is a data frame with 40 species and 2 columns.

## Details

Variables of the first data frame are : genre (a factor genre with 8
levels), famille (a factor familiy with 5 levels) and ordre (a factor
order with 2 levels).  

Variables of the second data frame are : gen(a factor genre with 29
levels), fam (a factor family with 19 levels).

## Examples

``` r
data(taxo.eg)
taxo.eg[[1]]
#>       genre famille ordre
#> esp8     g2    fam2  ORD2
#> esp3     g1    fam1  ORD1
#> esp1     g1    fam1  ORD1
#> esp2     g1    fam1  ORD1
#> esp4     g1    fam1  ORD1
#> esp14    g8    fam5  ORD2
#> esp15    g8    fam5  ORD2
#> esp9     g3    fam2  ORD2
#> esp13    g7    fam4  ORD2
#> esp12    g6    fam4  ORD2
#> esp11    g5    fam3  ORD2
#> esp10    g4    fam3  ORD2
#> esp5     g1    fam1  ORD1
#> esp6     g1    fam1  ORD1
#> esp7     g1    fam1  ORD1
as.taxo(taxo.eg[[1]])
#>       genre famille ordre
#> esp3     g1    fam1  ORD1
#> esp1     g1    fam1  ORD1
#> esp2     g1    fam1  ORD1
#> esp4     g1    fam1  ORD1
#> esp5     g1    fam1  ORD1
#> esp6     g1    fam1  ORD1
#> esp7     g1    fam1  ORD1
#> esp8     g2    fam2  ORD2
#> esp9     g3    fam2  ORD2
#> esp10    g4    fam3  ORD2
#> esp11    g5    fam3  ORD2
#> esp12    g6    fam4  ORD2
#> esp13    g7    fam4  ORD2
#> esp14    g8    fam5  ORD2
#> esp15    g8    fam5  ORD2
class(taxo.eg[[1]])
#> [1] "data.frame"
class(as.taxo(taxo.eg[[1]]))
#> [1] "data.frame" "taxo"      

tax.phy <- taxo2phylog(as.taxo(taxo.eg[[1]]),  add.tools = TRUE)
plot(tax.phy,clabel.l=1)


par(mfrow = c(1,2))
table.phylog(tax.phy$Bindica,tax.phy)
table.phylog(tax.phy$Bscores,tax.phy)

par(mfrow = c(1,1))

radial.phylog(taxo2phylog(as.taxo(taxo.eg[[2]])))
```
