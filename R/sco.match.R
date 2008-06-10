"sco.match" <- function(score1, score2, label = names(score1),  clabel = 1, horizontal = TRUE, reverse = FALSE, pos.lab = 0.5, wmatch=3,pch = 20, cpoint = 1, boxes = TRUE,  lim = NULL, grid = TRUE,  cgrid = 1, include.origin = TRUE, origin = c(0,0), sub = "", csub = 1.25, possub = "bottomleft"){
  
  if(!is.vector(score1))
    stop("score1 should be a vector")
  if(!is.vector(score2))
    stop("score2 should be a vector")
  nval <- length(score1)
  if(nval != length(score2))
    stop("length of 'score1' or 'score2' is not convenient")
  if(is.null(label))
    label <- 1:nval
  if(nval != length(label))
    stop("length of 'label' is not convenient")
  
  if (pos.lab>1 | pos.lab<0)
    stop("pos.lab should be between 0 and 1")
  

  oldpar <- par(mar=rep(0.1, 4))
  on.exit(par(oldpar))
  res <- scatterutil.sco(score = c(score1,score2), lim = lim, grid = grid, cgrid = cgrid, include.origin = include.origin, origin = origin, sub = sub, csub = csub, horizontal = horizontal, reverse = reverse)
  if(horizontal){
    if(reverse) {
      points(score1, rep(1- res[3], nval), pch = pch,  cex = par("cex") * cpoint)
      abline(h=1- wmatch*res[3])
      points(score2, rep(1- wmatch*res[3], nval), pch = pch,  cex = par("cex") * cpoint)
      segments(score1,rep(1- res[3], nval),score2,rep(1- wmatch*res[3], nval))
    } else {
      points(score1, rep(res[3], nval), pch = pch,  cex = par("cex") * cpoint)
      abline(h=wmatch*res[3])
      points(score2, rep(wmatch*res[3], nval), pch = pch,  cex = par("cex") * cpoint)
      segments(score1,rep(res[3], nval),score2,rep(wmatch*res[3], nval))
    }
    if(clabel>0){
      if(is.null(pos.lab))
        pos.lab <- 0.5
      if(reverse){
        pos.lab <- 1 - wmatch * res[3] - pos.lab * (1 - wmatch * res[3])
        pos.elbow <- 1 - wmatch * res[3] - (1 - wmatch * res[3] - pos.lab)/5
      } else {
        pos.lab <- wmatch * res[3] + pos.lab * (1 - wmatch * res[3])
        pos.elbow <- wmatch * res[3] + (pos.lab - wmatch * res[3])/5
      }
      
      for (i in 1:nval)
        {
          xh <- strwidth(paste(" ", label[order(score2)][i], " ", sep = ""), cex = par("cex") * clabel)
          tmp <- scatterutil.convrot90(xh,0)
          yh <- tmp[2]
          yreg <- res[1] + (res[2] - res[1])/(nval + 1) * i
          segments(score2[order(score2)][i],pos.elbow ,yreg, pos.lab)
          if(reverse) {
            segments(score2[order(score2)][i], 1 - wmatch * res[3], score2[order(score2)][i], pos.elbow)
            scatterutil.eti(yreg, pos.lab - yh/2, label[order(score2)][i], clabel = clabel, boxes = boxes, horizontal = FALSE)
          } else {
            segments(score2[order(score2)][i], wmatch * res[3], score2[order(score2)][i], pos.elbow)
            scatterutil.eti(yreg, pos.lab + yh/2, label[order(score2)][i], clabel = clabel, boxes = boxes, horizontal = FALSE)
          }
        }
    }
  } else {
    if(reverse){
      points(rep(1 - res[3], nval), score1, pch = pch,  cex = par("cex") * cpoint)
      abline(v=1- wmatch*res[3])
      points(rep(1- wmatch*res[3], nval), score2, pch = pch,  cex = par("cex") * cpoint)
      segments(rep(1- res[3], nval),score1,rep(1- wmatch*res[3], nval), score2)
    } else {
      points(rep(res[3], nval), score1, pch = pch,  cex = par("cex") * cpoint)
      abline(v=wmatch*res[3])
      points(rep(wmatch*res[3], nval), score2, pch = pch,  cex = par("cex") * cpoint)
      segments(rep(res[3], nval),score1,rep(wmatch*res[3], nval), score2)
    }
    if(clabel>0){
      if(is.null(pos.lab))
        pos.lab <- 0.5
      if(reverse){
        pos.lab <- 1 - wmatch * res[3] - pos.lab * (1 - wmatch * res[3])
        pos.elbow <- 1- wmatch * res[3] - (1 - wmatch * res[3]- pos.lab)/5
      } else {
        pos.lab <- wmatch * res[3] + pos.lab * (1 - wmatch * res[3])
        pos.elbow <- wmatch * res[3] + (pos.lab - wmatch * res[3])/5
      }
      
      for (i in 1:nval)
        {
          xh <- strwidth(paste(" ", label[order(score2)][i], " ", sep = ""), cex = par("cex") * clabel)
          yreg <- res[1] + (res[2] - res[1])/(nval + 1) * i
          segments(pos.elbow,score2[order(score2)][i],pos.lab ,yreg)
          if(reverse) {
            segments(1 - wmatch * res[3],score2[order(score2)][i], pos.elbow, score2[order(score2)][i]) 
            scatterutil.eti(pos.lab - xh/2, yreg, label[order(score2)][i], clabel = clabel, boxes = boxes, horizontal = TRUE)
          } else {
            segments(wmatch * res[3],score2[order(score2)][i], pos.elbow, score2[order(score2)][i]) 
            scatterutil.eti(pos.lab + xh/2, yreg, label[order(score2)][i], clabel = clabel, boxes = boxes, horizontal = TRUE)
          }        
        }
    }
  }
  invisible(match.call())
}
