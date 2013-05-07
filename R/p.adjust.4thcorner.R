p.adjust.4thcorner <- function(x, p.adjust.method.G = p.adjust.methods, p.adjust.method.D = p.adjust.methods, p.adjust.D = c("global", "levels")){

  if(!inherits(x, "4thcorner") & !inherits(x, "4thcorner.rlq"))
    stop("x must be of class '4thcorner' or '4thcorner.rlq'")
  
  p.adjust.D <- match.arg(p.adjust.D)
  p.adjust.method.D <- match.arg(p.adjust.method.D)
  p.adjust.method.G <- match.arg(p.adjust.method.G)

  ## for objects created by fourthcorner, fourthcorner2 or fourthcorner.rlq
  x$tabG$adj.pvalue <- p.adjust(x$tabG$pvalue, method=p.adjust.method.G)
  x$tabG$adj.method <- p.adjust.method.G

  ## tabD and tabD2 (i.e. not fourthcorner2)
  if(!inherits(x, "4thcorner.rlq")){
    if(p.adjust.D == "global"){
      x$tabD$adj.pvalue <- p.adjust(x$tabD$pvalue, method=p.adjust.method.D)
      x$tabD2$adj.pvalue <- p.adjust(x$tabD2$pvalue, method=p.adjust.method.D)
      x$tabD$adj.method <- x$tabD2$adj.method <- p.adjust.method.D
    }
    
    if(p.adjust.D == "levels"){
      ## adjustment only between levels of a factor (corresponds to the original paper of Legendre et al. 1997)
      for (i in 1:length(x$varnames.Q)){
        for (j in 1:length(x$varnames.R)){
          idx.varR <- which(x$assignR == j)
          idx.varQ <- which(x$assignQ == i)
          idx.vars <- length(x$varnames.R) * (idx.varQ - 1) + idx.varR
          x$tabD$adj.pvalue[idx.vars] <- p.adjust(x$tabD$pvalue[idx.vars], method = p.adjust.method.D)
          x$tabD2$adj.pvalue[idx.vars] <- p.adjust(x$tabD2$pvalue[idx.vars], method = p.adjust.method.D)
        }
      }
      x$tabD$adj.method <- x$tabD2$adj.method <- paste(p.adjust.method.D, "by levels")
    }
    
  }

  return(x)

}
