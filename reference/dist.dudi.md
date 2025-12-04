# Computation of the Distance Matrix from a Statistical Triplet

computes for a statistical triplet a distance matrix.

## Usage

``` r
dist.dudi(dudi, amongrow = TRUE)
```

## Arguments

- dudi:

  a duality diagram, object of class `dudi`

- amongrow:

  a logical value computing the distance if TRUE, between rows, if FALSE
  between columns.

## Value

an object of class `dist`

## Author

Daniel Chessel  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
data (meaudret)
pca1 <- dudi.pca(meaudret$env, scan = FALSE)
sum((dist(scalewt(meaudret$env)) - dist.dudi(pca1))^2)
#> [1] 3.85679e-29
#[1] 4.045e-29 the same thing
```
