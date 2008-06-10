################################
## Evenly spaced labels for a score
################################
## Can be used as a legend for the Gauss curve function.
## Takes one vector of quantitative values (abscissae) and draws lines connecting
## these abscissae to evenly spaced labels. 
################################
"sco.label" <- function(score, label = names(score),  clabel = 1, horizontal = TRUE, reverse = FALSE, pos.lab = 0.5, pch = 20, cpoint = 1, boxes = TRUE,  lim = NULL, grid = TRUE, cgrid = 1, include.origin = TRUE, origin = c(0,0), sub = "", csub = 1.25, possub = "bottomleft"){
  
  if(!is.vector(score))
    stop("score should be a vector")
  nval <- length(score)
  if(is.null(label))
    label <- 1:nval
  if(nval != length(label))
    stop("length of 'label' is not convenient")
  
  if (pos.lab>1 | pos.lab<0)
    stop("pos.lab should be between 0 and 1")
  

  oldpar <- par(mar=rep(0.1, 4))
  on.exit(par(oldpar))
  res <- scatterutil.sco(score = score, lim = lim, grid = grid, cgrid = cgrid, include.origin = include.origin, origin = origin, sub = sub, csub = csub, horizontal = horizontal, reverse = reverse)
  if(horizontal){
    if(reverse) {
      points(score, rep(1- res[3], nval), pch = pch,  cex = par("cex") * cpoint)
    } else {
      points(score, rep(res[3], nval), pch = pch,  cex = par("cex") * cpoint)
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
      
      for (i in 1:nval)
        {
          xh <- strwidth(paste(" ", label[order(score)][i], " ", sep = ""), cex = par("cex") * clabel)
          tmp <- scatterutil.convrot90(xh,0)
          yh <- tmp[2]
          y2 <- res[1] + (res[2] - res[1])/(nval + 1) * i
          segments(score[order(score)][i],pos.elbow ,y2, pos.lab)
          if(reverse) {
            segments(score[order(score)][i], 1 - res[3], score[order(score)][i], pos.elbow)
            scatterutil.eti(y2, pos.lab - yh/2, label[order(score)][i], clabel = clabel, boxes = boxes, horizontal = FALSE)
          } else {
            segments(score[order(score)][i], res[3], score[order(score)][i], pos.elbow)
            scatterutil.eti(y2, pos.lab + yh/2, label[order(score)][i], clabel = clabel, boxes = boxes, horizontal = FALSE)
          }
        }
    }
  } else {
    if(reverse){
      points(rep(1 - res[3], nval), score, pch = pch,  cex = par("cex") * cpoint)
    } else {
      points(rep(res[3], nval), score, pch = pch,  cex = par("cex") * cpoint)
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
      
      for (i in 1:nval)
        {
          xh <- strwidth(paste(" ", label[order(score)][i], " ", sep = ""), cex = par("cex") * clabel)
          y2 <- res[1] + (res[2] - res[1])/(nval + 1) * i
          segments(pos.elbow,score[order(score)][i],pos.lab ,y2)
          if(reverse) {
            segments(1 - res[3],score[order(score)][i], pos.elbow, score[order(score)][i]) 
            scatterutil.eti(pos.lab - xh/2, y2, label[order(score)][i], clabel = clabel, boxes = boxes, horizontal = TRUE)
          } else {
            segments(res[3],score[order(score)][i], pos.elbow, score[order(score)][i]) 
            scatterutil.eti(pos.lab + xh/2, y2, label[order(score)][i], clabel = clabel, boxes = boxes, horizontal = TRUE)
          }        
        }
    }
  }
  invisible(match.call()) 
}
