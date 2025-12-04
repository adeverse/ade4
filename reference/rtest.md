# Class of the Permutation Tests (in R).

rtest is a generic function. It proposes methods for the following
objects `between`, `discrimin`, `procuste` `...`  

## Usage

``` r
rtest(xtest, ...)
```

## Arguments

- xtest:

  an object used to select a method

- ...:

  further arguments passed to or from other methods; in `plot.randtest`
  to `hist`

## Value

`rtest` returns an object of class `randtest`

## See also

[`RV.rtest`](RV.rtest.md), [`mantel.rtest`](mantel.rtest.md),
[`procuste.rtest`](procuste.rtest.md), [`randtest`](randtest.md)

## Author

Daniel Chessel

## Examples

``` r
par(mfrow = c(2, 2))
for (x0 in c(2.4, 3.4, 5.4, 20.4)) {
    l0 <- as.randtest(sim = rnorm(200), obs = x0)
    print(l0)
    plot(l0, main = paste("p.value = ", round(l0$pvalue, dig = 5)))
}
#> Monte-Carlo test
#> Call: as.randtest(sim = rnorm(200), obs = x0)
#> 
#> Observation: 2.4 
#> 
#> Based on 200 replicates
#> Simulated p-value: 0.009950249 
#> Alternative hypothesis: greater 
#> 
#>     Std.Obs Expectation    Variance 
#>   2.4054920   0.1220573   0.8967632 

#> Monte-Carlo test
#> Call: as.randtest(sim = rnorm(200), obs = x0)
#> 
#> Observation: 3.4 
#> 
#> Based on 200 replicates
#> Simulated p-value: 0.009950249 
#> Alternative hypothesis: greater 
#> 
#>     Std.Obs Expectation    Variance 
#>  3.46897685  0.02514383  0.94647193 

#> Monte-Carlo test
#> Call: as.randtest(sim = rnorm(200), obs = x0)
#> 
#> Observation: 5.4 
#> 
#> Based on 200 replicates
#> Simulated p-value: 0.004975124 
#> Alternative hypothesis: greater 
#> 
#>      Std.Obs  Expectation     Variance 
#>  5.012020453 -0.009415846  1.164863584 

#> Monte-Carlo test
#> Call: as.randtest(sim = rnorm(200), obs = x0)
#> 
#> Observation: 20.4 
#> 
#> Based on 200 replicates
#> Simulated p-value: 0.004975124 
#> Alternative hypothesis: greater 
#> 
#>     Std.Obs Expectation    Variance 
#> 22.54257225 -0.01150032  0.81986607 

par(mfrow = c(1, 1))
```
