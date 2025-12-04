# Monte-Carlo Test on the percentage of explained (i.e. constrained) inertia

Performs a Monte-Carlo test on on the percentage of explained (i.e.
constrained) inertia. The statistic is the ratio of the inertia (sum of
eigenvalues) of the constrained analysis divided by the inertia of the
unconstrained analysis.

## Usage

``` r
# S3 method for class 'pcaiv'
randtest(xtest, nrepet = 99, ...)
# S3 method for class 'pcaivortho'
randtest(xtest, nrepet = 99, ...)
```

## Arguments

- xtest:

  an object of class `pcaiv`, `pcaivortho` or `caiv`

- nrepet:

  the number of permutations

- ...:

  further arguments passed to or from other methods

## Value

a list of the class `randtest`

## Author

Stéphane Dray <stephane.dray@univ-lyon1.fr>, original code by Raphaël
Pélissier

## Examples

``` r
data(rpjdl)
millog <- log(rpjdl$mil + 1)
coa1 <- dudi.coa(rpjdl$fau, scann = FALSE)
caiv1 <- pcaiv(coa1, millog, scan = FALSE)
randtest(caiv1)
#> Monte-Carlo test
#> Call: randtest.pcaiv(xtest = caiv1)
#> 
#> Observation: 0.2520234 
#> 
#> Based on 99 replicates
#> Simulated p-value: 0.01 
#> Alternative hypothesis: greater 
#> 
#>      Std.Obs  Expectation     Variance 
#> 3.899993e+01 4.529693e-02 2.809731e-05 
```
