# Wine Tasting

The `bordeaux` data frame gives the opinions of 200 judges in a blind
tasting of five different types of claret (red wine from the Bordeaux
area in the south western parts of France).

## Usage

``` r
data(bordeaux)
```

## Format

This data frame has 5 rows (the wines) and 4 columns (the judgements)
divided in excellent, good, mediocre and boring.

## Source

van Rijckevorsel, J. (1987) *The application of fuzzy coding and
horseshoes in multiple correspondence analysis*. DSWO Press, Leiden (p.
32)

## Examples

``` r
data(bordeaux)
bordeaux
#>                    excellent good mediocre boring
#> Cru_Bourgeois             45  126       24      5
#> Grand_Cru_classe          87   93       19      1
#> Vin_de_table               0    0       52    148
#> Bordeaux_d_origine        36   68       74     22
#> Vin_de_marque              0   30      111     59
score(dudi.coa(bordeaux, scan = FALSE))
```
