\name{seconde}
\alias{seconde}
\non_function{}
\title{Students and  Subjects}
\description{
The \code{seconde} data frame gives the marks of 22 students for 8 subjects. 
}
\usage{data(seconde)}
\format{
  This data frame (22,8) contains the following columns:
  \describe{
    \item{HGEO}{for History and Geography}
    \item{FRAN}{for French literature}
    \item{PHYS}{for Physics}
    \item{MATH}{for Mathematics}
    \item{BIOL}{for Biology}
    \item{ECON}{for Economy}
    \item{ANGL}{for English language}
    \item{ESPA}{for Spanish language}
  }
}
\source{
Personal communication
}
\examples{
data(seconde)
scatter(dudi.pca(seconde, scan = FALSE), clab.r = 1, clab.c = 1.5)
}
\keyword{datasets}
