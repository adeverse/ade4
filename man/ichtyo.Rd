\encoding{latin1}
\name{ichtyo}
\alias{ichtyo}
\docType{data}
\title{Point sampling of fish community}
\description{
This data set gives informations between a faunistic array, 
the total number of sampling points made at each sampling occasion and 
the year of the sampling occasion. 
}
\usage{data(ichtyo)}
\format{
    \code{ichtyo} is a list of 3 components.
    \describe{
    \item{tab}{is a faunistic array with 9 columns and 32 rows.}
    \item{eff}{is a vector of the 32 sampling effort.}
    \item{dat}{is a factor where the levels are the 10 years of the sampling occasion.}
    }
}
\details{
    The value \emph{n(i,j)} at the \emph{ith} row and the \emph{jth} column in \code{tab} corresponds
    to the number of sampling points of the \emph{ith} sampling occasion (in \code{eff}) that contains the \emph{jth} species.
}
\source{
Dolédec, S., Chessel, D. and Olivier, J. M. (1995)
L'analyse des correspondances décentrée: application aux peuplements ichtyologiques du haut-Rhône.
\emph{Bulletin Français de la Pêche et de la Pisciculture}, \bold{336}, 29--40.
}
\examples{
data(ichtyo)
dudi1 <- dudi.dec(ichtyo$tab, ichtyo$eff, scan = FALSE)
s.class(dudi1$li, ichtyo$dat, wt = ichtyo$eff / sum(ichtyo$eff))
}
\keyword{datasets}
