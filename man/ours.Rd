\encoding{latin1}
\name{ours}
\alias{ours}
\docType{data}
\title{A table of Qualitative Variables}
\usage{data(ours)}
\description{
  The \code{ours} (bears) data frame has 38 rows, areas of the "Inventaire National Forestier", and 10 columns.
}
\format{
  This data frame contains the following columns:
  \enumerate{
    \item altit: importance of the altitudinal area inhabited by bears,
    a factor with levels: 
    \itemize{
      \item \code{1} less than 50\% of the area between 800 and 2000 meters 
      \item \code{2} between 50 and 70\% 
      \item \code{3} more than 70\%}
    
    \item deniv: importance of the average variation in level by square of 50 km2, a factor with levels: 
    \itemize{
      \item \code{1} less than 700m
      \item \code{2} between 700 and 900 m 
      \item \code{3} more than 900 m }
    
    \item cloiso: partitioning of the massif, a factor with levels: 
    \itemize{
      \item \code{1} a great valley or a ridge isolates at least a quarter of the massif 
      \item \code{2} less than a quarter of the massif is isolated 
      \item \code{3} the massif has no split}
    
    \item domain: importance of the national forests on contact with the massif, a factor with levels: 
    \itemize{
      \item \code{1} less than 400  km2 
      \item \code{2} between 400 and 1000  km2 
      \item \code{3} more than 1000  km2 }
    
    \item boise: rate of afforestation, a factor with levels: 
    \itemize{
      \item \code{1} less than 30\% 
      \item \code{2} between 30 and 50\% 
      \item \code{3} more than 50\% }
    
    \item hetra: importance of plantations and mixed forests, a factor with levels: 
    \itemize{
      \item \code{1} less than 5\% 
      \item \code{2} between 5 and 10\% 
      \item \code{3} more than 10\% of the massif }
    
    \item favor: importance of favorable forests, plantations, mixed forests, fir plantations, a factor with levels: 
    \itemize{
      \item \code{1} less than 5\% 
      \item \code{2} between 5 and 10\% 
      \item \code{3} more than 10\% of the massif }
    
    \item inexp: importance of unworked forests, a factor with levels: 
    \itemize{
      \item \code{1} less than 4\% 
      \item \code{2} between 4 and 8\% 
      \item \code{3} more than 8\% of the total area }
    
    \item citat: presence of the bear before its disappearance, a factor with levels: 
    \itemize{
      \item \code{1} no quotation since 1840 
      \item \code{2} 1 to 3 quotations before 1900 and none after 
      \item \code{3} 4 quotations before 1900 and none after 
      \item \code{4} at least 4 quotations before 1900 and at least 1 quotation between 1900 and 1940 }
    
    \item depart: district, a factor with levels: 
    \itemize{
      \item \code{AHP} Alpes-de-Haute-Provence 
      \item \code{AM} Alpes-Maritimes 
      \item \code{D} Drôme 
      \item \code{HP} Hautes-Alpes 
      \item \code{HS} Haute-Savoie 
      \item \code{I} Isère 
      \item \code{S} Savoie}
  }
}
\source{
 Erome, G. (1989) \emph{L'ours brun dans les Alpes françaises. Historique de sa disparition}.
 Centre Ornithologique Rhône-Alpes, Villeurbanne. 120 p.
}
\examples{
data(ours)
if(adegraphicsLoaded()) {
  s1d.boxplot(dudi.acm(ours, scan = FALSE)$l1[, 1], ours)
} else {
  boxplot(dudi.acm(ours, scan = FALSE))
}
}
\keyword{datasets}
