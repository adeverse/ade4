# Leave-one-out cross-validation for a `discrimin` analysis

Leave-one-out cross-validation to test the existence of groups in a
`discrimin` analysis.

## Usage

``` r
# S3 method for class 'discrimin'
loocv(x, nax = 0, progress = FALSE, ...)
# S3 method for class 'discloocv'
print(x, ...)
# S3 method for class 'discloocv'
plot(x, xax = 1, yax = 2, ...)
```

## Arguments

- x:

  the `discrimin` analysis on which cross-validation should be done

- nax:

  list of axes for mean overlap index computation (0 = all axes)

- progress:

  logical to display a progress bar during computations (see the
  `progress` package)

- xax, yax:

  the numbers of the x-axis and the y-axis

- ...:

  further arguments passed to or from other methods

## Details

This function returns a list containing the cross-validated coordinates
of the rows. The analysis on which the `discrimin` was computed is
redone after removing each row of the data table, one at a time. A
`discrimin` analysis is done on this new analysis and the coordinates of
the missing row are computed by projection as supplementary element in
the new `discrimin` analysis. This can be useful to check that the
groups evidenced by the `discrimin` analysis are supported.

## Value

A list with:- `XValCoord`: the cross-validated row coordinates -
`PRESS`: the Predicted Residual Error Sum for each row- `PRESSTot`: the
sum of `PRESS` for each `bca` axis - `Oij_disc`: the mean overlap index
for the discriminant analysis- `Oij_XVal`: the mean overlap index for
cross-validation- `DeltaOij`: the spuriousness index

## Author

Jean Thioulouse

## See also

[loocv.dudi](loocv.dudi.md) [loocv.between](loocv.bca.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Data = skulls
data(skulls)
pcaskul <- dudi.pca(skulls, scan = FALSE)
facskul <- gl(5,30)
diskul <- discrimin(pcaskul, facskul, scan = FALSE)
xdiskul <- loocv(diskul, progress = TRUE)
oijdisc <- xdiskul$Oij_disc
oijxval <- xdiskul$Oij_XVal
Doij <- (oijxval - oijdisc)/0.5*100
pst1 <- paste0("Skulls discrimin randtest: p=", round(randtest(diskul)$pvalue, 4), 
", Oij = ", round(oijdisc,2))
pst2 <- paste0("Skulls cross-validation: Oij = ", round(oijxval,2), ", dOij = ",
round(Doij), "%")
if (adegraphicsLoaded()) {
  sc1 <- s.class(diskul$li, facskul, col = TRUE, psub.text = pst1, ellipseSize=0,
  chullSize=1, plot = FALSE)
  sc2 <- s.class(xdiskul$XValCoord, facskul, col = TRUE, psub.text = pst2,
  ellipseSize=0, chullSize=1, plot = FALSE)
  ADEgS(list(sc1, sc2), layout=c(2,2))
} else {
  par(mfrow=c(2,2))
  s.class(diskul$li, facskul, sub = pst1)
  s.class(xdiskul$XValCoord, facskul, sub = pst2)
}
data(chazeb)
pcacz <- dudi.pca(chazeb$tab, scan = FALSE)
discz <- discrimin(pcacz, chazeb$cla, scan = FALSE)
xdiscz <- loocv(discz, progress = TRUE)
oijdiscz <- xdiscz$Oij_disc
oijxvalz <- xdiscz$Oij_XVal
Doijz <- (oijxvalz - oijdiscz)/0.5*100
pst1 <- paste0("Chazeb discrimin randtest: p=", round(randtest(discz)$pvalue, 4), 
", Oij = ", round(oijdiscz,2))
pst2 <- paste0("Chazeb cross-validation: Oij = ", round(oijxvalz,2), ", dOij = ", 
round(Doijz), "%")
if (adegraphicsLoaded()) {
  tabi <- cbind(discz$li, pcacz$tab)
  gr1 <- s.class(tabi, xax=1, yax=2:7, chazeb$cla, col = TRUE, plot = FALSE)
  for (i in 1:6) gr1[[i]] <- update(gr1[[i]], psub.text = names(tabi)[i+1],
  plot = FALSE)
  pos1 <- gr1@positions
  pos1[,1] <- c(0, .3333, .6667, 0, .3333, .6667)
  pos1[,2] <- c(.6667, .6667, .6667, .3333, .3333, .3333)
  pos1[,3] <- c(.3333, .6667, 1, .3333, .6667, 1)
  pos1[,4] <- c(1, 1, 1, .6667, .6667, .6667)
  gr1@positions <- pos1
  sc1 <- s1d.gauss(discz$li, chazeb$cla, col = TRUE, psub.text = pst1,
  plot = FALSE)
  sc2 <- s1d.gauss(xdiscz$XValCoord, chazeb$cla, col = TRUE, psub.text = pst2,
  plot = FALSE)
  ADEgS(list(gr1[[1]], gr1[[2]], gr1[[3]], gr1[[4]], gr1[[5]], gr1[[6]], sc1, sc2))
} else {
  dev.new()
  sco.gauss(discz$li[,1], as.data.frame(chazeb$cla), sub = pst1)
  dev.new()
  sco.gauss(xdiscz$XValCoord[,1], as.data.frame(chazeb$cla), sub = pst2)
}
} # }
```
