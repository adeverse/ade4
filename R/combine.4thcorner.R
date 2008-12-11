combine.4thcorner <- function(four1,four2){
   if(inherits(four1, "4thcorner.rlq") & !inherits(four2, "4thcorner.rlq"))
     stop("can not combine objects created by both fourthcorner and fourthcorner2")
   if(!inherits(four1, "4thcorner.rlq") & inherits(four2, "4thcorner.rlq"))
     stop("can not combine objects created by both fourthcorner and fourthcorner2")
   
  res <- four1
  
  
  res$tabGmin <- replace(res$tabGmin, 1:length(res$tabGmin), NA)
  res$tabGmax <- replace(res$tabGmax, 1:length(res$tabGmax), NA)
  res$tabGNEQ <- replace(res$tabGNEQ, 1:length(res$tabGNEQ), NA)
  res$tabGNLT <- replace(res$tabGNLT, 1:length(res$tabGNLT), NA)
  for(i in 1:nrow(res$tabGProb)){
      for(j in 1:ncol(res$tabGProb)){
        res$tabGProb[i,j] <- max(c(four2$tabGProb[i,j],four1$tabGProb[i,j]))
        res$tabGmoy[i,j] <- (four2$tabGmoy[i,j]+four1$tabGmoy[i,j])/2
      }
    }
  
  
  res$call <- match.call()
  res$model <- paste("Comb.", four1$model, "and", four2$model)
  
  if(!inherits(res, "4thcorner.rlq")){
    res$tabDmin <- replace(res$tabDmin, 1:length(res$tabDmin), NA)
    res$tabDmax <- replace(res$tabDmax, 1:length(res$tabDmax), NA)
    res$tabDNEQ <- replace(res$tabDNEQ, 1:length(res$tabDNEQ), NA)
    res$tabDNLT <- replace(res$tabDNLT, 1:length(res$tabDNLT), NA)
    res$tabDNperm <- replace(res$tabDNperm, 1:length(res$tabDNperm), NA)
    
    res$tabD2min <- replace(res$tabD2min, 1:length(res$tabD2min), NA)
    res$tabD2max <- replace(res$tabD2max, 1:length(res$tabD2max), NA)
    res$tabD2NEQ <- replace(res$tabD2NEQ, 1:length(res$tabD2NEQ), NA)
    res$tabD2NLT <- replace(res$tabD2NLT, 1:length(res$tabD2NLT), NA)
    res$tabG2min <- replace(res$tabG2min, 1:length(res$tabG2min), NA)
    res$tabG2max <- replace(res$tabG2max, 1:length(res$tabG2max), NA)
    res$tabG2NEQ <- replace(res$tabG2NEQ, 1:length(res$tabG2NEQ), NA)
    res$tabG2NLT <- replace(res$tabG2NLT, 1:length(res$tabG2NLT), NA)
    res$tabG2moy <- replace(res$tabG2moy, 1:length(res$tabG2moy), NA)
    for(i in 1:nrow(res$tabDProb)){
      for(j in 1:ncol(res$tabD2Prob)){
        res$tabDProb[i,j] <- max(c(four2$tabDProb[i,j],four1$tabDProb[i,j]))
        res$tabD2Prob[i,j] <- max(c(four2$tabD2Prob[i,j],four1$tabD2Prob[i,j]))
        res$tabDmoy[i,j] <- (four2$tabDmoy[i,j]+four1$tabDmoy[i,j])/2
        res$tabD2moy[i,j] <- (four2$tabD2moy[i,j]+four1$tabD2moy[i,j])/2
             
      }
    }
    for(i in 1:nrow(res$tabG2Prob)){
      for(j in 1:ncol(res$tabG2Prob)){
        res$tabG2Prob[i,j] <- max(c(four2$tabG2Prob[i,j],four1$tabG2Prob[i,j]))
        res$tabG2moy[i,j] <- (four2$tabG2moy[i,j]+four1$tabG2moy[i,j])/2
             
      }
    }    
  }

   class(res) <- c(class(res), "combine")
return(res)

}
