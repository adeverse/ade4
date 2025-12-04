# Phylogeny and quantitative traits of ungulates.

This data set describes the phylogeny of 18 ungulates as reported by
Pélabon et al. (1995). It also gives 4 traits corresponding to these 18
species.

## Usage

``` r
data(ungulates)
```

## Format

`fission` is a list containing the 2 following objects :

- tre:

  is a character string giving the phylogenetic tree in Newick format.

- tab:

  is a data frame with 18 species and 4 traits

## Details

Variables of `ungulates$tab` are the following ones :  
afbw: is a numeric vector that describes the adult female body weight
(g)  
mnw: is a numeric vector that describes the male neonatal weight (g)  
fnw: is a numeric vector that describes the female neonatal weight (g)  
ls: is a numeric vector that describes the litter size  

## Source

Data were obtained from Pélabon, C., Gaillard, J.M., Loison, A. and
Portier, A. (1995) Is sex-biased maternal care limited by total maternal
expenditure in polygynous ungulates? *Behavioral Ecology and
Sociobiology*, **37**, 311–319.

## Examples

``` r
data(ungulates)
ung.phy <- newick2phylog(ungulates$tre)
plot(ung.phy,clabel.l=1.25,clabel.n=0.75)

ung.x <- log(ungulates$tab[,1])
ung.y <- log((ungulates$tab[,2]+ungulates$tab[,3])/2)
names(ung.x) <- names(ung.phy$leaves)
names(ung.y) <- names(ung.x)
plot(ung.x,ung.y)
abline(lm(ung.y~ung.x))

symbols.phylog(ung.phy,ung.x-mean(ung.x))

dotchart.phylog(ung.phy,ung.x,cle=1.5,cno=1.5,cdot=1)

if (requireNamespace("adephylo", quietly = TRUE) & requireNamespace("ape", quietly = TRUE)) {
  tre <- ape::read.tree(text = ungulates$tre)
  adephylo::orthogram(ung.x, tre)
  ung.z <- residuals(lm(ung.y~ung.x))
  names(ung.z) <- names(ung.phy$leaves)
  dotchart.phylog(ung.phy,ung.z,cle=1.5,cno=1.5,cdot=1,ceti=0.75)
  adephylo::orthogram(ung.z, tre)
}



#> class: krandtest lightkrandtest 
#> Monte-Carlo tests
#> Call: adephylo::orthogram(x = ung.z, tre = tre)
#> 
#> Number of tests:   4 
#> 
#> Adjustment method for multiple comparisons:   none 
#> Permutation number:   999 
#>    Test       Obs    Std.Obs   Alter Pvalue
#> 1 R2Max 0.3566524  0.7496833 greater  0.246
#> 2 SkR2k 5.1897459 -2.3137471 greater  0.997
#> 3  Dmax 0.4273104  2.5298217 greater  0.010
#> 4   SCE 1.1067580  3.0430932 greater  0.020
#> 
```
