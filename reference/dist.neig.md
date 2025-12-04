# Computation of the Distance Matrix associated to a Neighbouring Graph

This distance matrix between two points is the length of the shortest
path between these points.

## Usage

``` r
dist.neig(neig)
```

## Arguments

- neig:

  a neighbouring graph, object of class `neig`

## Value

returns a distance matrix, object of class `dist`

## Author

Daniel Chessel  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
    data(elec88)
    d0 <- dist.neig(nb2neig(elec88$nb))
    plot(dist(elec88$xy),d0)
```
