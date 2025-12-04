# K-tables of wine-tasting

This data set describes 27 characteristics of 21 wines distributed in
four fields : rest, visual, olfactory and global.

## Usage

``` r
data(escopage)
```

## Format

`escopage` is a list of 3 components.

- tab:

  is a data frame with 21 observations (wines) and 27 variables.

- tab.names:

  is the vector of the names of sub-tables : "rest" "visual" "olfactory"
  "global".

- blo:

  is a vector of the numbers of variables for each sub-table.

## Source

Escofier, B. and Pagès, J. (1990) *Analyses factorielles simples et
multiples : objectifs, méthodes et interprétation* Dunod, Paris. 1–267.

Escofier, B. and Pagès, J. (1994) Multiple factor analysis (AFMULT
package). *Computational Statistics and Data Analysis*, **18**, 121–140.

## Examples

``` r
data(escopage)
w <- data.frame(scale(escopage$tab))
w <- ktab.data.frame(w, escopage$blo)
names(w)[1:4] <- escopage$tab.names
plot(mfa(w, scan = FALSE))
#> Error in eval(thecall$fac, envir = sys.frame(sys.nframe() + pos)): object 'w' not found
```
