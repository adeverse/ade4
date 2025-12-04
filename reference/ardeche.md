# Fauna Table with double (row and column) partitioning

This data set gives information about species of benthic
macroinvertebrates in different sites and dates.

## Usage

``` r
data(ardeche)
```

## Format

`ardeche` is a list with 6 components.

- tab:

  is a data frame containing fauna table with 43 species (rows) and 35
  samples (columns).

- col.blocks:

  is a vector containing the repartition of samples for the 6 dates :
  july 1982, august 1982, november 1982, february 1983, april 1983 and
  july 1983.

- row.blocks:

  is a vector containing the repartition of species in the 4 groups
  defining the species order.

- dat.fac:

  is a date factor for samples (6 dates).

- sta.fac:

  is a site factor for samples (6 sites).

- esp.fac:

  is a species order factor (Ephemeroptera, Plecoptera, Coleoptera,
  Trichoptera).

## Details

The columns of the data frame `ardeche$tab` define the samples by a
number between 1 and 6 (the date) and a letter between A and F (the
site).

## Source

Cazes, P., Chessel, D., and Dolédec, S. (1988) L'analyse des
correspondances internes d'un tableau partitionné : son usage en
hydrobiologie. *Revue de Statistique Appliquée*, **36**, 39–54.

## Examples

``` r
data(ardeche)
dudi1 <- dudi.coa(ardeche$tab, scan = FALSE)
s.class(dudi1$co, ardeche$dat.fac)
if(adegraphicsLoaded()) {
  s.label(dudi1$co, plab.cex = 0.5, add = TRUE)
} else {
  s.label(dudi1$co, clab = 0.5, add.p = TRUE)
}
```
