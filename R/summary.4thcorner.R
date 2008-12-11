"summary.4thcorner" <-
function(object,...){

cat("Fourth-corner Statistics\n")
cat("Permutation method ",object$model," (",object$npermut," permutations)\n")
cat("---\n\n")
    res=matrix(0,nrow(object$tabG)*ncol(object$tabG),7)
    res[,1]=format(colnames(object$tabG)[col(as.matrix(object$tabG))],justify="right")
    res[,2]=format(rep("/",nrow(object$tabG)*ncol(object$tabG)),justify="none")
    res[,3]=format(rownames(object$tabG)[row(as.matrix(object$tabG))])
    res[,4]=as.vector(outer(object$indexQ,object$indexR))
    if (!inherits(object, "4thcorner.rlq")){
    res[res[,4]=="1",4]="r"
    res[res[,4]=="2",4]="F"
    res[res[,4]=="4",4]="Chi2"
    }
    else{
    res[res[,4]=="1",4]="r^2"
    res[res[,4]=="2",4]="Eta^2"
    res[res[,4]=="4",4]="Chi2/sum(L)"   
    }
    res[,5]=as.vector(signif(as.matrix(object$tabG)))
    res[,6]=format.pval(as.vector(as.matrix(object$tabGProb)))
    signifpval <- symnum(as.numeric(res[,6]), corr = FALSE, na = FALSE, cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1), symbols = c("***", "**", "*", ".", " "))
    res[,7]=signifpval
    rownames(res)=rep(" ",nrow(object$tabG)*ncol(object$tabG))
    colnames(res)=c("Var. R", " ","Var. Q", "Stat.","Value","Prob."," ")
    print(res,quote=FALSE)
    cat("\n---\nSignif. codes: ", attr(signifpval, "legend"), "\n")


}

