\name{chazeb}
\alias{chazeb}
\non_function{}
\title{Charolais-Zebus}
\description{
This data set gives six different weights of 23 charolais and zebu oxen. 
}
\usage{data(chazeb)}
\format{
  \code{chazeb} is a list with 2 components.
  \describe{
	  \item{tab}{is a data frame with 23 rows and 6 columns.}
	  \item{cla}{is a factor with two levels "cha" et "zeb". }
  }
}
\source{
Tomassone, R., Danzard, M., Daudin, J. J. and Masson J. P.  (1988)\cr
\emph{Discrimination et classement}, Masson, Paris. p. 43
}
\examples{
data(chazeb)
plot(discrimin(dudi.pca(chazeb$tab, scan = FALSE), 
    chazeb$cla, scan = FALSE))
}
\keyword{datasets}
