# A table of Qualitative Variables

The `ours` (bears) data frame has 38 rows, areas of the "Inventaire
National Forestier", and 10 columns.

## Usage

``` r
data(ours)
```

## Format

This data frame contains the following columns:

1.  altit: importance of the altitudinal area inhabited by bears, a
    factor with levels:

    - `1` less than 50% of the area between 800 and 2000 meters

    - `2` between 50 and 70%

    - `3` more than 70%

2.  deniv: importance of the average variation in level by square of 50
    km2, a factor with levels:

    - `1` less than 700m

    - `2` between 700 and 900 m

    - `3` more than 900 m

3.  cloiso: partitioning of the massif, a factor with levels:

    - `1` a great valley or a ridge isolates at least a quarter of the
      massif

    - `2` less than a quarter of the massif is isolated

    - `3` the massif has no split

4.  domain: importance of the national forests on contact with the
    massif, a factor with levels:

    - `1` less than 400 km2

    - `2` between 400 and 1000 km2

    - `3` more than 1000 km2

5.  boise: rate of afforestation, a factor with levels:

    - `1` less than 30%

    - `2` between 30 and 50%

    - `3` more than 50%

6.  hetra: importance of plantations and mixed forests, a factor with
    levels:

    - `1` less than 5%

    - `2` between 5 and 10%

    - `3` more than 10% of the massif

7.  favor: importance of favorable forests, plantations, mixed forests,
    fir plantations, a factor with levels:

    - `1` less than 5%

    - `2` between 5 and 10%

    - `3` more than 10% of the massif

8.  inexp: importance of unworked forests, a factor with levels:

    - `1` less than 4%

    - `2` between 4 and 8%

    - `3` more than 8% of the total area

9.  citat: presence of the bear before its disappearance, a factor with
    levels:

    - `1` no quotation since 1840

    - `2` 1 to 3 quotations before 1900 and none after

    - `3` 4 quotations before 1900 and none after

    - `4` at least 4 quotations before 1900 and at least 1 quotation
      between 1900 and 1940

10. depart: district, a factor with levels:

    - `AHP` Alpes-de-Haute-Provence

    - `AM` Alpes-Maritimes

    - `D` Drôme

    - `HP` Hautes-Alpes

    - `HS` Haute-Savoie

    - `I` Isère

    - `S` Savoie

## Source

Erome, G. (1989) *L'ours brun dans les Alpes françaises. Historique de
sa disparition*. Centre Ornithologique Rhône-Alpes, Villeurbanne. 120 p.

## Examples

``` r
data(ours)
if(adegraphicsLoaded()) {
  s1d.boxplot(dudi.acm(ours, scan = FALSE)$l1[, 1], ours)
} else {
  boxplot(dudi.acm(ours, scan = FALSE))
}
```
