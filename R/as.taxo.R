"as.taxo" <-                                                             
function (df) 
{
    if (!inherits(df, "data.frame")) 
        stop("df is not a data.frame")
    nc <- ncol(df)
    for (i in 1:nc) {
        w <- df[, i]
        if (!is.factor(w))  stop(paste("column", i, "of" ,deparse(substitute(df)),"is not a factor"))
        if (nlevels(w) == 1) stop(paste("One level in column", i,  "of" ,deparse(substitute(df))))
        if (nlevels(w) == length(w)) stop(paste("Column", i,  "of" ,deparse(substitute(df)),"has one row in each class"))
    }
    for (i in 1:(nc - 1)) {
        t <- table(df[, c(i, i + 1)])
        w <- apply(t, 1, function(x) sum(x != 0))
        if (any(w != 1)) {
            print(w)
            stop(paste("non hierarchical design", i, "in", i + 
                1))
        }
    }
    fac <- as.character(df[, nc])
    for (i in (nc - 1):1) fac <- paste(fac,as.character(df[, i]),sep=":")
    df <- df[order(fac), ]
    class(df) <- c("data.frame", "taxo")
    return(df)
}

"dist.taxo" <-
function(taxo)
{
    if (!inherits(taxo, "taxo")) 
        stop("class 'taxo' expected")
    distance<-matrix(2,nrow(taxo),nrow(taxo))
    diag(distance)<-0
    for (k in ncol(taxo):1) {
        toto=as.matrix( acm.disjonctif(as.data.frame(taxo[,k])))
        distance = distance +  2*(1-toto%*%t(toto))
    }
    dimnames(distance) <- list(row.names(taxo),row.names(taxo))
    return(as.dist(sqrt(distance)))
} 

