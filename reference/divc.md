# Rao's diversity coefficient also called quadratic entropy

Calculates Rao's diversity coefficient within samples.

## Usage

``` r
divc(df, dis, scale)
```

## Arguments

- df:

  a data frame with elements as rows, samples as columns, and abundance,
  presence-absence or frequencies as entries

- dis:

  an object of class `dist` containing distances or dissimilarities
  among elements. If `dis` is NULL, Gini-Simpson index is performed.

- scale:

  a logical value indicating whether or not the diversity coefficient
  should be scaled by its maximal value over all frequency
  distributions.

## Value

Returns a data frame with samples as rows and the diversity coefficient
within samples as columns

## References

Rao, C.R. (1982) Diversity and dissimilarity coefficients: a unified
approach. *Theoretical Population Biology*, **21**, 24–43.

Gini, C. (1912) Variabilità e mutabilità. *Universite di Cagliari III*,
Parte II.

Simpson, E.H. (1949) Measurement of diversity. *Nature*, **163**, 688.

Champely, S. and Chessel, D. (2002) Measuring biological diversity using
Euclidean metrics. *Environmental and Ecological Statistics*, **9**,
167–177.

## Author

Sandrine Pavoine <pavoine@mnhn.fr>

## Examples

``` r
data(ecomor)
dtaxo <- dist.taxo(ecomor$taxo)
divc(ecomor$habitat, dtaxo)
#>     diversity
#> Bu1  2.754458
#> Bu2  2.967895
#> Bu3  3.107200
#> Bu4  3.137755
#> Ca1  2.500000
#> Ca2  3.230769
#> Ca3  3.272727
#> Ca4  3.283203
#> Ch1  2.333333
#> Ch2  2.595041
#> Ch3  3.246528
#> Ch4  3.135734
#> Pr1  2.840000
#> Pr2  2.816327
#> Pr3  3.055556
#> Pr4  3.028355

data(humDNAm)
divc(humDNAm$samples, sqrt(humDNAm$distances))
#>           diversity
#> oriental 0.43100189
#> tharu    0.48255042
#> wolof    0.65884298
#> peul     0.55952920
#> pima     0.06198035
#> maya     0.17092768
#> finnish  0.33280992
#> sicilian 0.61913580
#> israelij 0.67061144
#> israelia 0.64036818
```
