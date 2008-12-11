plot.4thcorner <- function(x, type=c("D","G"), alpha=0.05, ...) {
  type <- match.arg(type)
  if(!inherits(x, "4thcorner") & !inherits(x, "4thcorner.rlq"))
    stop("x must be of class '4thcorner' or '4thcorner.rlq'")
  if(type=="D" & !inherits(x, "4thcorner.rlq")){
    res <- data.frame(matrix(1, nrow(x$tabD),ncol(x$tabD)))
    names(res) <- names(x$tabD)
    row.names(res) <- row.names(x$tabD)
    
    adjProb <- x$tabDProb
    for(i in 1:nrow(res)){
      for(j in 1:ncol(res)){
        if ((x$indexR[x$assignR[j]]==1)&(x$indexQ[x$assignQ[i]]==1)){
          if(x$tabDProb[i,j]<alpha){
            res[i,j] <- ifelse(x$tabD[i,j]>x$tabDmoy[i,j], 2, 3)
          }
        } else {
          whichR <- which(x$assignR==x$assignR[j])
          
          whichQ <- which(x$assignQ==x$assignQ[i])
          ## compute adjusted pvalue for multiple comparisons
          adjProb[whichQ,whichR] <- p.adjust(as.matrix(x$tabDProb[whichQ,whichR]),"holm")
          if(adjProb[i,j]<alpha){
            res[i,j] <- ifelse(x$tabD[i,j]>x$tabDmoy[i,j], 2, 3)
          }
        }        
      }
    }
  } else {
    res <- data.frame(matrix(1, nrow(x$tabG),ncol(x$tabG)))
    names(res) <- names(x$tabG)
    row.names(res) <- row.names(x$tabG)
    for(i in 1:nrow(res)){
      for(j in 1:ncol(res)){
        if(x$tabGProb[i,j]<alpha){
          res[i,j] <- ifelse(x$tabG[i,j]>x$tabGmoy[i,j], 2, 3)
        }
      }
    }
    
    
    
  }
  
  plot4thcorner <- function (df, x1 = 1:ncol(df), y = nrow(df):1, row.labels = row.names(df),  col.labels = names(df), clabel.row = 1, clabel.col = 1, csize = 1, type, assignR,assignQ) 
    {
      x1 <- rank(x1)
      y <- rank(y)
      opar <- par(mai = par("mai"), srt = par("srt"))
      on.exit(par(opar))
      table.prepare(x = x1, y = y, row.labels = row.labels, col.labels = col.labels, 
                    clabel.row = clabel.row, clabel.col = clabel.col, grid = FALSE, 
                    pos = "paint")
      xtot <- x1[col(as.matrix(df))]
      ytot <- y[row(as.matrix(df))]
      xdelta <- (max(x1) - min(x1))/(length(x1) - 1)/2
      ydelta <- (max(y) - min(y))/(length(y) - 1)/2
      coeff <- diff(range(xtot))/15
      valgris <- c("white","grey20","grey80")
      z <- unlist(df)
      rect(xtot - xdelta, ytot - ydelta, xtot + xdelta, ytot + 
           ydelta, col = valgris[z], border = "grey90")
      
      if(type == "D"){
        
        idR <- which(diff(assignR)==1)
        idQ <- which(diff(assignQ)==1)
        segments(sort(unique(xtot))[idR]+xdelta, max(ytot+ydelta), sort(unique(xtot))[idR]+xdelta, min(ytot-ydelta), lwd=2)
        segments(max(xtot+xdelta), sort(unique(ytot), decreasing = TRUE)[idQ+1]+ydelta, min(xtot-xdelta), sort(unique(ytot), decreasing = TRUE)[idQ+1]+ydelta, lwd=2)
      }
      rect(min(xtot) - xdelta, min(ytot) - ydelta, max(xtot) + xdelta, max(ytot) + ydelta, col = NULL)
      
    }
  
  
  plot4thcorner(res, type=type, assignR = x$assignR, assignQ = x$assignQ)
  

}
