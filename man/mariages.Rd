\name{mariages}
\alias{mariages}
\non_function{}
\title{Correspondence Analysis Table}
\description{
This array contains the socio-professionnal repartitions of 5850 couples.
}
\usage{data(mariages)}
\format{
The \code{mariages} data frame has 9 rows and 9 columns.
The rows represent the wife's socio-professionnal category and the columns the husband's socio-professionnal category (1982).\cr
Codes for rows and columns are identical.\cr
    \describe{
    \item{agri}{: Farmers}
    \item{ouva}{: Farm workers}
    \item{pat}{: Company directors (commerce and industry)}
    \item{sup}{: Liberal profession, executives and higher intellectual professions}
    \item{moy}{: Intermediate professions}
    \item{emp}{: Other white-collar workers}
    \item{ouv}{: Manual workers}
    \item{serv}{: Domestic staff}
    \item{aut}{: other workers}
  }
}
\source{
Vallet, L.A. (1986)\cr
Activité professionnelle de la femme mariée et détermination de la position sociale de la famille.\cr
Un test empirique : la France entre 1962 et 1982.\cr
\emph{Revue Française de Sociologie}, \bold{27}, 656--696.
}
\examples{
data(mariages)
par(mfrow = c(2,2))
w <- dudi.coa(mariages, scan = FALSE, nf = 3)
scatter(w, met = 1, posi = "bottom")
scatter(w, met = 2, posi = "bottom")
scatter(w, met = 3, posi = "bottom")
score(w, 3)
par(mfrow = c(1,1))
}
\keyword{datasets}
