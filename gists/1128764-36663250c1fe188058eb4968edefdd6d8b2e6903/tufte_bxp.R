tufte.boxplot <- function(x, g) {
  k <- nlevels(g)
  crit.val <- tapply(x, g, median)
  plot(1:k, crit.val, ylim=c(min(x)*1.1, max(x)*1.1), pch=19,
       xlab=deparse(substitute(g)), ylab=deparse(substitute(x)))
  for (i in 1:k) {
    tmp <- boxplot.stats(x[as.numeric(g)==i])
    segments(i, tmp$stats[1], i, tmp$stats[2])
    segments(i, tmp$stats[4], i, tmp$stats[5])
    points(rep(i, length(tmp$out)), tmp$out, cex=.8)
  }
}

dd <- data.frame(x=rnorm(50*100), g=gl(50,100))
with(dd, tufte.boxplot(x, g))
