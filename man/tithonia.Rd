\name{tithonia}
\alias{tithonia}
\docType{data}
\title{Phylogeny and quantitative traits of flowers}
\description{
This data set describes the phylogeny of 11 flowers as reported by Morales (2000). It also gives morphologic and demographic traits corresponding to these 11 species.
}
\usage{data(tithonia)}
\format{
\code{tithonia} is a list containing the 2 following objects : \cr  
            \item{tre}{is a character string giving the phylogenetic tree in Newick format.} 
            \item{tab}{is a data frame with 11 species and 14 traits (6 morphologic traits and 8 demographic).}    
        
        Variables of \code{tithonia$tab} are the following ones : \cr
        \item{morho1}{: is a numeric vector that describes the seed size (mm)}
        \item{morho2}{: is a numeric vector that describes the flower size (mm)}
        \item{morho3}{: is a numeric vector that describes the female leaf size (cm)}
        \item{morho4}{: is a numeric vector that describes the head size (mm)}
        \item{morho5}{: is a integer vector that describes the number of flowers per head}
        \item{morho6}{: is a integer vector that describes the number of seeds per head}
        \item{demo7}{: is a numeric vector that describes the seedling height (cm)}
        \item{demo8}{: is a numeric vector that describes the growth rate (cm/day)}
        \item{demo9}{: is a numeric vector that describes the germination time}
        \item{demo10}{: is a numeric vector that describes the establishment (per cent)}
        \item{demo11}{: is a numeric vector that describes the viability (per cent)}
        \item{demo12}{: is a numeric vector that describes the germination (per cent)}
        \item{demo13}{: is a integer vector that describes the resource allocation}
        \item{demo14}{: is a numeric vector that describes the adult height (m)}
}
\source{
Data were obtained from Morales, E. (2000) Estimating phylogenetic inertia in Tithonia (Asteraceae) : a comparative approach. \cr \emph{Evolution}, \bold{54}, 2, 475--484.
}
\examples{
data(tithonia)
phy <- newick2phylog(tithonia$tre)
tab <- log(tithonia$tab + 1)
table.phylog(scalewt(tab), phy)
gearymoran(phy$Wmat, tab)
gearymoran(phy$Amat, tab)
}
\keyword{datasets}
