\name{area.plot}
\alias{area.plot}
\alias{poly2area}
\alias{area2poly}
\alias{area2link}
\alias{area.util.contour}
\alias{area.util.xy}
\title{Graphical Display of Areas}
\description{
'area' is a data frame with three variables.\cr
The first variable is a factor defining the polygons.\cr
The second and third variables are the xy coordinates of the
polygon vertices in the order where they are found.

area.plot : grey levels areas mapping

poly2area takes an object of class 'polylist' (spdep package, that contains the
older package 'spweights') and returns a data frame of type area.\cr
area2poly takes an object of type 'area' and returns a list of class 'polylist'\cr
area.util.contour and area.util.xy are two utility functions.
}
\usage{
area.plot(x, center = NULL, values = NULL, graph = NULL, lwdgraph = 2,
nclasslegend = 8, clegend = 0.75, sub = "", csub = 1, 
possub = "topleft", cpoint = 0, label = NULL, clabel = 0, ...)

area2poly(area)
poly2area (polys)
}
\arguments{
\item{x}{a data frame with three variables}
\item{center}{a matrix with the same row number as x and two columns, the coordinates
of polugone centers. If NULL, it is computed with \code{area.util.xy}}
\item{values}{if not NULL, a vector which values will be mapped to grey levels.
The values must be in the same order as the values in \code{unique(x.area[,1])}}
\item{graph}{if not NULL, \code{graph} is a neighbouring graph (object of class "neig") between polygons}
\item{lwdgraph}{a line width to draw the neighbouring graph}
\item{nclasslegend}{if \code{value} not NULL, a number of classes for the legend}
\item{clegend}{if not NULL, a character size for the legend, used with \code{par("cex")*clegend}}
\item{sub}{a string of characters to be inserted as sub-title}
\item{csub}{a character size for the sub-titles, used with \code{par("cex")*csub}}
\item{possub}{a string of characters indicating the sub-titles position 
("topleft", "topright", "bottomleft", "bottomright")}
\item{cpoint}{if positive, a character size for drawing the polygons vertices (check up),
used with \code{par("cex")*cpoint}}
\item{label}{if not NULL, by default the levels of the factor that define the polygons
are used as labels. To change this value, use label. These labels must be in the same order than
\code{unique(x.area[,1])}}
\item{clabel}{if not NULL, a character size for the polygon labels, used with \code{par("cex")*clabel}}
\item{polys}{a list belonging to the 'polylist' class in the spdep package}
\item{area}{a data frame of class 'area'}
\item{\dots}{further arguments passed to or from other methods}
}
\value{
poly2area returns a data frame 'factor,x,y'. \cr
area2poly returns a list of class \code{polylist}. \cr
}
\examples{
data(elec88)
par(mfrow = c(2,2))
area.plot(elec88$area, cpoint = 1)
area.plot(elec88$area, lab = elec88$lab, clab = 0.75)
area.plot(elec88$area, clab = 0.75)
# elec88$neig <- neig(area = elec88$area)
area.plot(elec88$area, graph = elec88$neig, 
sub = "Neighbourhood graph", possub = "topright")

par(mfrow = c(3,3))
for (i in 1:9) {
    x <- elec88$tab[,i]
    area.plot(elec88$area, val=x,
    sub = names(elec88$tab)[i], csub = 3, cleg = 1.5)
}

par(mfrow = c(3,3))
for (i in 1:9) {
    x <- elec88$tab[,i]
    s.value(elec88$xy, elec88$tab[,i], contour = elec88$contour,
    meth = "greylevel", sub = names(elec88$tab)[i], csub = 3, 
    cleg = 1.5, incl = FALSE)
}

data(irishdata)
par(mfrow = c(2,2))
w <- area.util.contour(irishdata$area)
xy <- area.util.xy(irishdata$area)
area.plot(irishdata$area, cpoint = 1)
apply(w, 1, function(x) segments(x[1],x[2],x[3],x[4], lwd = 3))
area.plot(irishdata$area, clabel = 1)
s.label(xy, area = irishdata$area, incl = FALSE, clab = 0, 
cpoi = 3, addax = FALSE, contour = w)
s.label(xy, area = irishdata$area, incl = FALSE, 
addax = FALSE, contour = w)
if (require(spdep, quiet = TRUE)) {
    data(columbus)
    par(mfrow = c(2,2))
    plot(col.gal.nb, coords, pch = 20, cex = 2)
    col.gal.neig <- nb2neig(col.gal.nb)
    s.label(data.frame(coords), neig = col.gal.neig,
    inc = FALSE, addax = FALSE, clab = 0, cneig = 1, cpo = 2)
    plotpolys(polys,bbs)
    area.plot(poly2area(polys))

    # 1
    crime.f <- as.ordered(cut(columbus$CRIME,
    breaks = quantile(columbus$CRIME, probs = seq(0,1,0.2)),
    include.lowest = TRUE))
    colours <- c("salmon1", "salmon2", "red3", "brown", "black")
    plot(bbs[,1], bbs[,4], xlab = "", ylab = "", asp = 1, type = "n",
    xlim = range(c(bbs[,1], bbs[,3])), ylim = range(c(bbs[,2], bbs[,4])))
    for (i in 1:length(polys)) 
    polygon(polys[[i]], col = colours[codes(crime.f[i])])
    legend(x = c(6, 7.75), y = c(13.5, 15), legend = levels(crime.f),
    fill = colours, cex = 0.7)
    title(sub = paste("Columbus OH: residential burglaries and ",
    "vehicle\nthefts", "per thousand households, 1980"))
    
    # 2
    area1 <- poly2area(polys)
    w <- area.util.contour(area1)
    wxy <- area.util.xy(area1)
    area.plot(area1, values = columbus$CRIME, sub = paste("Columbus ",
    "OH: residential burglaries and vehicle\nthefts",
    "per thousand households, 1980"))
    apply(w, 1, function(x) segments(x[1], x[2], x[3], x[4], lwd = 2))

    # 3
    data(elec88)
    fr.area <- elec88$area
    fr.xy <- area.util.xy(fr.area)
    fr.neig <- elec88$neig # neig(area = fr.area)

    # 4
    fr.poly <- area2poly(fr.area)
    fr.nb <- neig2nb(fr.neig)
    plotpolys(fr.poly, attr(fr.poly, "region.rect"), border = "grey")
    plot(fr.nb, fr.xy, add = TRUE)
    s.label(fr.xy, clab = 0, area = fr.area, neig = fr.neig, 
    cneig = 1, cpo = 2, inc = FALSE, addax = FALSE)
}
}
\keyword{hplot}
