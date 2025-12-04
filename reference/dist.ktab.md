# Mixed-variables coefficient of distance

The mixed-variables coefficient of distance generalizes Gower's general
coefficient of distance to allow the treatment of various statistical
types of variables when calculating distances. This is especially
important when measuring functional diversity. Indeed, most of the
indices that measure functional diversity depend on variables (traits)
that have various statistical types (e.g. circular, fuzzy, ordinal) and
that go through a matrix of distances among species.

## Usage

``` r
dist.ktab(x, type, option = c("scaledBYrange", "scaledBYsd", "noscale"),
scann = FALSE, tol = 1e-8)
ldist.ktab(x, type, option = c("scaledBYrange", "scaledBYsd",
"noscale"), scann = FALSE, tol = 1e-8)
kdist.cor(x, type, option = c("scaledBYrange", "scaledBYsd", "noscale"),
scann = FALSE, tol = 1e-8, squared = TRUE)
prep.fuzzy(df, col.blocks, row.w = rep(1, nrow(df)), labels = paste("F",
1:length(col.blocks), sep = ""))
prep.binary(df, col.blocks, labels = paste("B", 1:length(col.blocks), sep = "")) 
prep.circular(df, rangemin = apply(df, 2, min, na.rm = TRUE), rangemax =
apply(df, 2, max, na.rm = TRUE))
```

## Arguments

- x:

  Object of class `ktab` (see details)

- type:

  Vector that provide the type of each table in x. The possible types
  are "Q" (quantitative), "O" (ordinal), "N" (nominal), "D"
  (dichotomous), "F" (fuzzy, or expressed as a proportion), "B"
  (multichoice nominal variables, coded by binary columns), "C"
  (circular). Values in type must be in the same order as in x.

- option:

  A string that can have three values: either "scaledBYrange" if the
  quantitative variables must be scaled by their range, or "scaledBYsd"
  if they must be scaled by their standard deviation, or "noscale" if
  they should not be scaled. This last option can be useful if the the
  values have already been normalized by the known range of the whole
  population instead of the observed range measured on the sample. If x
  contains data from various types, then the option "scaledBYsd" is not
  suitable (a warning will appear if the option selected with that
  condition).

- scann:

  A logical. If TRUE, then the user will have to choose among several
  possible functions of distances for the quantitative, ordinal, fuzzy
  and binary variables.

- tol:

  A tolerance threshold: a value less than tol is considered as null.

- squared:

  A logical, if TRUE, the squared distances are considered.

- df:

  Objet of class data.frame

- col.blocks:

  A vector that contains the number of levels per variable (in the same
  order as in `df`)

- row.w:

  A vector of row weigths

- labels:

  the names of the traits

- rangemin:

  A numeric corresponding to the smallest level where the loop starts

- rangemax:

  A numeric corresponding to the highest level where the loop closes

## Value

The functions provide the following results:

- dist.ktab:

  returns an object of class `dist`;

- ldist.ktab:

  returns a list of objects of class `dist` that correspond to the
  distances between species calculated per trait;

- kdist.cor:

  returns a list of three objects: "paircov" provides the covariance
  between traits in terms of (squared) distances between species;
  "paircor" provides the correlations between traits in terms of
  (squared) distances between species; "glocor" provides the
  correlations between the (squared) distances obtained for each trait
  and the global (squared) distances obtained by mixing all the traits
  (= contributions of traits to the global distances);

- prep.binary and prep.fuzzy:

  returns a data frame with the following attributes: col.blocks
  specifies the number of columns per fuzzy variable; col.num specifies
  which variable each column belongs to;

- prep.circular:

  returns a data frame with the following attributes: max specifies the
  number of levels in each circular variable.

## References

Pavoine S., Vallet, J., Dufour, A.-B., Gachet, S. and Daniel, H. (2009)
On the challenge of treating various types of variables: Application for
improving the measurement of functional diversity. *Oikos*, **118**,
391–402.
[doi:10.1111/j.1600-0706.2008.16668.x](https://doi.org/10.1111/j.1600-0706.2008.16668.x)

Appendix available at:
<http://www.oikosjournal.org/sites/oikosjournal.org/files/appendix/o16668.pdf>
<http://www.oikosjournal.org/sites/oikosjournal.org/files/appendix/o16668_files.zip>

## Author

Sandrine Pavoine <pavoine@mnhn.fr>

## Details

When preparing the object of class `ktab` (object x), variables of type
"Q", "O", "D", "F", "B" and "C" should be of class `numeric` (the class
`ordered` is not yet considered by `dist.ktab`); variables of type "N"
should be of class `character` or `factor`

## See also

[`daisy`](https://rdrr.io/pkg/cluster/man/daisy.html) in the case of
ratio-scale (quantitative) and nominal variables; and
[`woangers`](woangers.md) for an application.

## Examples

``` r
# With fuzzy variables
data(bsetal97)

w <- prep.fuzzy(bsetal97$biol, bsetal97$biol.blo)
w[1:6, 1:10]
#>    size.1 size.2 size.3 size.4 size.5 size.6 size.7 egglen.1 egglen.2 egglen.3
#> E1      0      0      0      1      0   0.00   0.00        0        0        0
#> E2     NA     NA     NA     NA     NA     NA     NA        0        0        0
#> E3      0      1      0      0      0   0.00   0.00        0        0        0
#> E4      0      0      0      1      0   0.00   0.00        0        0        0
#> E5      0      0      0      0      0   0.25   0.75        0        0        0
#> E6      0      0      0      0      0   0.50   0.50        0        0        0
ktab1 <- ktab.list.df(list(w))
dis <- dist.ktab(ktab1, type = "F")
as.matrix(dis)[1:5, 1:5]
#>           E1        E2        E3        E4        E5
#> E1 0.0000000 0.6947589 0.5947593 0.4008332 0.6487069
#> E2 0.6947589 0.0000000 0.6401753 0.6689944 0.5623047
#> E3 0.5947593 0.6401753 0.0000000 0.7107262 0.6289859
#> E4 0.4008332 0.6689944 0.7107262 0.0000000 0.5244575
#> E5 0.6487069 0.5623047 0.6289859 0.5244575 0.0000000

if (FALSE) { # \dontrun{
# With ratio-scale and multichoice variables
data(ecomor)

wM <- log(ecomor$morpho + 1) # Quantitative variables
wD <- ecomor$diet
# wD is a data frame containing a multichoice nominal variable
# (diet habit), with 8 modalities (Granivorous, etc)
# We must prepare it by prep.binary
head(wD)
wD <- prep.binary(wD, col.blocks = 8, label = "diet")
wF <- ecomor$forsub
# wF is also a data frame containing a multichoice nominal variable
# (foraging substrat), with 6 modalities (Foliage, etc)
# We must prepare it by prep.binary
head(wF)
wF <- prep.binary(wF, col.blocks = 6, label = "foraging")
# Another possibility is to combine the two last data frames wD and wF as
# they contain the same type of variables
wB <- cbind.data.frame(ecomor$diet, ecomor$forsub)
head(wB)
wB <- prep.binary(wB, col.blocks = c(8, 6), label = c("diet", "foraging"))
# The results given by the two alternatives are identical
ktab2 <- ktab.list.df(list(wM, wD, wF))
disecomor <- dist.ktab(ktab2, type= c("Q", "B", "B"))
as.matrix(disecomor)[1:5, 1:5]
contrib2 <- kdist.cor(ktab2, type= c("Q", "B", "B"))
contrib2

ktab3 <- ktab.list.df(list(wM, wB))
disecomor2 <- dist.ktab(ktab3, type= c("Q", "B"))
as.matrix(disecomor2)[1:5, 1:5]
contrib3 <- kdist.cor(ktab3, type= c("Q", "B"))
contrib3

# With a range of variables
data(woangers)

traits <- woangers$traits
# Nominal variables 'li', 'pr', 'lp' and 'le'
# (see table 1 in the main text for the codes of the variables)
tabN <- traits[,c(1:2, 7, 8)]
# Circular variable 'fo'
tabC <- traits[3]
tabCp <- prep.circular(tabC, 1, 12)
# The levels of the variable lie between 1 (January) and 12 (December).
# Ordinal variables 'he', 'ae' and 'un'
tabO <- traits[, 4:6]
# Fuzzy variables 'mp', 'pe' and 'di'
tabF <- traits[, 9:19]
tabFp <- prep.fuzzy(tabF, c(3, 3, 5), labels = c("mp", "pe", "di"))
# 'mp' has 3 levels, 'pe' has 3 levels and 'di' has 5 levels.
# Quantitative variables 'lo' and 'lf'
tabQ <- traits[, 20:21]
ktab1 <- ktab.list.df(list(tabN, tabCp, tabO, tabFp, tabQ))
distrait <- dist.ktab(ktab1, c("N", "C", "O", "F", "Q"))
is.euclid(distrait)
contrib <- kdist.cor(ktab1, type = c("N", "C", "O", "F", "Q"))
contrib
dotchart(sort(contrib$glocor), labels = rownames(contrib$glocor)[order(contrib$glocor[, 1])])
} # }
```
