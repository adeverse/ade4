# Graph to Analyse the Relation between a Score and Quantitative Variables

represents the graphs to analyse the relation between a score and
quantitative variables.

## Usage

``` r
sco.quant (score, df, fac = NULL, clabel = 1, abline = FALSE, 
    sub = names(df), csub = 2, possub = "topleft")
```

## Arguments

- score:

  a numeric vector

- df:

  a data frame which rows equal to the score length

- fac:

  a factor with the same length than the score

- clabel:

  character size for the class labels (if any) used with
  `par("cex")*clabel`

- abline:

  a logical value indicating whether a regression line should be added

- sub:

  a vector of strings of characters for the labels of variables

- csub:

  a character size for the legend, used with `par("cex")*csub`

- possub:

  a string of characters indicating the sub-title position ("topleft",
  "topright", "bottomleft", "bottomright")

## Author

Daniel Chessel

## Examples

``` r
w <- runif(100, -5, 10)
fw <- cut (w, 5)
levels(fw) <- LETTERS[1:5]
wX <- data.frame(matrix(w + rnorm(900, sd = (1:900) / 100), 100, 9))
sco.quant(w, wX, fac = fw, abline = TRUE, clab = 2, csub = 3)
```
