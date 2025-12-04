# Genetic variability of Cacadors

This data set contains information about genetic variability of *Atya
innocous* and *Atya scabra* in Guadeloupe (France).

## Usage

``` r
data(atya)
```

## Format

`atya` is a list with the following components:

- xy:

  a data frame with the coordinates of the 31 sites

- gen:

  a data frame with 22 variables collected on 31 sites

- nb:

  a neighborhood object (class `nb` defined in package `spdep`)

## Source

Fievet, E., Eppe, F. and Dolédec, S. (2001) Etude de la variabilité
morphométrique et génétique des populations de Cacadors (*Atya innocous*
et *Atya scabra*) de l'île de Basse-Terre. Direction Régionale de
L'Environnement Guadeloupe, Laboratoire des hydrosystèmes fluviaux,
Université Lyon 1.

## Examples

``` r
if (FALSE) { # \dontrun{
data(atya)
if(requireNamespace("pixmap", quietly = TRUE)) {
  atya.digi <- pixmap::read.pnm(system.file("pictures/atyadigi.pnm",
      package = "ade4"))
  atya.carto <- pixmap::read.pnm(system.file("pictures/atyacarto.pnm",
      package = "ade4"))
  par(mfrow = c(1, 2))
  pixmap:::plot(atya.digi)
  pixmap:::plot(atya.carto)
  points(atya$xy, pch = 20, cex = 2)
}
if(requireNamespace("spdep", quietly = TRUE)) {
  plot(atya$nb, atya$xy, col = "red", add = TRUE, lwd = 2)
  par(mfrow = c(1,1))
}
} # }
```
