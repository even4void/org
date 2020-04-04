mha <- 1  # mean under the alternative
es <- 2   # observed effect (deviation from mean under H0)
x <- seq(-6, 6, length=1000)
dh0 <- dnorm(x, 0, 1)

show.it <- function(es, mha, verbose=FALSE) {
  dh1 <- dnorm(x, mha, 1)

  plot.new()
  plot.window(xlim=range(x), ylim=c(0,.6)) 
  axis(1)

  ## show the two bell-shaped curves
  draw.curve <- function(x, y, col) {
    polygon(c(rev(x), x), c(rep(0, 1000), y), col=paste(col, "50", sep=""),
            border=NA)
    lines(x, y, lwd=1, col=col)
  }
  draw.curve(x, dh0, col="#2A4480")
  draw.curve(x, dh1, col="#FFE973")
  
  mtext(expression(mu[H0]), 1, -1.25, at=0)
  mtext(expression(mu[H1]), 1, -1.25, at=mha)

  ## show the observed effect
  abline(v=es, lty=2)

  ## highlight Type I and 1 - Type II error
  polygon(c(rev(x[x>=es]), x[x>=es]), c(rep(0, sum(x>=es)), dh0[x>=es]),
          col="#BF303075", border=NA)
  lines(x[x>=es], dh0[x>=es], col="#BF3030", lwd=1)
  polygon(c(rev(x[x>=es & dh0<dh1]), x[x>=es & dh0<dh1]),
          c(rev(dh0[x>=es & dh0<dh1]), dh1[x>=es & dh0<dh1]),
          col="#1D737375", border=NA)
  lines(x[x>=es & dh0<dh1], dh1[x>=es & dh0<dh1], col="#1D7373", lwd=1)

  alpha <- pnorm(es, 0, 1, lower.tail=FALSE)
  beta <- pnorm(es, mha, 1)
  
  labs.h0 <- "Type I Error (Alpha) "
  labs.h1a <- "Type II Error (Beta) "
  labs.h1b <- "1 - Type II Error (Power) "
  if (verbose) {
    labs.h0 <- paste(labs.h0, round(alpha*100, 1), "%", sep="")
    labs.h1a <- paste(labs.h1a, round(beta*100, 1), "%", sep="")
    labs.h1b <- paste(labs.h1b, round((1-beta)*100, 1), "%", sep="")
  }
  legend("topleft", c(labs.h0, labs.h1a, labs.h1b), pch=15,
         col=c("#BF3030", "#FFE973", "#1D7373"), bty="n")
}


animate.it <- function() {
  require(aplpack)
  update.display <- function(...) {
    s.es <- slider(no=1)
    s.mha <- slider(no=2)
    s.verbose <- slider(obj.name="show.numbers")
    show.it(s.es, s.mha, s.verbose)
  }
  slider(update.display, sl.names=c("Effect", "Mean Under HA"),
         sl.mins=c(0.5, 0.5), sl.maxs=c(4, 3), 
         sl.deltas=c(.05,.1), sl.defaults=c(es, mha),
         but.functions=list(
           function(...) {slider(obj.name="show.numbers", obj.value=TRUE);
                          update.display()},
           function(...) {slider(obj.name="show.numbers", obj.value=FALSE);
                          update.display()}),
         but.names=c("On", "Off"))
  slider(obj.name="show.numbers", obj.value=FALSE)
}
show.it(es, mha, verbose=FALSE)
animate.it()
