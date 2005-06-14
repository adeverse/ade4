\name{westafrica}
\alias{westafrica}
\docType{data}
\title{Freshwater fish zoogeography in west Africa}
\description{
This data set contains informations about faunal similarities between river basins in West africa.  
}
\usage{data(westafrica)}
\format{
\code{westafrica} is a list containing the following objects : 
\describe{
   \item{tab}{: a data frame with absence/presence of 268 species (rows) at 33 embouchures (columns)}
   \item{spe.names}{: a vector of string of characters with the name of species}
   \item{spe.binames}{: a data frame with the genus and species (columns) of the 256 species (rows)}
   \item{riv.names}{: a vector of string of characters with the name of rivers}
   \item{atlantic}{: a data frame with the coordinates of a polygon that represents the limits of atlantic (see example)}
   \item{riv.xy}{: a data frame with the coordinates of embouchures}
   \item{lines}{: a data frame with the coordinates of lines to complete the representation (see example)}
   \item{cadre}{: a data frame with the coordinates of points used to make the representation (see example)}   
}}
\source{
Data provided by B. Hugueny \email{hugueny@biomserv.univ-lyon1.fr}.

Paugy, D., Traoré, K. and Diouf, P.F. (1994) Faune ichtyologique des eaux douces d'Afrique de l'Ouest. 
In \emph{Diversité biologique des poissons des eaux douces et saumâtres d'Afrique. Synthèses géographiques}, 
Teugels, G.G., Guégan, J.F. and Albaret, J.J. (Editors). Annales du Musée Royal de l'Afrique Centrale,  
Zoologie, \bold{275}, Tervuren, Belgique, 35--66.

Hugueny, B. (1989) \emph{Biogéographie et structure des peuplements de Poissons d'eau douce de l'Afrique de l'ouest : 
approches quantitatives}. Thèse de doctorat, Université Paris 7.
}
\references{
Hugueny, B., and Lévêque, C. (1994) Freshwater fish zoogeography in west Africa: 
faunal similarities between river basins. \emph{Environmental Biology of Fishes}, \bold{39}, 365--380.
}
\examples{
data(westafrica)

s.label(westafrica$cadre, xlim = c(30,500), ylim = c(50,290),
    cpoi = 0, clab = 0, grid = FALSE, addax = 0)
old.par <- par(no.readonly = TRUE)
par(mar = c(0.1, 0.1, 0.1, 0.1))
rect(30,0,500,290)
polygon(westafrica$atlantic,col = "lightblue")
points(westafrica$riv.xy, pch = 20, cex = 1.5)
apply(westafrica$lines, 1, function(x) segments(x[1], x[2], x[3],
    x[4], lwd = 1))
apply(westafrica$riv.xy,1, function(x) segments(x[1], x[2], x[3],
    x[4], lwd = 1))
text(c(175,260,460,420), c(275,200,250,100), c("Senegal","Niger",
    "Niger","Volta"))
par(srt = 270)
text(westafrica$riv.xy$x2, westafrica$riv.xy$y2-10, 
    westafrica$riv.names, adj = 0, cex = 0.75)
par(old.par)
rm(old.par)

# multivariate analysis
afri.w <- data.frame(t(westafrica$tab))
afri.dist <- dist.binary(afri.w,1)
afri.pco <- dudi.pco(afri.dist, scan = FALSE, nf = 3)
par(mfrow = c(3,1))
barplot(afri.pco$li[,1])
barplot(afri.pco$li[,2])
barplot(afri.pco$li[,3])

if (require(spdep, quiet = TRUE)){
    #multivariate spatial analysis
    afri.neig <- neig(n.line = 33)
    afri.nb <- neig2nb(afri.neig)
    afri.listw <- nb2listw(afri.nb)
    afri.ms <- multispati(afri.pco, afri.listw, scan = FALSE,
        nfposi = 6, nfnega = 0)
    par(mfrow = c(3,1))
    barplot(afri.ms$li[,1])
    barplot(afri.ms$li[,2])
    barplot(afri.ms$li[,3])

    par(mfrow = c(2,2))
    s.label(afri.ms$li, clab = 0.75, cpoi = 0, neig = afri.neig,
       cneig = 1.5)
    s.value(afri.ms$li, afri.ms$li[,3])
    s.value(afri.ms$li, afri.ms$li[,4])
    s.value(afri.ms$li, afri.ms$li[,5])
    summary(afri.ms)
}

par(mfrow = c(1,1))
plot(hclust(afri.dist,"ward"),h=-0.2)
}
\keyword{datasets}
