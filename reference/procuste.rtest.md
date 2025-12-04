# Monte-Carlo Test on the sum of the singular values of a procustean rotation (in R).

performs a Monte-Carlo Test on the sum of the singular values of a
procustean rotation.

## Usage

``` r
procuste.rtest(df1, df2, nrepet = 99, ...)
```

## Arguments

- df1:

  a data frame

- df2:

  a data frame

- nrepet:

  the number of permutations

- ...:

  further arguments passed to or from other methods

## Value

returns a list of class `rtest`

## References

Jackson, D.A. (1995) PROTEST: a PROcustean randomization TEST of
community environment concordance. *Ecosciences*, **2**, 297–303.

## Author

Daniel Chessel  
Anne-Béatrice Dufour <anne-beatrice.dufour@univ-lyon1.fr>

## Examples

``` r
data(doubs)
pca1 <- dudi.pca(doubs$env, scal = TRUE, scann = FALSE)
pca2 <- dudi.pca(doubs$fish, scal = FALSE, scann = FALSE)
proc1 <- procuste(pca1$tab, pca2$tab)
protest1 <- procuste.rtest(pca1$tab, pca2$tab, 999)
protest1
#> Monte-Carlo test
#> Call: procuste.rtest(df1 = pca1$tab, df2 = pca2$tab, nrepet = 999)
#> 
#> Observation: 0.6562 
#> 
#> Based on 999 replicates
#> Simulated p-value: 0.001 
#> Alternative hypothesis: greater 
#> 
#>     Std.Obs Expectation    Variance 
#> 6.552568740 0.342274191 0.002295254 
plot(protest1)
```
