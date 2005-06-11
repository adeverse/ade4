\name{chevaine}
\docType{data}
\alias{chevaine}
\title{Enzymatic polymorphism in Leuciscus cephalus}
\description{
  This data set contains a list of three components: spatial map, allellic profiles and sample sizes.
} 
\usage{data(chevaine)} 
\format{
This data set is a list of three components:
  \describe{
    \item{tab}{ a data frame with 27 populations and 9 allelic frequencies (4 locus)}
    \item{coo}{ a list containing all the elements to build a spatial map}
    \item{eff}{ a numeric containing the numbers of fish samples per station}
  }
} 
\references{
Guinand B., Bouvet Y. and Brohon B. (1996) Spatial aspects of genetic differentiation of the European 
chub in the Rhone River basin. \emph{Journal of Fish Biology}, \bold{49}, 714--726.

See a data description at \url{http://pbil.univ-lyon1.fr/R/pps/pps054.pdf} (in French).
}
\examples{
data(chevaine)
'fun.chevaine' <- function(label=TRUE) {
    opar <- par(mar = par("mar"))
        on.exit(par(opar))
        par(mar = c(0.1, 0.1, 0.1, 0.1))
    s.label(chevaine$coo$poi, xlim = c(-20,400), clab = 0, cpoi = 0)
    invisible(lapply(chevaine$coo$lac, polygon,col = "blue", type = "l", lwd = 2)) 
    invisible(lapply(chevaine$coo$riv, points, col = "blue", type = "l", lwd = 2))
    if (label){
        s.label(chevaine$coo$poi, clab = 0.75, add.p = TRUE)
        s.label(chevaine$coo$sta, add.p = TRUE, clab = 0.5)
    }
    arrows(200,100,300,100, code = 3, angle = 15, length = 0.2)
    text(250,125,"50 Km")
}

fun.chevaine()

che.genet <- freq2genet(chevaine$tab)
che.pca <- dudi.pca(che.genet$tab, center = che.genet$center, scannf = FALSE, nf = 3)

par(mfrow = c(1,2))
fun.chevaine(FALSE)
s.value(chevaine$coo$sta, che.pca$li[,1], csi = 2, add.p = TRUE)
fun.chevaine(FALSE)
s.value(chevaine$coo$sta, che.pca$li[,2], csi = 2, add.p = TRUE)

w = prep.fuzzy.var (che.genet$tab, che.genet$loc.blocks)
che.fca <- dudi.fca(w, scannf = FALSE, nf = 3)

fun.chevaine(FALSE)
s.value(chevaine$coo$sta, che.fca$li[,1], csi = 1.5, add.p = TRUE)
fun.chevaine(FALSE)
s.value(chevaine$coo$sta, che.fca$li[,2], csi = 1.5, add.p = TRUE)

} 
\keyword{datasets}
