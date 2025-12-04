# Monte-Carlo Test on the sum of eigenvalues of a co-inertia analysis (in R).

performs a Monte-Carlo Test on the sum of eigenvalues of a co-inertia
analysis.

## Usage

``` r
RV.rtest(df1, df2, nrepet = 99, ...)
```

## Arguments

- df1, df2:

  two data frames with the same rows

- nrepet:

  the number of permutations

- ...:

  further arguments passed to or from other methods

## Value

returns a list of class 'rtest'

## References

Heo, M. & Gabriel, K.R. (1997) A permutation test of association between
configurations by means of the RV coefficient. Communications in
Statistics - Simulation and Computation, **27**, 843-856.

## Author

Daniel Chessel

## Examples

``` r
data(doubs)
pca1 <- dudi.pca(doubs$env, scal = TRUE, scann = FALSE)
pca2 <- dudi.pca(doubs$fish, scal = FALSE, scann = FALSE)
rv1 <- RV.rtest(pca1$tab, pca2$tab, 99)
rv1
#> Monte-Carlo test
#> Call: RV.rtest(df1 = pca1$tab, df2 = pca2$tab, nrepet = 99)
#> 
#> Observation: 0.4505569 
#> 
#> Based on 99 replicates
#> Simulated p-value: 0.01 
#> Alternative hypothesis: greater 
#> 
#>     Std.Obs Expectation    Variance 
#> 7.615218306 0.088467137 0.002260829 
plot(rv1)
```
