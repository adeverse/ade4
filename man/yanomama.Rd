\name{yanomama}
\alias{yanomama}
\non_function{}
\title{Distance Matrices}
\description{
This data set gives 3 matrices about goegroaphical, genetic and anthropoemtric distances. 
}
\usage{data(yanomama)}
\format{
	\code{yanomama} is a list of 3 components:
	\enumerate{
		\item{geo}{is a matrix of 19-19 geographical distances}
		\item{gen}{is a matrix of 19-19 SFA (genetic) distances}
		\item{ant}{is a matrix of 19-19 anthropometric distances}
	}
}
\source{
Spielman, R.S. (1973)\cr
Differences among Yanomama Indian villages: do the patterns of allele frequencies, anthropometrics and map locations correspond?\cr
\emph{American Journal of Physical Anthropology}, \bold{39}, 461--480.
}
\references{
Table 7.2 Distance matrices for 19 villages of Yanomama Indians.\cr
All distances are as given by Spielman (1973), multiplied by 100 for convenience in:\cr
Manly, B.F.J. (1991)\cr
\emph{Randomization and Monte Carlo methods in biology}\cr
Chapman and Hall, London, 1--281.
}
\examples{
if (require(mva, quietly = TRUE)) {
	data(yanomama)
	gen <- quasieuclid(as.dist(yanomama$gen)) # depends of mva
	ant <- quasieuclid(as.dist(yanomama$ant)) # depends of mva
	par(mfrow = c(2,2))
	plot(gen, ant)
	t1 <- mantel.randtest(gen, ant, 99);
	plot(t1, main = "gen-ant-mantel") ; print(t1)
	t1 <- procuste.rtest(pcoscaled(gen), pcoscaled(ant), 99)
	plot(t1, main = "gen-ant-procuste") ; print(t1)
	t1 <- RV.rtest(pcoscaled(gen), pcoscaled(ant), 99)
	plot(t1, main = "gen-ant-RV") ; print(t1)
	par(mfrow = c(1,1))
}
}
\keyword{datasets}
