"dotchart.phylog" <- function(phylog, values, y = NULL, scaling = TRUE, ranging = TRUE, yranging = NULL,
 joining = TRUE, yjoining = NULL, ceti = 1, cdot = 1, csub = 1, f.phylog = 1/(1 + ncol(values)), ...) 
{

# l'argument scaling décide si l'on normalise les données ou non
# l'argument ranging décide si l'on adopte une échelle commune pour toutes les séries ou non
# l'argument yranging permet de fixer l'échelle commune à toutes les séries lorsque ranging = TRUE. Par défaut, l'échelle
# commune est choisit en prenant les valeurs extrêmes de l'ensemble des valeurs
# l'argument joining décide si'lon rajoute ou non des traits verticaux qui relie chaque point à un axe horizontal
# l'argument yjoining définit le niveau de l'axe horizontal. Par défaut, il s'agit de la moyenne de chaque série.
# les autres arguments sont des arguments graphiques:
# ceti pour la taille des absisses
# cdot pour la taille des carrés
# csub pour la taille du titre de chaque série
# f.phylog pour la taille relative de la phylogénie
    
    if (!inherits(phylog, "phylog")) 
        stop("Non convenient data")
        
    if (is.vector(values))
        values <- as.data.frame(values)
    
    if (!is.data.frame(values))
        stop("'values' is not a data frame")

    if (!is.numeric(as.matrix(values))) 
        stop("'values' is not numeric")
    
    n <- nrow(values)
    nvar <- ncol(values)
    names.var <- names(values)
    
    if (length(phylog$leaves) != n) 
        stop("Non convenient length")
    
    if (scaling == TRUE){
        values <- scalewt(values)
        values <- as.data.frame(values)
        names(values) <- names.var
    }
    
    w <- plot.phylog(x = phylog, y = y, clabel.leaves = 0, f.phylog = f.phylog, ...)
    mar.old <- par("mar")
    on.exit(par(mar = mar.old))
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    par(usr = c(0, 1, -0.05, 1))
    
    x1 <- w$xbase
    space <- (1 - w$xbase - (w$xbase - max(w$xy$x))/2*nvar)/nvar
    x2 <- x1 + space
    fun1 <- function(x) {x1 + (x2 - x1) * (x - x1.use)/(x2.use - x1.use)}
    
    ret <- cbind.data.frame(values,w$xy[,"y"])
    for(i in 1:nvar){
    
    if (ranging == TRUE){
            if (is.null(yranging))  
                val.ref <- pretty(range(values), 4)
                else
                    val.ref <- pretty(yranging, 4)
       }  
        else
            val.ref <- pretty(values[,i], 4)

    x1.use <- min(val.ref)
    x2.use <- max(val.ref)
    xleg <- fun1(val.ref)
    miny <- 0
    maxy <- max(w$xy$y)
    nleg <- length(xleg)
   
    segments(xleg, rep(miny, nleg), xleg, rep(maxy, nleg), col = grey(0.85))
    segments(w$xy$x, w$xy$y, rep(max(w$xy$x), n), w$xy$y, col = grey(0.85))
    segments(rep(xleg[1], n), w$xy$y, rep(max(xleg), n), w$xy$y, col = grey(0.85))
    
    if (cdot > 0) 
        points(fun1(values[,i]), w$xy$y, pch = 15, cex = cdot, bg = 1)

    if (ceti > 0){
        if (trunc(i/2) < (i/2))
            text(xleg, rep((miny - 0.05)*2/3, nleg), as.character(val.ref), cex = par("cex") * ceti)
            else
                text(xleg, rep((miny - 0.05)*1/3, nleg), as.character(val.ref), cex = par("cex") * ceti)
        }
                
    if (joining == TRUE){
        if (is.null(yjoining)) origin <- mean(values[,i])
            else origin <- 0
        segments(fun1(origin), miny, fun1(origin), maxy, lty = 2, col = grey(0.50))
        segments(fun1(values[,i]), w$xy$y, fun1(origin), w$xy$y, col = grey(0.50))
        }    
        
    if (csub > 0)
        text(xleg[3], 1 - (1-max(w$xy$y))/3, names(values)[i], cex = par("cex") * csub)
    
    ret[,i] <- fun1(values[,i])
        
    x1 <- x1 + space + (w$xbase - max(w$xy$x))/2
    x2 <- x2 + space + (w$xbase - max(w$xy$x))/2
    }
    return(invisible(ret))
}
