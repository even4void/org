# Time-stamp: <2011-01-07 12:41:47 chl>

#
# Some illustrations of SQL joins with R.
# Inspiration: Jeff Atwood, http://bit.ly/eMhJEp
#

tableA <- data.frame(id=1:4, name=c("Pirate","Monkey","Ninja","Spaghetti"))
tableB <- data.frame(id=1:4, name=c("Rutabaga","Pirate","Darth Vader","Ninja"))

plot.venn <- function(fill=c("#0000ff75",NA,"#0000ff75",NA),
                      title=NULL, border=F) {
  # Barely adapted from the `venneuler' package.
  # The fill parameter allows to show the outer/inner part of each circle, so
  # fill[1] = outer part of A, fill[2] = intersected part of A with B, 
  # fill[3] = outer part of B, and fill[4] = intersected part of B with A.
  k <- 1e4 # high resolution
  p <- seq.int(k) / k * 2 * pi
  px <- cos(p) / 2
  py <- sin(p) / 2
  d <- 1
  x1 <-  0.25 +  d * px
  y1 <- 0.5 +  d * py
  x2 <- 0.75 + d * px
  y2 <- 0.5 +  d * py
  opar <- par(mar=c(1,1,1,1))
  plot.new()
  plot.window(c(-.25,1.25), c(-.25,1.25), "", asp = 1)
  polygon(x1, y1, col=fill[1], border=ifelse(border, fill[1], NA))
  polygon(x2, y2, col=fill[3], border=ifelse(border, fill[3], NA))
  polygon(x1[x1>=.5], y1[x1>=.5], col=fill[2],
          border=ifelse(border, fill[2], NA))
  polygon(x2[x2<=.5], y2[x2<=.5], col=fill[4],
          border=ifelse(border, fill[4], NA))
  text(0.15, 0.5, "A")
  text(0.85, 0.5, "B")
  title(main=title)
  par(opar)
}

plot.syntax <- function() {
  # should look better if we rely on expr that can be injected afterwards
  vf <- c("sans serif", "bold")
  opar <- par(mar=c(1,1,1,1), cex=.6)
  plot.new()
  plot.window(c(0,10), c(0,5), "", asp = 1)
  text(rep(1,5), c(5,4,3,2,0.5), paste("(", letters[1:5], ")", sep=""),
       col="blue", pos=2)
  text(1, 5, "merge(tableA, tableB, by='name', all=FALSE)",
       vfont=vf, pos=4)
  text(1, 4, "merge(tableA, tableB, by='name', all=TRUE)",
       vfont=vf, pos=4)
  text(1, 3, "merge(tableA, tableB, by='name', all.x=TRUE)",
       vfont=vf, pos=4)
  text(1, 2, "res <- merge(tableA, tableB, by='name', all.x=TRUE)",
       vfont=vf, pos=4)
  text(1, 1.5, "res[apply(res, 2, is.na)[,3],]",
       vfont=vf, pos=4)
  text(1, 0.5, "res <- merge(tableA, tableB, by='name', all=TRUE)",
       vfont=vf, pos=4)
  text(1, 0, "res[apply(res, 1, function(x) any(is.na(x))),]",
       vfont=vf, pos=4)
  par(opar)
}

# SQL syntax

# (1) Inner join
merge(tableA, tableB, by="name", all=FALSE)

# (2) Full outer join
merge(tableA, tableB, by="name", all=TRUE)

# (3) Left outer join
merge(tableA, tableB, by="name", all.x=TRUE)

# (4) Records in A, but not in B
res <- merge(tableA, tableB, by="name", all.x=TRUE)
res[apply(res, 2, is.na)[,3],]
# or 
# intersect(tableA$name, tableB$name)

# (5) Records unique to A and B
res <- merge(tableA, tableB, by="name", all=TRUE)
res[apply(res, 1, function(x) any(is.na(x))),]

# Visuals

#
# The PNG output produces good looking results, but let's stick
# on PDF for nice vectorized shapes.
#

pdf("venn.pdf", fillOddEven=TRUE)
layout(matrix(c(1,2,3,4,6,6,5,6,6), 3, 3, byrow = TRUE))
plot.venn(c("white","#0000ff75","white","#0000ff75"), border=F,
          title="(a)")                                          # (1)
plot.venn(title="(b)")                                          # (2)
plot.venn(c("#0000ff75",NA,NA,NA), border=T, title="(c)")       # (3)
plot.venn(c("#0000ff75",NA,"white",NA), border=T, title="(d)")  # (4)
plot.venn(c("#0000ff75","white","#0000ff75","white"), border=T,
          title="(e)")                                          # (5)
plot.syntax()
dev.off()
