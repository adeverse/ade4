"print.4thcorner" <-
function(x,varQ=1:nrow(x$tabG),varR=1:ncol(x$tabG),...){

cat("Fourth-corner Statistics\n")
cat("------------------------\n")
cat("------------------------\n")
cat("Permutation method ",x$model," (",x$npermut," permutations)\n")
cat("call: ",deparse(x$call),"\n\n")
if (!inherits(x, "4thcorner.rlq")){
for(i in varQ) {
    for(j in varR){
        # quantitatif/quantitatif
        if ((x$indexR[j]==1)&(x$indexQ[i]==1)){
            cat(row.names(x$tabG)[i]," and ",names(x$tabG)[j]," : \n")
            cat(paste(rep("-",nchar(paste(row.names(x$tabG)[i]," and ",names(x$tabG)[j]," :",collapse=""))),collapse=""),"\n")
            cat("r = ",x$tabG[i,j],"\tProb(r) =",x$tabGProb[i,j],"\n")
            if (!inherits(x, "combine")){
              cat("N. less than r obs = ",x$tabGNLT[i,j],"\tN. equal to r obs = ",x$tabGNEQ[i,j],"\n")
              cat("Min(r) = ",x$tabGmin[i,j],"\tMax(r) = ",x$tabGmax[i,j],"\tMean(r) = ",x$tabGmoy[i,j],"\n")
            }
            cat("\n\n") 
            }
        else if ((x$indexR[j]==2)&(x$indexQ[i]==2)){
            cat(row.names(x$tabG)[i]," and ",names(x$tabG)[j]," : \n")
            cat(paste(rep("-",nchar(paste(row.names(x$tabG)[i]," and ",names(x$tabG)[j]," :",collapse=""))),collapse=""),"\n")
            cat("Chi2 = ",x$tabG[i,j],"\tProb(Chi2) =",x$tabGProb[i,j],"\n")
            if (!inherits(x, "combine")){
              cat("N. less than Chi2 obs = ",x$tabGNLT[i,j],"\tN. equal to Chi2 obs = ",x$tabGNEQ[i,j],"\n")
              cat("Min(Chi2) = ",x$tabGmin[i,j],"\tMax(Chi2) = ",x$tabGmax[i,j],"\tMean(Chi2) = ",x$tabGmoy[i,j])
            }
            cat("\n\n")
            cat("G = ",x$tabG2[i,j],"\tProb(G) =",x$tabG2Prob[i,j],"\n")
            if (!inherits(x, "combine")){
              cat("N. less than G obs = ",x$tabG2NLT[i,j],"\tN. equal to G obs = ",x$tabG2NEQ[i,j],"\n")
              cat("Min(G) = ",x$tabG2min[i,j],"\tMax(G) = ",x$tabG2max[i,j],"\tMean(G) = ",x$tabG2moy[i,j],"\n")
              whichR <- which(x$assignR==j)
              whichQ <- which(x$assignQ==i)
              levR <- strsplit(names(x$tabD),"\\.")
              levR <- unlist(lapply(levR,function(x) x[length(x)]))[whichR]
              levQ <- strsplit(row.names(x$tabD),"\\.")
              levQ <- unlist(lapply(levQ,function(x) x[length(x)]))[whichQ]
              resD <- outer(levQ,levR,function(x,y) paste("D(",x,",",y,")=",sep=""))
              resD <- matrix(paste(resD,as.matrix(x$tabD[whichQ,whichR]),sep=""),length(whichQ),length(whichR))
              resMin <- as.matrix(signif(x$tabDmin[whichQ,whichR]))
              resMax <- as.matrix(signif(x$tabDmax[whichQ,whichR]))
              resMoy <- as.matrix(signif(x$tabDmoy[whichQ,whichR]))
              resDProb <- as.matrix(signif(x$tabDProb[whichQ,whichR]))
              resDProbadj <- matrix(signif(p.adjust(as.matrix(x$tabDProb[whichQ,whichR]),"holm")),length(whichQ),length(whichR))
              resDNLT <- as.matrix(x$tabDNLT[whichQ,whichR])
              resDNEQ <- as.matrix(x$tabDNEQ[whichQ,whichR])
              resDspace <- matrix(" ",length(whichQ),length(whichR))
              results <- rbind(resD,resMin,resMax,resMoy,resDspace,resDProb,resDProbadj,resDNLT,resDNEQ,resDspace,resDspace)
              results <- results[matrix(1:(11*length(whichQ)),11 , byrow=TRUE), ]
              colnames(results) <- rep(" ",length(whichR))
              rownames(results) <- rep(c(" ","Min","Max","Mean"," ","Pr.","Pr. adj.","N.LT","N.EQ"," "," "),length(whichQ))
              print(results,quote=FALSE)
            } else {
              cat("\n")
              whichR <- which(x$assignR==j)
              whichQ <- which(x$assignQ==i)
              levR <- strsplit(names(x$tabD),"\\.")
              levR <- unlist(lapply(levR,function(x) x[length(x)]))[whichR]
              levQ <- strsplit(row.names(x$tabD),"\\.")
              levQ <- unlist(lapply(levQ,function(x) x[length(x)]))[whichQ]
              resD <- outer(levQ,levR,function(x,y) paste("D(",x,",",y,")=",sep=""))
              resD <- matrix(paste(resD,as.matrix(x$tabD[whichQ,whichR]),sep=""),length(whichQ),length(whichR))
              resDProb <- as.matrix(signif(x$tabDProb[whichQ,whichR]))
              resDProbadj <- matrix(signif(p.adjust(as.matrix(x$tabDProb[whichQ,whichR]),"holm")),length(whichQ),length(whichR))
              resDspace <- matrix(" ",length(whichQ),length(whichR))
              results <- rbind(resD,resDspace,resDProb,resDProbadj,resDspace)
              results <- results[matrix(1:(5*length(whichQ)),5 , byrow=TRUE), ]
              colnames(results) <- rep(" ",length(whichR))
              rownames(results) <- rep(c(" "," ","Pr.","Pr. adj."," "),length(whichQ))
              print(results,quote=FALSE)
            }
            cat("\n\n") 
                    
                    
            }
        else {
            cat(row.names(x$tabG)[i]," and ",names(x$tabG)[j]," : \n")
            cat(paste(rep("-",nchar(paste(row.names(x$tabG)[i]," and ",names(x$tabG)[j]," :",collapse=""))),collapse=""),"\n")
            cat("F = ",x$tabG[i,j],"\tProb(F) =",x$tabGProb[i,j],"\n")
            if (!inherits(x, "combine")){
              cat("N. less than F obs = ",x$tabGNLT[i,j],"\tN. equal to F obs = ",x$tabGNEQ[i,j],"\n")
              cat("Min(F) = ",x$tabGmin[i,j],"\tMax(F) = ",x$tabGmax[i,j],"\tMean(F) = ",x$tabGmoy[i,j],"\n")
              whichR <- which(x$assignR==j)
              whichQ <- which(x$assignQ==i)
              levR <- strsplit(names(x$tabD),"\\.")
              levR <- unlist(lapply(levR,function(x) x[length(x)]))[whichR]
              levQ <- strsplit(row.names(x$tabD),"\\.")
              levQ <- unlist(lapply(levQ,function(x) x[length(x)]))[whichQ]
              resD <- outer(levQ,levR,function(x,y) paste("D(",x,",",y,")=",sep=""))
              resD <- matrix(paste(resD,as.matrix(signif(x$tabD[whichQ,whichR])),sep=""),length(whichQ),length(whichR))
              resMin <- as.matrix(signif(x$tabDmin[whichQ,whichR]))
              resMax <- as.matrix(signif(x$tabDmax[whichQ,whichR]))
              resMoy <- as.matrix(signif(x$tabDmoy[whichQ,whichR]))
              resDProb <- as.matrix(signif(x$tabDProb[whichQ,whichR]))
              resDProbadj <- matrix(signif(p.adjust(as.matrix(x$tabDProb[whichQ,whichR]),"holm")),length(whichQ),length(whichR))
              resDNLT <- as.matrix(x$tabDNLT[whichQ,whichR])
              resDNEQ <- as.matrix(x$tabDNEQ[whichQ,whichR])
              resDNperm <- as.matrix(x$tabDNperm[whichQ,whichR])
              resDspace <- matrix(" ",length(whichQ),length(whichR))
              results <- as.matrix(rbind(resD,resMin,resMax,resMoy,resDspace,resDProb,resDProbadj,resDNLT,resDNEQ,resDNperm,resDspace,resDspace))
              results <- as.matrix(results[matrix(1:(12*length(whichQ)),12 , byrow=TRUE), ])
            colnames(results) <- rep(" ",length(whichR))
            rownames(results) <- rep(c("Homog.","Min","Max","Mean"," ","Pr.","Pr. adj.","N.LT","N.EQ","N.PERM"," "," "),length(whichQ))
            print(results,quote=FALSE)
            
            resD <- outer(levQ,levR,function(x,y) paste("D(",x,",",y,")=",sep=""))
            resD <- matrix(paste(resD,as.matrix(signif(x$tabD2[whichQ,whichR])),sep=""),length(whichQ),length(whichR))
            resMin <- as.matrix(signif(x$tabD2min[whichQ,whichR]))
            resMax <- as.matrix(signif(x$tabD2max[whichQ,whichR]))
            resMoy <- as.matrix(signif(x$tabD2moy[whichQ,whichR]))
            resDProb <- as.matrix(signif(x$tabD2Prob[whichQ,whichR]))
            resDProbadj <- matrix(signif(p.adjust(as.matrix(x$tabD2Prob[whichQ,whichR]),"holm")),length(whichQ),length(whichR))
            resDNLT <- as.matrix(x$tabD2NLT[whichQ,whichR])
            resDNEQ <- as.matrix(x$tabD2NEQ[whichQ,whichR])
            resDspace <- matrix(" ",length(whichQ),length(whichR))
            results <- as.matrix(rbind(resD,resMin,resMax,resMoy,resDspace,resDProb,resDProbadj,resDNLT,resDNEQ,resDspace,resDspace))
            results <- as.matrix(results[matrix(1:(11*length(whichQ)),11 , byrow=TRUE), ])
            colnames(results) <- rep(" ",length(whichR))
            rownames(results) <- rep(c("Corr.","Min","Max","Mean"," ","Pr.","Pr. adj.","N.LT","N.EQ"," "," "),length(whichQ))
            print(results,quote=FALSE)
            } else {
              whichR <- which(x$assignR==j)
              whichQ <- which(x$assignQ==i)
              levR <- strsplit(names(x$tabD),"\\.")
              levR <- unlist(lapply(levR,function(x) x[length(x)]))[whichR]
              levQ <- strsplit(row.names(x$tabD),"\\.")
              levQ <- unlist(lapply(levQ,function(x) x[length(x)]))[whichQ]
              resD <- outer(levQ,levR,function(x,y) paste("D(",x,",",y,")=",sep=""))
              resD <- matrix(paste(resD,as.matrix(signif(x$tabD[whichQ,whichR])),sep=""),length(whichQ),length(whichR))
              resDProb <- as.matrix(signif(x$tabDProb[whichQ,whichR]))
              resDProbadj <- matrix(signif(p.adjust(as.matrix(x$tabDProb[whichQ,whichR]),"holm")),length(whichQ),length(whichR))
              resDspace <- matrix(" ",length(whichQ),length(whichR))
              results <- as.matrix(rbind(resD,resDspace,resDProb,resDProbadj,resDspace))
              results <- as.matrix(results[matrix(1:(5*length(whichQ)),5 , byrow=TRUE), ])
            colnames(results) <- rep(" ",length(whichR))
            rownames(results) <- rep(c("Homog."," ","Pr.","Pr. adj."," "),length(whichQ))
            print(results,quote=FALSE)
            
            resD <- outer(levQ,levR,function(x,y) paste("D(",x,",",y,")=",sep=""))
            resD <- matrix(paste(resD,as.matrix(signif(x$tabD2[whichQ,whichR])),sep=""),length(whichQ),length(whichR))

            resDProb <- as.matrix(signif(x$tabD2Prob[whichQ,whichR]))
            resDProbadj <- matrix(signif(p.adjust(as.matrix(x$tabD2Prob[whichQ,whichR]),"holm")),length(whichQ),length(whichR))
            
            resDspace <- matrix(" ",length(whichQ),length(whichR))
            results <- as.matrix(rbind(resD,resDspace,resDProb,resDProbadj,resDspace))
            results <- as.matrix(results[matrix(1:(5*length(whichQ)),5 , byrow=TRUE), ])
            colnames(results) <- rep(" ",length(whichR))
            rownames(results) <- rep(c("Corr."," ","Pr.","Pr. adj."," "),length(whichQ))
            print(results,quote=FALSE)
            }
            cat("\n\n") 
            }




        }
    }
}

else{
for(i in varQ) {
    for(j in varR){
        # quantitatif/quantitatif
        if ((x$indexR[j]==1)&(x$indexQ[i]==1)){
            cat(row.names(x$tabG)[i]," and ",names(x$tabG)[j]," : \n")
            cat(paste(rep("-",nchar(paste(row.names(x$tabG)[i]," and ",names(x$tabG)[j]," :",collapse=""))),collapse=""),"\n")
            cat("r^2 = ",x$tabG[i,j],"\tProb(r^2) =",x$tabGProb[i,j],"\n")
            if (!inherits(x, "combine")){
              cat("N. less than r^2 obs = ",x$tabGNLT[i,j],"\tN. equal to r^2 obs = ",x$tabGNEQ[i,j],"\n")
              cat("Min(r^2) = ",x$tabGmin[i,j],"\tMax(r^2) = ",x$tabGmax[i,j],"\tMean(r^2) = ",x$tabGmoy[i,j],"\n")
            }
            cat("\n\n") 
            }
        else if ((x$indexR[j]==2)&(x$indexQ[i]==2)){
            cat(row.names(x$tabG)[i]," and ",names(x$tabG)[j]," : \n")
            cat(paste(rep("-",nchar(paste(row.names(x$tabG)[i]," and ",names(x$tabG)[j]," :",collapse=""))),collapse=""),"\n")
            cat("Chi2/sum(L) = ",x$tabG[i,j],"\tProb(Chi2/sum(L)) =",x$tabGProb[i,j],"\n")
            if (!inherits(x, "combine")){
              cat("N. less than Chi2/sum(L) obs = ",x$tabGNLT[i,j],"\tN. equal to Chi2/sum(L) obs = ",x$tabGNEQ[i,j],"\n")
              cat("Min(Chi2/sum(L)) = ",x$tabGmin[i,j],"\n")
              cat("Max(Chi2/sum(L)) = ",x$tabGmax[i,j],"\n")
              cat("Mean(Chi2/sum(L)) = ",x$tabGmoy[i,j],"\n\n")
            }
                           
                    
            }
        else {
          cat(row.names(x$tabG)[i]," and ",names(x$tabG)[j]," : \n")
          cat(paste(rep("-",nchar(paste(row.names(x$tabG)[i]," and ",names(x$tabG)[j]," :",collapse=""))),collapse=""),"\n")
          cat("Eta^2 = ",x$tabG[i,j],"\tProb(Eta^2) =",x$tabGProb[i,j],"\n")
          if (!inherits(x, "combine")){
            cat("N. less than Eta^2 obs = ",x$tabGNLT[i,j],"\tN. equal to Eta^2 obs = ",x$tabGNEQ[i,j],"\n")
            cat("Min(Eta^2) = ",x$tabGmin[i,j],"\n")
            cat("Max(Eta^2) = ",x$tabGmax[i,j],"\n")
            cat("Mean(Eta^2) = ",x$tabGmoy[i,j])              
          }
          cat("\n\n")
        }
        
        
        
        
      }
  }

}   
}

