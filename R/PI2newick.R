"PI2newick" <- function(x){
# cette fonction permet de convertir les fichiers d'entrée du logiciel PI 
# d'Abouheif au format newick (on récupère également les valeurs associées
# aux feuilles)
# x est une matrice qui vient de la lecture des fichiers .txt: x <- read.table("PI1.txt", h = FALSE)
# il a autant de lignes qu'il y a de feuilles-1; dans le cas d'une phylogénie résolue, c'est le nombre de noeuds
# il y a 6 colonnes: Contrast value/ Left tip value/ Right tip value/ Left node name/ Right node name/ Unresolved nodes group

# on prépare le terrain
nodes.group <- as.factor(x[, 6])
x <- x[, -c(1,6)]
x[,c(3,4)] <-x[,c(3,4)] + 1
x[x == -99] <- 0
nleaves <- nrow(x) + 1 
nnodes <- sum(nodes.group==0)+length(levels(nodes.group))-1

# on récuupère les valeurs associées aux feuilles
values <- as.vector(t(as.matrix(x[,c(1,2)])))
values <- values[values!=0]
for (i in 1:nleaves) 
    x[x==values[i]] <- i
#print(x)

# on construit la chaine de charactère au format newick
names(x) <- c("Ext", "Ext", "I", "I")
tre <- NULL
if (nodes.group[1]==0){
    u <- x[1,]
    v <- names(x)[u!=0]
    w <- u[u!=0]
    u <- paste(v, w, sep="")
    tre <- paste("(", u[1], ",", u[2], ")Root;", sep="")
    }
    else 
        stop("the Root must be resolved: will be programmed later")  # le cas ou il y a plusieurs feuilles et un noeud reste à faire  
j <- 2   
for (i in 2:nnodes){
    if (nodes.group[j]==0){
        u <- x[j,]
        v <- names(x)[u!=0]
        w <- u[u!=0]
        u <- paste(v, w, sep="")
        u <- paste("(", u[1], ",", u[2], ")", paste("I", i,sep=""), sep="")
        tre <- gsub(paste("I", j,sep=""), u, tre)
        j <- j + 1
        }
        else{
            u <- nodes.group[j]
            v <- sum(nodes.group==u)
            w <- x[j:(j+v-1), 1:2]
            w <- as.vector(as.matrix(w))
            w <- w[w!=0]
            w <- sort(w)
            y <- paste(rep("Ext", v+1), w, sep="")
            z <- y[1]
            for (i in 2:(v+1)) z <- paste(z, y[i], sep=",")
            z <- paste("(", z, ")", paste("I", j,sep=""), sep="") 
            tre <- gsub(paste("I", j,sep=""), z, tre)
            j <- j + v
            } 
    }
    
return(list(tre = tre, trait = values))
}
