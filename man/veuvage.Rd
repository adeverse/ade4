\name{veuvage}
\alias{veuvage}
\docType{data}
\title{Example for Centring in PCA}
\description{
The data come from the INSEE (National Institute of Statistics and Economical Studies). 
It is an array of widower percentages in relation with the age and the socioprofessional category. 
}
\usage{data(veuvage)}
\format{
    \code{veuvage} is a list of 2 components.
\describe{
   \item{tab}{is a data frame with 37 rows (widowers) 6 columns (socio-professional categories)}
   \item{age}{is a vector of the ages of the 37 widowers. }
    }
}
\details{
The columns contain the socioprofessional categories:\cr
1- Farmers, 2- Craftsmen, 3- Executives and higher intellectual professions,\cr
4- Intermediate Professions, 5- Others white-collar workers and 6- Manual workers.\cr
}
\source{
unknown
}
\examples{
data(veuvage)
par(mfrow = c(3,2))
for (j in 1:6) plot(veuvage$age, veuvage$tab[,j],
    xlab = "âge", ylab = "pourcentage de veufs",
    type = "b", main = names(veuvage$tab)[j])
}
\keyword{datasets}
