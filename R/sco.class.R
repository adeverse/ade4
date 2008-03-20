"sco.class" <- function(score, fac, label = levels(fac),  clabel = 1, horizontal = TRUE, reverse = FALSE, pos.lab = 0.5, pch = 20, cpoint = 1, boxes = TRUE,  col = rep(1, length(levels(fac))), lim = NULL, grid = TRUE,  cgrid = 1, include.origin = TRUE, origin = c(0,0), sub = "", csub = 1.25, possub = "bottomleft"){
  
  if(!is.vector(score))
    stop("score should be a vector")
  nval <- length(score)
  if(is.null(label))
    label <- 1:nlevels(fac)
  if(nlevels(fac) != length(label))
    stop("length of 'label' is not convenient")
  
  if (pos.lab>1 | pos.lab<0)
    stop("pos.lab should be between 0 and 1")
  if (!is.factor(fac)) 
    stop("factor expected for fac")


  oldpar <- par(mar=rep(0.1, 4))
  on.exit(par(oldpar))
  res <- scatterutil.sco(score = score, lim = lim, grid = grid, cgrid = cgrid, include.origin = include.origin, origin = origin, sub = sub, csub = csub, horizontal = horizontal, reverse = reverse)
  ymean <- tapply(score,fac,mean)
  y2 <- rep(0, nlevels(fac))
  if(horizontal){
    if(reverse) {
      points(score, rep(1- res[3], nval), pch = pch,  cex = par("cex") * cpoint, col=col[fac])
    } else {
      points(score, rep(res[3], nval), pch = pch,  cex = par("cex") * cpoint, col=col[fac])
    }
    if(clabel>0){
      if(is.null(pos.lab))
        pos.lab <- 0.5
      if(reverse){
        pos.lab <- 1 - res[3] - pos.lab * (1 - res[3])
        pos.elbow <- 1- res[3] - (pos.lab - res[3])/5
      } else {
        pos.lab <- res[3] + pos.lab * (1 - res[3])
        pos.elbow <- res[3] + (pos.lab - res[3])/5
      }
      
      for (i in 1:nlevels(fac))
        {
          xh <- strwidth(paste(" ", label[order(ymean)][i], " ", sep = ""), cex = par("cex") * clabel)
          tmp <- scatterutil.convrot90(xh,0)
          yh <- tmp[2]
          y2[i] <- res[1] + (res[2] - res[1])/(nlevels(fac) + 1) * i
          
          if(reverse) {
            scatterutil.eti(y2[i], pos.lab - yh/2, label[order(ymean)][i], clabel = clabel, boxes = boxes, horizontal = FALSE, coul = col[order(ymean)][i])
          } else {
            scatterutil.eti(y2[i], pos.lab + yh/2, label[order(ymean)][i], clabel = clabel, boxes = boxes, horizontal = FALSE, coul = col[order(ymean)][i])
          }
        }
      for (i in 1:nval)
        {
          lev <- which(levels(fac)==fac[i])
          segments(score[i],pos.elbow ,y2[which(order(ymean)==lev)], pos.lab, col = col[lev])
          if(reverse) {
            segments(score[i], 1 - res[3], score[i], pos.elbow, col = col[lev])
          } else {
            segments(score[i], res[3], score[i], pos.elbow, col = col[lev])
          }
        }
    }
  } else {
    if(reverse){
      points(rep(1 - res[3], nval), score, pch = pch,  cex = par("cex") * cpoint, col=col[fac])
    } else {
      points(rep(res[3], nval), score, pch = pch,  cex = par("cex") * cpoint, col=col[fac])
    }
    if(clabel>0){
      if(is.null(pos.lab))
        pos.lab <- 0.5
      if(reverse){
        pos.lab <- 1 - res[3] - pos.lab * (1 - res[3])
        pos.elbow <- 1- res[3] - (pos.lab - res[3])/5
      } else {
        pos.lab <- res[3] + pos.lab * (1 - res[3])
        pos.elbow <- res[3] + (pos.lab - res[3])/5
      }
      
      for (i in 1:nlevels(fac))
        {
          xh <- strwidth(paste(" ", label[order(ymean)][i], " ", sep = ""), cex = par("cex") * clabel)
          y2[i] <- res[1] + (res[2] - res[1])/(nlevels(fac) + 1) * i
          
          if(reverse) {
            scatterutil.eti(pos.lab - xh/2, y2[i],  label[order(ymean)][i], clabel = clabel, boxes = boxes, horizontal = TRUE, coul = col[order(ymean)][i])
          } else {
            scatterutil.eti(pos.lab + xh/2, y2[i],  label[order(ymean)][i], clabel = clabel, boxes = boxes, horizontal = TRUE, coul = col[order(ymean)][i])
          }
        }
      for (i in 1:nval)
        {
          lev <- which(levels(fac)==fac[i])
          segments(pos.elbow,score[i],pos.lab ,y2[which(order(ymean)==lev)], col = col[lev])
          if(reverse) {
            segments(1 - res[3],score[i], pos.elbow, score[i], col = col[lev]) 
            
          } else {
            segments(res[3],score[i], pos.elbow, score[i], col = col[lev]) 
            
          }        
        }
    }
  }
  invisible(match.call())
}
