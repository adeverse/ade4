# Leave-one-out cross-validation for a `dudi`

Leave-one-out cross-validation to check the dispersion of row
coordinates in a `dudi`.

## Usage

``` r
# S3 method for class 'dudi'
loocv(x, progress = FALSE, ...)
```

## Arguments

- x:

  the dudi of the `bca` on which cross-validation should be done

- progress:

  logical to display a progress bar during computations (see the
  `progress` package)

- ...:

  further arguments passed to or from other methods

## Details

This function does a cross-validation of the row coordinates of a dudi.
Each row is removed from the table one at a time, and its coordinates
are computed by projection of this row in the analysis of the table with
the removed row. This can be used to check the sensitivity of an
analysis to outliers. The cross-validated and original coordinates can
be compared with the `s.match` function (see example).

## Value

A list with:- `XValCoord`: the cross-validated row coordinates -
`PRESS`: the Predicted Residual Error Sum for each row- `PRESSTot`: the
sum of `PRESS` for each `bca` axis

## Author

Jean Thioulouse

## See also

[loocv.between](loocv.bca.md), [loocv.discrimin](loocv.discrimin.md),
[suprow](suprow.md), [s.match](s.match.md)

## Examples

``` r
data(meaudret)
envpca <- dudi.pca(meaudret$env, scannf = FALSE, nf = 3)
xvpca <- loocv(envpca)
s.match(envpca$li, xvpca$XValCoord)
```
