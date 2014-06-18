\name{santacatalina}
\alias{santacatalina}
\docType{data}
\title{Indirect Ordination}
\description{
This data set gives the densities per hectare of 11 species of trees 
for 10 transects of topographic moisture values (mean of several stations per class).
}
\usage{data(santacatalina)}
\format{
a data frame with 11 rows and 10 columns
}
\source{
Gauch, H. G. J., Chase, G. B. and Whittaker R. H. (1974)
Ordination of vegetation samples by Gaussian species distributions.
\emph{Ecology}, \bold{55}, 1382--1390.
}
\examples{
data(santacatalina)
coa1 <- dudi.coa(log(santacatalina + 1), scan = FALSE) # 2 factors

if(adegraphicsLoaded()) {
  g1 <- table.value(log(santacatalina + 1), plot = F)
  g2 <- table.value(log(santacatalina + 1)[, sample(10)], plot = F)
  g3 <- table.value(log(santacatalina + 1)[order(coa1$li[, 1]), order(coa1$co[, 1])], plot = F)
  g4 <- scatter(coa1, posi = "bottomright", plot = F)
  G <- ADEgS(list(g1, g2, g3, g4), layout = c(2, 2))
} else {
  par(mfrow = c(2, 2))
  table.value(log(santacatalina + 1))
  table.value(log(santacatalina + 1)[, sample(10)])
  table.value(log(santacatalina + 1)[order(coa1$li[, 1]), order(coa1$co[, 1])]) 
  scatter(coa1, posi = "bottomright")
}}
\keyword{datasets}
