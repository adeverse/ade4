\name{aminoacyl}
\alias{aminoacyl}
\docType{data}
\title{Codon usage}
\description{
        \code{aminoacyl} is a list containing the codon counts of 36 genes encoding yeast aminoacyl-tRNA-synthetase(S.Cerevisiae).
}
\usage{data(aminoacyl)}
\format{
   \code{aminoacyl} is a list containing the 5 following objects:  
\describe{     
   \item{genes}{is a vector giving the gene names.} 
   \item{localisation}{is a vector giving the cellular localisation
         of the proteins (M = mitochondrial, C = cytoplasmic,
         I = indetermined, CI = cyto and mito).}    
   \item{codon}{is a vector containing the codon.}
   \item{AA}{is a factor giving the amino acid names for each codon.}
   \item{usage.codon}{is a dataframe containing the codon counts for each gene.}
 } 
}
\source{
 Data prepared by D. Charif \email{charif@biomserv.univ-lyon1.fr} starting from:\cr
 \url{http://www.expasy.org/sprot/}
}
\references{
Chiapello H., Olivier E., Landes-Devauchelle C., Nitschké P. and Risler J.L (1999) Codon usage as a tool to predict the cellular localisation of eukariotic ribosomal proteins and aminoacyl-tRNA synthetases. ,\emph{Nucleic Acids Res.}, \bold{27}, 14, 2848--2851.
}
\examples{
data(aminoacyl)
aminoacyl$genes
aminoacyl$usage.codon
dudi.coa(aminoacyl$usage.codon, scannf = FALSE)
}
\keyword{datasets}
