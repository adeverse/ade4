# human mitochondrial DNA restriction data

This data set gives the frequencies of haplotypes of mitochondrial DNA
restriction data in ten populations all over the world.  
It gives also distances among the haplotypes.

## Usage

``` r
data(humDNAm)
```

## Format

`humDNAm` is a list of 3 components.

- distances:

  is an object of class `dist` with 56 haplotypes. These distances are
  computed by counting the number of differences in restriction sites
  between two haplotypes.

- samples:

  is a data frame with 56 haplotypes, 10 abundance variables
  (populations). These variables give the haplotype abundance in a given
  population.

- structures:

  is a data frame with 10 populations, 1 variable (classification). This
  variable gives the name of the continent in which a given population
  is located.

## Source

Excoffier, L., Smouse, P.E. and Quattro, J.M. (1992) Analysis of
molecular variance inferred from metric distances among DNA haplotypes:
application to human mitochondrial DNA restriction data. *Genetics*,
**131**, 479–491.

## Examples

``` r
data(humDNAm)
dpcoahum <- dpcoa(data.frame(t(humDNAm$samples)), 
    sqrt(humDNAm$distances), scan = FALSE, nf = 2)
plot(dpcoahum)
#> Error in s.corcircle(dfxy = dpcoahum$c1, xax = 1, yax = 2, plot = FALSE,     storeData = TRUE, pos = -3, psub = list(text = "Principal axes",         position = "topleft"), pbackground = list(box = FALSE),     plabels = list(cex = 1.25)): non convenient selection for dfxy (can not be converted to dataframe)
```
