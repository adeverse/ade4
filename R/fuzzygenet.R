"fuzzygenet" <- function(X) {
    if (!inherits(X, "data.frame")) stop ("X is not a data.frame")
    nind <- nrow(X)
    ####################################################################################
    "codred" <- function(base, n) {
        # fonction qui fait des codes de noms ordonnés par ordre
        # alphabétique de longueur constante le plus simples possibles
        # base est une chaîne de charactères, n le nombre qu'on veut
        w <- as.character(1:n)
        max0 <- max(nchar(w))
        "fun1" <- function(x) while ( nchar(w[x]) < max0) w[x] <<- paste("0",w[x],sep="")
        lapply(1:n, fun1)
        return(paste(base,w,sep="")) 
    }
    ###################################################################################
    # ce qui touche au loci
    loc.names <- names(X)
    nloc <- ncol(X)
    loc.codes <- codred("L",nloc)
    names(loc.names) <- loc.codes
    names(X) <- loc.codes
    "cha6car" <- function(cha) {
        # pour compléter les chaînes de caratères par des zéros devant
        n0 <- nchar(cha)
        if (n0 == 6) return (cha)
        if (n0 >6) stop ("More than 6 characters")
        cha = paste("0",cha,sep="")
        cha = cha6car(cha)
     }
     X <- apply(X,c(1,2),cha6car)
     
     # Toutes les chaînes sont de 6 charactères suppose que le codage est complet
     # ou qu'il ne manque des zéros qu'au début
     "enumallel" <- function (x) {
        w <- as.character(x)
        w1 <- substr(w,1,3)
        w2 <- substr(w,4,6)
        w3 <- sort(unique (c(w1,w2)))
        return(w3)
    }
    all.util <- apply(X,2,enumallel)
    # all.util est une liste dont les composantes sont les noms des allèles ordonnés
    # peut comprendre 000 pour un non typé
    # on conserve le nombre d'individus typés par locus dans vec1
    "compter" <- function(x) {
    # compte le nombre d'individus typés par locus
        num0 <- x!="000000"
        num0 <- sum(num0)
        return(num0)
    }
    vec1 <- unlist(apply(X,2, compter))
    names(vec1) <- loc.codes
    # vec1 est le vecteur des effectifs d'individus typés par locus
    "polymor" <- function(x) {
        if (any(x=="000")) return(x[x!="000"])
        return(x)
    }
    "nallel" <- function(x) {
        l0 <- length(x)
        if (any(x=="000")) return(l0-1)
        return(l0)
    }
    vec2  <-  unlist(lapply(all.util, nallel))
    names(vec2) <- names(all.util)
    # vec2 est le vecteur du nombre d'allèles observés par locus
    
    all.names  <-  unlist(lapply(all.util, polymor))
    # all.names contient les nomds des alleles sans "000"
    loc.blocks  <-  unlist(lapply(all.util, nallel))
    names(loc.blocks) <- names(all.util)
    all.names  <-  unlist(lapply(all.util, polymor))
    w1 <- rep(loc.codes,loc.blocks)
    w2 <- unlist(lapply(loc.blocks, function(n) codred(".",n)))
    all.codes <- paste(w1,w2,sep="")
    all.names <- paste(rep(loc.names, loc.blocks),all.names,sep=".")
    names(all.names) <- all.codes
    # all.names est le nouveau nom des allèles
    w1 <- as.factor(w1)
    names(w1) <- all.codes
    loc.fac <- w1
    "manq"<- function(x) {
        if (any(x=="000")) return(TRUE)
        return(FALSE)
    }
    missingdata <- unlist(lapply(all.util, manq))
    "enumindiv" <- function (x) {
        x <- as.character(x)
        n <- length(x)
        w1 <- substr(x, 1, 3)
        w2 <- substr(x, 4, 6)
        "funloc1" <- function (k) {
            w0 <- rep(0,length(all.util[[k]]))
            names(w0) <- all.util[[k]]
            w0[w1[k]] <- w0[w1[k]]+1
            w0[w2[k]] <- w0[w2[k]]+1
            # ce locus n'a pas de données manquantes
            if (!missingdata[k]) return(w0)
            # ce locus a des données manquantes mais pas cet individu
            if (w0["000"]==0) return(w0[names(w0)!="000"])
            #cet individus a deux données manquantes
            if (w0["000"]==2) {
                w0 <- rep(NA, length(w0)-1)
                return(w0)
            }
            # il doit y avoir une seule donnée manquante
            stop( paste("a1 =",w1[k],"a2 =",w2[k], "Non implemented case"))
        }
        w  <-  as.numeric(unlist(lapply(1:n, funloc1)))
        return(w)
    }
    ind.all <- apply(X,1,enumindiv)
    ind.all <- data.frame(t(ind.all))
    names(ind.all) <- all.names
    nind <- nrow(ind.all)
    # ind.all contient un tableau individus - alleles codé 
    # ******* pour NA pour les manquants
    # 010010 pour les hétérozygotes
    # 000200 pour les homozygotes
    all.som <- apply(ind.all,2,function(x) sum(na.omit(x)))
    #all.som contient le nombre d'allèles présents par forme allélique
    names(all.som) = all.names

    center <- split(all.som, loc.fac)
    center <- lapply(center, function(x) 2*x/sum(x))
    center <- unlist(center)
    names(center) <- all.codes
    "modifier" <- function (x) {
        x[is.na(x)]=center[is.na(x)]
        return(x/2)
    }
    ind.all <- t(apply(ind.all, 1, modifier))
    ind.all <- as.data.frame(ind.all)
    names(ind.all) <- all.codes
    attr(ind.all,"col.blocks") <- vec2
    attr(ind.all,"all.names") <- all.names
    attr(ind.all,"loc.names") <- loc.names
    attr(ind.all,"row.w") <- rep(1/nind, nind)
    attr(ind.all,"col.freq") <- center/2
    attr(ind.all,"col.num") <- as.factor(rep(loc.names,vec2))
    return(ind.all)
}


