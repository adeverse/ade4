# Array of Recapture of Rings

The data frame `sarcelles$tab` contains the number of the winter teals
(*Anas C. Crecca*) for which the ring was retrieved in the area *i*
during the month *j* (*n*=3049).

## Usage

``` r
data(sarcelles)
```

## Format

`sarcelles` is a list with the following components:

- tab:

  a data frame with 14 rows-areas and 12 columns-months

- xy:

  a data frame with the 2 spatial coordinates of the 14 region centers

- col.names:

  a vector containing the month items

- nb:

  a neighborhood object (class `nb` defined in package `spdep`)

## Source

Lebreton, J.D. (1973). Etude des déplacements saisonniers des Sarcelles
d'hiver, Anas c. crecca L., hivernant en Camargue à l'aide de l'analyse
factorielle des correspondances. *Compte rendu hebdomadaire des séances
de l'Académie des sciences*, Paris, D, III, **277**, 2417–2420.

## Examples

``` r
if (FALSE) { # \dontrun{
if(!adegraphicsLoaded()) {
  # depends of pixmap
  if(requireNamespace("pixmap", quietly = TRUE)) {
    bkgnd.pnm <- pixmap::read.pnm(system.file("pictures/sarcelles.pnm", package = "ade4"))
    data(sarcelles)
    par(mfrow = c(4, 3))
    for(i in 1:12) {
      s.distri(sarcelles$xy, sarcelles$tab[, i], pixmap = bkgnd.pnm, 
       sub = sarcelles$col.names[i], clab = 0, csub = 2)
      s.value(sarcelles$xy, sarcelles$tab[, i], add.plot = TRUE, cleg = 0)
    }
    par(mfrow = c(1, 1))
  }
}} # }
```
