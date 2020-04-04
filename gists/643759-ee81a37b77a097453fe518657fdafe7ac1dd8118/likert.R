# Some examples of graphical displays for Likert items
#
# Time-stamp: <2010-10-24 20:04:59 chl>
data(Environment, package="ltm")
Environment[sample(1:nrow(Environment), 10),1] <- NA
na.count <- apply(Environment, 2, function(x) sum(is.na(x)))
tab <- apply(Environment, 2, table)/apply(apply(Environment, 2, table), 2, sum)*100

# Cleveland dot plot
dotchart(tab, xlim=c(0,100), xlab="Frequency (%)", sub=paste("N", nrow(Environment), sep="="), pch=19)
text(100, c(2,7,12,17,22,27), rev(na.count), cex=.8)
mtext("# NA", side=3, line=0, at=100, cex=.8)

# Stacked barcharts
library(lattice)
barchart(t(tab), auto.key=list(columns=3, cex=.8), xlab="Frequency (%)")

# Heatmap and fluctuation diagram
library(ggplot2)
ggfluctuation(as.table(tab)) + xlab("") + ylab("")
ggfluctuation(as.table(tab), type="colour") + xlab("") + ylab("")

# Custom fluctuation diagram
k <- 10
op <- par(mar=c(5, 8, 2, 2), las=1)
plot(1:3, rep(0, 3), type="n", xlim=c(0.5,3.5), ylim=c(0,ncol(tab)+1), 
     axes=F, xlab="", ylab="")
abline(h=seq(1,ncol(tab)), col="lightgray")
for (i in 1:ncol(tab))
  points(1:3, rep(i,3), cex=tab[,i]/k, pch=19, col="coral", bg="coral")
mtext(c(rownames(tab),"NA (%)"), side=1, line=-1, at=c(1:3,3.5), cex=.8)
axis(2, at=1:6, labels=colnames(tab), lwd=0, cex=.8)
points(rep(0.5,2), c(7,6.7), cex=1:2, pch=19, col="coral", bg="coral")
text(rep(0.7,2), c(7,6.7), c("10%","20%"), cex=.8)
text(3.5, 7, paste("N", nrow(Environment), sep="="), cex=.8)
text(rep(3.5,6), 1:6, paste(na.count, " (", round(na.count/nrow(Environment)*100,0), ")", sep=""), cex=.8)
par(op)