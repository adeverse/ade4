# Minimal Spanning Tree

Minimal Spanning Tree

## Usage

``` r
mstree(xdist, ngmax = 1)
```

## Arguments

- xdist:

  an object of class `dist` containing an observed dissimilarity

- ngmax:

  a component number (default=1). Select 1 for getting classical MST. To
  add n supplementary edges k times: select k+1.

## Value

returns an object of class `neig`

## Author

Daniel Chessel

## Examples

``` r
data(mafragh)
maf.coa <- dudi.coa(mafragh$flo, scan = FALSE)
maf.mst <- ade4::mstree(dist.dudi(maf.coa), 1)

if(adegraphicsLoaded()) {
  g0 <- s.label(maf.coa$li, plab.cex = 0, ppoints.cex = 2, nb = neig2nb(maf.mst))
} else {
  s.label(maf.coa$li, clab = 0, cpoi = 2, neig = maf.mst, cnei = 1)
}


xy <- data.frame(x = runif(20), y = runif(20))

if(adegraphicsLoaded()) {
  g1 <- s.label(xy, xlim = c(0, 1), ylim = c(0, 1), 
    nb = neig2nb(ade4::mstree(dist.quant(xy, 1), 1)), plot = FALSE)
  g2 <- s.label(xy, xlim = c(0, 1), ylim = c(0, 1), 
    nb = neig2nb(ade4::mstree(dist.quant(xy, 1), 2)), plot = FALSE)
  g3 <- s.label(xy, xlim = c(0, 1), ylim = c(0, 1), 
    nb = neig2nb(ade4::mstree(dist.quant(xy, 1), 3)), plot = FALSE)
  g4 <- s.label(xy, xlim = c(0, 1), ylim = c(0, 1), 
    nb = neig2nb(ade4::mstree(dist.quant(xy, 1), 4)), plot = FALSE)
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))

} else {
  par(mfrow = c(2, 2))
  for(k in 1:4) {
    neig <- mstree(dist.quant(xy, 1), k)
    s.label(xy, xlim = c(0, 1), ylim = c(0, 1), addax = FALSE, neig = neig)
  }
}
```
