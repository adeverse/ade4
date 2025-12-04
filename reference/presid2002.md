# Results of the French presidential elections of 2002

`presid2002` is a list of two data frames `tour1` and `tour2` with 93
rows (93 departments from continental Metropolitan France) and, 4 and 12
variables respectively .

## Usage

``` r
data(presid2002)
```

## Format

`tour1` contains the following arguments:  
the number of registered voters (`inscrits`); the number of abstentions
(`abstentions`); the number of voters (`votants`); the number of
expressed votes (`exprimes`) and, the numbers of votes for each
candidate: `Megret`, `Lepage`, `Gluksten`, `Bayrou`, `Chirac`, `Le_Pen`,
`Taubira`, `Saint.josse`, `Mamere`, `Jospin`, `Boutin`, `Hue`,
`Chevenement`, `Madelin`, `Besancenot`.  
  
`tour2` contains the following arguments:  
the number of registered voters (`inscrits`); the number of abstentions
(`abstentions`); the number of voters (`votants`); the number of
expressed votes (`exprimes`) and, the numbers of votes for each
candidate: `Chirac` and `Le_Pen`.

## Source

Site of the ministry of the Interior, of the Internal Security and of
the local liberties  
<https://www.archives-resultats-elections.interieur.gouv.fr/resultats/presidentielle_2002/index.php>

## See also

This dataset is compatible with `elec88` and `cnc2003`

## Examples

``` r
data(presid2002)
all((presid2002$tour2$Chirac + presid2002$tour2$Le_Pen) == presid2002$tour2$exprimes)
#> [1] TRUE

if (FALSE) { # \dontrun{
data(elec88)
data(cnc2003)
w0 <- ade4:::area.util.class(elec88$area, cnc2003$reg)
w1 <- scale(elec88$tab$Chirac)
w2 <- scale(presid2002$tour1$Chirac / presid2002$tour1$exprimes)
w3 <- scale(elec88$tab$Mitterand)
w4 <- scale(presid2002$tour2$Chirac / presid2002$tour2$exprimes)

if(adegraphicsLoaded()) {
  g1 <- s.value(elec88$xy, w1, Sp = elec88$Spatial, pSp.col = "white", pgrid.draw = FALSE, 
    psub.text = "Chirac 1988 T1", plot = FALSE)
  g2 <- s.value(elec88$xy, w2, Sp = elec88$Spatial, pSp.col = "white", pgrid.draw = FALSE, 
    psub.text = "Chirac 2002 T1", plot = FALSE)
  g3 <- s.value(elec88$xy, w3, Sp = elec88$Spatial, pSp.col = "white", pgrid.draw = FALSE, 
    psub.text = "Mitterand 1988 T1", plot = FALSE)
  g4 <- s.value(elec88$xy, w4, Sp = elec88$Spatial, pSp.col = "white", pgrid.draw = FALSE, 
    psub.text = "Chirac 2002 T2", plot = FALSE)
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
      
} else {
  par(mfrow = c(2, 2))
  par(mar = c(0.1, 0.1, 0.1, 0.1))

  area.plot(w0)
  s.value(elec88$xy, w1, add.plot = TRUE)
  scatterutil.sub("Chirac 1988 T1", csub = 2, "topleft")

  area.plot(w0)
  s.value(elec88$xy, w2, add.plot = TRUE)
  scatterutil.sub("Chirac 2002 T1", csub = 2, "topleft")
  
  area.plot(w0)
  s.value(elec88$xy, w3, add.plot = TRUE)
  scatterutil.sub("Mitterand 1988 T1", csub = 2, "topleft")
  
  area.plot(w0)
  s.value(elec88$xy, w4, add.plot = TRUE)
  scatterutil.sub("Chirac 2002 T2", csub = 2, "topleft")
}} # }
```
