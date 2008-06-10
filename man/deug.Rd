\name{deug}
\alias{deug}
\docType{data}
\title{Exam marks for some students}
\description{
This data set gives the exam results of 104 students in the second year of a French University onto 9 subjects. 
}
\usage{data(deug)}
\format{
    \code{deug} is a list of three components.
    \describe{
    \item{tab}{is a data frame with 104 students and 9 subjects : Algebra, Analysis, Proba, Informatic, Economy,
    Option1, Option2, English, Sport.}
    \item{result}{is a factor of 104 components giving the final exam levels (A+, A, B, B-, C-, D).}
    \item{cent}{is a vector of required marks by subject to get exactly 10/20 with a coefficient.}
    }
}
\source{
University of Lyon 1
}
\examples{
data(deug)
# decentred PCA
pca1 <- dudi.pca(deug$tab, scal = FALSE, center = deug$cent, 
    scan = FALSE)
s.class(pca1$li, deug$result)
s.arrow(40 * pca1$c1, add.plot = TRUE)
}
\keyword{datasets}
