# Contingency Table with a partition in Molecular Biology

This data set gives the amino acids of 904 proteins distributed in three
classes.

## Usage

``` r
data(perthi02)
```

## Format

`perthi02` is a list of 2 components.

- tab:

  is a data frame 904 rows (proteins of 201 species) 20 columns (amino
  acids).

- cla:

  is a factor of 3 classes of protein

The levels of `perthi02$cla` are `cyto` (cytoplasmic proteins) `memb`
(integral membran proteins) `peri` (periplasmic proteins)

## Source

Perriere, G. and Thioulouse, J. (2002) Use of Correspondence
Discriminant Analysis to predict the subcellular location of bacterial
proteins. *Computer Methods and Programs in Biomedicine*, **70**, 2,
99–105.

## Examples

``` r
data(perthi02)
plot(discrimin.coa(perthi02$tab, perthi02$cla, scan = FALSE))
```
