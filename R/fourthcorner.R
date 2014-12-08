"fourthcorner" <- function(tabR, tabL, tabQ, modeltype = 6,nrepet = 999, tr01 = FALSE, p.adjust.method.G = p.adjust.methods, p.adjust.method.D = p.adjust.methods, p.adjust.D = c("global","levels")) {  
  
  ## tabR ,tabL, tabQ are 3 data frames containing the data    
  ## permut.model is the permutational model and can take 6 values (1:6)   6 corresponds to the combination of 2 and 4    
  
  
  
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
  
  p.adjust.D <- match.arg(p.adjust.D)
  p.adjust.method.D <- match.arg(p.adjust.method.D)
  p.adjust.method.G <- match.arg(p.adjust.method.G)       
  
  if (sum(modeltype==(1:6))!=1)
    stop("modeltype should be 1, 2, 3, 4, 5 or 6")

  if(modeltype == 6){
    test1 <- fourthcorner(tabR, tabL, tabQ, modeltype = 2,nrepet = nrepet, tr01 = tr01, p.adjust.method.G = p.adjust.method.G, p.adjust.method.D = p.adjust.method.D, p.adjust.D = p.adjust.D)
    test2 <- fourthcorner(tabR, tabL, tabQ, modeltype = 4,nrepet = nrepet, tr01 = tr01, p.adjust.method.G = p.adjust.method.G, p.adjust.method.D = p.adjust.method.D, p.adjust.D = p.adjust.D)
    res <- combine.4thcorner(test1,test2)
    res$call <- res$tabD2$call <- res$tabD$call <- res$tabG$call <- match.call()
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
  
  ## transform the data into presence-absence if trO1 = TRUE
  if (tr01)   
    {  
      cat("Values in table L are 0-1 transformed\n")  
      tabL <- ifelse(tabL==0,0,1)  
      
    }   
  
  ## ------------------------------------------ 
  ## Create the data matrices for R and Q 
  ## Transform factors into disjunctive tables 
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
    ## The type is stored in the index vector (1 for numeric / 2 for factor)
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
  tabD <- matrix(0,nrepet + 1, ncolR * ncolQ)
  tabD2 <- matrix(0,nrepet + 1, ncolR * ncolQ)
  tabG <- matrix(0,nrepet + 1, nvarR * nvarQ)
  res <- list()
  
  ##------------------
  ##   Call the C code
  ##------------------
  res <- .C("quatriemecoin",
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
            tabD = as.double(tabD),
            tabD2 = as.double(tabD2),
            tabG = as.double(tabG),
            as.integer(indexR),
            as.integer(indexQ),
            as.integer(assignR),
            as.integer(assignQ),
            PACKAGE="ade4")[c("tabD","tabD2","tabG")]
  
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
  res$indexR <-  indexR
  
  ## set invalid permutation to NA (in the case of levels of a factor with no observation)
  res$tabD <- ifelse(res$tabD < (-998), NA, res$tabD)
  res$tabG <- ifelse(res$tabG < (-998), NA, res$tabG)

  ## Reshape the tables
  res$tabD <- matrix(res$tabD, nrepet + 1, ncolR * ncolQ, byrow=TRUE)
  res$tabD2 <- matrix(res$tabD2, nrepet + 1, ncolR * ncolQ, byrow=TRUE)
  res$tabG <- matrix(res$tabG, nrepet + 1, nvarR * nvarQ, byrow=TRUE)

  ## Create vectors to store type of statistics and alternative hypotheses
  names.stat.D <- vector(mode="character")
  names.stat.D2 <- vector(mode="character")
  names.stat.G <- vector(mode="character")
  alter.G <-  vector(mode="character")
  alter.D <-  vector(mode="character")
  alter.D2 <-  vector(mode="character")
  
  for (i in 1:nvarQ){
    for (j in 1:nvarR){
      ## Type of statistics for G and alternative hypotheses
      if ((res$indexR[j]==1)&(res$indexQ[i]==1)){
        names.stat.G <- c(names.stat.G, "r")
        alter.G <- c(alter.G, "two-sided")
      }
      if ((res$indexR[j]==1)&(res$indexQ[i]==2)){
        names.stat.G <- c(names.stat.G, "F")
        alter.G <- c(alter.G, "greater")
      }
      if ((res$indexR[j]==2)&(res$indexQ[i]==1)){
        names.stat.G <- c(names.stat.G, "F")
        alter.G <- c(alter.G, "greater")
      }
      if ((res$indexR[j]==2)&(res$indexQ[i]==2)){
        names.stat.G <- c(names.stat.G, "Chi2")
        alter.G <- c(alter.G, "greater")
      }
    }
  }
  
  for (i in 1:ncolQ){
    for (j in 1:ncolR){
      ## Type of statistics for D and alternative hypotheses
      idx.vars <- ncolR * (i-1) + j
      if ((res$indexR[res$assignR[j]]==1)&(res$indexQ[res$assignQ[i]]==1)){
        names.stat.D <- c(names.stat.D, "r")
        names.stat.D2 <- c(names.stat.D2, "r")
        alter.D <- c(alter.D, "two-sided")
        alter.D2 <- c(alter.D2, "two-sided")
      }
      if ((res$indexR[res$assignR[j]]==1)&(res$indexQ[res$assignQ[i]]==2)){
        names.stat.D <- c(names.stat.D, "Homog.")
        names.stat.D2 <- c(names.stat.D2, "r")
        alter.D <- c(alter.D, "less")
        alter.D2 <- c(alter.D2, "two-sided")
      }
      if ((res$indexR[res$assignR[j]]==2)&(res$indexQ[res$assignQ[i]]==1)){
        names.stat.D <- c(names.stat.D, "Homog.")
        names.stat.D2 <- c(names.stat.D2, "r")
        alter.D <- c(alter.D, "less")
        alter.D2 <- c(alter.D2, "two-sided")
      }
      if ((res$indexR[res$assignR[j]]==2)&(res$indexQ[res$assignQ[i]]==2)){
        names.stat.D <- c(names.stat.D, "N")
        names.stat.D2 <- c(names.stat.D2, "N")
        alter.D <- c(alter.D, "two-sided")
        alter.D2 <- c(alter.D2, "two-sided")
      }
    }
  }

  provinames <- apply(expand.grid(res$colnames.R, res$colnames.Q), 1, paste, collapse=" / ")
  res$tabD <- as.krandtest(obs = res$tabD[1, ], sim = res$tabD[-1, , drop = FALSE], names = provinames, alter = alter.D, call = match.call(), p.adjust.method = p.adjust.method.D)
  res$tabD2 <- as.krandtest(obs = res$tabD2[1, ], sim = res$tabD2[-1, , drop = FALSE], names = provinames, alter = alter.D2, call = match.call(), p.adjust.method = p.adjust.method.D)


  if(p.adjust.D == "levels"){
    ## adjustment only between levels of a factor (corresponds to the original paper of Legendre et al. 1997)
    for (i in 1:nvarQ){
      for (j in 1:nvarR){
        idx.varR <- which(res$assignR == j)
        idx.varQ <- which(res$assignQ == i)
        idx.vars <- nvarR * (idx.varQ - 1) + idx.varR
        res$tabD$adj.pvalue[idx.vars] <- p.adjust(res$tabD$pvalue[idx.vars], method = p.adjust.method.D)
        res$tabD2$adj.pvalue[idx.vars] <- p.adjust(res$tabD2$pvalue[idx.vars], method = p.adjust.method.D)
      }
    }
    res$tabD$adj.method <- res$tabD2$adj.method <- paste(p.adjust.method.D, "by levels")
  }
  
  
  
  provinames <- apply(expand.grid(res$varnames.R, res$varnames.Q), 1, paste, collapse=" / ")
  res$tabG <- as.krandtest(obs = res$tabG[1, ], sim = res$tabG[-1, ,drop = FALSE], names = provinames, alter = alter.G, call = match.call(), p.adjust.method = p.adjust.method.G)

  res$tabD$statnames <- names.stat.D
  res$tabD2$statnames <- names.stat.D2
  res$tabG$statnames <- names.stat.G
  
  res$call <- match.call()  
  res$model <- modeltype  
  res$npermut <- nrepet

  class(res) <- "4thcorner"
  
  return(res)  
}
