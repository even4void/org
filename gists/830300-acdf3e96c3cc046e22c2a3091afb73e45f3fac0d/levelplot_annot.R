x <- seq(0,10)
y <- seq(0,10)
df <- expand.grid(x=x, y=y)
df$z <- rnorm(nrow(df), mean=5)

library(lattice)
levelplot(z ~ x+y, data=df, 
          panel=function(x, y, ...) {
            panel.levelplot(x, y, ...)
            panel.abline(v=1)
          })

library(RColorBrewer)
my.cols <- brewer.pal(7, "RdBu")
levelplot(z ~ x+y, data=df, xlab="", ylab="", 
          cuts=length(my.cols), pretty=T, col.regions=my.cols, 
	  panel=function(x, y, ...) {
	    panel.levelplot(x, y, ...)
	    panel.segments(c(2,4,4,2), c(2,2,4,4),
                           c(4,4,2,2), c(2,4,4,2), lty=2, col="red")
          })
