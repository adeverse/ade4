# Road distances in New-Zealand

This data set gives the road distances between 13 towns in New-Zealand.

## Usage

``` r
data(zealand)
```

## Format

`zealand` is a list with the following components:

- road:

  a data frame with 13 rows (New Zealand towns) and 13 columns (New
  Zealand towns) containing the road distances between these towns

- xy:

  a data frame containing the coordinates of the 13 towns

- nb:

  a neighborhood object (class `nb` defined in package `spdep`)

## Source

Manly, B.F. (1994). *Multivariate Statistical Methods. A primer.*,
Second edition, Chapman and Hall, London, 1–215, page 172.

## Examples

``` r
data(zealand)
d0 <- as.dist(as.matrix(zealand$road))
d1 <- cailliez (d0)
d2 <- lingoes(d0)

if(adegraphicsLoaded()) {
  G1 <- s.label(zealand$xy, lab = as.character(1:13), nb = zealand$nb)
  
  g1 <- s.label(cmdscale(dist(zealand$xy)), lab = as.character(1:13), nb = zealand$nb, 
    psub.text = "Distance canonique", plot = FALSE)
  g2 <- s.label(cmdscale(d0), lab = as.character(1:13), nb = zealand$nb, 
    psub.text = "Distance routiere", plot = FALSE)
  g3 <- s.label(cmdscale(d1), lab = as.character(1:13), nb = zealand$nb, 
    psub.text = "Distance routiere / Cailliez", plot = FALSE)
  g4 <- s.label(cmdscale(d2), lab = as.character(1:13), nb = zealand$nb, 
    psub.text = "Distance routiere / Lingoes", plot = FALSE)
  G2 <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))

}
```
