\name{cnc2003}
\alias{cnc2003}
\docType{data}
\title{Frequenting movie theaters in France in 2003}
\description{
    \code{cnc2003} is a data frame with 93 rows (93 departments from continental Metropolitan France)and 12 variables. 
}
\usage{data(cnc2003)}
\format{
    This data frame contains the following variables:
    \describe{
        \item{popu}{is the population department in million inhabitants. }
        \item{entr}{is the number of movie theater visitors in million. }
        \item{rece}{is the takings from ticket offices. }
        \item{sean}{is the number of proposed shows in thousands. }
        \item{comm}{is the number of equipped communes in movie theaters (units). }
        \item{etab}{is the number of active movie theaters (units). }
        \item{salle}{is the number of active screens. }
        \item{faut}{is the number of proposed seats. }
        \item{artes}{is the number of movie theaters offering "Art and Essay" movies. }
        \item{multi}{is the number of active multiplexes. }
        \item{depart}{is the name of the department. }
        \item{reg}{is the administrative region of the department. }
    }
}
\source{
National Center of Cinematography (CNC), september 2003\cr
\url{http://www.cnc.fr/cncinfo/288/index.html}
}
\seealso{
This dataset is compatible with \code{elec88} and \code{presid2002}}
\examples{
data(cnc2003)
sco.quant(cnc2003$popu, cnc2003[,2:10], abline = TRUE, csub = 3)
}
\keyword{datasets}
