# Apportionment of Quadratic Entropy

The hierarchical apportionment of quadratic entropy defined by Rao
(1982).

## Usage

``` r
apqe(samples, dis = NULL, structures)
# S3 method for class 'apqe'
print(x, full = FALSE, ...)
```

## Arguments

- samples:

  a data frame with haplotypes (or genotypes) as rows, populations as
  columns and abundance or presence-absence as entries

- dis:

  an object of class `dist` computed from Euclidean distance. If `dis`
  is null, equidistances are used.

- structures:

  a data frame that contains, in the jth row and the kth column, the
  name of the group of level k to which the jth population belongs

- x:

  an object of class `apqe`

- full:

  a logical value that indicates whether the original data ('distances',
  'samples', 'structures') should be printed

- ...:

  `...` further arguments passed to or from other methods

## Value

Returns a list of class `apqe`

- call:

  call

- results:

  a data frame that contains the components of diversity.

## References

Rao, C.R. (1982) Diversity: its measurement, decomposition,
apportionment and analysis. *Sankhya: The Indian Journal of Statistics*,
**A44**, 1–22.

Pavoine S. and Dolédec S. (2005) The apportionment of quadratic entropy:
a useful alternative for partitioning diversity in ecological data.
*Environmental and Ecological Statistics*, **12**, 125–138.

## Author

Sandrine Pavoine <pavoine@mnhn.fr>

## Examples

``` r
data(ecomor)
ecomor.phylog <- taxo2phylog(ecomor$taxo)
apqe(ecomor$habitat, ecomor.phylog$Wdist)
#> $call
#> apqe(samples = ecomor$habitat, dis = ecomor.phylog$Wdist)
#> 
#> $results
#>                  diversity
#> Between samples 0.04253396
#> Within samples  0.94719472
#> Total           0.98972868
#> 
```
