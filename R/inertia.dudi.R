"inertia" <- function (x, ...) UseMethod("inertia")

"inertia.dudi" <- function (x, row.inertia = FALSE, col.inertia = FALSE, ...) {
    if (!inherits(x, "dudi")) 
        stop("Object of class 'dudi' expected")
    
    nf <- x$nf
    inertia <- x$eig
    cum <- cumsum(inertia)
    ratio <- cum/sum(inertia) * 100
    tot.inertia <- cbind.data.frame(inertia, cum, ratio)
    rownames(tot.inertia) <- paste0("Ax", 1:length(ratio))
    names(tot.inertia)[3] <- "cum(%)"
    listing <- list(tot.inertia = tot.inertia)
    if (row.inertia) {
        w <- x$tab * sqrt(x$lw)
        w <- sweep(w, 2, sqrt(x$cw), "*")
        w <- w * w
        listing$row.contrib <- apply(w, 1, sum)/sum(w) * 100
        w <- x$li * x$li * x$lw
        listing$row.abs <- sweep(w, 2, x$eig[1:nf], "/") * 100
         
        w <- x$tab
        w <- sweep(w, 2, sqrt(x$cw), "*")
        d2 <- apply(w * w, 1, sum)
        w <- x$li * x$li
        w <- sweep(w, 1, d2, "/")
        w <- w * sign(x$li)
        names(w) <- names(x$li)
        listing$row.rel <- data.frame(w) * 100
        
        w <- x$li * x$li
        w <- sweep(w, 1, d2, "/")
        w <- data.frame(t(apply(w, 1, cumsum)))
        names(w) <- names(x$li)
        remain <- 1 - w[, ncol(w)]
        listing$row.cum <- cbind.data.frame(w, remain) * 100
        names(listing$row.cum) <- paste0("Axis", c(1, if(nf > 1) paste(1,2:nf, sep =":") else NULL, paste0(nf+ 1, ":", length(ratio))))
    }
    if (col.inertia) {
        w <- x$tab * sqrt(x$lw)
        w <- sweep(w, 2, sqrt(x$cw), "*")
        w <- w * w
        listing$col.contrib <- apply(w, 2, sum)/sum(w) * 100
        w <- x$co * x$co * x$cw
        listing$col.abs <- sweep(w, 2, x$eig[1:nf], "/") * 100
        names(listing$col.abs) <- paste0("Axis", 1:nf)
        
        w <- x$tab
        w <- sweep(w, 1, sqrt(x$lw), "*")
        d2 <- apply(w * w, 2, sum)
        w <- x$co * x$co
        w <- sweep(w, 1, d2, "/")
        w <- w * sign(x$co)
        names(w) <- paste0("Axis", 1:ncol(w))
        listing$col.rel <- data.frame(w) * 100

        
        w <- x$co * x$co
        w <- sweep(w, 1, d2, "/")
        w <- data.frame(t(apply(w, 1, cumsum)))
        names(w) <- names(x$co)
        remain <- 1 - w[, ncol(w)]
        listing$col.cum <- cbind.data.frame(w, remain) * 100
        names(listing$col.cum) <- paste0("Axis", c(1, if(nf > 1) paste(1,2:nf, sep =":") else NULL, paste0(nf+ 1, ":", length(ratio))))
    }  
    
    listing$nf <- nf
    listing$call <- match.call()
    class(listing) <- c("inertia", class(listing))
    return(listing)
}

print.inertia <- function(x, ...){
    cat("Inertia information:")
    cat("\nCall: ")
    print(x$call)
    cat("\nDecomposition of total inertia:\n")
    print(format(x$tot.inertia, digits = 4, trim = TRUE, width = 7), quote = FALSE)
  
    if(!is.null(x$row.abs)){
        cat("\nRow contributions (%):\n")
        print(format(x$row.contrib, digits = 4, trim = TRUE, width = 7), quote = FALSE)
        
        cat("\nRow absolute contributions (%):\n")
        print(format(x$row.abs, digits = 4, trim = TRUE, width = 7), quote = FALSE)
 
        cat("\nSigned row relative contributions:\n")
        print(format(x$row.rel, digits = 4, trim = TRUE, width = 7), quote = FALSE)
        
        cat("\nCumulative sum of row relative contributions (%):\n")
        print(format(x$row.cum, digits = 4, trim = TRUE, width = 7), quote = FALSE)
        
    }
    
    if(!is.null(x$col.abs)){
        cat("\nColumn contributions (%):\n")
        print(format(x$col.contrib, digits = 4, trim = TRUE, width = 7), quote = FALSE)
        
        cat("\nColumn absolute contributions (%):\n")
        print(format(x$col.abs, digits = 4, trim = TRUE, width = 7), quote = FALSE)
        
        cat("\nSigned column relative contributions:\n")
        print(format(x$col.rel, digits = 4, trim = TRUE, width = 7), quote = FALSE)
        
        cat("\nCumulative sum of column relative contributions (%):\n")
        print(format(x$col.cum, digits = 4, trim = TRUE, width = 7), quote = FALSE)
        
    }
}


summary.inertia <- function(object, sort.axis = 1, subset = 5, ...){
    cat("\nTotal inertia: ")
    cat(signif(sum(object$tot.inertia$inertia), 4))
    cat("\n")
    
    call <- as.list(object$call)$x
    tab <- eval.parent(call)$tab
    subset <- min(subset, dim(tab))
    
    nf <- object$nf
    if(sort.axis > nf)
      stop("Non convenient axis for sorting contributions (sort.axis parameter).")
    l0 <- nrow(object$tot.inertia)
    
    cat("\nProjected inertia (%):\n")
    vec <- (object$tot.inertia$inertia / sum(object$tot.inertia$inertia) * 100)[1:(min(nf, l0))]
    names(vec) <- paste("Ax", 1:length(vec), sep = "")
    print(format(vec, digits = 4, trim = TRUE, width = 7), quote = FALSE)
    
    if (l0 > nf) {
        cat("\n")
        cat(paste("(Only ", nf, " dimensions (out of ", l0, ") are shown)\n", sep = "", collapse = ""))
    }
    cat("\n") 
    
    if(!is.null(object$row.abs)){
        cat("\nRow absolute contributions (%):\n")
        idx <- apply(object$row.abs, 2, order, decreasing = TRUE)
        idx <- unique(as.vector(idx[1:subset, sort.axis]))
        print(format(object$row.abs[idx, ], digits = 4, trim = TRUE, width = 7), quote = FALSE)
        cat("\n")
        
        cat("\nRow relative contributions (%):\n")
        idx <- apply(abs(object$row.rel), 2, order, decreasing = TRUE)
        idx <- unique(as.vector(idx[1:subset, sort.axis]))
        print(format(abs(object$row.rel[idx, ]), digits = 4, trim = TRUE, width = 7), quote = FALSE)
    }
  
    if(!is.null(object$col.abs)){
        cat("\nColumn absolute contributions (%):\n")
        idx <- apply(object$col.abs, 2, order, decreasing = TRUE)
        idx <- unique(as.vector(idx[1:subset, sort.axis]))
        print(format(object$col.abs[idx, ], digits = 4, trim = TRUE, width = 7), quote = FALSE)
        
        cat("\nColumn relative contributions (%):\n")
        idx <- apply(abs(object$col.rel), 2, order, decreasing = TRUE)
        idx <- unique(as.vector(idx[1:subset, sort.axis]))
        print(format(abs(object$col.rel[idx, ]), digits = 4, trim = TRUE, width = 7), quote = FALSE)
    }
}