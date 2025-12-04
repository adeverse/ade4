# Distribution of of tropical trees along the Panama canal

Abundance of tropical trees, environmental variables and spatial
coordinates for 50 sites. Data are available at
[doi:10.1126/science.1066854](https://doi.org/10.1126/science.1066854)
but plots from Barro Colorado Island were removed.

## Usage

``` r
data(pcw)
```

## Format

A list with 5 components.

- spe:

  Distribution of the abundances of 778 species in 50 sites

- env:

  Measurements of environmental variables for the 50 sites

- xy:

  Spatial coordinates for the sites (decimal degrees)

- xy.utm:

  Spatial coordinates for the sites (UTM)

- map:

  Map of the study area stored as a SpatialPolygons object

## Source

Condit, R., N. Pitman, E. G. Leigh, J. Chave, J. Terborgh, R. B. Foster,
P. Núnez, S. Aguilar, R. Valencia, G. Villa, H. C. Muller-Landau, E.
Losos, and S. P. Hubbell. (2002) Beta-diversity in tropical forest
trees. *Science*, **295**, 666-669.

Pyke, C. R., R. Condit, S. Aguilar, and S. Lao. (2001) Floristic
composition across a climatic gradient in a neotropical lowland forest.
*Journal of Vegetation Science*, **12**, 553–566.

## References

Dray, S., R. Pélissier, P. Couteron, M. J. Fortin, P. Legendre, P. R.
Peres-Neto, E. Bellier, R. Bivand, F. G. Blanchet, M. De Caceres, A. B.
Dufour, E. Heegaard, T. Jombart, F. Munoz, J. Oksanen, J. Thioulouse,
and H. H. Wagner. (2012) Community ecology in the age of multivariate
multiscale spatial analysis. *Ecological Monographs*, **82**, 257–275.

## Examples

``` r
if(adegraphicsLoaded()) {
  data(pcw)
  if(requireNamespace("spdep", quietly = TRUE)) {
    nb1 <- spdep::graph2nb(spdep::gabrielneigh(pcw$xy.utm), sym = TRUE) 
    s.label(pcw$xy, nb = nb1, Sp = pcw$map)
  }
}
```
