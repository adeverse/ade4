# Phylogenetic and quantitative traits of amazonian palm trees

This data set describes the phylogeny of 66 amazonian palm trees. It
also gives 7 traits corresponding to these 66 species.

## Usage

``` r
data(palm)
```

## Format

`palm` is a list containing the 2 following objects:

- tre:

  is a character string giving the phylogenetic tree in Newick format.

- traits:

  is a data frame with 66 species (rows) and 7 traits (columns).

## Details

Variables of `palm$traits` are the following ones:  
rord: specific richness with five ordered levels  
h: height in meter (squared transform)  
dqual: diameter at breast height in centimeter with five levels
`sout : subterranean`, ` d1(0, 5 cm)`, ` d2(5, 15 cm)`, ` d3(15, 30 cm)`
and ` d4(30, 100 cm)`  
vfruit: fruit volume in \\mm^{3}\\ (logged transform)  
vgrain: seed volume in \\mm^{3}\\ (logged transform)  
aire: spatial distribution area (\\km^{2}\\)  
alti: maximum altitude in meter (logged transform)  

## Source

This data set was obtained by Clémentine Gimaret-Carpentier.

## Examples

``` r
if (FALSE) { # \dontrun{
data(palm)
palm.phy <- newick2phylog(palm$tre)
radial.phylog(palm.phy,clabel.l=1.25)

if (requireNamespace("adephylo", quietly = TRUE) & requireNamespace("ape", quietly = TRUE)) {
  tre <- ape::read.tree(text = palm$tre)
  adephylo::orthogram(palm$traits[, 4], tre)
}
dotchart.phylog(palm.phy,palm$traits[,4], clabel.l = 1,
 labels.n = palm.phy$Blabels, clabel.n = 0.75)
w <- cbind.data.frame(palm.phy$Bscores[,c(3,4,6,13,21)],
 scalewt((palm$traits[,4])))
names(w)[6] <- names(palm$traits[4])
table.phylog(w, palm.phy, clabel.r = 0.75, f = 0.5)

gearymoran(palm.phy$Amat, palm$traits[,-c(1,3)])
} # }
```
