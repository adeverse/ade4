\name{seconde}
\alias{seconde}
\docType{data}
\title{Students and  Subjects}
\description{
The \code{seconde} data frame gives the marks of 22 students for 8 subjects. 
}
\usage{data(seconde)}
\format{
  This data frame (22,8) contains the following columns:
- HGEO: History and Geography
- FRAN: French literature
- PHYS: Physics
- MATH: Mathematics
- BIOL: Biology
- ECON: Economy
- ANGL: English language
- ESPA: Spanish language
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
