\name{fruits}
\alias{fruits}
\docType{data}
\title{Pair of Tables}
\description{
    28 batches of fruits -two types- are judged by two different ways.\cr
    They are classified in order of preference, without ex aequo, by 16 individuals.\cr
    15 quantitative variables described the batches of fruits.\cr
}
\usage{data(fruits)}
\format{
    \code{fruits} is a list of 3 components:
    \describe{
    \item{typ}{is a vector returning the type of the 28 batches of fruits (peaches or nectarines).}
    \item{jug}{is a data frame of 28 rows and 16 columns (judges).}
    \item{var}{is a data frame of 28 rows and 16 measures (average of 2 judgements).}
    }
}
\details{
    \code{fruits$var} is a data frame of 15 variables:
    \enumerate{
    \item{1{\_}taches}{: quantity of cork blemishes (0=absent - maximum 5)}
    \item{2{\_}stries}{: quantity of stria (1/none - maximum 4)}
    \item{3{\_}ab{\_}muc}{: abundance of mucron (1/absent - 4)}
    \item{4{\_}ir{\_}for}{: shape irregularity (0/none - 3)}
    \item{5{\_}allong}{: length of the fruit (1/round fruit - 4)}
    \item{6{\_}su{\_}rou}{: percentage of the red surface (minimum 40\% - maximum 90\%)}
    \item{7{\_}ho{\_}lot}{: homogeneity of the intra-batch coloring (1/strong - 4)}
    \item{8{\_}ho{\_}fru}{: homogeneity of the intra-fruit coloring (1/strong - 4)}
    \item{9{\_}pubes}{: pubescence (0/none - 4)}
    \item{10{\_}vert}{: intensity of green in red area (1/none - 4)}
    \item{11{\_}fonc}{: intensity of dark area (0/pink - 4)}
    \item{12{\_}col{\_}mu}{: intensity of the mucron color (1=no contrast - 4/dark)}
    \item{13{\_}impres}{: kind of impression (1/watched - 4/pointillé)}
    \item{14{\_}col{\_}dom}{: intensity of the predominating color (0/clear - 4)}
    \item{15{\_}calib}{: grade (1/<90g - 5/>200g)}
    }
}
\source{
Kervella, J. (1991) 
Analyse de l'attrait d'un produit : exemple d'une comparaison de lots de pêches. 
Agro-Industrie et méthodes statistiques. 
Compte-rendu des secondes journées européennes. Nantes 13-14 juin 1991.  
Association pour la Statistique et ses Utilisations, Paris,  313--325.
}
\examples{
data(fruits)
par(mfrow = c(2,2))
pcajug <- dudi.pca(fruits$jug, scann = FALSE)
s.corcircle(pcajug$co)
s.class(pcajug$li, fac = fruits$type)

pcavar <- dudi.pca(fruits$var, scann = FALSE)
s.corcircle(pcavar$co)
s.class(pcavar$li, fac = fruits$type)

par(mfrow = c(1,1))
plot(coinertia(pcajug, pcavar, scan = FALSE))
}
\keyword{datasets}
