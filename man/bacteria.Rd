\name{bacteria}
\alias{bacteria}
\docType{data}
\title{Genomes of 43 Bacteria}
\description{
    \code{bacteria} is a list containing 43 species and genomic informations : codons, amino acid and bases. 
}
\usage{data(bacteria)}
\format{
    This list contains the following objects:
    \describe{
        \item{code}{is a factor with the amino acid names for each codon. }
        \item{espcodon}{is a data frame 43 species 64 codons. }
        \item{espaa}{is a data frame 43 species 21 amino acid. }
        \item{espbase}{is a data frame 43 species 4 bases. }
    }
}
\source{
Data prepared by J. Lobry \email{lobry@biomserv.univ-lyon1.fr}
starting from:\cr
\url{http://www.tigr.org/tdb/mdb/mdbcomplete.html}
}
\examples{
data(bacteria)
names(bacteria$espcodon)
names(bacteria$espaa)
names(bacteria$espbase)
sum(bacteria$espcodon) # 22,619,749 codons
scatter.coa(dudi.coa(bacteria$espcodon, scann = FALSE), 
    posi = "bottom")
}
\keyword{datasets}
