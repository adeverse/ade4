\name{s.multinom}
\alias{s.multinom}
\title{Représentation des profils de fréquences (utile en génétique, par exemple)}
\description{
    # Le but du programme est de placer sur une figure des catégories à l'aide de scores et des profils par leur centre de gravité
    # avec éventuellement une ellipse de confiance de la position moyenne dérivée de la variable multinomiale
}
\usage{
s.multinom(dfxy, dfrowprof, translate = FALSE, xax = 1, yax = 2, 
labelcat = row.names(dfxy), clabelcat = 1, cpointcat = if (clabelcat == 0) 2 else 0, 
pchcat = 20, labelrowprof = row.names(dfrowprof), clabelrowprof = 0.75, 
cpointrowprof = if (clabelrowprof == 0) 2 else 0, pchrowprof = 20, 
coulrowprof = grey(0.8), proba = 0.95, n.sample = apply(dfrowprof, 1, sum),
axesell = TRUE, ...)
}
    # labelcat 
    # clabelcat l
    # pchcat 
    #
    # labelrowprof un vecteur d'étiquettes pour les profils
    # clabelrowprof la taille des caractères pour les étiquettes des profils utilisé avec par("cex")*clabelrowprof
    # pchrowprof le type de caractères pour les étiquettes des profils
    # coulrowprof 
    #
    # proba 
    # n.sample . 
    # La valeur 0 indique qu'on ne trace pas d'ellipses de confiance.
    # axesell 
    #
    # ... 

\arguments{
  \item{dfxy}{\code{dfxy} est un data.frame contenant au moins deux variables numériques.
  Les lignes de \code{dfxy} sont des catégories, typiquement 1,2 et 3 dans une représentation triangulaire.}
  \item{dfrowprof}{\code{dfrowprof} est un data.frame dont les colonnes correspondent aux lignes de \code{dfxy}.
  Les lignes de \code{dfxy} sont des profils ou distribution de fréquences sur les catégories.
  Le nombre de colonnes de \code{dfrowprof} doit être égal au nombre de lignes de \code{dfxy}.
  \code{row.names(dfxy)} et \code{names(dfrowprof)} doivent être identiques.}
  \item{translate}{logique si TRUE la figure est translatée et on place l'origine au centre de gravité pondéré des profils}
  \item{xax}{the column number of \code{dfxy} for the x-axis}
  \item{yax}{the column number of \code{dfxy} for the y-axis}
  \item{labelcat}{un vecteur d'étiquettes pour les catégories}
  \item{clabelcat}{un numerique pour la taille des caractères des étiquettes des catégories utilisé avec par("cex")*clabelcat}
  \item{cpointcat}{un numérique pour la taille des points représentant les catégories utilisé avec par("cex")*cpointcat}
  \item{pchcat}{le type de caractères pour les étiquettes des catégories}
  \item{labelrowprof}{un vecteur d'étiquettes pour les profils (lignes de \code{dfrowprof})}
  \item{clabelrowprof}{un numerique pour la taille des caractères des étiquettes des profils utilisé avec par("cex")*clabelrowprof}
  \item{cpointrowprof}{un numérique pour la taille des points représentant les profils utilisé avec par("cex")*cpointrowprof}
  \item{pchrowprof}{le type de caractères pour les étiquettes des profils}
  \item{coulrowprof}{un vecteur de couleurs utilisées pour les ellipses, éventuellement recyclé}
  \item{proba}{une valeur comprise entre 0.500 et 0.999 pour tracer une ellipse de confiance}
  \item{n.sample}{un vecteur de taille d'échantillon, éventuellement recyclé. Utiliser \code{n.sample=0} si les profils
   n'expriment pas un tirage multinomial et que les ellipses de confiance n'ont pas de sens.}
  \item{axesell}{logique si TRUE les axes de l'ellipse sont tracées}
  \item{\dots}{paramètres complémentaires pouvant être passé à \code{s.label} qui commence la figure.}
}

\value{
  Retourne de manière invisible une liste à deux composantes
  \item{tra}{vecteur de deux valeurs donnant la translation d'origine effectuée.}
  \item{ell}{matrice à 5 colonnes et autant de lignes que de profils donnant
  les moyennes, variances et covariance du profil pour les codes numeriques utilisés (colonne de \code{dfxy})}
}
\author{Daniel Chessel \email{chessel@biomserv.univ-lyon1.fr}}
\examples{
par(mfrow=c(2,2))
par(mar=c(0.1,0.1,0.1,0.1))
proba <- matrix(c(0.49,0.47,0.04,0.4,0.3,0.3,0.05,0.05,0.9,0.05,0.7,0.25),ncol=3,byrow=T)
proba.df <- as.data.frame (proba)
names(proba.df) <- c("A","B","C") ; row.names(proba.df) <- c("P1","P2","P3","P4")
w.proba <- triangle.plot(proba.df,clab=2,show=F)
box()

w.tri=data.frame(x=c(-sqrt(1/2),sqrt(1/2),0),y=c(-1/sqrt(6),-1/sqrt(6),2/sqrt(6)))
L3 <- c("A","B","C")
row.names(w.tri) <- L3
s.multinom(w.tri,proba.df,n.sample=0,coulrowprof="black",clabelrowprof=1.5)
s.multinom(w.tri,proba.df,n.sample=30,coul=palette()[5])
s.multinom(w.tri,proba.df,n.sample=60,coul=palette()[6],add.p=T)
s.multinom(w.tri,proba.df,n.sample=120,coul=grey(0.8),add.p=T)

print(s.multinom(w.tri,proba.df[-3,],n.sample=0,translate=T)$tra)

}
\keyword{multivariate}
\keyword{hplot}
