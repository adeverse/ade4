# Import data files from Phylogenetic Independance Package

This function ensures to transform a data set written for the
Phylogenetic Independance package of Abouheif (1999) in a data set
formatting for the functions of ade4.

## Usage

``` r
PI2newick(x)
```

## Arguments

- x:

  is a data frame that contains information on phylogeny topology and
  trait values

## Value

Returns a list containing :

- tre:

  : a character string giving the phylogenetic tree in Newick format

- trait:

  : a vector containing values of the trait

## References

Abouheif, E. (1999) A method for testing the assumption of phylogenetic
independence in comparative data. *Evolutionary Ecology Research*,
**1**, 895–909.

## Author

Sébastien Ollier <sebastien.ollier@u-psud.fr>  
Daniel Chessel

## Examples

``` r
x <- c(2.0266, 0.5832, 0.2460, 1.2963, 0.2460, 0.1565, -99.0000,
        -99.0000, 10.1000, -99.0000,  20.2000,  28.2000, -99.0000, 
        14.1000, 11.2000, -99.0000, 21.3000, 27.5000, 1.0000, 2.0000,
        -1.0000, 4.0000, -1.0000, -1.0000, 3.0000, -1.0000, -1.0000,
        5.0000, -1.0000, -1.0000, 0.0000, 0.0000, 0.0000, 0.0000,
        0.0000, 0.0000)
x <- matrix(x, nrow = 6)
x <- as.data.frame(x)
res <- PI2newick(x)
dotchart.phylog(newick2phylog(res$tre), res$trait)
```
