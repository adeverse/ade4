\name{fourthcorner}
\alias{fourthcorner}
\alias{fourthcorner2}
\alias{print.4thcorner}
\alias{summary.4thcorner}
\alias{plot.4thcorner}
\alias{combine.4thcorner}
\title{ Functions to compute the fourth-corner statistic  }
\description{
  These functions allow to compute the fourth-corner statistic for abundance or presence-absence data. The fourth-corner statistic has been developped by Legendre et al (1997) and extended in Dray and Legendre (2008). The statistic measures the link between three tables: a table L (n x p) containing the abundances of p species at n sites, a second table R (n x m) with the measurements of m environmental variables for the n sites, and a third table Q (p x s) describing s species traits for the p species. 
}
\usage{
fourthcorner(tabR, tabL, tabQ, modeltype = 1, nrepet = 999, tr01 = FALSE)
fourthcorner2(tabR, tabL, tabQ, modeltype = 1, nrepet = 999, tr01 = FALSE)
\method{print}{4thcorner}(x, varQ = 1:nrow(x$tabG), varR = 1:ncol(x$tabG),...)
\method{summary}{4thcorner}(object,...)
\method{plot}{4thcorner}(x, type=c("D","G"), alpha=0.05,...)
combine.4thcorner(four1,four2)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{tabR}{ a dataframe with the measurements of m environmental variables (columns) for the n sites (rows).}
  \item{tabL}{ a dataframe containing the abundances of p species (columns) at n sites (rows).}
  \item{tabQ}{ a dataframe describing s species traits (columns) for the p species (rows).}
  \item{modeltype}{ an integer (0-5) indicating the permutation model used in the testing procedure (see details). }
  \item{nrepet}{ the number of permutations }
  \item{tr01}{ a logical indicating if data in \code{tabL} must be transformed to presence-absence data (FALSE by default)}
  \item{object}{ an object of the class 4thcorner}
  \item{x}{ an object of the class 4thcorner}
  \item{varR}{ a vector with indices for variables in \code{tabR}}
  \item{varQ}{ a vector with indices for variables in \code{tabQ}}
  \item{type}{ a character to specify if results should be plotted for
    cells or variables}
  \item{alpha}{ a value of significance level}
  \item{four1}{ an object of the class 4thcorner}
  \item{four2}{ an object of the class 4thcorner}
  \item{\dots}{further arguments passed to or from other methods}
  
}
\details{
For the \code{fourthcorner} function, the link is measured by a Pearson correlation coefficient for two quantitatives variables (trait and environmental variable), by a Pearson Chi2 and G statistic for two qualitative variables and by a Pseudo-F and Pearson r for one quantitative variable and one qualitative variable. The fourthcorner2 function offers a multivariate statistic (equal to the sum of eigenvalues of RLQ analysis) and measures the link between two variables by a square correlation coefficient (quant/quant), a Chi2/sum(L) (qual/qual) and a correlation ratio (quant/qual). The significance is tested by a permutation procedure. Different models are available:
\itemize{
\item model 1 (\code{modeltype}=1): Permute values for each species independently (i.e., permute within each column of table L)
\item model 2 (\code{modeltype}=2): Permute values of sites (i.e., permute entire rows of table L)
\item model 3 (\code{modeltype}=3): Permute values for each site independently (i.e., permute within each row of table L)
\item model 4 (\code{modeltype}=4): Permute values of species (i.e., permute entire columns of table L)
\item model 5 (\code{modeltype}=5): Permute values of species and after (or before) permute values of sites (i.e., permute entire columns and after (or before) entire rows of table L)
}
Note that the last model is strictly equivalent to permuting simultaneously the rows of tables R and Q, as proposed by Doledec et al. (1996).

The function \code{plot} produces a graphical representation of the
results (white for non siginficant, light grey for negative sgnificant
and dark grey for positive suignficant relationships).

The function \code{combine.4thcorner} combines the outputs of two
fourth-corner objects as described in Dray and Legendre (2008). It
returns an object of the class \code{4thcorner}. The function simply
creates a  new \code{4th.corner} object where pvalues are equal to the
maximum of pvalues of the two arguments.

}
\value{
  For the \code{fourthcorner} function, a list where:
   
   \code{tabD, tabDmin, tabDmax, tabDmoy, tabDNEQ, tabDNLT, tabDProb, tabDNperm } are dataframes with observed statistic; minimum, maximum, average statistics obtained by the permutation procedure; number of simulated values equal to the observed statistic; number of simulated values less than the observed statistic; P-values; and number of permutations. Results are given for cells of the fourth-corner (homogeneity for quant./qual.).
   
   \code{tabG, tabGmin, tabGmax, tabGmoy, tabGNEQ, tabGNLT, tabGProb, tabGNperm} are dataframes with observed statistic; minimum, maximum, average statistics obtained by the permutation procedure; number of simulated values equal to the observed statistic; number of simulated values less than the observed statistic; P-values; and number of permutations. Results are given for variables (Pearson's Chi2 for qual./qual.).
   
   \code{tabD2, tabD2min, tabD2max, tabD2moy, tabD2NEQ, tabD2NLT, tabD2Prob, tabD2Nperm} are dataframes with observed statistic; minimum, maximum, average statistics obtained by the permutation procedure; number of simulated values equal to the observed statistic; number of simulated values less than the observed statistic; P-values; and number of permutations. Results are given for cells of the fourth-corner (Pearson r for quant./qual.).
   
   \code{tabG2, tabG2min, tabG2max, tabG2moy, tabG2NEQ, tabG2NLT, tabG2Prob, tabG2Nperm } are dataframes with observed statistic; minimum, maximum, average statistics obtained by the permutation procedure; number of simulated values equal to the observed statistic; number of simulated values less than the observed statistic; P-values; and number of permutations. Results are given for variables (G for qual./qual.)  

The \code{fourthcorner2} function returns a list where:

\code{tabG, tabGmin, tabGmax, tabGmoy, tabGNEQ, tabGNLT, tabGProb, tabGNperm } are dataframes with observed statistic; minimum, maximum, average statistics obtained by the permutation procedure; number of simulated values equal to the observed statistic; number of simulated values less than the observed statistic; P-values; and number of permutations. Results are given for variables. It returns also the list \code{trRLQ } with results for the multivariate statistic.

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
 }
\author{ Stephane Dray \email{dray@biomserv.univ-lyon1.fr}}
\seealso{ \code{rlq}}
\examples{
data(aviurba)
four1<-fourthcorner(aviurba$mil,aviurba$fau,aviurba$traits,nrepet=99)
print(four1,varR=2,varQ=3)
summary(four1)
plot(four1, type = "G")

## Procedure to combine the results of two models proposed in Dray and Legendre (2008)
four2<-fourthcorner(aviurba$mil,aviurba$fau,aviurba$traits,nrepet=99,modeltype=2)
four4<-fourthcorner(aviurba$mil,aviurba$fau,aviurba$traits,nrepet=99,modeltype=4)
four.comb<-combine.4thcorner(four2,four4)
plot(four.comb, type = "G")

}
\keyword{ multivariate }

