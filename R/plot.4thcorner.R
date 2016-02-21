plot.4thcorner <- function(x, stat = c("D", "D2", "G"), type = c("table", "biplot"), xax = 1, yax = 2, x.rlq = NULL, alpha = 0.05, col = c("lightgrey", "red", "deepskyblue", "purple"),...) {
    ## function to display the results obtained with the fourthcorner, fourthcorner2 or fourthcorner.rlq functions
    ## biplot available only for D and D2 stats
    
    stat <- match.arg(stat)
    type <- match.arg(type)
    appel <- as.list(x$call)
    fctn <- appel[[1]]
    
    if(!inherits(x, "4thcorner") & !inherits(x, "4thcorner.rlq"))
        stop("x must be of class '4thcorner' or '4thcorner.rlq'")
    if(inherits(x, "4thcorner.rlq") & stat != "G")
        stop("stat should be 'G' for object of class '4thcorner.rlq' (created by the 'fourthcorner2' function)")
    if(type == "biplot" & stat == "G")
        stop("'biplot not available for the 'G' statistic")
    
    if((stat == "D2" | stat=="D")){
        ## For D and D2 stats
        res <- data.frame(matrix(1, length(x$colnames.Q),length(x$colnames.R)))
        names(res) <- x$colnames.R
        row.names(res) <- x$colnames.Q
        if(stat == "D2") {
            xrand <- x$tabD2
        } else {
            xrand <- x$tabD
        }
        
        for(i in 1:nrow(res)){
            for(j in 1:ncol(res)){
                ## in res, 1 corresponds to white, 2 to dark grey and 3 to light grey
                idx.var <-  ncol(res) * (i - 1) + j
                if(!is.na(xrand$adj.pvalue[idx.var])){
                    if(xrand$adj.pvalue[idx.var] < alpha){
                        ## for significant associations
                        res[i,j] <- ifelse(xrand$alter[idx.var]=="greater", 2, 3)
                        
                        if((x$indexR[x$assignR[j]]==1) != (x$indexQ[x$assignQ[i]]==1)){
                            if(stat == "D")
                                ## homogeneity has no sign and test only "positive" association
                                res[i,j] <- 2 
                            if(stat == "D2")
                                ## sign of the correlation (two-sided test)
                                res[i,j] <- ifelse(xrand$obs[idx.var] > 0, 2, 3) 
                        }
                        else if((x$indexR[x$assignR[j]]==1) & (x$indexQ[x$assignQ[i]]==1)){
                            ## sign of the correlation (two-sided test)
                            res[i,j] <- ifelse(xrand$obs[idx.var] > 0, 2, 3) 
                        }
                        else if((x$indexR[x$assignR[j]]==2) & (x$indexQ[x$assignQ[i]]==2)){
                            ## sign relative to the mean of permuted values
                            res[i,j] <- ifelse(xrand$obs[idx.var] > mean(xrand$sim[,idx.var]), 2, 3) 
                        }
                    }
                }
            }
        }
    } else if(stat=="G"){
        ## for G stats
        res <- data.frame(matrix(1, length(x$varnames.Q),length(x$varnames.R)))
        names(res) <- x$varnames.R
        row.names(res) <- x$varnames.Q
        xrand <- x$tabG
        for(i in 1:nrow(res)){
            for(j in 1:ncol(res)){
                idx.var <-  ncol(res) * (i - 1) + j
                if(xrand$adj.pvalue[idx.var] < alpha){
                    res[i,j] <- ifelse(xrand$alter[idx.var]=="greater", 2, 3)
                    if((x$indexR[j]==1) & (x$indexQ[i]==1)){
                        ## sign of the correlation (two-sided test)
                        res[i,j] <- ifelse(xrand$obs[idx.var] > 0, 2, 3)
                    }
                }
            }
        }
    }
    
    
    
    table4thcorner <- function (df, stat, assignR, assignQ, col) 
        {
            ## plot results as a table with white, light grey and dark grey
            x1 <- 1:ncol(df)
            y <- nrow(df):1
            opar <- par(mai = par("mai"), srt = par("srt"))
            on.exit(par(opar))
            table.prepare(x = x1, y = y, row.labels = row.names(df), col.labels = names(df), 
                          clabel.row = 1, clabel.col = 1, grid = FALSE, 
                          pos = "paint")
            xtot <- x1[col(as.matrix(df))]
            ytot <- y[row(as.matrix(df))]
            xdelta <- (max(x1) - min(x1))/(length(x1) - 1)/2
            ydelta <- (max(y) - min(y))/(length(y) - 1)/2
            
            ##valgris <- c("white","grey20","grey80")
            
            z <- unlist(df)
            rect(xtot - xdelta, ytot - ydelta, xtot + xdelta, ytot + 
                 ydelta, col = col[1:3][z], border = "grey90")
            
            if((stat == "D") | (stat == "D2")){
                
                idR <- which(diff(assignR)==1)
                idQ <- which(diff(assignQ)==1)
                if(length(idR) > 0)
                    segments(sort(unique(xtot))[idR]+xdelta, max(ytot+ydelta), sort(unique(xtot))[idR]+xdelta, min(ytot-ydelta), lwd=2)
                if(length(idQ) > 0)
                    segments(max(xtot+xdelta), sort(unique(ytot), decreasing = TRUE)[idQ+1]+ydelta, min(xtot-xdelta), sort(unique(ytot), decreasing = TRUE)[idQ+1]+ydelta, lwd=2)
            }
            rect(min(xtot) - xdelta, min(ytot) - ydelta, max(xtot) + xdelta, max(ytot) + ydelta, col = NULL)
            
        }
    
    
    biplot.rlq4thcorner <- function (res.4thcorner, obj.rlq, stat, alpha, xax, yax, clab.traits, clab.env, col) 
        {
            ## plot associations between variables on a biplot
            opar <- par(mar = par("mar"))
            on.exit(par(opar))
            coolig <- obj.rlq$li[, c(xax, yax)]
            coocol <- obj.rlq$c1[, c(xax, yax)]
            
            s.label(coolig, clabel = 0, cpoint = 0, xlim = 1.2 * range(coolig[,1]))
            
            born <- par("usr")
            k1 <- min(coocol[, 1])/born[1]
            k2 <- max(coocol[, 1])/born[2]
            k3 <- min(coocol[, 2])/born[3]
            k4 <- max(coocol[, 2])/born[4]
            k <- c(k1, k2, k3, k4)
            coocol <- 0.9 * coocol/max(k)
            
            idx.pos <- which(t(res.4thcorner)==2, arr.ind=TRUE) ## positive association 
            idx.neg <- which(t(res.4thcorner)==3, arr.ind=TRUE) ## negative association
            idx.tot <- list(unique(c(idx.pos[,1],idx.neg[,1])), unique(c(idx.pos[,2],idx.neg[,2])))
            
            par(mar = c(0.1, 0.1, 0.1, 0.1))

            ## variables with no significant links
            if(length(idx.tot[[1]]) > 0)
                {
                    
                    scatterutil.eti(coolig[-idx.tot[[1]],1], coolig[-idx.tot[[1]],2],label=row.names(coolig)[-idx.tot[[1]]], clabel = clab.env, boxes = FALSE, coul = rep(col[1], nrow(coolig) - length(idx.tot[[1]])))
                    scatterutil.eti(coocol[-idx.tot[[2]],1], coocol[-idx.tot[[2]],2],label=row.names(coocol)[-idx.tot[[2]]], clabel = clab.traits, boxes = FALSE, coul = rep(col[1], nrow(coocol) - length(idx.tot[[2]])))
                } else {
                    scatterutil.eti(coolig[,1], coolig[,2],label=row.names(coolig), clabel = clab.env, boxes = FALSE, coul = rep(col[1], nrow(coolig)))
                    scatterutil.eti(coocol[,1], coocol[,2],label=row.names(coocol), clabel = clab.traits, boxes = FALSE, coul = rep(col[1], nrow(coocol)))
                }
            
            if(nrow(idx.pos) > 0)
                segments(coolig[idx.pos[,1],1],coolig[idx.pos[,1],2],coocol[idx.pos[,2],1],coocol[idx.pos[,2],2], lty = 1, lwd = 2, col = col[2])
            
            if(nrow(idx.neg) > 0)
                segments(coolig[idx.neg[,1],1],coolig[idx.neg[,1],2],coocol[idx.neg[,2],1],coocol[idx.neg[,2],2], lty = 1, lwd = 2, col = col[3])
            
            if(length(idx.tot[[1]]) > 0)
                {
                    scatterutil.eti.circ(coolig[idx.tot[[1]],1], coolig[idx.tot[[1]],2], label=row.names(coolig)[idx.tot[[1]]], clabel = clab.env, boxes = FALSE)
                    ##s.label(coolig[idx.tot[[1]],], clabel = clab.env, add.plot = TRUE)
                    ##scatterutil.eti(coocol[idx.tot[[2]],1], coocol[idx.tot[[2]],2],label=row.names(coocol)[idx.tot[[2]]], clabel = clab.traits, boxes = TRUE,bg = 'grey')
                    scatterutil.eti.circ(coocol[idx.tot[[2]],1], coocol[idx.tot[[2]],2],label=row.names(coocol)[idx.tot[[2]]], clabel = clab.traits, boxes = FALSE)
                    points(coolig[idx.tot[[1]],], pch = 17)
                    points(coocol[idx.tot[[2]],], pch = 19)
                }
        }
    
    
    
    
    biplot.axesrlq4thcorner <- function(res.4thcorner, coo, alpha, xax, yax, type.axes, col){
        opar <- par(mar = par("mar"))
        on.exit(par(opar))
        
        s.label(coo, clabel = 0, cpoint = 0)
        
        if(type.axes == "R.axes")
            res.4thcorner <- res.4thcorner[c(xax,yax),]
        if(type.axes == "Q.axes"){
            res.4thcorner <- res.4thcorner[,c(xax,yax)]
            res.4thcorner <- t(res.4thcorner)
        }
        
        ##idx.pos.xax <- which(res.4thcorner[1,] == 2) ## positive association with xax
        ##idx.pos.yax <- which(res.4thcorner[2,] == 2) ## positive association with yax
        
        ##idx.neg.xax <- which(res.4thcorner[1,] == 3) ## negative association with xax
        ##idx.neg.yax <- which(res.4thcorner[2,] == 3) ## negative association with yax
        
        ##idx.tot <- unique(c(idx.pos.xax, idx.pos.yax, idx.neg.xax, idx.neg.yax))
        idx.xax <- which((res.4thcorner[1,] > 1) & (res.4thcorner[2,] == 1))
        idx.yax <- which((res.4thcorner[1,] == 1) & (res.4thcorner[2,] > 1))
        idx.both <- which((res.4thcorner[1,] > 1) & (res.4thcorner[2,] > 1))
        idx.tot <- c(idx.xax, idx.yax, idx.both)
        
        par(mar = c(0.1, 0.1, 0.1, 0.1))

        if(length(idx.tot) > 0)
            {
                scatterutil.eti(coo[-idx.tot,1], coo[-idx.tot,2],label=row.names(coo)[-idx.tot], clabel = 1, boxes = FALSE, coul = rep(col[1], nrow(coo) - length(idx.tot)))
            } else {
                scatterutil.eti(coo[,1], coo[,2],label=row.names(coo), clabel = 1, boxes = FALSE, coul = rep(col[1], nrow(coo)))
            }
        
        if(length(idx.xax) > 0)
            scatterutil.eti(coo[idx.xax,1], coo[idx.xax,2],label=row.names(coo)[idx.xax], clabel = 1, boxes = TRUE, coul = rep(col[2], length(idx.xax)))
        
         if(length(idx.yax) > 0)
            scatterutil.eti(coo[idx.yax,1], coo[idx.yax,2],label=row.names(coo)[idx.yax], clabel = 1, boxes = TRUE, coul = rep(col[3], length(idx.xax)))

         if(length(idx.both) > 0)
            scatterutil.eti(coo[idx.both,1], coo[idx.both,2],label=row.names(coo)[idx.both], clabel = 1, boxes = TRUE, coul = rep(col[4], length(idx.both)))

       
    }
    
    if(type=="table"){
        table4thcorner(res, stat = stat, assignR = x$assignR, assignQ = x$assignQ, col = col)
    } else if(type=="biplot"){
        if(fctn =="fourthcorner" | fctn =="fourthcorner2"){ 
            if (!inherits(x.rlq, "rlq")) 
                stop("'x.rlq' should be of class 'rlq'")
            biplot.rlq4thcorner(res.4thcorner = res, obj.rlq = x.rlq, stat = stat, alpha = alpha, xax = xax, yax = yax, clab.traits = 1, clab.env = 1, col = col) 
        } else if(fctn=="fourthcorner.rlq"){
            obj.rlq <- eval(appel$xtest, sys.frame(0))
            type.axes <- eval(appel$typetest, sys.frame(0))
            
            if(type.axes == "axes")
                stop("The option 'axes' is only implemented for pedagogic purposes and is not relevant to analyse data")
            if(type.axes == "R.axes")
                coo <- obj.rlq$li[, c(xax, yax)]
            if(type.axes == "Q.axes")
                coo <- obj.rlq$co[, c(xax, yax)]
            biplot.axesrlq4thcorner(res.4thcorner = res, coo = coo, alpha = alpha, xax = xax, yax = yax, type.axes = type.axes, col = col)
        }
    }
}
