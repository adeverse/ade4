\name{genet}
\alias{genet}
\alias{char2genet}
\alias{count2genet}
\alias{freq2genet}
\title{A class of data: tables of populations and alleles}
\description{
There are multiple formats of genetic data.  The functions of ade4 associated genetic data use the class \code{genet}.
An object of the class \code{genet} is a list containing at least one data frame whose lines are groups of individuals (populations) and columns alleles forming blocks associated with the locus.
They contain allelic frequencies expressed as a percentage. \cr
The function \code{char2genet} ensures the reading of tables crossing diploid individuals arranged by groups (populations) and polymorphic loci. Data frames containing only strings of characters are transformed in tables of allelic frequencies of the class \code{genet}. 
In entry a row is an individual, a variable is a locus and a value is a string of characters, for example ' 012028 ' for a heterozygote carrying alleles 012 and 028, ' 020020 ' for a homozygote carrying two alleles 020 and ' 000000 ' for a not classified locus (missing data). \cr
The function \code{count2genet} reads data frames containing allelic countings by populations and allelic forms classified by locus.\cr 
The function \code{freq2genet} reads data frames containing allelic frequencies by populations and allelic forms classified by locus. \cr
In these two cases, use as names of variables of strings of characters \code{xx.yyy} where \code{xx} are the names of locus and \code{yyy} a name of allelic forms in this locus.
The analyses on this kind of data having to use compact labels, these functions classify the names of the populations, the names of the loci and the names of the allelic forms in vectors and re-code in a simple way starting with P for population, L for locus and 1,\dots, m  for the alleles.  
}
\usage{
char2genet(X, pop, complete)
count2genet(PopAllCount)
freq2genet(PopAllFreq)
}
\arguments{
  \item{X}{a data frame of strings of characters (individuals in row, locus in variables), the value coded '000000' or two alleles of 6 characters}
  \item{pop}{a factor with the same number of rows than \code{df} classifying the individuals by population}
  \item{complete}{a logical value indicating a complete issue or not, by default FALSE}
  \item{PopAllCount}{a data frame containing integers: the occurrences of each allelic form (column) in each population (row)}
  \item{PopAllFreq}{a data frame containing values between 0 and 1: the frequencies of each allelic form (column) in each population (row)}
}
\value{
\code{char2genet} returns a list of class \code{genet} with :
\item{$tab}{a frequencies table of poplations (row) and alleles (column) }
\item{$center}{the global frequency of each allelic form calculated on the overall individuals classified on each locus} 
\item{$pop.names}{a vector containing the names of populations present in the data re-coded P01, P02, \dots}}
\item{$all.names}{a vector containing the names of the alleles present in the data re-coded L01.1, L01.2, \dots}
\item{$loc.blocks}{a vector containing the number of alleles by loci}
\item{$loc.fac}{a factor sharing the alleles by loci}
\item{$loc.names}{a vector containing the names of loci present in the data re-coded L01, \dots, L99 }
\item{$pop.loc}{a data frame containing the number of genus allowing the calculation of frequencies}
\item{$comp}{the complete individual typing with the code 02000 or 01001 if the option \code{complete} is TRUE}
\item{$comp.pop}{a factor indicating the population if the option \code{complete} is TRUE}

\code{count2genet} and \code{req2genet} return a list of class \code{genet} which don't contain the components \code{pop.loc} and \code{complete}.
}
\details{
As a lot of formats for genetic data are puublished in literature, a list of class \code{genet} contains at least a table of allellic frequencies and an attribut \code{loc.blocks}. The populations (row) and the variables (column) are classified by alphabetic order.
In the component \code{comp}, each individual per locus of m alleles is re-coded by a vector of length m: for hererozygicy 0,\dots,1,\dots,1,\dots,0 and homozygocy 0,\dots,2,0.
}
\author{
Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}
}
\examples{
data(casitas)
casitas[24,]
casitas.pop <- as.factor(rep(c("dome", "cast", "musc", "casi"), c(24,11,9,30)))
casi.genet <- char2genet(casitas, casitas.pop, complete=TRUE)
names(casi.genet$tab) 
casi.genet$tab[,1:8] 
casi.genet$pop.names
casi.genet$loc.names
casi.genet$all.names
casi.genet$loc.blocks # number of allelic forms by loci
casi.genet$loc.fac # factor classifying the allelic forms by locus
casi.genet$pop.loc # table populations loci
names(casi.genet$comp)
casi.genet$comp[1:4,]
casi.genet$comp.pop
casi.genet$center
apply(casi.genet$tab,2,mean)
casi.genet$pop.loc[,"L15"]
casi.genet$tab[, c("L15.1","L15.2")]
class(casi.genet)
casitas.coa <- dudi.coa(casi.genet$comp, scannf = FALSE)
s.class(casitas.coa$li,casi.genet$comp.pop)
}
\keyword{multivariate}
