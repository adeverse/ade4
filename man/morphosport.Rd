\name{morphosport}
\alias{morphosport}
\docType{data}
\title{Athletes' Morphology}
\description{
This data set gives a morphological description of 153 athletes split in five different sports. 
 }
\usage{data(morphosport)}
\format{
\code{morphosport} is a list of 2 components.
    \enumerate{
    \item{tab}{is a data frame with 153 athletes and 5 variables.}
    \item{sport}{is a factor with 6 items}
    }

    Variables of \code{morphosport$tab} are the following ones.
    \enumerate{
    \item{dbi}{: biacromial diameter (cm)}
    \item{tde}{: height (cm)}
    \item{tas}{: distance from the buttocks to the top of the head (cm)}
    \item{lms}{: length of the upper limbs (cm)}
    \item{poids}{: weigth (kg)}
    }

    The levels of \code{morphosport$sport} are:
    \enumerate{
    \item{athl}{: athletics}
    \item{foot}{: football}
    \item{hand}{: handball}
    \item{judo}{: judo}
    \item{nata}{: swimming}
    \item{voll}{: volleyball}
    }
}
\source{
Mimouni , N. (1996)\cr
Contribution de méthodes biométriques à l'analyse de la morphotypologie des sportifs.\cr
Thèse de doctorat. Université Lyon 1.
}
\examples{
data(morphosport)
plot(discrimin(dudi.pca(morphosport$tab, scan = FALSE), morphosport$sport, scan = FALSE))
}
\keyword{datasets}
