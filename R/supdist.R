"supdist" <- function (d, fsup, tol = 1e-07)
{
#
# This function takes a distance matrix between Supplementary and Active items.
# It computes the PCO of the distance matrix between Active items, and projects
# the distance matrix between Supplementary and Active elements in this PCO.
# Jean Thioulouse 06/2017. Based on : https://doi.org/10.1371/journal.pone.0019094
#
    if (!inherits(d, "dist")) 
        stop("Distance matrix expected")
    n <- attr(d, "Size")
    if (!inherits(fsup, "factor"))
    	stop("Argument fsup must be a factor")
    if (length(fsup) != attr(d, "Size"))
    	stop("Incompatible factor length")
    if (length(levels(fsup)) != 2)
    	stop("The factor must have exactly two levels")
	if (any(levels(fsup) != c("A","S")))
    	stop("The factor must give the Active (A) / Supplementary (S) status for each item in the distance matrix")
	
	# distance matrix between Supplementary and Active items
	DSup <- as.matrix(d)[fsup == "S", fsup == "A", drop = FALSE]
	nS <- table(fsup)[2]
	nA <- table(fsup)[1]
	nT <- nS + nA
	Id <- diag(nrow = nA)
	One <- matrix(1, nrow = nA, ncol = nA)
	
	# distance matrix between Active items
	DAct <- as.matrix(d)[fsup == "A", fsup == "A"]
	# squared distances
    DAct <- DAct * DAct
    # Double centering, cross-product matrix
	SAct <- -0.5 * (Id - One * 1 / nA) %*% DAct %*% (Id - One * 1 / nA)

	# PCO of Active items
	eigAct<- eigen(SAct)
	rAct <- sum(eigAct$values > (eigAct$values[1] * tol))
	# coordinates of Active items
	FAct <- t(t(eigAct$vectors[, 1:rAct]) * sqrt(eigAct$values[1:rAct]))

	OneS <- matrix(1, nrow = nS, ncol = nA)
	# squared distances between Supplementary and Active items
    DSup <- DSup * DSup
    # Double centering, cross-product matrix
	SSup <- -0.5 * (Id - One * 1 / nA) %*% (t(DSup) - DAct %*% t(OneS) * 1 / nA)
	# coordinates of Supplementary items
	FSup <- t(SSup) %*% t(t(FAct) * 1 / eigAct$values[1:rAct])
	
	# conversion to dataframes and creation of the returned object
	# Supplementary items
	FSup <- as.data.frame(FSup)
	names(FSup) <- paste("A", 1:rAct, sep = "")
	row.names(FSup) <- attr(d, "Labels")[fsup == "S"]

	# Active items
	FAct <- as.data.frame(FAct)
	names(FAct) <- paste("A", 1:rAct, sep = "")
	row.names(FAct) <- attr(d, "Labels")[fsup == "A"]
	
	# Active + Supplementary items
	FTot <- rbind.data.frame(FAct, FSup)
	
	res <- list(coordSup = FSup, coordAct = FAct, coordTot = FTot)
	return(res)
}
