library(ade4)
library(ggplot2)

data (olympic)
dudi1 <- dudi.pca(olympic$tab, scan = FALSE)

# graphics

s.corcircle(dudi1$co, lab = names(olympic$tab))
s.corcircle(dudi1$co, cgrid = 0, full = FALSE, clab = 0.8)

s.corcircle(dudi1$co, lab = as.character(1:11), cgrid = 2, 
            full = FALSE, sub = "Correlation circle", csub = 2.5, 
            possub = "bottomleft", box = TRUE)


# ggplot

library(ggforce)
library(ggrepel)
library(ggpp)
 
s.corcircle(dudi1$co, lab = names(olympic$tab), plotstyle = "ggplot")
