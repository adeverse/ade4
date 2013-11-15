"print.phylog" <- function (x, ...) {
    phylog <- x
    if (!inherits(phylog, "phylog")) 
        stop("for 'phylog' object")
   leaves.n <- length(phylog$leaves)
    nodes.n <- length(phylog$nodes)
     cat("Phylogenetic tree with",leaves.n,"leaves and",nodes.n,"nodes\n")
    cat("$class: ")
    cat(class(phylog))
    cat("\n$call: ")
    print(phylog$call)
    cat("$tre: ")
    l0 <- nchar(phylog$tre)
    if (l0 < 50) 
        cat(phylog$tre, "\n")
    else {
        cat(substring(phylog$tre, 1, 25))
        cat("...")
        cat(substring(phylog$tre, l0 - 26, l0), "\n")
    }
    cat("\n")
    n1 <-paste("$",names(phylog)[2:6],sep="")
    sumry <- array(" ", c(length(n1), 3), list(n1, c("class", "length", "content")))
    # leaves
    k <- 1; sumry[k,1] <- "numeric" ; sumry[k,2] <- as.character(length(phylog$leaves))
    sumry[k,3] <- "length of the first preceeding adjacent edge"
    #nodes
    k <- 2 ; sumry[k,1] <- "numeric" ; sumry[k,2] <- as.character(length(phylog$nodes))
    sumry[k,3]  <- "length of the first preceeding adjacent edge"
    #parts
    k <-3; sumry[k,1] <- "list";sumry[k,2] <- as.character(length(phylog$parts))
    sumry[k,3]  <- "subsets of descendant nodes"
    #paths
    k = 4; sumry[k,1] <- "list";sumry[k,2] <- as.character(length(phylog$paths))
    sumry[k,3]  <- "path from root to node or leave"
    #droot
    k = 5; sumry[k,1] <- "numeric";sumry[k,2] <- as.character(length(phylog$droot))
    sumry[k,3]  <- "distance to root"
    print.noquote(sumry)
    cat("\n")
    if (is.null(phylog$Wmat)) return(invisible())

    n1 <- names(phylog)[-(1:7)]
    n1 <- paste("$",n1,sep="")
    sumry <- array(" ", c(length(n1), 3), list(n1, c("class", "dim", "content")))
    # 8 Wmat
    k = 1
    sumry[k,1] <- "matrix"
    sumry[k,2] <- paste(nrow(phylog$Wmat),ncol(phylog$Wmat),sep="-")
    sumry[k,3] <- "W matrix : root to the closest ancestor"
    #9 Wdist
    k = 2
    sumry[k,1] <- "dist" ; 
    sumry[k,2] <- as.character(length(phylog$Wdist))
    sumry[k,3] <- "Nodal distances"
    # 10 Wvalues
    k = 3
    sumry[k,1] <- "numeric"
    sumry[k,2] <- length(phylog$Avalues)
    sumry[k,3] <- "Eigen values of QWQ/sum(Q)"
    #11 "Wscores"
    k = 4
    sumry[k,1] <- "data.frame"
    sumry[k,2] <- paste(nrow(phylog$Wscores),ncol(phylog$Wscores),sep="-")
    sumry[k,3] <- "Eigen vectors of QWQ '1/n' normed"
    #12 "Amat" 
    k = 5
    sumry[k,1] <- "matrix"
    sumry[k,2] <- paste(nrow(phylog$Amat),ncol(phylog$Amat),sep="-")
    sumry[k,3] <- "Topological proximity matrix A"
    #13 Avalues
    k = 6
    sumry[k,1] <- "numeric"
    sumry[k,2] <- length(phylog$Avalues)
    sumry[k,3] <- "Eigen values of QAQ matrix"
    #14 Adim
    k = 7
    sumry[k,1] <- "integer"
    sumry[k,2] <- "1"
    sumry[k,3] <- "number of positive eigen values of QAQ"  
    #15 Ascores
    k = 8
    sumry[k,1] <- "data.frame"
    sumry[k,2] <- paste(nrow(phylog$Ascores),ncol(phylog$Ascores),sep="-")
    sumry[k,3] <- "Eigen vectors of QAQ '1/n' normed"
    #16 Aparam
    k = 9
    sumry[k,1] <- "data.frame"
    sumry[k,2] <- paste(nrow(phylog$Aparam),ncol(phylog$Aparam),sep="-")
    sumry[k,3] <- "Topological indices for nodes"   
    # 17 Bindica
    k = 10 
    sumry[k,1] <- "data.frame"
    sumry[k,2] <- paste(nrow(phylog$Bindica),ncol(phylog$Bindica),sep="-")
    sumry[k,3] <- "class indicator from nodes"   
    # 18 Bscores
    k = 11 
    sumry[k,1] <- "data.frame"
    sumry[k,2] <- paste(nrow(phylog$Bscores),ncol(phylog$Bscores),sep="-")
    sumry[k,3] <- "Topological orthonormal basis '1/n' normed"   
    # 19 Bvalues
    # 20 Blabels
    k=12
    sumry[k,1] <- "character"
    sumry[k,2] <- length(phylog$Blabels)
    sumry[k,3] <- "Nodes labelling from orthonormal basis"
    print.noquote(sumry)
    return(invisible())
}

#######################################################################################
"phylog.extract" <- function (phylog, node, distance = TRUE){
    local <- lapply(phylog$paths, function(x) sum(x == node))
    tu.names <- names(which(local == 1))
    tre <- phylog$tre
    local1 <- paste(tu.names, ")", sep = "")
    local2 <- paste(tu.names, ",", sep = "")
    local3 <- paste(tu.names, ";", sep = "")
    tu.pos1  <- unlist(lapply(local1, function(x) regexpr(x, tre)))
    tu.pos2  <- unlist(lapply(local2, function(x) regexpr(x, tre)))
    tu.pos3  <- unlist(lapply(local3, function(x) regexpr(x, tre)))
    tu.pos <- cbind(tu.pos1, tu.pos2, tu.pos3)
    tu.pos <- apply(tu.pos, 1, function(x) x[which(x != -1)])
    leave.pos <- min(tu.pos)
    node.pos <- tu.pos[which(tu.names == node)]
    res <- substr(tre, leave.pos, node.pos - 1)
    res <- paste(res, node, sep = "")
    res <- paste(res, ";", sep = "")
    n.fermante <- length(unlist(gregexpr(")", res)))
    n.ouvrante <- length(unlist(gregexpr("(", res, fixed = TRUE)))
    parentheses <- rep("(", n.fermante - n.ouvrante)
    parentheses <- paste(parentheses, collapse = "")
    res <- paste(parentheses, res, sep = "")

    if (distance){
        nodes.names <- names(phylog$nodes)
        leaves.names <- names(phylog$leaves) 
       
        "tre2tre" <- function(res){
        	for (i in 1:length(leaves.names)) {
            	res <- sub(paste(leaves.names[i], ",", sep = ""), 
                	 paste(leaves.names[i], ":", phylog$leaves[i], 
                    ",", sep = ""), res)
        	}
        	for (i in 1:length(leaves.names)) {
            	res <- sub(paste(leaves.names[i], ")", sep = ""), 
                	 paste(leaves.names[i], ":", phylog$leaves[i], 
                    ")", sep = ""), res)
        	}
        	for (i in 1:length(nodes.names)) {
            	res <- sub(paste(nodes.names[i], ",", sep = ""), 
                	 paste(nodes.names[i], ":", phylog$nodes[i], ",", 
                    sep = ""), res)
        	}
        	for (i in 1:length(nodes.names)) {
            	res <- sub(paste(nodes.names[i], ")", sep = ""), 
                	 paste(nodes.names[i], ":", phylog$nodes[i], ")", 
                   sep = ""), res)
        	}
        return(res)
        }
        
        res <- tre2tre(res)
    }

    add.t <- !is.null(phylog$Wmat)
    res <- newick2phylog(res, add.tools = add.t, call = match.call())

return(res)
}

#######################################################################################
phylog.permut <- function(phylog,list.nodes = NULL, distance = TRUE){
    if (is.null(list.nodes)) list.nodes <- lapply(phylog$parts,function(a) if (length(a)==1) a else sample(a))
    #############################
    adddistances<-function(){
        # cette fonction assure la conversion de tre
        # en son équivalent muni des distances
        for(i in 1:length(leaves.names)) {
             tre<<- sub(paste(leaves.names[i],",",sep=""),paste(leaves.names[i],":",phylog$leaves[i],",",sep=""),tre,fixed=TRUE)
        }
        for(i in 1:length(leaves.names)) {
            tre<<- sub(paste(leaves.names[i],")",sep=""),paste(leaves.names[i],":",phylog$leaves[i],")",sep=""),tre,fixed=TRUE)
        }
      for(i in 1:length(nodes.names)) {
            tre<<- sub(paste(nodes.names[i],",",sep=""),paste(nodes.names[i],":",phylog$nodes[i],",",sep=""),tre,fixed=TRUE)
        }
        for(i in 1:length(nodes.names)) {
            tre<<- sub(paste(nodes.names[i],")",sep=""),paste(nodes.names[i],":",phylog$nodes[i],")",sep=""),tre,fixed=TRUE)
        }
    }
    #############################
    extract<-function(node) {
        # extrait de tre le sous-arbre enraciné au noeud node
        # il serait intéressant de traduire cett fonction en C,
        # en ne travaillant que sur les chaines de caractères newick
        # node.number<- grep(node, nodes.names)
        # on détermine la feuilles la plus à gauche associée au noeud
        # utilise la liste phylogparts contenant les descendants
        leave <- node
        k <- 0
        while(length(grep(leave,leaves.names))==0) {
            k <- k+1
            leave <- phylogparts[[leave]][1]
        }
        #on construit la chaine de caractère associée à l'arbre enraciné au noeud
        if (regexpr(paste(leave,")",sep=""),tre) == -1) {
            leave.pos <- regexpr(paste(leave,",",sep=""),tre)
        } else { 
            leave.pos <- regexpr(paste(leave,")",sep=""),tre)            
        }
        if (regexpr(paste(node,")",sep=""),tre) == -1) {
            node.pos <- regexpr(paste(node,",",sep=""),tre)
        } else { 
            node.pos <- regexpr(paste(node,")",sep=""),tre)            
        }
        res<-substr(tre,leave.pos,node.pos-1) 
        res<-paste(res,node,sep="")
        if (k==0) parentheses<-"" else parentheses<-"("
        if(k > 1) {
            for(i in 2:k){
                parentheses<-paste(parentheses,"(", sep="")
            }
        }
        res<-(paste(parentheses, res, sep=""))
        return(res)
    }
    #############################
    permute <- function (node) {
        # cette fonction assure la permutation dans tre des branches descendantes du noeud node
        # on remplace l'ordre initial conservé dans phylogparts[[node]]
        # par l'ordre final conservé dans list.nodes[[node]]
        # phylogparts[[node]] est mis à jour à la sortie
        new.part <- list.nodes[[node]]
        if (length(new.part)==1) return(invisible())
        old.part <- phylogparts[[node]]
        if (all (old.part==new.part)) return(invisible())
        for (k in 1:(length(new.part)-1)) {
            if (old.part[k]!=new.part[k]) {
                n1 <- old.part[k]
                n2 <- new.part[k]
                u1 <- extract(n1)
                u1.pos <- regexpr(paste(u1,"[,\\);]",sep=""),tre)
                u1.fin <- u1.pos+attr(u1.pos,"match.length")-1
                lastcar1 <- substring(tre, u1.fin, u1.fin)
                u2 <- extract(n2)
                u2.pos<-regexpr(paste(u2,"[,\\);]",sep=""),tre)
                u2.fin <- u2.pos+attr(u2.pos,"match.length")-1
                lastcar2 <- substring(tre, u2.fin, u2.fin)
                tre <<- sub(paste(u1,lastcar1,sep=""),"Restunlogicielformidable",tre,fixed = TRUE)
                tre <<- sub(paste(u2,lastcar2,sep=""), paste(u1,lastcar2,sep=""),tre,fixed=TRUE)
                tre <<- sub("Restunlogicielformidable",paste(u2,lastcar1,sep=""), tre,fixed=TRUE)
                old.part[old.part==n1] <- "1234564789"
                old.part[old.part==n2] <- n1
                old.part[old.part=="1234564789"] <- n2
             }
        }
        phylogparts[[node]] <<- new.part
    }    
    #############################
    verif <- function(node) {
        new.part <- sort(list.nodes[[node]])
        old.part <- sort(phylogparts[[node]])
        if (!(all(new.part==old.part))) return (FALSE)
        return (TRUE)
    }
    if(!inherits(phylog,"phylog")) stop ("Object with class 'phylog' expected")
    nodes.names<- names(phylog$nodes)
    leaves.names<- names(phylog$leaves)
    new.names <- names(list.nodes)
    phylogparts <- phylog$parts
    if (any(!new.names%in%nodes.names)) stop ("Non convient name in 'list.nodes'")
    wverif <- unlist(lapply(new.names,verif))
    if (any(!wverif)) stop ("Non convient content in 'list.nodes'")
    tre <- phylog$tre
    add.t <- !is.null(phylog$Wmat)
    for (node in new.names) permute(node)
    if (distance) adddistances ()
    res <- newick2phylog(tre, add.tools= add.t, call = match.call())
    return(res)
}
