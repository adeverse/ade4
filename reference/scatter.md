# Graphical representation of the outputs of a multivariate analysis

`scatter` is a generic function that has methods for the classes `coa`,
`dudi`, `fca`, `acm` and `pco`. It plots the outputs of a multivariate
analysis by representing simultaneously the rows and the colums of the
original table (biplot). The function `biplot` returns exactly the same
representation.  
The function `screeplot` represents the amount of inertia (usually
variance) associated to each dimension.

## Usage

``` r
scatter(x, ...)
# S3 method for class 'dudi'
biplot(x, ...)
# S3 method for class 'dudi'
screeplot(x, npcs = length(x$eig), type = c("barplot", "lines"), 
    main = deparse(substitute(x)), col = c(rep("black", x$nf),
rep("grey", npcs - x$nf)), ...)
```

## Arguments

- x:

  an object of the class `dudi` containing the outputs of a multivariate
  analysis

- npcs:

  the number of components to be plotted

- type:

  the type of plot

- main:

  the title of the plot

- col:

  a vector of colors

- ...:

  further arguments passed to or from other methods

## See also

[`s.arrow`](s.arrow.md), [`s.chull`](s.chull.md),
[`s.class`](s.class.md), [`s.corcircle`](s.corcircle.md),
[`s.distri`](s.distri.md), [`s.label`](s.label.md),
[`s.match`](s.match.md), [`s.traject`](s.traject.md),
[`s.value`](s.value.md), [`add.scatter`](add.scatter.md)

## Author

Daniel Chessel  
Stéphane Dray <stephane.dray@univ-lyon1.fr>

## Examples

``` r
data(rpjdl)
rpjdl.coa <- dudi.coa(rpjdl$fau, scannf = FALSE, nf = 4)
screeplot(rpjdl.coa)
#> Error in eval(thecall$score, envir = sys.frame(sys.nframe() + pos)): object 'rpjdl.coa' not found
biplot(rpjdl.coa)
#> Error in biplot.dudi(rpjdl.coa): object 'rpjdl.coa' not found
```
