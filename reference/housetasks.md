# Contingency Table

The `housetasks` data frame gives 13 housetasks and their repartition in
the couple.

## Usage

``` r
data(housetasks)
```

## Format

This data frame contains four columns : wife, alternating, husband and
jointly. Each column is a numeric vector.

## Source

Kroonenberg, P. M. and Lombardo, R. (1999) Nonsymmetric correspondence
analysis: a tool for analysing contingency tables with a dependence
structure. *Multivariate Behavioral Research*, **34**, 367–396

## Examples

``` r
data(housetasks)
nsc1 <- dudi.nsc(housetasks, scan = FALSE)

if(adegraphicsLoaded()) {
  s.label(nsc1$c1, plab.cex = 1.25)
  s.arrow(nsc1$li, add = TRUE, plab.cex = 0.75)
} else {
  s.label(nsc1$c1, clab = 1.25)
  s.arrow(nsc1$li, add.pl = TRUE, clab = 0.75) 
}
```
