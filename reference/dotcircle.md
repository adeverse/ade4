# Representation of n values on a circle

This function represents *n* values on a circle. The *n* points are
shared out regularly over the circle and put on the radius according to
the value attributed to that measure.

## Usage

``` r
dotcircle(z, alpha0 = pi/2, xlim = range(pretty(z)),
 labels = names(z), clabel = 1, cleg = 1)
```

## Arguments

- z:

  : a numeric vector

- alpha0:

  : polar angle to put the first value

- xlim:

  : the ranges to be encompassed by the circle radius

- labels:

  : a vector of strings of characters for the angle labels

- clabel:

  : a character size for the labels, used with `par("cex")*clabel`

- cleg:

  : a character size for the ranges, used with `par("cex")*cleg`

## See also

[`circ.plot`](https://rdrr.io/pkg/CircStats/man/circ.plot.html)

## Author

Daniel Chessel

## Examples

``` r
w <- scores.neig(neig(n.cir = 24))
par(mfrow = c(4,4))
for (k in 1:16) dotcircle(w[,k],labels = 1:24)

par(mfrow = c(1,1))
```
