\name{dist.genet}
\alias{dist.genet}
\title{ Genetic distances from gene frequencies }
\description{
  This program computes any one of five measures of genetic distance from a set of gene frequencies in different populations with several loci.
}
\usage{
dist.genet(genet, method = 1, diag = FALSE, upper = FALSE)
}
\arguments{
  \item{genet}{ a list of class \code{genet}  }
  \item{method}{ an integer between 1 and 5. See details }
  \item{diag}{ a logical value indicating whether the diagonal of the distance matrix should be printed by \code{print.dist} }
  \item{upper}{ a logical value indicating whether the upper triangle of the distance matrix should be printed by \code{print.dist} }
}
\details{
Let \bold{A} a table containing allelic frequencies with \emph{t} populations (rows) and \emph{m} alleles (columns).\cr
Let  \eqn{\nu} the number of loci. The locus \emph{j} gets \emph{m(j)} alleles. 
\eqn{m=\sum_{j=1}^{\nu} m(j)}\cr

For the row \emph{i} and the modality \emph{k} of the variable \emph{j}, notice the value \eqn{a_{ij}^k} (\eqn{1 \leq i \leq t}, \eqn{1 \leq j \leq \nu},
\eqn{1 \leq k \leq m(j)}) the value of the initial table.\cr

\eqn{a_{ij}^+=\sum_{k=1}^{m(j)}a_{ij}^k} and \eqn{p_{ij}^k=\frac{a_{ij}^k}{a_{ij}^+}}\cr

Let \bold{P} the table of general term \eqn{p_{ij}^k}\cr
\eqn{p_{ij}^+=\sum_{k=1}^{m(j)}p_{ij}^k=1}, \eqn{p_{i+}^+=\sum_{j=1}^{\nu}p_{ij}^+=\nu}, \eqn{p_{++}^+=\sum_{j=1}^{\nu}p_{i+}^+=t\nu}\cr

The option \code{method} computes the distance matrices between populations using the frequencies \eqn{p_{ij}^k}. \cr

1. Nei's distance: \cr
\eqn{D_1(a,b)=- \ln(\frac{\sum_{k=1}^{\nu} \sum_{j=1}^{m(k)}
p_{aj}^k p_{bj}^k}{\sqrt{\sum_{k=1}^{\nu} \sum_{j=1}^{m(k)}
{(p_{aj}^k) }^2}\sqrt{\sum_{k=1}^{\nu} \sum_{j=1}^{m(k)}
{(p_{bj}^k)}^2}})}\cr

2. Angular distance or Edwards' distance:\cr
\eqn{D_2(a,b)=\sqrt{1-\frac{1}{\nu} \sum_{k=1}^{\nu}
\sum_{j=1}^{m(k)} \sqrt{p_{aj}^k  p_{bj}^k}}}\cr

3. Coancestrality coefficient or Reynolds' distance:\cr
\eqn{D_3(a,b)=\sqrt{\frac{\sum_{k=1}^{\nu}
\sum_{j=1}^{m(k)}{(p_{aj}^k - p_{bj}^k)}^2}{2 \sum_{k=1}^{\nu} (1-
\sum_{j=1}^{m(k)}p_{aj}^k p_{bj}^k)}}}\cr

4. Classical Euclidean distance or Rogers' distance:\cr
\eqn{D_4(a,b)=\frac{1}{\nu} \sum_{k=1}^{\nu} \sqrt{\frac{1}{2}
\sum_{j=1}^{m(k)}{(p_{aj}^k - p_{bj}^k)}^2}}\cr

5. Absolute genetics distance or Provesti 's distance:\cr
\eqn{D_5(a,b)=\frac{1}{2{\nu}} \sum_{k=1}^{\nu} \sum_{j=1}^{m(k)}
|p_{aj}^k - p_{bj}^k|}
}
\value{
returns a distance matrix of class \code{dist} between the rows of the data frame
}
\references{ 
To complete informations about distances:\cr

Distance 1:\cr
Nei, M. (1972) Genetic distances between populations. \emph{American Naturalist}, \bold{106}, 283--292. \cr
Nei M. (1978) Estimation of average heterozygosity and genetic distance from a small number of individuals. \emph{Genetics}, \bold{23}, 341--369. \cr
Avise, J. C. (1994) Molecular markers, natural history and evolution. Chapman & Hall, London. 

Distance 2:\cr
Edwards, A.W.F. (1971) Distance between populations on the basis of gene frequencies. \emph{Biometrics}, \bold{27}, 873--881. \cr
Cavalli-Sforza L.L. and Edwards A.W.F. (1967) Phylogenetic analysis: models and estimation procedures. \emph{Evolution}, \bold{32}, 550--570. \cr
Hartl, D.L. and Clark, A.G. (1989) Principles of population genetics. Sinauer Associates, Sunderland, Massachussetts (p. 303).

Distance 3:\cr
Reynolds, J. B., B. S. Weir, and C. C. Cockerham. (1983) Estimation of the coancestry coefficient: basis for a short-term genetic distance. \emph{Genetics}, \bold{105}, 767--779.

Distance 4:\cr
Rogers, J.S. (1972) Measures of genetic similarity and genetic distances. \emph{Studies in Genetics}, Univ. Texas Publ., \bold{7213}, 145--153.  \cr
Avise, J. C. (1994) Molecular markers, natural history and evolution. Chapman & Hall, London. 

Distance 5:\cr
Prevosti A. (1974) La distancia genética entre poblaciones. \emph{Miscellanea Alcobé}, \bold{68}, 109--118. \cr
Prevosti A., Ocaña J. and Alonso G. (1975) Distances between populations of Drosophila subobscura, based on chromosome arrangements frequencies. \emph{Theoretical and Applied Genetics}, \bold{45}, 231--241. \cr

To find some useful explanations:\cr
Sanchez-Mazas A. (2003) Cours de Génétique Moléculaire des Populations. Cours VIII Distances génétiques - Représentation des populations. \cr
\url{http://anthro.unige.ch/GMDP/Alicia/GMDP_dist.htm}
}
\author{ Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}\cr
Anne B Dufour \email{dufour@biomserv.univ-lyon1.fr} 
}
\examples{
data(casitas)
casi.genet <- char2genet(casitas,
    as.factor(rep(c("dome", "cast", "musc", "casi"), c(24,11,9,30))))
ldist <- lapply(1:5, function(method) dist.genet(casi.genet,method))
ldist
unlist(lapply(ldist, is.euclid))
kdist(ldist)
}
\keyword{ multivariate }
