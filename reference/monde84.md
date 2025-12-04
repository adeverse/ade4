# Global State of the World in 1984

The `monde84` data frame gives five demographic variables for 48
countries in the world.

## Usage

``` r
data(monde84)
```

## Format

This data frame contains the following columns:

1.  pib: Gross Domestic Product

2.  croipop: Growth of the population

3.  morta: Infant Mortality

4.  anal: Literacy Rate

5.  scol: Percentage of children in full-time education

## Source

Geze, F. and Coll., eds. (1984) *L'état du Monde 1984 : annuaire
économique et géopolitique mondial*. La Découverte, Paris.

## Examples

``` r
data(monde84)
X <- cbind.data.frame(lpib = log(monde84$pib), monde84$croipop)
Y <- cbind.data.frame(lmorta = log(monde84$morta), 
    lanal = log(monde84$anal + 1), rscol = sqrt(100 - monde84$scol))
pcaY <- dudi.pca(Y, scan = FALSE)
pcaiv1 <- pcaiv(pcaY, X0 <- scale(X), scan = FALSE)
sum(cor(pcaiv1$l1[,1], Y0 <- scale(Y))^2)
#> [1] 2.227037
pcaiv1$eig[1] #the same
#> [1] 2.227037
```
