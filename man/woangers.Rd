\name{woangers}
\alias{woangers}
\docType{data}
\title{Plant assemblages in woodlands of the conurbation of Angers (France)}
\description{
This data set gives the presence of plant species in relevés of woodlands in the conurbation of Angers; and their biological traits. 
}
\usage{data(woangers)}
\format{
    \code{woangers} is a list of 2 components.
\enumerate{
    \item flo: is a data frame that contains the presence/absence of species in each sample site. In the
codes for the sample sites (first column of the data frame), the first three letters provide the
code of the woodland and the numbers represent the 5 quadrats sampled in each site.
Codes for the woodlands are based on either their local name when they have one or on
the name of the nearest locality.

    \item traits: is a data frame that contains the values of the 13 functional traits considered in the paper.
One trait can be encoded by several columns.
The codes are as follows:
\itemize{
\item Column 1: Species names;
\item Column 2: \code{li}, nominal variable that indicates the presence (y) or absence (n) of
ligneous structures;
\item Column 3: \code{pr}, nominal variable that indicates the presence (y) or absence (n) of
prickly structures;
\item Column 4: \code{fo}, circular variable that indicates the month when the flowering period
starts (from 1 January to 9 September);
\item Column 5: \code{he}, ordinal variable that indicates the maximum height of the leaf
canopy;
\item Column 6: \code{ae}, ordinal variable that indicates the degree of aerial vegetative
multiplication;
\item Column 7: \code{un}, ordinal variable that indicates the degree of underground vegetative
multiplication;
\item Column 8: \code{lp}, nominal variable that represents the leaf position by 3 levels (\code{ros} =
rosette, \code{semiros} = semi-rosette and \code{leafy} = leafy stem);
\item Column 9: \code{le}, nominal variable that represents the mode of leaf persistence by 5
levels (\code{seasaes} = seasonal aestival, \code{seashib} = seasonal hibernal, \code{seasver} =
seasonal vernal, \code{everalw} = always evergreen, \code{everparti} = partially evergreen);
\item Columns 10, 11 and 12: fuzzy variable that describes the modes of pollination with 3
levels (\code{auto} = autopollination, \code{insects} = pollination by insects, \code{wind} =
pollination by wind); this fuzzy variable is expressed as proportions, i.e. for each
row, the sum of the three columns equals 1;
\item Columns 13, 14 and 15: fuzzy variable that describes the life cycle with 3 levels
(annual, monocarpic and polycarpic); this fuzzy variable is expressed as
proportions, i.e. for each row, the sum of the three column equals 1;
\item Columns 16 to 20: fuzzy variable that describes the modes of dispersion with 5 levels
(\code{elaio} = dispersion by ants, \code{endozoo} = injection by animals, \code{epizoo} =
external transport by animals, \code{wind} = transport by wind, \code{unsp} = unspecialized
transport); this fuzzy variable is expressed as proportions, i.e. for each row, the
sum of the three columns equals 1;
\item Column 21: \code{lo}, quantitative variable that provides the seed bank longevity index;
\item Column 22: \code{lf}, quantitative variable that provides the length of the flowering
period.
}
}
}
\source{
Pavoine, S., Vallet, J., Dufour, A.-B., Gachet, S. and Daniel, H. (2009) 
On the challenge of treating various types of variables: 
Application for improving the measurement of functional diversity. \emph{Oikos}, \bold{118}, 391--402.
}
\examples{
# Loading the data
data(woangers)

# Preparating of the traits
traits <- woangers$traits
# Nominal variables 'li', 'pr', 'lp' and 'le'
# (see table 1 in the main text for the codes of the variables)
tabN <- traits[, c(1:2, 7, 8)]
# Circular variable 'fo'
tabC <- traits[3]
tabCp <- prep.circular(tabC, 1, 12)
# The levels of the variable lie between 1 (January) and 12 (December).
# Ordinal variables 'he', 'ae' and 'un'
tabO <- traits[, 4:6]
# Fuzzy variables 'mp', 'pe' and 'di'
tabF <- traits[, 9:19]
tabFp <- prep.fuzzy(tabF, c(3, 3, 5), labels = c("mp", "pe", "di"))
# 'mp' has 3 levels, 'pe' has 3 levels and 'di' has 5 levels.
# Quantitative variables 'lo' and 'lf'
tabQ <- traits[, 20:21]

# Combining the traits
ktab1 <- ktab.list.df(list(tabN, tabCp, tabO, tabFp, tabQ))
\dontrun{
# Calculating the distances for all traits combined
distrait <- dist.ktab(ktab1, c("N", "C", "O", "F", "Q"))
is.euclid(distrait)

# Calculating the contribution of each trait in the combined distances
contrib <- kdist.cor(ktab1, type = c("N", "C", "O", "F", "Q"))
contrib
dotchart(sort(contrib$glocor), labels = rownames(contrib$glocor)[order(contrib$glocor[, 1])])
}
}
\keyword{datasets}
