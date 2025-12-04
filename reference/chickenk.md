# Veterinary epidemiological study to assess the risk factors for losses in broiler chickens

This data set contains information about potential risk factors for
losses in broiler chickens

## Usage

``` r
data(chickenk)
```

## Format

A list with 5 components:

- mortality:

  a data frame with 351 observations and 4 variables which describe the
  losses (dependent dataset Y)

- FarmStructure:

  a data frame with 351 observations and 5 variables which describe the
  farm structure (explanatory dataset)

- OnFarmHistory:

  a data frame with 351 observations and 4 variables which describe the
  flock characteristics at placement (explanatory dataset)

- FlockCharacteristics:

  a data frame with 351 observations and 6 variables which describe the
  flock characteristics during the rearing period (explanatory dataset)

- CatchingTranspSlaught:

  a data frame with 351 observations and 5 variables which describe the
  transport, lairage conditions, slaughterhouse and inspection features
  (explanatory dataset)

## Source

Lupo C., le Bouquin S., Balaine L., Michel V., Peraste J., Petetin I.,
Colin P. and Chauvin C. (2009) Feasibility of screening broiler chicken
flocks for risk markers as an aid for meat inspection. *Epidemiology and
Infection*, 137, 1086-1098

## Examples

``` r
data(chickenk)
kta1 <- ktab.list.df(chickenk)
```
