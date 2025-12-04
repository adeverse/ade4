# Vegetation in Trois-Fontaines

This data set contains abundance values (Braun-Blanquet scale) of 80
plant species for 337 sites. Data have been collected by Sonia Said and
Francois Debias.

## Usage

``` r
data(vegtf)
```

## Format

`vegtf` is a list with the following components:

- veg:

  a data.frame with the abundance values of 80 species (columns) in 337
  sites (rows)

- xy:

  a data.frame with the spatial coordinates of the sites

- area:

  a data.frame (area) which define the boundaries of the study site

- sp.names:

  a vector containing the species latin names

- nb:

  a neighborhood object (class `nb` defined in package `spdep`)

- Spatial:

  an object of the class `SpatialPolygons` of `sp`, containing the map

## Source

Dray, S., Said, S. and Debias, F. (2008) Spatial ordination of
vegetation data using a generalization of Wartenberg's multivariate
spatial correlation. *Journal of vegetation science*, **19**, 45–56.

## Examples

``` r
if(requireNamespace("spdep", quietly = TRUE) & requireNamespace("adespatial", quietly = TRUE)) {
  data(vegtf)
  coa1 <- dudi.coa(vegtf$veg, scannf = FALSE)
  ms.coa1 <- adespatial::multispati(coa1, listw = spdep::nb2listw(vegtf$nb), nfposi = 2, 
    nfnega = 0, scannf = FALSE)
  summary(ms.coa1)
  plot(ms.coa1)
  
  if(adegraphicsLoaded()) {
    g1 <- s.value(vegtf$xy, coa1$li[, 1], Sp = vegtf$Spatial, pSp.col = "white", plot = FALSE)
    g2 <- s.value(vegtf$xy, ms.coa1$li[, 1], Sp = vegtf$Spatial, pSp.col = "white", plot = FALSE)
    g3 <- s.label(coa1$c1, plot = FALSE)
    g4 <- s.label(ms.coa1$c1, plot = FALSE)
    G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
  } else {
    par(mfrow = c(2, 2))
    s.value(vegtf$xy, coa1$li[, 1], area = vegtf$area, include.origin = FALSE)
    s.value(vegtf$xy, ms.coa1$li[, 1], area = vegtf$area, include.origin = FALSE)
    s.label(coa1$c1)
    s.label(ms.coa1$c1)
  }
}
#> 
#> Multivariate Spatial Analysis
#> Call: adespatial::multispati(dudi = coa1, listw = spdep::nb2listw(vegtf$nb), 
#>     scannf = FALSE, nfposi = 2, nfnega = 0)
#> 
#> Scores from the initial duality diagram:
#>           var       cum      ratio      moran
#> RS1 0.5237982 0.5237982 0.04018794 0.08653081
#> RS2 0.4852328 1.0090310 0.07741699 0.08012944
#> 
#> Multispati eigenvalues decomposition:
#>           eig       var    moran
#> CS1 0.1689640 0.4047914 0.417410
#> CS2 0.1306298 0.3131971 0.417085
#> Error in s.match(dfxy1 = ms.coa1$li, dfxy2 = ms.coa1$ls, xax = 1, yax = 2,     plot = FALSE, storeData = TRUE, pos = -3, psub = list(text = "Scores and lag scores")): non convenient selection for dfxy1 or dfxy2 (can not be converted to dataframe)
```
