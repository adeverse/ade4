"as.taxo" <-                                                             
function (df)                                                            
{                                                                        
    if (!inherits(df, "data.frame"))                                     
        stop("df is not a data.frame")                                   
    nr <- nrow(df)                                                       
    nc <- ncol(df)                                                       
    for (i in 1:nc) if (!is.factor(df[, i]))                             
        stop(paste("column", i, "of 'df' is not a factor"))              
    for (i in 1:(nc - 1)) {                                              
        t <- table(df[, c(i, i + 1)])                                    
        w <- apply(t, 1, function(x) sum(x != 0))                        
        if (any(w != 1)) {
            print(w)                                                 
            stop(paste("non hierarchical design", i, "in", i +           
                1))   
        }                                                   
    }                                                                    
    fac <- df[, nc]                                                      
    for (i in (nc - 1):1) fac <- fac:df[, i]                             
    df <- df[order(fac), ]                                               
    class(df) <- c("data.frame", "taxo")                                 
    return(df)                                                           
}                                      
                                                                                                                                                                                                                    
