"char2genet" <- function(X,pop,complete=FALSE) {
    if (!inherits(X, "data.frame")) stop ("X is not a data.frame")
    if (!is.factor(pop)) stop("pop is not a factor")
    nind <- length(pop)
    if (nrow(X) != nind) stop ("pop & X have non convenient dimension")
    # tri des lignes par ordre alphabétique des noms de population
    # tri par ordre alphabétique des noms de loci
    X <- X[order(pop),]
    X <- X[,sort(names(X))]
    pop <- sort(pop) # comme pop[order(pop)]
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
    ####################################################################################
    # Ce qui touche aux populations
    npop <- nlevels(pop)
    pop.names <- as.character(levels(pop))
    pop.codes <- codred("P", npop)
    names(pop.names) <- pop.codes
    levels(pop) <- pop.codes    
    ####################################################################################
    # Ce qui touche aux individus
    nind <- nrow(X)
    ind.names <- row.names(X)
    ind.codes <- codred("", nind)
    names(ind.names) <- ind.codes
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
     X <- as.data.frame(apply(X,c(1,2),cha6car))
     
     # Toutes les chaînes sont de 6 charactères suppose que le codage est complet
     # ou qu'il ne manque des zéros qu'au début
     "enumallel" <- function (x) {
        w <- as.character(x)
        w1 <- substr(w,1,3)
        w2 <- substr(w,4,6)
        w3 <- sort(unique (c(w1,w2)))
        return(w3)
    }
    all.util <- lapply(X,enumallel)
    # all.util est une liste dont les composantes sont les noms des allèles ordonnés
    # Correction d'un bug mis en evidence par Amalia
    # amalia@mail.imsdd.meb.uni-bonn.de 
    # La liste etait automatiquement une matrice quand le nombre d'allele par locus est constant
    # peut comprendre 000 pour un non typé
    # on conserve le nombre d'individus typés par locus et par populations
    "compter" <- function(x) {
        num0 <- x!="000000"
        num0 <- split(num0,pop)
        num0 <- as.numeric(unlist(lapply(num0,sum)))
        return(num0)
    }
    Z <- unlist(apply(X,2, compter))
    Z <- data.frame(matrix(Z,ncol=nloc))
    names(Z) <- loc.codes
    row.names(Z) <- pop.codes
    # Z est un data.frame populations-locus des effectifs d'individus
    ind.full <- apply(X,1,function (x) !any(x == "000000"))
    "polymor" <- function(x) {
        if (any(x=="000")) return(x[x!="000"])
        return(x)
    }
    "nallel" <- function(x) {
        l0 <- length(x)
        if (any(x=="000")) return(l0-1)
        return(l0)
    }
    loc.blocks  <-  unlist(lapply(all.util, nallel))
    names(loc.blocks) <- names(all.util)
    all.names  <-  unlist(lapply(all.util, polymor))
    w1 <- rep(loc.codes,loc.blocks)
    w2 <- unlist(lapply(loc.blocks, function(n) codred(".",n)))
    all.codes <- paste(w1,w2,sep="")
    all.names <- paste(rep(loc.names, loc.blocks),all.names,sep=".")
    names(all.names) <- all.codes
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
    names(ind.all) <- all.codes
    nallels <- length(all.codes)
    
    # ind.all contient un tableau individus - alleles codé 
    # ******* pour NA pour les manquants
    # 010010 pour les hétérozygotes
    # 000200 pour les homozygotes
    ind.all <- split(ind.all, pop)
     "remplacer" <- function (a,b) {
        if (all(!is.na(a))) return(a)
        if (all(is.na(a))) return(b)
        a[is.na(a)] <- b[is.na(a)]
        return(a)
    }
    
    "sommer"<- function (x){
        apply(x,2,function(x) sum(na.omit(x)))
    }
    all.pop <- matrix(unlist(lapply(ind.all,sommer)),nrow = nallels)
    all.pop = as.data.frame(all.pop)
    names(all.pop) <- pop.codes
    row.names(all.pop) <- all.codes

    center <- apply(all.pop,1,sum)
    center <- split(center, loc.fac)
    center <- unlist(lapply(center, function(x) x/sum(x)))
    names(center) <- all.codes
    "completer" <- function (x) {
        moy0  <-  apply(x,2,mean, na.rm=TRUE)
        y <- apply(x, 1, function(a) remplacer(a,moy0))
        return(y/2)
    }
    ind.all <- lapply(ind.all, completer)
    res <- list()
    pop.all <- unlist(lapply(ind.all,function(x) apply(x,1,mean)))
    pop.all <- matrix(pop.all, ncol=nallels, byrow=TRUE)
    pop.all <- data.frame(pop.all)
    names(pop.all) <- all.codes
    row.names(pop.all) <- pop.codes
    # 1) tableau de fréquences alléliques popualations-lignes
    # allèles-colonnes indispensable pour la classe genet
    res$tab <- pop.all
    # 2) marge du précédent calculé sur l'ensemble des individus typés par locus
    res$center <- center
    # 3) noms des populations renumérotées P001 ... P999
    # le vecteur contient les noms d'origine
    res$pop.names <- pop.names
    # 4) noms des allèles recodé L01.1, L01.2, ...
    # le vecteurs contient les noms d'origine.
    res$all.names <- all.names
    # 5) le vecteur du nombre d'allèles par loci
    res$loc.blocks <- loc.blocks
    # 6) le facteur répartissant les allèles par loci
    res$loc.fac <- loc.fac
    # 7) noms des loci renumérotées L01 ... L99
    # le vecteur contient les noms d'origine
    res$loc.names <- loc.names
    # 8) le nombre de gènes qui ont permis les calculs de fréquences
    res$pop.loc <- Z
    # 9) le nombre d'occurences de chaque forme allélique dans chaque population
    # allèles eln lignes, populations en colonnes
    res$all.pop <- all.pop
    #######################################################
    if (complete) {
        n0 <- length(all.codes) # nrow(ind.all[[1]])
        ind.all <- unlist(ind.all)
        ind.all <- matrix(ind.all, ncol=n0, byrow=TRUE)
        ind.all <- data.frame(ind.all)
        ind.all <- ind.all[ind.full,]
        pop.red <- pop[ind.full]
        names(ind.all) <- all.codes
        row.names(ind.all) <- ind.codes[ind.full]
        ind.all <- 2*ind.all
        # ind.all <- split(ind.all,pop.red)
        # ind.all <- lapply(ind.all,t)
        # 10) les typages d'individus complets
        # ind.all est une liste de matrices allèles-individus
        # ne contenant que les individus complètement typés
        # avec le codage 02000 ou 01001
        
        res$comp <- ind.all
        res$comp.pop <- pop.red
    }
     class(res) <- c("genet", "list")
    return(res)
}


"count2genet" <- function (PopAllCount) {
    # PopAllCount est un data.frame qui contient des dénombrements
     ####################################################################################
    "codred" <- function(base, n) {
        # fonction qui fait des codes de noms ordonnés par ordre
        # alphabétique de longueur constante le plus simples possibles
        # base est une chaîne de charactères, n le nombre qu'on veut
        w <- as.character(1:n)
        max0 <- max(nchar(w))
        "fun1" <- function(x) while ( nchar(w[x]) < max0) w[x] <<- paste("0",x,sep="")
        lapply(1:n, fun1)
        return(paste(base,w,sep="")) 
    }
  
    if (!inherits(PopAllCount,"data.frame")) stop ("data frame expected")
    if (!all(apply(PopAllCount,2,function(x) all(x==as.integer(x)))))
        stop("For integer values only")
    PopAllCount <- PopAllCount[sort(row.names(PopAllCount)),]
    PopAllCount <- PopAllCount[,sort(names(PopAllCount))]
    npop <- nrow(PopAllCount)
    w1 <- strsplit(names(PopAllCount),"[.]")
    loc.fac <- as.factor(unlist(lapply(w1, function(x) x[1])))
    loc.blocks <- as.numeric(table(loc.fac))
    nloc <- nlevels(loc.fac)    
    loc.names <- as.character(levels(loc.fac))
    pop.codes <- codred("P", npop)
    loc.codes <- codred("L",nloc)
    names(loc.blocks) <- loc.codes 
    pop.names <- row.names(PopAllCount)
    names(pop.names) <- pop.codes
    
    w1 <- rep(loc.codes,loc.blocks)
    w2 <- unlist(lapply(loc.blocks, function(n) codred(".",n)))
    all.codes <- paste(w1,w2,sep="")
    all.names <- names(PopAllCount)
    names(all.names) <- all.codes
    names(loc.names) <- loc.codes
    all.pop <- as.data.frame(t(PopAllCount))
    names(all.pop) <- pop.codes
    row.names(all.pop) <- all.codes
    
    center <- apply(all.pop,1,sum)
    center <- split(center,loc.fac)
    center <- unlist(lapply(center, function(x) x/sum(x)))
    names(center) <- all.codes
    
    PopAllCount <- split(all.pop,loc.fac)
    "pourcent" <- function(x) {
        x <- t(x)
        w <- apply(x,1,sum)
        w[w==0] <- 1
        x <- x/w
        return(x)
        # retourne un tableau populations-allèles
    }
    PopAllCount <- lapply(PopAllCount,pourcent)
    tab <- data.frame(provi=rep(1,npop))
    lapply(PopAllCount, function(x) tab <<- cbind.data.frame(tab,x))
    tab <- tab[,-1]
    names(tab) <- all.codes
    row.names(tab) <- pop.codes
    res <- list()
    res$tab <- tab
    res$center <- center
    res$pop.names <- pop.names
    res$all.names <- all.names
    res$loc.blocks <- loc.blocks
    res$loc.fac <- loc.fac
    res$loc.names <- loc.names
    res$pop.loc <- NULL
    res$all.pop <- all.pop
    res$complet <- NULL
    class(res) <- c("genet","list")
    return(res)
}

"freq2genet" <- function (PopAllFreq) {
    # PopAllFreq est un data.frame qui contient des fréquences alléliques
     ####################################################################################
    "codred" <- function(base, n) {
        # fonction qui fait des codes de noms ordonnés par ordre
        # alphabétique de longueur constante le plus simples possibles
        # base est une chaîne de charactères, n le nombre qu'on veut
        w <- as.character(1:n)
        max0 <- max(nchar(w))
        nformat <- paste("%0",max0,"i",sep="")
        "fun1" <- function(x) w[x] <<- sprintf(nformat,x)
        # "fun1" <- function(x) while ( nchar(w[x]) < max0) w[x] <<- paste("0",x,sep="")
        lapply(1:n, fun1)
        return(paste(base,w,sep="")) 
    }
  
    if (!inherits(PopAllFreq,"data.frame")) stop ("data frame expected")
    if (!all(apply(PopAllFreq,2,function(x) all(x>=0))))
        stop("Data >= 0 expected")
    if (!all(apply(PopAllFreq,2,function(x) all(x<=1))))
        stop("Data <= 1 expected")
    PopAllFreq <- PopAllFreq[sort(row.names(PopAllFreq)),]
    PopAllFreq <- PopAllFreq[,sort(names(PopAllFreq))]
    npop <- nrow(PopAllFreq)
    w1 <- strsplit(names(PopAllFreq),"[.]")
    loc.fac <- as.factor(unlist(lapply(w1, function(x) x[1])))
    loc.blocks <- as.numeric(table(loc.fac))
    nloc <- nlevels(loc.fac)    
    loc.names <- as.character(levels(loc.fac))
    pop.codes <- codred("P", npop)
    loc.codes <- codred("L",nloc)
    names(loc.blocks) <- loc.codes 
    pop.names <- row.names(PopAllFreq)
    names(pop.names) <- pop.codes
    
    w1 <- rep(loc.codes,loc.blocks)
    w2 <- unlist(lapply(loc.blocks, function(n) codred(".",n)))
    all.codes <- paste(w1,w2,sep="")
    all.names <- names(PopAllFreq)
    names(all.names) <- all.codes
    names(loc.names) <- loc.codes
    all.pop <- as.data.frame(t(PopAllFreq))
    names(all.pop) <- pop.codes
    row.names(all.pop) <- all.codes
    
    center <- apply(all.pop,1,mean)
    center <- split(center,loc.fac)
    center <- unlist(lapply(center, function(x) x/sum(x)))
    names(center) <- all.codes
    
    PopAllFreq <- split(all.pop,loc.fac)
    "pourcent" <- function(x) {
        x <- t(x)
        w <- apply(x,1,sum)
        w[w==0] <- 1
        x <- x/w
        return(x)
        # retourne un tableau populations-allèles
    }
    PopAllFreq <- lapply(PopAllFreq,pourcent)
    tab <- data.frame(provi=rep(1,npop))
    lapply(PopAllFreq, function(x) tab <<- cbind.data.frame(tab,x))
    tab <- tab[,-1]
    names(tab) <- all.codes
    row.names(tab) <- pop.codes
    res <- list()
    res$tab <- tab
    res$center <- center
    res$pop.names <- pop.names
    res$all.names <- all.names
    res$loc.blocks <- loc.blocks
    res$loc.fac <- loc.fac
    res$loc.names <- loc.names
    res$pop.loc <- NULL
    res$all.pop <- all.pop
    res$complet <- NULL
    class(res) <- c("genet","list")
    return(res)
}

