fourthcorner.rlq <- function(xtest, nrepet = 999, modeltype = 6, typetest = c("axes","Q.axes","R.axes"), p.adjust.method.G = p.adjust.methods, p.adjust.method.D = p.adjust.methods, p.adjust.D = c("global","levels"), ...)
{
  ## test RLQ axes
  
  if (!inherits(xtest, "dudi"))
    stop("Object of class dudi expected")
  if (!inherits(xtest, "rlq"))
    stop("Object of class 'rlq' expected")
  if (!(modeltype %in% c(2, 4, 5, 6)))
    stop("modeltype should be 2, 4, 5 or 6")

  if(modeltype == 6){
    test1 <- fourthcorner.rlq(xtest, modeltype = 2,nrepet = nrepet, typetest = typetest, p.adjust.method.G = p.adjust.method.G, p.adjust.method.D = p.adjust.method.D, p.adjust.D = p.adjust.D)
    test2 <- fourthcorner.rlq(xtest, modeltype = 4,nrepet = nrepet, typetest = typetest, p.adjust.method.G = p.adjust.method.G, p.adjust.method.D = p.adjust.method.D, p.adjust.D = p.adjust.D)
    res <- combine.4thcorner(test1, test2)
    res$call <- res$tabD2$call <- res$tabD$call <- res$tabG$call <- match.call()
    return(res)
  }
  
  p.adjust.D <- match.arg(p.adjust.D)
  p.adjust.method.D <- match.arg(p.adjust.method.D)
  p.adjust.method.G <- match.arg(p.adjust.method.G)
  typetest <- match.arg(typetest)
  
  appel <- as.list(xtest$call)
  dudiR <- eval.parent(appel$dudiR)
  dudiQ <- eval.parent(appel$dudiQ)
  dudiL <- eval.parent(appel$dudiL)

  tabR.cw <- dudiR$cw
  appelR <- as.list(dudiR$call)
  tabR <- Rinit <- eval.parent(appelR$df)
  
  ## Test the different cases
  ##      typ=1 no modification (PCA on original variable)
  ##      typ=2 ACM 
  ##      typ=3 normed and centred PCA 
  ##      typ=4 centred PCA 
  ##      typ=5 normed and non-centred PCA 
  ##      typ=6 COA 
  ##      typ=7 FCA 
  ##      typ=8 Hill-smith
  

  typR <- dudi.type(dudiR$call)
  ##------- index can takes 2 values (1 for quantitative / 2 for factor)  --------#
  if (typR %in% c(1, 3, 4, 5, 6, 7)) {
    indexR <- rep(1, ncol(Rinit))
    assignR <- 1:ncol(Rinit)
  } else if (typR == 2) {
    indexR <- rep(2, ncol(Rinit))
    assignR <- rep(1:ncol(Rinit), apply(Rinit, 2, function(x) nlevels(as.factor(x))))
    Rinit <- acm.disjonctif(Rinit)
  } else if (typR == 8) {
    provinames <- "tmp"
    indexR <- ifelse(dudiR$index == "q", 1, 2)
    assignR <- as.numeric(dudiR$assign)
    
    res <- matrix(0, nrow(Rinit), 1)

    for (j in 1:(ncol(Rinit))) {
      if (indexR[j] == 1) {
        res <- cbind(res, Rinit[, j])
        provinames <- c(provinames,names(Rinit)[j])
      }
      else if (indexR[j] == 2) {
        w <- fac2disj(Rinit[, j], drop = TRUE)
        res <- cbind(res, w)
        provinames <- c(provinames, paste(substr(names(Rinit)[j], 1, 5), ".", names(w), sep = ""))
      }
    }
    Rinit <- res[,-1]
    colnames(Rinit) <- provinames[-1] 
  } else stop ("Not yet available")

  
  tabQ.cw <- dudiQ$cw
  appelQ <- as.list(dudiQ$call)
  tabQ <- Qinit <- eval.parent(appelQ$df)
  
  typQ <- dudi.type(dudiQ$call)
  
  if (typQ %in% c(1, 3, 4, 5, 6, 7)) {
  indexQ <- rep(1,ncol(Qinit))
  assignQ <- 1:ncol(Qinit)
} else if (typQ == 2) {
  indexQ <- rep(2, ncol(Qinit))
  assignQ <- rep(1:ncol(Qinit),apply(Qinit, 2, function(x) nlevels(as.factor(x))))
  Qinit <- acm.disjonctif(Qinit)
} else if (typQ == 8) {
  provinames <- "tmp"
  indexQ <- ifelse(dudiQ$index=="q",1,2)
  assignQ <- as.numeric(dudiQ$assign)
  
  res <- matrix(0, nrow(Qinit), 1)

  for (j in 1:(ncol(Qinit))) {
    if (indexQ[j] == 1) {
      res <- cbind(res, Qinit[, j])
      provinames <- c(provinames,names(Qinit)[j])
    }
    else if (indexQ[j] == 2) {
      w <- fac2disj(Qinit[, j])
      res <- cbind(res, w)
      provinames <- c(provinames, paste(substr(names(Qinit)[j], 1, 5), ".", names(w), sep = ""))
    }
  }
  Qinit <- res[,-1]
  colnames(Qinit) <- provinames[-1] 
} else stop ("Not yet available")


appelL <- as.list(dudiL$call)
tabL <- eval.parent(appelL$df)
tabL.cw <- dudiL$cw
tabL.lw <- dudiL$lw

ncolQ <- ncol(Qinit)  
ncolR <- ncol(Rinit)
nvarR <- ncol(tabR)
nvarQ <- ncol(tabQ)

##  Dimensions for D ang G matrices
naxes <- xtest$nf


if(typetest=="axes"){
  ncolD <- ncolG <- naxes
  nrowD <- nrowG <- naxes
  typeTestN <- 1
} else if (typetest=="Q.axes"){
  ncolD <- ncolG <- naxes
  nrowD <- ncolQ
  nrowG <- nvarQ
  typeTestN <- 3
} else if(typetest=="R.axes"){
  ncolD <- ncolR
  ncolG <- nvarR
  nrowD <- nrowG <- naxes
  typeTestN <- 2
}




##----- create objects to store results -------#  

tabD <- matrix(0, nrepet + 1, nrowD * ncolD)
tabD2 <- matrix(0, nrepet + 1, nrowD * ncolD)
tabG <- matrix(0, nrepet + 1, nrowG * ncolG)  
res <- list()

##------------------
##   Call the C code
##------------------
res <- .C("quatriemecoinRLQ",
          as.double(t(Rinit)),
          as.double(t(tabL)),
          as.double(t(Qinit)),  
          as.integer(ncolR),
          as.integer(nvarR),
          as.integer(nrow(tabL)),
          as.integer(ncol(tabL)),
          as.integer(ncolQ),
          as.integer(nvarQ),
          as.integer(nrepet),
          modeltype = as.integer(modeltype),  
          tabD = as.double(tabD),
          tabD2 = as.double(tabD2),
          tabG = as.double(tabG),
          as.integer(nrowD),
          as.integer(ncolD),
          as.integer(nrowG),
          as.integer(ncolG),
          as.integer(indexR),
          as.integer(indexQ),
          as.integer(assignR),
          as.integer(assignQ),
          as.double(t(xtest$c1)),
          as.double(t(xtest$l1)),
          as.integer(typeTestN),
          as.integer(naxes),
          as.integer(typR),
          as.integer(typQ),
          as.double(tabR.cw),
          as.double(tabQ.cw),
          PACKAGE="ade4")[c("tabD","tabD2","tabG")] 

##-------------------------------------------------------------------#
##                       Outputs                                     #
##-------------------------------------------------------------------#

if(typetest == "axes"){
  res$varnames.Q <- res$colnames.Q <- names(xtest$lQ)
  res$varnames.R <-  res$colnames.R <- names(xtest$lR)
  res$assignR <- res$assignQ <- 1:naxes
  res$indexR <- res$indexQ <- rep(1,naxes)
} else if (typetest == "Q.axes"){
  res$varnames.Q <- names(tabQ)
  res$colnames.Q <- colnames(Qinit)
  res$varnames.R <-  res$colnames.R <- names(xtest$lR)
  res$indexQ <- indexQ
  res$assignQ <- assignQ
  res$assignR <- 1:naxes
  res$indexR <- rep(1,naxes)
} else if(typetest == "R.axes"){
  res$varnames.Q <-  res$colnames.Q <- names(xtest$lQ)
  res$varnames.R <- names(tabR)
  res$colnames.R <- colnames(Rinit)
  res$indexR <- indexR
  res$assignR <- assignR
  res$assignQ <- 1:naxes
  res$indexQ <- rep(1,naxes)
}

## set invalid permutation to NA (in the case of levels of a factor with no observation)
res$tabD <- ifelse(res$tabD < (-998), NA, res$tabD)
res$tabG <- ifelse(res$tabG < (-998), NA, res$tabG)

## Reshape the tables
res$tabD <- matrix(res$tabD, nrepet + 1, nrowD * ncolD, byrow = TRUE)
res$tabD2 <- matrix(res$tabD2, nrepet + 1, nrowD * ncolD, byrow = TRUE)
res$tabG <- matrix(res$tabG, nrepet + 1, nrowG * ncolG, byrow = TRUE)

## Create vectors to store type of statistics and alternative hypotheses
names.stat.D <- vector(mode="character")
names.stat.D2 <- vector(mode="character")
names.stat.G <- vector(mode="character")
alter.G <-  vector(mode="character")
alter.D <-  vector(mode="character")
alter.D2 <-  vector(mode="character")

for (i in 1:nrowG){
  for (j in 1:ncolG){
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
  }
}

for (i in 1:nrowD){
  for (j in 1:ncolD){
    ## Type of statistics for D and alternative hypotheses
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
  }
}

provinames <- apply(expand.grid(res$colnames.R, res$colnames.Q), 1, paste, collapse=" / ")
res$tabD <- as.krandtest(obs = res$tabD[1, ], sim = res$tabD[-1, , drop = FALSE], names = provinames, alter = alter.D, call = match.call(), p.adjust.method = p.adjust.method.D)
res$tabD2 <- as.krandtest(obs = res$tabD2[1, ], sim = res$tabD2[-1, , drop = FALSE], names = provinames, alter = alter.D2, call = match.call(), p.adjust.method = p.adjust.method.D)


if(p.adjust.D == "levels"){
  ## adjustment only between levels of a factor (corresponds to the original paper of Legendre et al. 1997)
  for (i in 1:nrowG){
    for (j in 1:ncolG){
      idx.varR <- which(res$assignR == j)
      idx.varQ <- which(res$assignQ == i)
      idx.vars <- ncolG * (idx.varQ - 1) + idx.varR
      res$tabD$adj.pvalue[idx.vars] <- p.adjust(res$tabD$pvalue[idx.vars], method = p.adjust.method.D)
      res$tabD2$adj.pvalue[idx.vars] <- p.adjust(res$tabD2$pvalue[idx.vars], method = p.adjust.method.D)
    }
  }
  res$tabD$adj.method <- res$tabD2$adj.method <- paste(p.adjust.method.D, "by levels")
}

provinames <- apply(expand.grid(res$varnames.R, res$varnames.Q), 1, paste, collapse=" / ")
res$tabG <- as.krandtest(obs = res$tabG[1, ], sim = res$tabG[-1, , drop = FALSE], names = provinames, alter = alter.G, call = match.call(), p.adjust.method = p.adjust.method.G)

res$tabD$statnames <- names.stat.D
res$tabD2$statnames <- names.stat.D2
res$tabG$statnames <- names.stat.G

res$call <- match.call()  
res$model <- modeltype  
res$npermut <- nrepet

class(res) <- "4thcorner"

return(res)  


}
