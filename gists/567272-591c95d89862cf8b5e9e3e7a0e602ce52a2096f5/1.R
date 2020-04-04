# Time-stamp: <2010-09-06 19:09:25 chl>

#
# Show multiple boxplot on the same page.
# Part of the code (esp. that concerned with making a bxp
# from scratch comes from P. Murrell.
#

#x <- replicate(50, sample(1:5, 500, rep=TRUE))
x <- replicate(190, rnorm(500))

grid.bxp <- function(x, axes=F, lines=3) {
  grid.newpage()
  xmax <- ceiling(ncol(x)/lines)
  coor.x <- rep(seq(1,xmax), lines)
  coor.y <- rep(seq(1,lines), each=xmax)

  lay.vp <- grid.layout(lines, xmax)
  pushViewport(viewport(width=.98, height=.98, layout=lay.vp))
  grid.rect(gp=gpar(col="grey"))
  
  for (i in 1:ncol(x)) {
    bxp <- boxplot(x[,i], plot=FALSE)
      pushViewport(viewport(layout.pos.col=coor.x[i],
                            layout.pos.row=coor.y[i]))
    pushViewport(viewport(x=1, width=unit(.25, "inches"),
                          height=unit(.25, "inches"),
                          just=c("centre", "center")))
    left <- -.3
    width <- .4
    middle <- left + width/2
    grid.rect(x=left, y=unit(bxp$conf[1,1], "native"),
              width=width, height=unit(diff(bxp$conf[,1]), "native"),
              just=c("left", "bottom"),
              gp=gpar(col=NULL, fill="orange"))
    grid.rect(x=left, y=unit(bxp$stats[4,1], "native"),
              width=width, height=unit(diff(bxp$stats[4:3,1]), "native"),
              just=c("left", "bottom"))
    grid.rect(x=left, y=unit(bxp$stats[3,1], "native"),
              width=width, height=unit(diff(bxp$stats[3:2,1]), "native"),
              just=c("left", "bottom"))
    grid.lines(x=c(middle, middle), y=unit(bxp$stats[1:2,1], "native"))
    grid.lines(x=c(middle, middle), y=unit(bxp$stats[4:5,1], "native"))
    grid.lines(x=c(middle-.1, middle+.1), y=unit(bxp$stats[1,1], "native"))
    grid.lines(x=c(middle-.1, middle+.1), y=unit(bxp$stats[5,1], "native"))
    np <- length(bxp$out)
    if (np > 0)
      grid.points(x=rep(middle, np),
                  y=unit(bxp$out, "native"),
                  size=unit(.25, "char"))
    grid.text(i, x=0.5, y=2, just="right", gp=gpar(fontsize=6))
    if (axes) {
      if (i==1)
        grid.yaxis(main=TRUE)
    }
      popViewport(2)
  }
}

grid.bxp(x, lines=4)

