# Analysis of molecular variance

The analysis of molecular variance tests the differences among
population and/or groups of populations in a way similar to ANOVA. It
includes evolutionary distances among alleles.

## Usage

``` r
amova(samples, distances, structures)
# S3 method for class 'amova'
print(x, full = FALSE, ...)
```

## Arguments

- samples:

  a data frame with haplotypes (or genotypes) as rows, populations as
  columns and abundance as entries

- distances:

  an object of class `dist` computed from Euclidean distance. If
  `distances` is null, equidistances are used.

- structures:

  a data frame containing, in the jth row and the kth column, the name
  of the group of level k to which the jth population belongs

- x:

  an object of class `amova`

- full:

  a logical value indicating whether the original data ('distances',
  'samples', 'structures') should be printed

- ...:

  further arguments passed to or from other methods

## Value

Returns a list of class `amova`

- call:

  call

- results:

  a data frame with the degrees of freedom, the sums of squares, and the
  mean squares. Rows represent levels of variability.

- componentsofcovariance:

  a data frame containing the components of covariance and their
  contribution to the total covariance

- statphi:

  a data frame containing the phi-statistics

## References

Excoffier, L., Smouse, P.E. and Quattro, J.M. (1992) Analysis of
molecular variance inferred from metric distances among DNA haplotypes:
application to human mitochondrial DNA restriction data. *Genetics*,
**131**, 479–491.

## Author

Sandrine Pavoine <pavoine@mnhn.fr>

## See also

[`randtest.amova`](randtest.amova.md)

## Examples

``` r
data(humDNAm)
amovahum <- amova(humDNAm$samples, sqrt(humDNAm$distances), humDNAm$structures)
amovahum
#> $call
#> amova(samples = humDNAm$samples, distances = sqrt(humDNAm$distances), 
#>     structures = humDNAm$structures)
#> 
#> $results
#>                                 Df     Sum Sq    Mean Sq
#> Between regions                  4  78.238115 19.5595288
#> Between samples Within regions   5   9.284744  1.8569488
#> Within samples                 662 316.197379  0.4776395
#> Total                          671 403.720238  0.6016695
#> 
#> $componentsofcovariance
#>                                                 Sigma          %
#> Variations  Between regions                0.13380659  21.119144
#> Variations  Between samples Within regions 0.02213345   3.493396
#> Variations  Within samples                 0.47763955  75.387459
#> Total variations                           0.63357958 100.000000
#> 
#> $statphi
#>                           Phi
#> Phi-samples-total   0.2461254
#> Phi-samples-regions 0.0442870
#> Phi-regions-total   0.2111914
#> 
```
