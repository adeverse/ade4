 "Rtoade4" <-
function (x) {
    if (!is.data.frame(x)) 
        stop("x is not a data.frame")
    nombase <- deparse(substitute(x))


  # Si il n'y a que des variables qualitatives
  
   if (all(unlist(lapply(x, is.factor)))) {
        z <- matrix(0, nrow(x), ncol(x))
        for (j in 1:(ncol(x))) {
            toto <- x[, j]
            z[, j] <- unlist(lapply(toto, function(x, fac) which(x == 
                levels(fac)), fac = toto))
        }
        nomfic <- paste(nombase, ".txt", sep = "")
        write.table(z, file = nomfic, quote = FALSE, sep = "    ", 
            eol = "\n", na = "-999", row.names = FALSE, col.names = FALSE, 
            qmethod = c("escape", "double"))
        cat("File creation", nomfic, "\n")
        if (!is.null(attr(x, "names"))) {
            y <- attr(x, "names")
            nomfic <- paste(nombase, "_var_lab.txt", sep = "")
            write.table(y, file = nomfic, quote = FALSE, sep = "    ", 
                eol = "\n", na = "999", row.names = FALSE, col.names = FALSE, 
                qmethod = c("escape", "double"))
            cat("File creation", nomfic, "\n")
        }
        nommoda <- NULL
        for (j in 1:(ncol(x))) {
            toto <- x[, j]
            nommoda <- c(nommoda, levels(toto))
        }
        nomfic <- paste(nombase, "_moda_lab.txt", sep = "")
        write.table(y, file = nomfic, quote = FALSE, sep = "    ", 
            eol = "\n", na = "999", row.names = FALSE, col.names = FALSE, 
            qmethod = c("escape", "double"))
        cat("File creation", nomfic, "\n")
        return(invisible())
    }

    # Le cas général
    nomfic <- paste(nombase, ".txt", sep = "")
    write.table(x, file = nomfic, quote = FALSE, sep = "    ", eol = "\n", 
        na = "-999", row.names = FALSE, col.names = FALSE, qmethod = c("escape", 
            "double"))
    cat("File creation", nomfic, "\n")
    if (!is.null(attr(x, "names"))) {
        y <- attr(x, "names")
        nomfic <- paste(nombase, "_col_lab.txt", sep = "")
        write.table(y, file = nomfic, quote = FALSE, sep = "    ", 
            eol = "\n", na = "-999", row.names = FALSE, col.names = FALSE, 
            qmethod = c("escape", "double"))
        cat("File creation", nomfic, "\n")
    }
    if (!is.null(attr(x, "row.names"))) {
        y <- attr(x, "row.names")
        nomfic <- paste(nombase, "_row_lab.txt", sep = "")
        write.table(y, file = nomfic, quote = FALSE, sep = "    ", 
            eol = "\n", na = "-999", row.names = FALSE, col.names = FALSE, 
            qmethod = c("escape", "double"))
        cat("File creation", nomfic, "\n")
    }
    if (!is.null(attr(x, "col.blocks"))) {
        y <- as.vector(attr(x, "col.blocks"))
        nomfic <- paste(nombase, "_col_bloc.txt", sep = "")
        write.table(y, file = nomfic, quote = FALSE, sep = "    ", 
            eol = "\n", na = "-999", row.names = FALSE, col.names = FALSE, 
            qmethod = c("escape", "double"))
        cat("File creation", nomfic, "\n")
        y <- names(attr(x, "col.blocks"))
        nomfic <- paste(nombase, "_col_bloc_lab.txt", sep = "")
        write.table(y, file = nomfic, quote = FALSE, sep = "    ", 
            eol = "\n", na = "-999", row.names = FALSE, col.names = FALSE, 
            qmethod = c("escape", "double"))
        cat("File creation", nomfic, "\n")
    }
}

"ade4toR" <- function (fictab, ficcolnames = NULL, ficrownames = NULL) {
    if (!file.exists(fictab)) 
        stop(paste("file", fictab, "not found"))
    if (!is.null(ficrownames) && !file.exists(ficrownames)) 
        stop(paste("file", ficrownames, "not found"))
    if (!is.null(ficcolnames) && !file.exists(ficcolnames)) 
        stop(paste("file", ficcolnames, "not found"))
    w <- read.table(fictab, header = FALSE)
    nl <- nrow(w)
    nc <- ncol(w)
    if (!is.null(ficcolnames)) 
        provicol <- as.character((read.table(ficcolnames, header = FALSE))$V1)
    else provicol <- as.character(1:nc)
    if ((length(provicol)) != nc) {
        stop(paste("Non convenient row number in file", ficcolnames, 
            "- Expected:", nc, "- Input:", length(provicol)))
    }
    if (is.null(ficcolnames)) 
        names(w) <- paste("v", provicol, sep = "")
    else names(w) <- provicol
    if (!is.null(ficrownames)) 
        provirow <- as.character((read.table(ficrownames, header = FALSE))$V1)
    else provirow <- as.character(1:nl)
    if ((length(provirow)) != nl) {
        stop(paste("Non convenient row number in file", ficrownames, 
            "- Expected:", nl, "- Input:", length(provirow)))
    }
    row.names(w) <- provirow
    return(w)
}


