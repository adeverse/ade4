"fourthcorner2" <-
function(tabR,tabL,tabQ,modeltype=1,nrepet=999,tr01=FALSE) {  
  
# tabR ,tabL, tabQ sont 3 data frames avec les donnees     
# permut.model est le type de permutations utilisees       
# il peut prendre les valeurs "model1"                     
# "model2", "model3", "model4" ou "model5" (ligne et col)  
# les permutations sont faites sur L                       
# on garde les noms de modeles en rapport avec espece/sites
# et non ligne colonnes                                    

# -------------------------------  
# Test de conformite des tableaux  
# -------------------------------  
 
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
         
        
          
            
    ligL<-nrow(tabL)  
    colL<-ncol(tabL)  
    ligR<-nrow(tabR)  
    ligQ<-nrow(tabQ)
 
    nvarQ<-ncol(tabQ)  
    nvarR<-ncol(tabR)
       
    if (ligR != ligL)   
        stop("Non equal row numbers")
     if (ligQ != colL)   
        stop("Non equal row numbers")  
  
    if (tr01)   
        {  
           cat("Values in table L are 0-1 transformed\n")  
            tabL <- ifelse(tabL==0,0,1)  
          
        }   


#------- 1 equivaut a quantitatif et 2 equivaut a facteur --------#
    indexR <- rep(0, nvarR)  
    for (j in 1:nvarR) {  
        w1 <- 1  
        if (is.factor(tabR[, j])){   
            w1 <- 2    
            }
            
        indexR[j] <- w1  

        if (is.ordered(tabR[, j]))   
            stop("not yet implemented for ordered variables")  
       }  
   
    indexQ <- rep(0, nvarQ)  
    for (j in 1:nvarQ) {  
        w1 <- 1  
        if (is.factor(tabQ[, j])){   
            w1 <- 2    
            }
        indexQ[j] <- w1  
        if (is.ordered(tabQ[, j]))   
            stop("not yet implemented for ordered variables")  
        }  
        
          
# ------------------------------------------  
# Transformation des facteurs en disjonctifs  
# tabR devient matR  et tabQ devient matQ     
# ------------------------------------------  
  
# f1 normalise un vecteur en 1/n  
# pas utilise => fait en C  
#    f1 <- function(v,mat) {  
#          
#        tot=sum(mat)  
#        moy <- sum(v*apply(mat,1,sum)/tot)  
#        print(moy)  
#        v <- v - moy  
#        print(v)  
#        et <- sqrt(sum(v * v)/(tot-1))  
#        print(et)  
#        return(v/et)  
#        }  
#--------fin f1 --------  

  
    matR <- matrix(0, ligR, 1)  
    matQ <- matrix(0, ligQ, 1)  
     
# Pour tabR  
    provinames <- "0"  
    col.assignR <- NULL  
    k <- 0  
    for (j in 1:nvarR) {  
        if ((indexR[j] == 1)) {  
  
            #matR <- cbind(matR, f1(tabR[, j]))  
            matR <- cbind(matR, tabR[, j])  
            provinames <- c(provinames, names(tabR)[j])  
            k <- k + 1  
            col.assignR <- c(col.assignR, k)  
  
        }  
        else if ((indexR[j] == 2)) {  
            w <- fac2disj(tabR[, j], drop = TRUE)  
            cha <- paste(substr(names(tabR)[j], 1, 5), ".", names(w), sep = "")  
            matR <- cbind(matR, w)  
            provinames <- c(provinames, cha)  
            k <- k + 1  
            col.assignR <- c(col.assignR, rep(k, length(cha)))  
        }

    } 

    matR <- data.frame(matR[, -1])  
    names(matR) <- provinames[-1]  
      
#----------  
  
# Pour tabQ  
    provinames <- "0"  
    col.assignQ <- NULL  
    k <- 0  
    for (j in 1:nvarQ) {  
        if (indexQ[j] == 1) {  
  
            #matQ <- cbind(matQ, f1(tabQ[, j]))  
            matQ <- cbind(matQ, tabQ[, j])  
            provinames <- c(provinames, names(tabQ)[j])  
            k <- k + 1  
            col.assignQ <- c(col.assignQ, k)  
  
        }  
        else if ((indexQ[j] == 2)) {  
            w <- fac2disj(tabQ[, j], drop = TRUE)  
            cha <- paste(substr(names(tabQ)[j], 1, 5), ".", names(w), sep = "")  
            matQ <- cbind(matQ, w)  
            provinames <- c(provinames, cha)  
            k <- k + 1  
            col.assignQ <- c(col.assignQ, rep(k, length(cha)))  
        }
          
    }  
    matQ <- data.frame(matQ[, -1])  
    names(matQ) <- provinames[-1]  
  

#  nb col de matR et matQ
    ncolQ<-ncol(matQ)  
    ncolR<-ncol(matR)
    
          
#-----creation objet pour les resultat-------#  


    tabG<-matrix(0,nvarQ,nvarR)  
    tabGmin<-matrix(0,nvarQ,nvarR)  
    tabGmax<-matrix(0,nvarQ,nvarR)  
    tabGmoy<-matrix(0,nvarQ,nvarR)  
    tabGNLT<-matrix(0,nvarQ,nvarR)  
    tabGNEQ<-matrix(0,nvarQ,nvarR)  
    tabGProb<-matrix(0,nvarQ,nvarR)
 


#-------------------------------------------------------------------#
#                             Appel au code C                       #
#-------------------------------------------------------------------#
 
            res<-list()
            res<-.C("quatriemecoin2", as.double(t(matR)), as.double(t(tabL)), as.double(t(matQ)),  
            as.integer(ncolR),as.integer(nvarR),as.integer(ligL),as.integer(colL),
            as.integer(ncolQ),as.integer(nvarQ),as.integer(nrepet), modeltype=as.integer(modeltype),  
            tabG=as.double(tabG),
            tabGProb=as.double(tabGProb),tabGmoy=as.double(tabGmoy),tabGmin=as.double(tabGmin),tabGmax=as.double(tabGmax),
            tabGNLT=as.integer(tabGNLT),tabGNEQ=as.integer(tabGNEQ),
            as.integer(indexR),as.integer(indexQ),as.integer(col.assignR),as.integer(col.assignQ),trRLQ=as.double(rep(0,7))
            ,PACKAGE="ade4")[c("tabG","tabGmin","tabGmax",
            "tabGmoy","tabGNEQ","tabGNLT","tabGProb","trRLQ")] 

#-------------------------------------------------------------------#
#                       Mise en forme des Resultats                 #
#-------------------------------------------------------------------#


            res$tabG<-as.data.frame(matrix(res$tabG,nvarQ,nvarR,byrow=TRUE))  
            res$tabGmin<-as.data.frame(matrix(res$tabGmin,nvarQ,nvarR,byrow=TRUE))  
            res$tabGmax<-as.data.frame(matrix(res$tabGmax,nvarQ,nvarR,byrow=TRUE))  
            res$tabGmoy<-as.data.frame(matrix(res$tabGmoy,nvarQ,nvarR,byrow=TRUE))  
            res$tabGNEQ<-as.data.frame(matrix(res$tabGNEQ,nvarQ,nvarR,byrow=TRUE))  
            res$tabGNLT<-as.data.frame(matrix(res$tabGNLT,nvarQ,nvarR,byrow=TRUE))  
            res$tabGProb<-as.data.frame(matrix(res$tabGProb,nvarQ,nvarR,byrow=TRUE))
              
            row.names(res$tabG)<-row.names(res$tabGmin)<-row.names(res$tabGmax)<-row.names(res$tabGmoy)<-  
            row.names(res$tabGProb)<-row.names(res$tabGNLT)<-row.names(res$tabGNEQ)<-names(tabQ) 
  
            names(res$tabG)<-names(res$tabGmin)<-names(res$tabGmax)<-names(res$tabGmoy)<-names(res$tabGProb)<-  
            names(res$tabGNLT)<-names(res$tabGNEQ)<-names(tabR)
         names(res$trRLQ)<-c("Obs","Min","Max","Moy","NEQ","GNLT","Prob")
    res$trRLQ<-as.list(res$trRLQ)
    res$call<-match.call()  
    res$model<-modeltype  
    res$npermut<-nrepet
    res$assignR <- col.assignR
    res$assignQ <- col.assignQ
    res$indexR <- indexR
    res$indexQ <- indexQ
    class(res) <- c("4thcorner","4thcorner.rlq")
    
 return(res)  
 }

