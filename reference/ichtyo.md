# Point sampling of fish community

This data set gives informations between a faunistic array, the total
number of sampling points made at each sampling occasion and the year of
the sampling occasion.

## Usage

``` r
data(ichtyo)
```

## Format

`ichtyo` is a list of 3 components.

- tab:

  is a faunistic array with 9 columns and 32 rows.

- eff:

  is a vector of the 32 sampling effort.

- dat:

  is a factor where the levels are the 10 years of the sampling
  occasion.

## Details

The value *n(i,j)* at the *ith* row and the *jth* column in `tab`
corresponds to the number of sampling points of the *ith* sampling
occasion (in `eff`) that contains the *jth* species.

## Source

Dolédec, S., Chessel, D. and Olivier, J. M. (1995) L'analyse des
correspondances décentrée: application aux peuplements ichtyologiques du
haut-Rhône. *Bulletin Français de la Pêche et de la Pisciculture*,
**336**, 29–40.

## Examples

``` r
data(ichtyo)
dudi1 <- dudi.dec(ichtyo$tab, ichtyo$eff, scannf = FALSE)
#> Warning: coercing argument of type 'double' to logical
s.class(dudi1$li, ichtyo$dat, wt = ichtyo$eff / sum(ichtyo$eff))
```
