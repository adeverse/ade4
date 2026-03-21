# Class of the Permutation Tests (in C).

Plot, print and extract permutation tests. Objects of class
`'krandtest'` are lists.

## Usage

``` r
as.krandtest(sim, obs, alter = "greater", call = match.call(),
  names = colnames(sim), p.adjust.method = "none", output = c("light", "full"))

# S3 method for class 'krandtest'
plot(x, mfrow = NULL, nclass = 10, main.title = x$names, ...)
# S3 method for class 'krandtest'
print(x, ...)
# S3 method for class 'krandtest'
x[i]
# S3 method for class 'krandtest'
x[[i]]
```

## Arguments

- sim:

  a matrix or data.frame of simulated values (repetitions as rows,
  number of tests as columns

- obs:

  a numeric vector of observed values for each test

- alter:

  a vector of character specifying the alternative hypothesis for each
  test. Each element must be one of "greater" (default), "less" or
  "two-sided". The length must be equal to the length of the vector obs,
  values are recycled if shorter.

- call:

  a call order

- names:

  a vector of names for tests

- p.adjust.method:

  a string indicating a method for multiple adjustment, see
  `p.adjust.methods` for possible choices.

- output:

  a character string specifying if all simulations should be stored
  (`"full"`). This was the default until `ade4` 1.7-5. Now, by default
  (`"light"`), only the distribution of simulated values is stored in
  element `plot` as produced by the `hist` function.

- x:

  an object of class `'krandtest'`

- mfrow:

  a vector of the form 'c(nr,nc)', otherwise computed by as special own
  function `n2mfrow`

- nclass:

  a number of intervals for the histogram. Ignored if object output is
  `"light"`

- main.title:

  a string of character for the main title

- ...:

  further arguments passed to or from other methods

- i:

  numeric indices specifying elements to extract

## Value

`plot.krandtest` draws the *p* simulated values histograms and the
position of the observed value. `[.krandtest` returns a `krandtest`
object and `[[.krandtest` returns a `randtest` object.

## Author

Daniel Chessel and Stéphane Dray <stephane.dray@univ-lyon1.fr>

## See also

[`randtest`](randtest.md)

## Examples

``` r
wkrandtest <- as.krandtest(obs = c(0, 1.2, 2.4, 3.4, 5.4, 20.4), 
  sim = matrix(rnorm(6*200), 200, 6))
wkrandtest
#> class: krandtest lightkrandtest 
#> Monte-Carlo tests
#> Call: as.krandtest(sim = matrix(rnorm(6 * 200), 200, 6), obs = c(0, 
#>     1.2, 2.4, 3.4, 5.4, 20.4))
#> 
#> Number of tests:   6 
#> 
#> Adjustment method for multiple comparisons:   none 
#> Permutation number:   200 
#>    Test  Obs     Std.Obs   Alter      Pvalue
#> 1 test1  0.0 -0.05855639 greater 0.562189055
#> 2 test2  1.2  1.25489519 greater 0.114427861
#> 3 test3  2.4  2.37133502 greater 0.014925373
#> 4 test4  3.4  3.34558664 greater 0.004975124
#> 5 test5  5.4  5.56073080 greater 0.004975124
#> 6 test6 20.4 18.78122846 greater 0.004975124
#> 
plot(wkrandtest)

wkrandtest[c(1, 4, 6)]
#> class: krandtest lightkrandtest 
#> Monte-Carlo tests
#> Call: `[.krandtest`(x = wkrandtest, i = c(1, 4, 6))
#> 
#> Number of tests:   3 
#> 
#> Adjustment method for multiple comparisons:   none 
#> Permutation number:   200 
#>    Test  Obs     Std.Obs   Alter      Pvalue
#> 1 test1  0.0 -0.05855639 greater 0.562189055
#> 2 test4  3.4  3.34558664 greater 0.004975124
#> 3 test6 20.4 18.78122846 greater 0.004975124
#> 
wkrandtest[[1]]
#> Monte-Carlo test
#> Call: `[[.krandtest`(x = wkrandtest, i = 1)
#> 
#> Observation: 0 
#> 
#> Based on 200 replicates
#> Simulated p-value: 0.5621891 
#> Alternative hypothesis: greater 
#> 
#>       Std.Obs Expectation  Variance
#> 1 -0.05855639  0.05805514 0.9914399
```
