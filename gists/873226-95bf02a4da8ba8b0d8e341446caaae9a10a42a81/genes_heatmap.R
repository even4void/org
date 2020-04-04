library(mixOmics)
library(RColorbrewer)

X <- replicate(6, rnorm(50))
X.row.mds <- cmdscale(dist(X), k=1)
X.col.mds <- cmdscale(dist(t(X)), k=1)
cim(cor(X)[order(X.col.mds),order(X.col.mds)], col=rev(brewer.pal(8, "RdBu")))
cim(cor(t(X))[order(X.row.mds),order(X.row.mds)], col=rev(brewer.pal(8, "RdBu")))
cim(X, col=rev(brewer.pal(8, "RdBu"))
