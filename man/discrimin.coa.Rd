\name{discrimin.coa}
\alias{discrimin.coa}
\title{Discriminant Correspondence Analysis
}
\description{
performs a discriminant correspondence analysis. 
}
\usage{
discrimin.coa(df, fac, scannf = TRUE, nf = 2)
}
\arguments{
  \item{df}{a data frame containing positive or null values}
  \item{fac}{a factor defining the classes of discriminant analysis}
  \item{scannf}{a logical value indicating whether the eigenvalues bar plot should be displayed}
  \item{nf}{if scannf FALSE, an integer indicating the number of kept axes}
}
\value{
a list of class \code{discrimin}. See \code{\link{discrimin}}
}
\references{
Perriere, G.,Lobry,  J. R.  and Thioulouse J. (1996) Correspondence discriminant analysis: a multivariate method for comparing classes of protein and nucleic acid sequences. \emph{CABIOS}, \bold{12}, 519--524.\cr

Perriere, G. and Thioulouse, J. (2002) Use of Correspondence Discriminant Analysis to predict the subcellular location of bacterial proteins. \emph{Computer Methods and Programs in Biomedicine}, in press.
}
\examples{
data(perthi02)
plot(discrimin.coa(perthi02$tab, perthi02$cla, scan = FALSE))
}
\keyword{multivariate}
