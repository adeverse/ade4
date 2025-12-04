# Tests of randomization on the correlation between two distance matrices (in R).

performs a RV Test between two distance matrices.

## Usage

``` r
RVdist.randtest(m1, m2, nrepet = 999, ...)
```

## Arguments

- m1, m2:

  two Euclidean matrices

- nrepet:

  the number of permutations

- ...:

  further arguments passed to or from other methods

## Value

returns a list of class 'randtest'

## References

Heo, M. & Gabriel, K.R. (1997) A permutation test of association between
configurations by means of the RV coefficient. Communications in
Statistics - Simulation and Computation, **27**, 843-856.

## Author

Daniel Chessel
