\name{ichtyo}
\alias{ichtyo}
\non_function{}
\title{Point sampling of fish community}
\description{
This data set gives informations between a faunistic array, 
the total number of sampling points made at each sampling occasion and 
the year of the sampling occasion. 
}
\usage{data(ichtyo)}
\format{
    \code{ichtyo} is a list of 3 components.
    \enumerate{
    \item{tab}{is a faunistic array with 9 columns and 32 rows.}
    \item{eff}{is a vector of the 32 sampling effort.}
    \item{dat}{is a factor where the levels are the 10 years of the sampling occasion.}
    }
}
\details{
    The value n(i,j) at the ith row and the jth column in \code{tab} corresponds to the number of sampling
    points of the ith sampling occasion (in \code{eff}) that contains the jth species.
}
\source{
Dolédec, S., Chessel, D. and Olivier, J. M. (1995)\cr
L'analyse des correspondances décentrée: application aux peuplements ichtyologiques du haut-Rhône.\cr
\emph{Bulletin Français de la P"che et de la Pisciculture}, \bold{336}, 29--40.
}
\examples{
data(ichtyo)
dudi1 <- dudi.dec(ichtyo$tab, ichtyo$eff, scan = FALSE)
s.class(dudi1$li, ichtyo$dat, wt = ichtyo$eff / sum(ichtyo$eff))
}
\keyword{datasets}
