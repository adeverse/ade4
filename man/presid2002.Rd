\name{presid2002}
\alias{presid2002}
\docType{data}
\title{Results of the French presidential elections of 2002}
\description{
    \code{presid2002} is a list of two data frames \code{tour1} and \code{tour2} with 93 rows ( 93 departments from continental Metropolitan France) and,
    4 and 12 variables respectively . 
}
\usage{data(presid2002)}
\format{
    \code{tour1} contains the following arguments:\cr
    the number of registered voters (\code{inscrits}); the number of abstentions (\code{abstentions});
    the number of voters (\code{votants}); the number of expressed votes (\code{exprimes}) and,
    the numbers of votes for each candidate: \code{Megret}, \code{Lepage}, \code{Gluksten}, \code{Bayrou}, 
    \code{Chirac}, \code{Le_Pen}, \code{Taubira}, \code{Saint.josse}, \code{Mamere}, \code{Jospin}, \code{Boutin}, 
    \code{Hue}, \code{Chevenement}, \code{Madelin}, \code{Besancenot}.\cr\cr
    \code{tour2} contains the following arguments:\cr
    the number of registered voters (\code{inscrits}); the number of abstentions (\code{abstentions});
    the number of voters (\code{votants}); the number of expressed votes (\code{exprimes}) and, 
    the numbers of votes for each candidate: \code{Chirac} and \code{Le_Pen}.
}
\source{
Site of the ministry of the Inerior, of the Internal Security and of the local liberties\cr
\url{http://www.interieur.gouv.fr/avotreservice/elections/presid2002/}
}
\seealso{
This dataset is compatible with \code{elec88} and \code{cnc2003}}
\examples{
data(presid2002)
all((presid2002$tour2$Chirac + presid2002$tour2$Le_Pen) == presid2002$tour2$exprimes)
\dontrun{
data(elec88)
data(cnc2003)
w1 = area.util.class(elec88$area, cnc2003$reg)

par(mfrow = c(2,2))
par(mar = c(0.1,0.1,0.1,0.1))

area.plot(w1)
w = scale(elec88$tab$Chirac)
s.value(elec88$xy, w, add.plot = TRUE)
scatterutil.sub("Chirac 1988 T1", csub = 2, "topleft")

area.plot(w1)
w = scale(presid2002$tour1$Chirac/ presid2002$tour1$exprimes)
s.value(elec88$xy, w, add.plot = TRUE)
scatterutil.sub("Chirac 2002 T1", csub = 2, "topleft")

area.plot(w1)
w = scale(elec88$tab$Mitterand)
s.value(elec88$xy, w, add.plot = TRUE)
scatterutil.sub("Mitterand 1988 T1", csub = 2, "topleft")

area.plot(w1)
w = scale(presid2002$tour2$Chirac/ presid2002$tour2$exprimes)
s.value(elec88$xy, w, add.plot = TRUE)
scatterutil.sub("Chirac 2002 T2", csub = 2, "topleft")
}
}
\keyword{datasets}
