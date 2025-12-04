# Charolais-Zebus

This data set gives six different weights of 23 charolais and zebu oxen.

## Usage

``` r
data(chazeb)
```

## Format

`chazeb` is a list of 2 components.

- tab:

  is a data frame with 23 rows and 6 columns.

- cla:

  is a factor with two levels "cha" and "zeb".

## Source

Tomassone, R., Danzard, M., Daudin, J. J. and Masson J. P. (1988)
*Discrimination et classement*, Masson, Paris. p. 43

## Examples

``` r
data(chazeb)
if(!adegraphicsLoaded())
  plot(discrimin(dudi.pca(chazeb$tab, scan = FALSE), 
    chazeb$cla, scan = FALSE))
#> Error in plot.discrimin(discrimin(dudi.pca(chazeb$tab, scan = FALSE),     chazeb$cla, scan = FALSE)): One axis only : not yet implemented
```
