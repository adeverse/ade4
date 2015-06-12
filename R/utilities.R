dudi.type <- function(x){
  ## Test the different types of dudi
  ##      typ=1 no modification (PCA on original variable)
  ##      typ=2 ACM 
  ##      typ=3 normed and centred PCA 
  ##      typ=4 centred PCA 
  ##      typ=5 normed and non-centred PCA 
  ##      typ=6 COA 
  ##      typ=7 FCA 
  ##      typ=8 Hill-smith
  ##      typ=9 Decentred PCA
  if(!is.call(x))
    stop("Argument x should be a 'call' object")
  x <- match.call(eval(x[[1]]),call = x) ## fill arguments names
  call.list <- as.list(x)
  dudi.name <- deparse(call.list[[1]])
  call.list <- modifyList(formals(dudi.name), call.list[-1]) ## fill with default for unused arguments
  
  if (dudi.name == "dudi.pca") {
    call.list$scale <- eval(call.list$scale)
    call.list$center <- eval(call.list$center)
    
    if(!(is.logical(call.list$center)))
      typ <- 9
    if (!call.list$center & !call.list$scale) typ <- 1
    if (!call.list$center & call.list$scale) typ <- 5
    if (call.list$center & !call.list$scale) typ <- 4
    if (call.list$center & call.list$scale) typ <- 3
  } else if (dudi.name == "dudi.fpca") {
    typ <- 4
  } else if (dudi.name == "dudi.coa") {
    typ <- 6
  } else if (dudi.name == "dudi.fca") {
    typ <- 7
  } else if (dudi.name == "dudi.acm") {
    typ <- 2
  } else if (dudi.name == "dudi.hillsmith") {
    typ <- 8
  } else stop ("Not yet available")
  return(typ)
}


adegraphicsLoaded <- function() {
    ## check if adegraphics is loaded
    "package:adegraphics"%in%search()
}
    
