combine.4thcorner <- function(four1,four2){
  if(!inherits(four1, "4thcorner") || !inherits(four2, "4thcorner") )
    stop("objects must be of class '4thcorner'")          
  if(four1$call[[1]] != four2$call[[1]])
    stop("can not combine objects created by different functions")
  if(four1$call[[1]]=="fourthcorner.rlq"){
    if(four1$call$xtest != four2$call$xtest)
      stop("can not combine objects: different 'rlq' objects")
  } else {
    if(four1$call$tabR != four2$call$tabR)
      stop("can not combine objects: different tables R")
    if(four1$call$tabL != four2$call$tabL)
      stop("can not combine objects: different tables L")
    if(four1$call$tabQ != four2$call$tabQ)
      stop("can not combine objects: different tables Q")
  }
  
  ## test longueur (i.e. meme tableaux pour lignes et colonnes)
  ## test adjustment
  
  res <- four1
  ## For tabG
  if(four1$tabG$adj.method != four2$tabG$adj.method)
    stop("can not combine objects: diferent adjustment methods for tabG")
  for(i in 1:length(res$tabG$names)){
    idx <- ifelse(four2$tabG$adj.pvalue[i] > four1$tabG$adj.pvalue[i], 1, 2)
    if(idx==1) {
      tmp <- four2
    } else if(idx==2){
      tmp <- four1
    }
    res$tabG$expvar[i,] <-  tmp$tabG$expvar[i,]
    res$tabG$pvalue[i] <-  tmp$tabG$pvalue[i]
    res$tabG$adj.pvalue[i] <- tmp$tabG$adj.pvalue[i]
    res$tabG$sim[,i] <- tmp$tabG$sim[,i]
  }
  res$tabG$call <- match.call()
  
  if(!inherits(res, "4thcorner.rlq")){
    if(four1$tabD$adj.method != four2$tabD$adj.method)
      stop("can not combine objects: diferent adjustment methods for tabD")
    if(four1$tabD2$adj.method != four2$tabD2$adj.method)
      stop("can not combine objects: diferent adjustment methods for tabD2")
    for(i in 1:length(res$tabD$names)){
      ## For tabD
      idx <- ifelse(four2$tabD$adj.pvalue[i] > four1$tabD$adj.pvalue[i], 1, 2)
      idx <- ifelse(is.na(idx), 1, idx) ## NA could occur in the case of factor with one level. In this case, return the first output
      if(idx == 1) {
        tmp <- four2
      } else if(idx == 2){
        tmp <- four1
      }
      res$tabD$expvar[i,] <-  tmp$tabD$expvar[i,]
      res$tabD$pvalue[i] <-  tmp$tabD$pvalue[i]
      res$tabD$adj.pvalue[i] <- tmp$tabD$adj.pvalue[i]
      res$tabD$sim[,i] <- tmp$tabD$sim[,i]
      
      ## For tabD2
      idx <- ifelse(four2$tabD2$adj.pvalue[i] > four1$tabD2$adj.pvalue[i], 1, 2)
      if(idx==1) {
        tmp <- four2
      } else if(idx==2){
        tmp <- four1
      }
      res$tabD2$expvar[i,] <-  tmp$tabD2$expvar[i,]
      res$tabD2$pvalue[i] <-  tmp$tabD2$pvalue[i]
      res$tabD2$adj.pvalue[i] <- tmp$tabD2$adj.pvalue[i]
      res$tabD2$sim[,i] <- tmp$tabD2$sim[,i]
    }
    res$tabD2$call <- res$tabD$call <- match.call()
  } else {
    ## For trRLQ
    idx <- ifelse(four2$trRLQ$pvalue > four1$trRLQ$pvalue, 1, 2)
    if(idx==1) {
      tmp <- four2
    } else if(idx==2){
      tmp <- four1
    }
    res$trRLQ <- tmp$trRLQ
    res$trRLQ$call <- match.call()
  }

  res$call <- match.call()
  res$model <- paste("Comb.", four1$model, "and", four2$model)
  class(res) <- c(class(res), "combine")
  return(res)
  
}
