######################################################
# Function to add sub-graphics to an existing plot
# Thibaut Jombart 2007
# (t.jombart@imperial.ac.uk)
######################################################

# Note: this function uses par("plt"), which interacts with other par()
# otions
# When addgraph is used with a function which uses par(), it is safer to
# add along other options: par([other options],plt=par("plt"))

#######################
# Function add.scatter
#######################
add.scatter <- function(func,posi=c("bottomleft","bottomright","topleft","topright"),ratio=.2,inset=.01,bg.col='white'){

  if(tolower(posi[1])=="none") return()
  
  if(ratio>.99) ratio <- .99
  if(ratio<0) ratio <- .2
  
  # set inset in x and y
  if(length(inset)==2) {
    inset.x <- inset[1]
    inset.y <- inset[2]
  } else{
    inset.x <- inset[1]
    inset.y <- inset[1]
  }

  inset[inset<0] <- 0  
  
  plotreg0 <- par('plt')
  plotreg <- plotreg0 + c(inset.x,-inset.x,inset.y,-inset.y)

  # restore full plot region and previous graphic parameters on exit 
  on.exit(par(plt=plotreg0))

  # handle position
  # "top" and "bottom" are considered as "topleft" and "bottomleft"
  posi <- tolower(posi[1])
  
  if(posi=="bottomleft" || posi=="bottom") {
    x1 <- plotreg[1]
    y1 <- plotreg[3]
  }else if(posi=="topleft" || posi=="top") {
    x1 <- plotreg[1]
    y1 <- plotreg[4]-ratio
  }else if(posi=="bottomright") {
    x1 <- plotreg[2]-ratio
    y1 <- plotreg[3]
  }else if(posi=="topright") {
    x1 <- plotreg[2]-ratio
    y1 <- plotreg[4]-ratio
  }else stop("Unknown position required")
  
  x2 <- x1+ratio
  y2 <- y1+ratio

  # clean subplot region
  par(plt=c(x1,x2,y1,y2),new=TRUE)
  plot.new()
  polygon(c(-0.1, 1.1, 1.1, -0.1), c(-0.1, -0.1, 1.1, 1.1), border = NA, col = bg.col)

  # draw the subplot
  # beware: if func uses par, it must specify "par(...,plt=par("plt",...)"
  # (due to weired par interaction, e.g. with par(mar))
  par(plt=c(x1,x2,y1,y2),new=TRUE)
  eval(func)

  return(invisible(match.call()))
  
} # end add.scatter 


###########################
# Function add.scatter.eig
###########################
"add.scatter.eig" <- function (w, nf=NULL, xax, yax, posi = "bottomleft", ratio = .25, inset = .01, sub="Eigenvalues",csub=2*ratio){
  opar <- par("mar","xaxt","yaxt")
  on.exit(par(opar))
  par(mar=rep(.1,4),xaxt="n",yaxt="n")

  fgraph <- function(){
    scatterutil.eigen(w, nf=nf, wsel=c(xax,yax), sub=sub, csub=csub, box=TRUE)
  }
  
  add.scatter( fgraph(), posi=posi, ratio=ratio, inset=inset)
  
} # end add.scatter.eig
