# Permutation test for double principal coordinate analysis (DPCoA)

`randtest.dpcoa` calculates the ratio of beta to gamma diversity
associated with DPCoA and compares the observed value to values obtained
by permuting data.

## Usage

``` r
# S3 method for class 'dpcoa'
randtest(xtest, model = c("1p","1s"), nrepet = 99,
alter = c("greater", "less", "two-sided"), ...)
```

## Arguments

- xtest:

  an object of class `dpcoa`

- model:

  either "1p", "1s", or the name of a function, (see details)

- nrepet:

  the number of permutations to perform, the default is 99

- alter:

  a character string specifying the alternative hypothesis, must be one
  of "greater" (default), "less" or "two-sided"

- ...:

  further arguments passed to or from other methods

## Details

Model 1p permutes the names of the columns of the abundance matrix.
Model 1s permutes the abundances of the categories (columns of the
abundance matrix, usually species) within collections (rows of the
abundance matrix, usually communities). Only the categories with
positive abundances are permuted. The null models were introduced in
Hardy (2008).

Other null model can be used by entering the name of a function. For
example, loading the `picante` package of R, if `model=randomizeMatrix`,
then the permutations will follow function `randomizeMatrix` available
in picante. Any function can be used provided it returns an abundance
matrix of similar size as the observed abundance matrix. Parameters of
the chosen function can be added to `randtest.dpcoa`. For example, using
parameter `null.model` of `randomizeMatrix`, the following command can
be used:
`randtest.dpcoa(xtest, model = randomizeMatrix, null.model = "trialswap")`

## Value

an object of class `randtest`

## References

Hardy, O. (2008) Testing the spatial phylogenetic structure of local
communities: statistical performances of different null models and test
statistics on a locally neutral community. *Journal of Ecology*, **96**,
914–926

## Author

Sandrine Pavoine <pavoine@mnhn.fr>

## See also

[`dpcoa`](dpcoa.md)

## Examples

``` r
data(humDNAm)
dpcoahum <- dpcoa(data.frame(t(humDNAm$samples)), sqrt(humDNAm$distances), scan = FALSE, nf = 2)
randtest(dpcoahum)
#> Monte-Carlo test
#> Call: randtest.dpcoa(xtest = dpcoahum)
#> 
#> Observation: 0.2167909 
#> 
#> Based on 99 replicates
#> Simulated p-value: 0.05 
#> Alternative hypothesis: greater 
#> 
#>      Std.Obs  Expectation     Variance 
#> 1.9526484914 0.1644421414 0.0007187271 
```
