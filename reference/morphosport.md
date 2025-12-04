# Athletes' Morphology

This data set gives a morphological description of 153 athletes split in
five different sports.

## Usage

``` r
data(morphosport)
```

## Format

`morphosport` is a list of 2 objects.

- tab:

  is a data frame with 153 athletes and 5 variables.

- sport:

  is a factor with 6 items

## Details

Variables of `morphosport$tab` are the following ones: dbi (biacromial
diameter (cm)), tde (height (cm)), tas (distance from the buttocks to
the top of the head (cm)), lms (length of the upper limbs (cm)), poids
(weigth (kg)).  

The levels of `morphosport$sport` are: athl (athletics), foot
(football), hand (handball), judo, nata (swimming), voll (volleyball).

## Source

Mimouni , N. (1996) *Contribution de méthodes biométriques à l'analyse
de la morphotypologie des sportifs*. Thèse de doctorat. Université Lyon
1.

## Examples

``` r
data(morphosport)
plot(discrimin(dudi.pca(morphosport$tab, scan = FALSE), 
    morphosport$sport, scan = FALSE))
```
