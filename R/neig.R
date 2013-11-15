"neig" <- function (list = NULL, mat01 = NULL, edges = NULL, n.line = NULL,
    n.circle = NULL, area = NULL) 
{
    if (!is.null(list)) {
        n <- length(list)
        output <- matrix(0, n, n)
        for (i in 1:n) {
            w <- list[[i]]
            if (length(w) > 0) 
                output[i, w] <- 1
        }
        output <- output + t(output)
        output <- 1 * (output > 0)
        w.output <- as.vector(apply(output, 1, sum))
        names(w.output) <- as.character(1:n)
        if (!is.null(attr(list, "region.id"))) 
            names(w.output) <- attr(list, "region.id")
        output <- neig.util.GtoL(output)
    }
    else if (!is.null(mat01)) {
        output <- neig.util.GtoL(mat01)
        w.output <- as.vector(apply(mat01, 1, sum))
        if (!is.null(rownames(mat01))) 
            names(w.output) <- rownames(mat01)
        else if (!is.null(colnames(mat01))) 
            names(w.output) <- colnames(mat01)
        else names(w.output) <- as.character(1:(nrow(mat01)))
    }
    else if (!is.null(edges)) {
        output <- edges
        G <- neig.util.LtoG(edges)
        w.output <- as.vector(apply(G, 1, sum))
        names(w.output) <- as.character(1:length(w.output))
    }
    else if (!is.null(n.line)) {
        output <- cbind(1:(n.line - 1), 2:n.line)
        G <- neig.util.LtoG(output)
        w.output <- as.vector(apply(G, 1, sum))
        names(w.output) <- as.character(1:n.line)
    }
    else if (!is.null(n.circle)) {
        output <- cbind(1:(n.circle - 1), 2:n.circle)
        output <- rbind(output, c(n.circle, 1))
        G <- neig.util.LtoG(output)
        w.output <- as.vector(apply(G, 1, sum))
        names(w.output) <- as.character(1:n.circle)
    }
    else if (!is.null(area)) {
        fac <- area[, 1]
        levpoly <- unique(fac)
        npoly <- length(levpoly)
        ng1 <- 0
        ng2 <- 0
        k <- 0
        for (i in 1:(npoly - 1)) {
            t1poly <- paste(area[fac == levpoly[i], 2], area[fac == 
                levpoly[i], 3], sep = "000")
            for (j in (i + 1):npoly) {
                t2poly <- paste(area[fac == levpoly[j], 2], area[fac == 
                  levpoly[j], 3], sep = "000")
                if (any(t1poly %in% t2poly)) {
                  k <- k + 1
                  ng1[k] <- i
                  ng2[k] <- j
                }
            }
        }
        output <- cbind(ng1, ng2)
        G <- neig.util.LtoG(output)
        w.output <- as.vector(apply(G, 1, sum))
        names(w.output) <- as.character(levpoly)
    }
    attr(output, "degrees") <- w.output
    attr(output, "call") <- match.call()
    class(output) <- "neig"
    output
}

"nb2neig" <- function (nb) {
    if (!inherits(nb, "nb")) 
        stop("Non convenient data")
    res <- neig(list = nb)
    w <- attr(nb, "region.id")
    if (is.null(w)) 
        w <- as.character(1:length(nb))
    names(attr(res, "degrees")) <- w
    return(res)
}

"neig2nb" <- function (neig) {
    if (!inherits(neig, "neig")) 
        stop("Non convenient data")
    w1 <- attr(neig, "degrees")
    n <- length(w1)
    region.id <- names(w1)
    if (is.null(region.id)) 
        region.id <- as.character(1:n)
    G <- neig.util.LtoG(neig)
    res <- split(G, row(G))
    res <- lapply(res, function(x) which(x > 0))
    attr(res, "region.id") <- region.id
    attr(res, "gal") <- FALSE
    attr(res, "call") <- match.call()
    class(res) <- "nb"
    return(res)
}

"neig2mat" <- function (neig) {
    # synonyme de neig.util.GtoL plus simple de mémorisation
    # donne la matrice d'incidence sommet-sommet en 0-1
    if (!inherits(neig,"neig")) stop ("Object 'neig' expected")
    deg <- attr(neig, "degrees")
    n <- length(deg)
    labels <- names(deg)
    neig <- unclass(neig)
    G <- matrix(0, n, n)
    for (i in 1:n) {
        w <- neig[neig[, 1] == i, 2]
        if (length(w) > 0) G[i, w] <- 1
    }
    G <- G + t(G)
    G <- 1 * (G > 0)
    if (is.null(labels)) labels <- paste("P",1:n,sep="")
    dimnames(G) <- list(labels,labels)
    return(G)
}

"neig.util.GtoL" <- function (G) {
    G <- as.matrix(G)
    n <- nrow(G)
    if (ncol(G) != n) 
        stop("Square matrix expected")
    # modif du any samedi, mai 31, 2003 at 16:19
    if (any(t(G) != G))
        stop("Symetric matrix expected")
    if (sum(G == 0 | G == 1) != n * n) 
        stop("0-1 values expected")
    if (sum(diag(G) != 0)) 
        stop("Null diagonal expected")
    G <- G * (row(G) < col(G))
    G <- (row(G) + 0 + (0+1i) * col(G)) * G
    G <- as.vector(G)
    G <- G[G != 0]
    G <- cbind(Re(G), Im(G))
    return(G)
}

"neig.util.LtoG" <- function (L, n = max(L)) {
    L <- unclass(L)
    if (ncol(L) != 2) 
        stop("two col expected")
    no.is.int <- function(x) x != as.integer(x)
    if (any(apply(L, c(1, 2), no.is.int))) 
        stop("Non integer value found")
    if (n < max(L)) 
        stop("Non convenient 'n' parameter")
    G <- matrix(0, n, n)
    for (i in 1:n) {
        w <- L[L[, 1] == i, 2]
        if (length(w) > 0) 
            G[i, w] <- 1
    }
    G <- G + t(G)
    G <- 1 * (G > 0)
    return(G)
}

"print.neig" <- function (x, ...) {
    deg <- attr(x, "degrees")
    n <- length(deg)
    labels <- names(deg)
    df <- neig.util.LtoG(x)
    for (i in 1:n) {
        w <- c(".", "1")[df[i, 1:i] + 1]
        cat(labels[i], " ", w, "\n", sep = "")
    }
    invisible(df)
}

 "summary.neig" <- function (object, ...) {
    cat("Neigbourhood undirected graph\n")
    deg <- attr(object, "degrees")
    size <- length(deg)
    cat("Vertices:", size, "\n")
    cat("Degrees:", deg, "\n")
    m <- sum(deg)/2
    cat("Edges (pairs of vertices):", m, "\n")
}

"scores.neig" <- function (obj) { 
    tol <- 1e-07
    if (!inherits(obj, "neig")) 
        stop("Object of class 'neig' expected")
    b0 <- neig.util.LtoG(obj)
    deg <- attr(obj, "degrees")
    m <- sum(deg)
    n <- length(deg)
    b0 <- -b0/m + diag(deg)/m
    # b0 est la matrice D-P
    eig <- eigen (b0, symmetric = TRUE)
    w0 <- abs(eig$values)/max(abs(eig$values))
    w0 <- which(w0<tol)
    if (length(w0)==0) stop ("abnormal output : no null eigenvalue")
    if (length(w0)==1) w0 <- (1:n)[-w0]
    else if (length(w0)>1) {
        # on ajoute le vecteur dérivé de 1n 
        w <- cbind(rep(1,n),eig$vectors[,w0])
        # on orthonormalise l'ensemble
        w <- qr.Q(qr(w))
        # on met les valeurs propres à 0
        eig$values[w0] <- 0
        # on remplace les vecteurs du noyau par une base orthonormée contenant 
        # en première position le parasite
        eig$vectors[,w0] <- w[,-ncol(w)]
        # on enlève la position du parasite
        w0 <- (1:n)[-w0[1]]
    }
    w0=rev(w0)
    rank <- length(w0)
    values <- n-eig$values[w0]*n
    eig <- eig$vectors[,w0]*sqrt(n)
    eig <- data.frame(eig)
    row.names(eig) <- names(deg)
    names(eig) <- paste("V",1:rank,sep="")
    attr(eig,"values")<-values
    eig
}

