# Taxonomy and quantitative traits of carnivora

This data set describes the taxonomy of 39 carnivora. It also gives
life-history traits corresponding to these 39 species.

## Usage

``` r
data(pap)
```

## Format

`pap` is a list containing the 2 following objects :

- taxo:

  is a data frame with 39 species and 3 columns.

- tab:

  is a data frame with 39 species and 4 traits.

## Details

Variables of `pap$tab` are the following ones : genre (genus with 30
levels), famille (family with 6 levels), superfamille (superfamily with
2 levels).  

Variables of `pap$tab` are Group Size, Body Weight, Brain Weight, Litter
Size.

## Source

Data taken from the phylogenetic autocorrelation package

## Examples

``` r
data(pap)
taxo <- taxo2phylog(as.taxo(pap$taxo))
table.phylog(as.data.frame(scalewt(pap$tab)), taxo, csi = 2, clabel.nod = 0.6,
 f.phylog = 0.6)
```
