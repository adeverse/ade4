originality <- function (phyl, method = 5) 
{
    if (!inherits(phyl, "phylog")) 
        stop("unconvenient phyl")
    if (any(is.na(match(method, 1:7)))) 
        stop("unconvenient method")
    nbMeth <- length(method)
    nbesp <- length(phyl$leaves)
    nbnodes <- length(phyl$nodes)
    resWeights <- as.data.frame(matrix(0, nbesp, nbMeth))
    rownames(resWeights) <- names(phyl$leaves)
    for (k in 1:nbMeth) {
        meth <- method[k]
        if (meth == 1) {
            interm <- (unlist(lapply(phyl$paths, length))[1:length(phyl$leaves)] - 
                1)
            res <- max(interm)/interm/sum(max(interm)/interm)
            resWeights[, k] <- res
            names(resWeights)[k] <- "VW"
        }
        if (meth == 2) {
            nbesp <- length(phyl$leaves)
            es1 <- lapply(phyl$paths[1:nbesp], function(x) x[-length(x)])
            fun <- function(x) {
                interm <- 0
                for (i in 1:length(x)) {
                  interm <- interm + length(phyl$parts[[x[i]]])
                }
                return(interm)
            }
            es2 <- lapply(es1, fun)
            es2 <- unlist(es2)
            res <- max(es2)/es2/sum(max(es2)/es2)
            resWeights[, k] <- res
            names(resWeights)[k] <- "M"
        }
        if (meth == 3) {
            len <- length(phyl$path)
            nam <- names(phyl$path)
            NbPerNode <- cbind.data.frame(Nb = rep(0, len))
            rownames(NbPerNode) <- nam
            NbPerNode[1:nbesp, ] <- 1
            for (i in (nbesp + 1):len) {
                NbPerNode[i, ] <- sum(NbPerNode[phyl$parts[[i - 
                  nbesp]], ])
            }
            BinPerNode <- cbind.data.frame(Nb = rep(0, len))
            CoPerNode <- NbPerNode - 1
            for (i in 1:(len - nbesp)) {
                index <- phyl$parts[[i]]
                len.index <- length(index)
                interm <- sapply(index, function(x) CoPerNode[x, 
                  ])
                if (sum(interm) == 0) {
                  BinPerNode[index, ] <- 0
                }
                else {
                  if (len.index == 2) {
                    if (interm[1] == interm[2]) {
                      BinPerNode[index, ] <- 1/2
                    }
                    else {
                      BinPerNode[index[rank(interm)], ] <- c(0, 
                        1)
                    }
                  }
                  else {
                    if (length(unique(interm)) == 1) {
                      BinPerNode[index[rank(interm)], ] <- 1/len.index
                    }
                    else {
                      Rank.1 <- as.factor(rank(interm))
                      Rank.1 <- as.numeric(Rank.1)
                      nb.groups <- length(unique(interm))
                      if (nb.groups == 2) 
                        Rank.2 <- c(0, 1)
                      else Rank.2 <- c(((nb.groups - 1):1)/nb.groups, 
                        0)[nb.groups:1]
                      BinPerNode[index, ] <- Rank.2[Rank.1]
                    }
                  }
                }
            }
            res <- lapply(phyl$path[1:nbesp], function(x) if (length(x) > 
                2) 
                sum(BinPerNode[x[2:(length(x) - 1)], ])
            else BinPerNode[x[2], ])
            res <- 1/(unlist(res) + 1)
            res <- res/sum(res)
            resWeights[, k] <- res
            names(resWeights)[k] <- "NWU*"
        }
        if (meth == 4) {
            len <- length(phyl$path)
            nam <- names(phyl$path)
            NbPerNode <- cbind.data.frame(Nb = rep(0, len))
            rownames(NbPerNode) <- nam
            NbPerNode[1:nbesp, ] <- 1
            for (i in (nbesp + 1):len) {
                NbPerNode[i, ] <- sum(NbPerNode[phyl$parts[[i - 
                  nbesp]], ])
            }
            res <- lapply(phyl$path[1:nbesp], function(x) sum(NbPerNode[x[2:(length(x) - 
                1)], ]))
            res <- 1/unlist(res)
            res <- res/sum(res)
            resWeights[, k] <- res
            names(resWeights)[k] <- "NWW"
        }
        if (meth == 5) {
            D <- as.matrix(phyl$Wdist^2/2)
            res <- solve(D) %*% rep(1, nbesp)/sum(solve(D))
            resWeights[, k] <- res
            names(resWeights)[k] <- "QEbased"
        }
        if (meth == 6) {
            pathsp <- phyl$paths[1:nbesp]
            mat1 <- matrix(0, nbesp, nbnodes)
            colnames(mat1) <- names(phyl$nodes)
            for(i in 1:nbesp){
                pathi <- phyl$path[[i]]
                pathi <- pathi[-length(pathi)]
                mat1[i, pathi] <- 1
            }
            wedges <- cbind.data.frame(apply(mat1, 2, sum))
            rownames(wedges) <- names(phyl$nodes)
            ndescendents <- unlist(lapply(phyl$parts, length))
            reslist <- lapply(pathsp, function(x) sum(c(unlist(phyl$nodes[x[-length(x)]])/wedges[x[-length(x)], ], phyl$leaves[x[length(x)]]))) 
            res <- unlist(reslist)
            resWeights[, k] <- res
            names(resWeights)[k] <- "ED"
        }
        if (meth == 7) {
            pathsp <- phyl$paths[1:nbesp]
            ndescendents <- unlist(lapply(phyl$parts, length))
            reslist <- lapply(pathsp, function(x) 
                sum(c(unlist(phyl$nodes[x[-length(x)]]) / 
                rev(cumprod(rev(ndescendents[x[-length(x)]]))), 
                phyl$leaves[x[length(x)]]))) 
            res <- unlist(reslist)
            resWeights[, k] <- res
            names(resWeights)[k] <- "eqsplit"
        }
        }
        return(resWeights)
}
