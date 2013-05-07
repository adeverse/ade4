"fourthcorner2" <- function(tabR, tabL, tabQ, modeltype = 6,nrepet = 999, tr01 = FALSE, p.adjust.method.G = p.adjust.methods) {  
  
  ## tabR ,tabL, tabQ are 3 data frames containing the data    
  ## permut.model is the permutational model and can take 6 values (1:6). 6 corresponds to the combined approach      
  
  
  
  ## -------------------------------  
  ## Test of the different arguments 
  ## -------------------------------  
  
  if (!is.data.frame(tabR))   
    stop("data.frame expected") 
  
  if (!is.data.frame(tabL))   
    stop("data.frame expected")  
  
  if (!is.data.frame(tabQ))   
    stop("data.frame expected")
  
  if (any(is.na(tabR)))   
    stop("na entries in table")  
  
  if (any(is.na(tabL)))   
    stop("na entries in table") 
  
  if (any(tabL<0))   
    stop("negative values in table L")  
  
  if (any(is.na(tabQ)))   
    stop("na entries in table")
  
  p.adjust.method.G <- match.arg(p.adjust.method.G)       
  
  if (sum(modeltype==(1:6))!=1)
    stop("modeltype should be 1, 2, 3, 4, 5 or 6")

  if(modeltype == 6){
    test1 <- fourthcorner2(tabR, tabL, tabQ, modeltype = 2,nrepet = nrepet, tr01 = tr01, p.adjust.method.G = p.adjust.method.G)
    test2 <- fourthcorner2(tabR, tabL, tabQ, modeltype = 4,nrepet = nrepet, tr01 = tr01, p.adjust.method.G = p.adjust.method.G)
    res <- combine.4thcorner(test1,test2)
    res$call <- res$tabG$call <- res$trRLQ$call <- match.call()
    return(res)
  }
  
  nrowL <- nrow(tabL)  
  ncolL <- ncol(tabL)  
  nrowR <- nrow(tabR)  
  nrowQ <- nrow(tabQ)
  
  nvarQ <- ncol(tabQ)  
  nvarR <- ncol(tabR)
  
  if (nrowR != nrowL)   
    stop("Non equal row numbers")
  if (nrowQ != ncolL)   
    stop("Non equal row numbers")  
  
  ## transform the data into prsence-absence if trO1 = TRUE
  if (tr01)   
    {  
      cat("Values in table L are 0-1 transformed\n")  
      tabL <- ifelse(tabL==0,0,1)  
      
    }   
  
  ## ------------------------------------------ 
  ## Create the data matrices for R and Q 
  ## Transform factors into dsjunctive tables 
  ## tabR becomes matR  and tabQ becomes matQ     
  ## ------------------------------------------  
  
  ## For tabR
  matR <- matrix(0, nrowR, 1)  
  provinames <- "tmp"  
  assignR <- NULL  
  k <- 0
  indexR <- rep(0, nvarR) 
  
  for (j in 1:nvarR) {
    ## Get the type of data
    ## The type is store in the index vector (1 for numeric / 2 for factor)
    if (is.numeric(tabR[, j])) {
      indexR[j] <- 1
      matR <- cbind(matR, tabR[, j])  
      provinames <- c(provinames, names(tabR)[j])  
      k <- k + 1  
      assignR <- c(assignR, k)  
    }  
    else if (is.factor(tabR[, j])) {
      indexR[j] <- 2
      if (is.ordered(tabR[, j]))   
        warning("ordered variables will be considered as factor")  
      w <- fac2disj(tabR[, j], drop = TRUE)  
      cha <- paste(substr(names(tabR)[j], 1, 5), ".", names(w), sep = "")  
      matR <- cbind(matR, w)  
      provinames <- c(provinames, cha)  
      k <- k + 1  
      assignR <- c(assignR, rep(k, length(cha)))  
    } else stop("Not yet available")
  } 
  matR <- data.frame(matR[, -1])  
  names(matR) <- provinames[-1]
  ncolR <- ncol(matR)
  ## ----------  
  
  ## For tabQ
  matQ <- matrix(0, nrowQ, 1)  
  provinames <- "tmp"  
  assignQ <- NULL  
  k <- 0
  indexQ <- rep(0, nvarQ)
  
  for (j in 1:nvarQ) {
    ## Get the type of data
    ## The type is store in the index vector (1 for numeric / 2 for factor)
    if (is.numeric(tabQ[, j])) {  
      indexQ[j] <- 1
      matQ <- cbind(matQ, tabQ[, j])  
      provinames <- c(provinames, names(tabQ)[j])  
      k <- k + 1  
      assignQ <- c(assignQ, k)  
    }  
    else if (is.factor(tabQ[, j])) {
      indexQ[j] <- 2
      if (is.ordered(tabQ[, j]))   
        warning("ordered variables will be considered as factor")  
      w <- fac2disj(tabQ[, j], drop = TRUE)  
      cha <- paste(substr(names(tabQ)[j], 1, 5), ".", names(w), sep = "")  
      matQ <- cbind(matQ, w)  
      provinames <- c(provinames, cha)  
      k <- k + 1  
      assignQ <- c(assignQ, rep(k, length(cha)))  
    }
  }  
  matQ <- data.frame(matQ[, -1])  
  names(matQ) <- provinames[-1]
  ncolQ <- ncol(matQ) 
  ## ----------  
  
  ##----- create objects to store results -------#  
  tabG <- matrix(0,nrepet + 1, nvarR * nvarQ)
  trRLQ <- rep(0, nrepet + 1)
  res <- list()
  
  ##------------------
  ##   Call the C code
  ##------------------
  res <- .C("quatriemecoin2",
            as.double(t(matR)),
            as.double(t(tabL)),
            as.double(t(matQ)),  
            as.integer(ncolR),
            as.integer(nvarR),
            as.integer(nrowL),
            as.integer(ncolL),
            as.integer(ncolQ),
            as.integer(nvarQ),
            as.integer(nrepet),
            modeltype = as.integer(modeltype),  
            tabG = as.double(tabG),
            trRLQ = as.double(trRLQ),
            as.integer(indexR),
            as.integer(indexQ),
            as.integer(assignR),
            as.integer(assignQ),
            PACKAGE="ade4")[c("tabG", "trRLQ")]
  
  ##-------------------------------------------------------------------#
  ##                       Outputs                                     #
  ##-------------------------------------------------------------------#
  
  res$varnames.R <- names(tabR)
  res$colnames.R <- names(matR)
  res$varnames.Q <- names(tabQ)
  res$colnames.Q <- names(matQ)
  res$indexQ <- indexQ
  res$assignQ <- assignQ
  res$assignR <- assignR
  res$indexR <- indexR
  
  ## set invalid permutation to NA (in the case of levels of a factor with no observation)
  res$tabG <- ifelse(res$tabG < (-998), NA, res$tabG)

  ## Reshape the tables
  res$tabG <- matrix(res$tabG, nrepet + 1, nvarR * nvarQ, byrow=TRUE)

  ## Create vectors to store type of statistics and alternative hypotheses
  names.stat.G <- vector(mode="character")
  alter.G <-  rep("greater", nvarQ * nvarR)

  for (i in 1:nvarQ){
    for (j in 1:nvarR){
      ## Type of statistics for G 
      if ((res$indexR[j]==1)&(res$indexQ[i]==1))
        names.stat.G <- c(names.stat.G, "r^2")
      if ((res$indexR[j]==1)&(res$indexQ[i]==2))
        names.stat.G <- c(names.stat.G, "Eta^2")
      if ((res$indexR[j]==2)&(res$indexQ[i]==1))
        names.stat.G <- c(names.stat.G, "Eta^2")
      if ((res$indexR[j]==2)&(res$indexQ[i]==2))
        names.stat.G <- c(names.stat.G, "Chi2/sum(L)")
    }
  }
  
  provinames <- apply(expand.grid(res$varnames.R, res$varnames.Q), 1, paste, collapse=" / ")
  res$tabG <- as.krandtest(obs = res$tabG[1, ], sim = res$tabG[-1, ,drop = FALSE], names = provinames, alter = alter.G, call = match.call(), p.adjust.method = p.adjust.method.G)
  res$trRLQ <- as.randtest(obs = res$trRLQ[1], sim = res$trRLQ[-1], alter = "greater", call = match.call())
  res$tabG$statnames <- names.stat.G
  
  res$call <- match.call()  
  res$model <- modeltype  
  res$npermut <- nrepet

  class(res) <-  c("4thcorner", "4thcorner.rlq")
  
  return(res)  
}
