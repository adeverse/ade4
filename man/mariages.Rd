\name{mariages}
\alias{mariages}
\docType{data}
\title{Correspondence Analysis Table}
\description{
This array contains the socio-professionnal repartitions of 5850 couples.
}
\usage{data(mariages)}
\format{
The \code{mariages} data frame has 9 rows and 9 columns.
The rows represent the wife's socio-professionnal category and the columns the husband's socio-professionnal category (1982).\cr

Codes for rows and columns are identical : agri (Farmers), ouva (Farm workers),
pat (Company directors (commerce and industry)), sup (Liberal profession, executives and higher intellectual professions),
moy (Intermediate professions), emp (Other white-collar workers), ouv (Manual workers), serv (Domestic staff),
aut (other workers).
}
\source{
Vallet, L.A. (1986)
Activité professionnelle de la femme mariée et détermination de la position sociale de la famille.
Un test empirique : la France entre 1962 et 1982.
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
par(mfrow = c(1,1))}
\keyword{datasets}
