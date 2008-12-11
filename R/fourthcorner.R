"fourthcorner" <-
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


# disjonctif transforme un facteur en tableau disjonctif  
    disjonctif <- function(cl) {  
        n <- length(cl)  
        cl <- as.factor(cl)  
        x <- matrix(0, n, length(levels(cl)))  
        x[(1:n) + n * (unclass(cl) - 1)] <- 1  
        dimnames(x) <- list(names(cl), as.character(levels(cl)))  
        as.data.frame(x)  
        }  
#------- fin disjonctif ---------  
  
  
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
            w <- disjonctif(factor(tabR[, j]))  
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
            w <- disjonctif(factor(tabQ[, j]))  
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

    tabD<-matrix(0,ncolQ,ncolR)  
    tabDmin<-matrix(0,ncolQ,ncolR)  
    tabDmax<-matrix(0,ncolQ,ncolR)  
    tabDmoy<-matrix(0,ncolQ,ncolR)  
    tabDNLT<-matrix(0,ncolQ,ncolR)  
    tabDNEQ<-matrix(0,ncolQ,ncolR)  
    tabDProb<-matrix(0,ncolQ,ncolR)
    tabDNperm<-matrix(0,ncolQ,ncolR)
    tabD2<-matrix(0,ncolQ,ncolR)  
    tabD2min<-matrix(0,ncolQ,ncolR)  
    tabD2max<-matrix(0,ncolQ,ncolR)  
    tabD2moy<-matrix(0,ncolQ,ncolR)  
    tabD2NLT<-matrix(0,ncolQ,ncolR)  
    tabD2NEQ<-matrix(0,ncolQ,ncolR)  
    tabD2Prob<-matrix(0,ncolQ,ncolR)

    tabG<-matrix(0,nvarQ,nvarR)  
    tabGmin<-matrix(0,nvarQ,nvarR)  
    tabGmax<-matrix(0,nvarQ,nvarR)  
    tabGmoy<-matrix(0,nvarQ,nvarR)  
    tabGNLT<-matrix(0,nvarQ,nvarR)  
    tabGNEQ<-matrix(0,nvarQ,nvarR)  
    tabGProb<-matrix(0,nvarQ,nvarR)
    tabG2<-matrix(0,nvarQ,nvarR)  
    tabG2min<-matrix(0,nvarQ,nvarR)  
    tabG2max<-matrix(0,nvarQ,nvarR)  
    tabG2moy<-matrix(0,nvarQ,nvarR)  
    tabG2NLT<-matrix(0,nvarQ,nvarR)  
    tabG2NEQ<-matrix(0,nvarQ,nvarR)  
    tabG2Prob<-matrix(0,nvarQ,nvarR)



#-------------------------------------------------------------------#
#                             Appel au code C                       #
#-------------------------------------------------------------------#
 
            res<-list()
            res<-.C("quatriemecoin", as.double(t(matR)), as.double(t(tabL)), as.double(t(matQ)), tabD=as.double(tabD), 
            as.integer(ncolR),as.integer(nvarR),as.integer(ligL),as.integer(colL),
            as.integer(ncolQ),as.integer(nvarQ),as.integer(nrepet), modeltype=as.integer(modeltype),  
            tabDmoy=as.double(tabDmoy),tabDmin=as.double(tabDmin),tabDmax=as.double(tabDmax),tabDNLT=as.integer(tabDNLT),  
            tabDNEQ=as.integer(tabDNEQ),tabDProb=as.double(tabDProb),tabDNperm=as.integer(tabDNperm),tabG=as.double(tabG),
            tabGProb=as.double(tabGProb),tabGmoy=as.double(tabGmoy),tabGmin=as.double(tabGmin),tabGmax=as.double(tabGmax),
            tabGNLT=as.integer(tabGNLT),tabGNEQ=as.integer(tabGNEQ),
            tabD2=as.double(tabD2),tabD2moy=as.double(tabD2moy),tabD2min=as.double(tabD2min),tabD2max=as.double(tabD2max),
            tabD2NLT=as.integer(tabD2NLT),tabD2NEQ=as.integer(tabD2NEQ),tabD2Prob=as.double(tabD2Prob),tabG2=as.double(tabG2),
            tabG2Prob=as.double(tabG2Prob),tabG2moy=as.double(tabG2moy),tabG2min=as.double(tabG2min),tabG2max=as.double(tabG2max),
            tabG2NLT=as.integer(tabG2NLT),tabG2NEQ=as.integer(tabG2NEQ),
            as.integer(indexR),as.integer(indexQ),as.integer(col.assignR),as.integer(col.assignQ)
            ,PACKAGE="ade4")[c("tabD","tabDmin","tabDmax","tabDmoy","tabDNEQ","tabDNLT","tabDProb","tabDNperm","tabG","tabGmin","tabGmax",
            "tabGmoy","tabGNEQ","tabGNLT","tabGProb","tabD2","tabD2moy","tabD2min","tabD2max","tabD2NLT","tabD2NEQ",
            "tabD2Prob","tabG2","tabG2Prob","tabG2moy","tabG2min","tabG2max","tabG2NLT","tabG2NEQ")] 

#-------------------------------------------------------------------#
#                       Mise en forme des Resultats                 #
#-------------------------------------------------------------------#

            res$tabD<-as.data.frame(matrix(res$tabD,ncolQ,ncolR,byrow=TRUE))  
            res$tabDmin<-as.data.frame(matrix(res$tabDmin,ncolQ,ncolR,byrow=TRUE))  
            res$tabDmax<-as.data.frame(matrix(res$tabDmax,ncolQ,ncolR,byrow=TRUE))  
            res$tabDmoy<-as.data.frame(matrix(res$tabDmoy,ncolQ,ncolR,byrow=TRUE))  
            res$tabDNEQ<-as.data.frame(matrix(res$tabDNEQ,ncolQ,ncolR,byrow=TRUE))  
            res$tabDNLT<-as.data.frame(matrix(res$tabDNLT,ncolQ,ncolR,byrow=TRUE))  
            res$tabDProb<-as.data.frame(matrix(res$tabDProb,ncolQ,ncolR,byrow=TRUE))
            res$tabDNperm<-as.data.frame(matrix(res$tabDNperm,ncolQ,ncolR,byrow=TRUE)) 
            
            
            row.names(res$tabD)<-row.names(res$tabDmin)<-row.names(res$tabDmax)<-row.names(res$tabDmoy)<-row.names(res$tabDProb)<-
            row.names(res$tabDNLT)<-row.names(res$tabDNEQ)<-row.names(res$tabDNperm)<-names(matQ)  
            
            names(res$tabD)<-names(res$tabDmin)<-names(res$tabDmax)<-names(res$tabDmoy)<-names(res$tabDProb)<-  
            names(res$tabDNLT)<-names(res$tabDNEQ)<-names(res$tabDNperm)<-names(matR)  
            

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
  

            res$tabD2<-as.data.frame(matrix(res$tabD2,ncolQ,ncolR,byrow=TRUE))  
            res$tabD2min<-as.data.frame(matrix(res$tabD2min,ncolQ,ncolR,byrow=TRUE))  
            res$tabD2max<-as.data.frame(matrix(res$tabD2max,ncolQ,ncolR,byrow=TRUE))  
            res$tabD2moy<-as.data.frame(matrix(res$tabD2moy,ncolQ,ncolR,byrow=TRUE))  
            res$tabD2NEQ<-as.data.frame(matrix(res$tabD2NEQ,ncolQ,ncolR,byrow=TRUE))  
            res$tabD2NLT<-as.data.frame(matrix(res$tabD2NLT,ncolQ,ncolR,byrow=TRUE))  
            res$tabD2Prob<-as.data.frame(matrix(res$tabD2Prob,ncolQ,ncolR,byrow=TRUE))

            row.names(res$tabD2)<-row.names(res$tabD2min)<-row.names(res$tabD2max)<-row.names(res$tabD2moy)<-  
            row.names(res$tabD2Prob)<-row.names(res$tabD2NLT)<-row.names(res$tabD2NEQ)<-names(matQ)

            names(res$tabD2)<-names(res$tabD2min)<-names(res$tabD2max)<-names(res$tabD2moy)<-names(res$tabD2Prob)<-  
            names(res$tabD2NLT)<-names(res$tabD2NEQ)<-names(matR)

            res$tabG2<-as.data.frame(matrix(res$tabG2,nvarQ,nvarR,byrow=TRUE))  
            res$tabG2min<-as.data.frame(matrix(res$tabG2min,nvarQ,nvarR,byrow=TRUE))  
            res$tabG2max<-as.data.frame(matrix(res$tabG2max,nvarQ,nvarR,byrow=TRUE))  
            res$tabG2moy<-as.data.frame(matrix(res$tabG2moy,nvarQ,nvarR,byrow=TRUE))  
            res$tabG2NEQ<-as.data.frame(matrix(res$tabG2NEQ,nvarQ,nvarR,byrow=TRUE))  
            res$tabG2NLT<-as.data.frame(matrix(res$tabG2NLT,nvarQ,nvarR,byrow=TRUE))  
            res$tabG2Prob<-as.data.frame(matrix(res$tabG2Prob,nvarQ,nvarR,byrow=TRUE))  

            row.names(res$tabG2)<-row.names(res$tabG2min)<-row.names(res$tabG2max)<-row.names(res$tabG2moy)<-  
            row.names(res$tabG2Prob)<-row.names(res$tabG2NLT)<-row.names(res$tabG2NEQ)<-names(tabQ)  
   
            names(res$tabG2)<-names(res$tabG2min)<-names(res$tabG2max)<-names(res$tabG2moy)<-
            names(res$tabG2Prob)<-names(res$tabG2NLT)<-names(res$tabG2NEQ)<-names(tabR)  
        
    
    res$call<-match.call()  
    res$model<-modeltype  
    res$npermut<-nrepet
    res$assignR <- col.assignR
    res$assignQ <- col.assignQ
    res$indexR <- indexR
    res$indexQ <- indexQ
    class(res) <- "4thcorner"
    
 return(res)  
 }

