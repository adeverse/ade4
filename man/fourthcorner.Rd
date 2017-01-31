\name{fourthcorner}
\alias{fourthcorner}
\alias{fourthcorner2}
\alias{print.4thcorner}
\alias{summary.4thcorner}
\alias{plot.4thcorner}
\alias{fourthcorner.rlq}

\title{ Functions to compute the fourth-corner statistic  }
\description{
  These functions allow to compute the fourth-corner statistic for abundance or presence-absence data. The fourth-corner statistic has been developed by Legendre et al (1997) and extended in Dray and Legendre (2008). The statistic measures the link between three tables: a table L (n x p) containing the abundances of p species at n sites, a second table R (n x m) with the measurements of m environmental variables for the n sites, and a third table Q (p x s) describing s species traits for the p species. 
}
\usage{
fourthcorner(tabR, tabL, tabQ, modeltype = 6, nrepet = 999, tr01 =
FALSE, p.adjust.method.G = p.adjust.methods, p.adjust.method.D =
p.adjust.methods, p.adjust.D = c("global", "levels"))
fourthcorner2(tabR, tabL, tabQ, modeltype = 6, nrepet = 999, tr01 =
FALSE, p.adjust.method.G = p.adjust.methods)
\method{print}{4thcorner}(x, varQ = 1:length(x$varnames.Q), varR =
1:length(x$varnames.R), stat = c("D", "D2"), ...)
\method{summary}{4thcorner}(object,...)
\method{plot}{4thcorner}(x, stat = c("D", "D2", "G"), type = c("table",
"biplot"), xax = 1, yax = 2, x.rlq = NULL, alpha = 0.05, col =
c("lightgrey", "red", "deepskyblue", "purple"), ...)
fourthcorner.rlq(xtest, nrepet = 999, modeltype = 6, typetest =
c("axes", "Q.axes", "R.axes"), p.adjust.method.G = p.adjust.methods,
p.adjust.method.D = p.adjust.methods, p.adjust.D = c("global",
"levels"), ...)
}

\arguments{
  \item{tabR}{ a dataframe with the measurements of m environmental variables (columns) for the n sites (rows).}
  \item{tabL}{ a dataframe containing the abundances of p species (columns) at n sites (rows).}
  \item{tabQ}{ a dataframe describing s species traits (columns) for the p species (rows).}
  \item{modeltype}{ an integer (1-6) indicating the permutation model used in the testing procedure (see details). }
  \item{nrepet}{ the number of permutations }
  \item{tr01}{ a logical indicating if data in \code{tabL} must be transformed to presence-absence data (FALSE by default)}
  \item{object}{ an object of the class 4thcorner}
  \item{x}{ an object of the class 4thcorner}
  \item{varR}{ a vector with indices for variables in \code{tabR}}
  \item{varQ}{ a vector with indices for variables in \code{tabQ}}
  \item{type}{ results are represented by a table or on a biplot (see x.rlq)}
  \item{alpha}{ a value of significance level}
  \item{p.adjust.method.G}{a string indicating a method for multiple
    adjustment used for output tabG, see \code{\link[stats]{p.adjust.methods}} for possible choices}
  \item{p.adjust.method.D}{a string indicating a method for multiple
    adjustment used for output tabD/tabD2, see \code{p.adjust.methods} for possible choices}
  \item{p.adjust.D}{a string indicating if multiple adjustment for
  tabD/tabD2 should be done globally or only between levels of a factor
  ("levels", as in the original paper of Legendre et al. 1997)}
  \item{stat}{a character to specify if results should be plotted for
    cells (D and D2) or variables (G)}
  \item{xax}{an integer indicating which rlq axis should be plotted on the x-axis}
  \item{yax}{an integer indicating which rlq axis should be plotted on the y-axis}
  \item{x.rlq}{an object created by the \code{rlq} function. Used to
  represent results on a biplot (type should be "biplot" and object
  created by the \code{fourthcorner} functions)}
  \item{col}{a vector of length 4 containing four colors used for the
  graphical representations. The first is used to represent non-significant
  associations, the second positive significant, the third negative
  significant. For the 'biplot' method and objects created by the
  \code{fourthcorner.rlq} function, the second corresponds to variables
  significantly linked
  to the x-axis, the third for the y-axis and the fourth for both axes}
  \item{xtest}{an object created by the \code{rlq} function}
  \item{typetest}{a string indicating which tests should be performed}
  \item{\dots}{further arguments passed to or from other methods}
  
}
\details{
For the \code{fourthcorner} function, the link is measured by a Pearson correlation coefficient for two quantitative variables (trait and environmental variable), by a Pearson Chi2 and G statistic for two qualitative variables and by a Pseudo-F and Pearson r for one quantitative variable and one qualitative variable. The fourthcorner2 function offers a multivariate statistic (equal to the sum of eigenvalues of RLQ analysis) and measures the link between two variables by a square correlation coefficient (quant/quant), a Chi2/sum(L) (qual/qual) and a correlation ratio (quant/qual). The significance is tested by a permutation procedure. Different models are available:
\itemize{
\item model 1 (\code{modeltype}=1): Permute values for each species independently (i.e., permute within each column of table L)
\item model 2 (\code{modeltype}=2): Permute values of sites (i.e., permute entire rows of table L)
\item model 3 (\code{modeltype}=3): Permute values for each site independently (i.e., permute within each row of table L)
\item model 4 (\code{modeltype}=4): Permute values of species (i.e., permute entire columns of table L)
\item model 5 (\code{modeltype}=5): Permute values of species and after
(or before) permute values of sites (i.e., permute entire columns and
after (or before) entire rows of table L)
\item model 6 (\code{modeltype}=6): combination of the outputs of models
2 and 4. Dray and Legendre (2008) and ter Braak et al. (20012) showed
that all models (except model 6) have inflated type I error.
}
Note that the model 5 is strictly equivalent to permuting
simultaneously the rows of tables R and Q, as proposed by Doledec et
al. (1996).

The function \code{summary} returns results for variables (G). The
function \code{print} returns results for cells (D and D2). In the case
of qualitative variables, Holm's corrected pvalues are also provided.

The function \code{plot} produces a graphical representation of the
results (white for non significant, light grey for negative significant
and dark grey for positive significant relationships). Results can be
plotted for variables (G) or for cells (D and D2). In the case of
qualitative / quantitative association, homogeneity (D) or correlation
(D2) are plotted.
}
\value{
  The \code{fourthcorner} function returns a a list where:
  
  \code{tabD} is a \code{krandtest} object giving the results of tests
  for cells of the fourth-corner (homogeneity for quant./qual.).
  \code{tabD2} is a \code{krandtest} object giving the results of tests
  for cells of the fourth-corner (Pearson r for quant./qual.).
  \code{tabG} is a \code{krandtest} object giving the results of tests
  for variables (Pearson's Chi2 for qual./qual.).
  
  The \code{fourthcorner2} function returns a list where:
  
  \code{tabG} is a \code{krandtest} object giving the results of tests for
  variables.
  \code{trRLQ} is a \code{krandtest} object giving the results of tests for
  the multivariate statistic (i.e. equivalent to \code{randtest.rlq} function).
}

\references{ 
Doledec, S., Chessel, D., ter Braak, C.J.F. and Champely, S. (1996) 
Matching species traits to environmental variables: a new three-table ordination method. \emph{Environmental and Ecological Statistics}, 
\bold{3}, 143--166.

Legendre, P., R. Galzin, and M. L. Harmelin-Vivien. (1997)
Relating behavior to habitat: solutions to the fourth-corner problem. \emph{Ecology},
\bold{78}, 547--562.

Dray, S. and Legendre, P. (2008) 
Testing the species traits-environment relationships: the fourth-corner
problem revisited. \emph{Ecology},
\bold{89}, 3400--3412.

ter Braak, C., Cormont, A., and Dray, S. (2012)
Improved testing of species traits-environment relationships in the
fourth corner problem. \emph{Ecology}, \bold{93}, 1525--1526.

Dray, S., Choler, P., Doledec, S., Peres-Neto, P.R., Thuiller, W.,
Pavoine, S. and ter Braak, C.J.F (2014)
Combining the fourth-corner and the RLQ methods for assessing trait
responses to environmental variation. \emph{Ecology}, \bold{95}, 14--21. doi:10.1890/13-0196.1
}
 
\author{Stéphane Dray \email{stephane.dray@univ-lyon1.fr}}
\seealso{ \code{\link{rlq}}, \code{\link{combine.4thcorner}}, \code{\link[stats]{p.adjust.methods}}}
\examples{
data(aviurba)

## Version using the sequential test (ter Braak et al 2012)
## as recommended in Dray et al (2013), 
## using Holm correction of P-values (only 99 permutations here)
four.comb.default <- fourthcorner(aviurba$mil,aviurba$fau,aviurba$traits,nrepet=99)
summary(four.comb.default)
plot(four.comb.default, stat = "G")

## using fdr correction of P-values
four.comb.fdr <- fourthcorner(aviurba$mil, aviurba$fau, aviurba$traits,
nrepet = 99, p.adjust.method.G = 'fdr', p.adjust.method.D = 'fdr')  
summary(four.comb.fdr)
plot(four.comb.fdr, stat = "G")

## Explicit procedure to combine the results of two models
## proposed in Dray and Legendre (2008);the above does this implicitly
four2 <- fourthcorner(aviurba$mil,aviurba$fau,aviurba$traits,nrepet=99,modeltype=2)
four4 <- fourthcorner(aviurba$mil,aviurba$fau,aviurba$traits,nrepet=99,modeltype=4)
four.comb <- combine.4thcorner(four2, four4)
summary(four.comb)
plot(four.comb, stat = "G")


}
\keyword{ multivariate }

