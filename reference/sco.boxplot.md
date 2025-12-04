# Representation of the link between a variable and a set of qualitative variables

represents the link between a variable and a set of qualitative
variables.

## Usage

``` r
sco.boxplot(score, df, labels = names(df), clabel = 1, xlim = NULL, 
    grid = TRUE, cgrid = 0.75, include.origin = TRUE, origin = 0, 
    sub = NULL, csub = 1)
```

## Arguments

- score:

  a numeric vector

- df:

  a data frame with only factors

- labels:

  a vector of strings of characters for the labels of variables

- clabel:

  if not NULL, a character size for the labels, used with
  `par("cex")*clabel`

- xlim:

  the ranges to be encompassed by the x axis, if NULL they are computed

- grid:

  a logical value indicating whether the scale vertical lines should be
  drawn

- cgrid:

  a character size, parameter used with `par("cex")*cgrid` to indicate
  the mesh of the scale

- include.origin:

  a logical value indicating whether the point "origin" should be
  belonged to the graph space

- origin:

  the fixed point in the graph space, for example 0 the origin axis

- sub:

  a string of characters to be inserted as legend

- csub:

  a character size for the legend, used with `par("cex")*csub`

## Author

Daniel Chessel

## Examples

``` r
w1 <- rnorm(100,-1)
w2 <- rnorm(100)
w3 <- rnorm(100,1)
f1 <- gl(3,100)
f2 <- gl(30,10)
sco.boxplot(c(w1,w2,w3), data.frame(f1,f2))


data(banque)
banque.acm <- dudi.acm(banque, scan = FALSE, nf = 4)
par(mfrow = c(1,3))
sco.boxplot(banque.acm$l1[,1], banque[,1:7], clab = 1.8)
sco.boxplot(banque.acm$l1[,1], banque[,8:14], clab = 1.8)
sco.boxplot(banque.acm$l1[,1], banque[,15:21], clab = 1.8)

par(mfrow = c(1,1))
```
