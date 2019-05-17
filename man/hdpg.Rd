\name{hdpg}
\alias{hdpg}
\docType{data}
\title{Genetic Variation In Human Populations}
\description{
This data set gives genotypes variation of 1066 individuals belonging to 52 predefined populations, 
for 404 microsatellite markers. 
}
\usage{data(hdpg)}
\format{
\code{hdpg} is a list of 3 components. \cr
   \describe{
   \item{tab}{ is a data frame with the genotypes of 1066 individuals 
      encoded with 6 characters (individuals in row, locus in column), for 
      example \sQuote{123098} for a heterozygote carrying alleles \sQuote{123} and \sQuote{098}, 
      \sQuote{123123} for a homozygote carrying two alleles \sQuote{123} and,
      \sQuote{000000} for a not classified locus (missing data). }
   \item{ind}{ is a a data frame with 4 columns containing information about the 1066 individuals: 
      \code{hdpg$ind$id} containing the Diversity Panel identification number of each individual,
      and three factors \code{hdpg$ind$sex}, \code{hdpg$ind$population} and \code{hdpg$ind$region} 
      containing the names of the 52 populations belonging to 7 major geographic regions (see details). }
   \item{locus}{ is a dataframe containing four columns: \code{hdpg$locus$marknames} 
      a vector of names of the microsatellite markers, \code{hdpg$locus$allbyloc} 
      a vector containing the number of alleles by loci, \code{hdpg$locus$chromosome} 
      a factor defining a number for one chromosome and,
      \code{hdpg$locus$maposition} indicating the position of the locus in the chromosome. }
      }
}
\details{
The rows of \code{hdpg$pop} are the names of the 52 populations belonging to the geographic regions
contained in the rows of \code{hdpg$region}. The chosen regions are: America, Asia, Europe, 
Middle East North Africa, Oceania, Subsaharan AFRICA. \cr

The 52 populations are: Adygei, Balochi, Bantu, Basque, Bedouin, Bergamo, Biaka Pygmies, 
Brahui, Burusho, Cambodian, Columbian, Dai, Daur, Druze, French, 
Han, Hazara, Hezhen, Japanese, Kalash, Karitiana, Lahu, Makrani, Mandenka, Maya,
Mbuti Pygmies, Melanesian, Miaozu, Mongola, Mozabite, Naxi, NewGuinea, Nilote, Orcadian,
Oroqen, Palestinian, Pathan, Pima, Russian, San, Sardinian, She, Sindhi, Surui, Tu, Tujia, Tuscan,
Uygur, Xibo, Yakut, Yizu, Yoruba. \cr

\code{hdpg$freq} is a data frame with 52 rows, 
corresponding to the 52 populations described above, and 4992 microsatellite markers.
}
\source{
Extract of data prepared by the Human Diversity Panel Genotypes 
(invalid http://research.marshfieldclinic.org/genetics/Freq/FreqInfo.htm)

prepared by Hinda Haned, from data used in:
Noah A. Rosenberg, Jonatahan K. Pritchard, James L. Weber, Howard M. Cabb, Kenneth K. Kidds, 
Lev A. Zhivotovsky, Marcus W. Feldman (2002)
Genetic Structure of human Populations
\emph{Science}, \bold{298}, 2381--2385.

Lev A. Zhivotovsky, Noah Rosenberg, and Marcus W. Feldman (2003).
Features of Evolution and Expansion of Modern Humans, Inferred from Genomewide Microsatellite Markers
\emph{Am. J. Hum. Genet}, \bold{72}, 1171--1186.
}
\examples{
data(hdpg)
names(hdpg)
str(hdpg)
}
\keyword{datasets}
