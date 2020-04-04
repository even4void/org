# Time-stamp: <2010-08-09 12:10:54 chl>

#
# Some illustrations of splines fitting.
#
# The example used throughout this script comes from
# Kooperberg & LeBlanc, Multivariate Nonparametric Regression,
# in _High-Dimensional Data Analysis in Cancer Research_
# (Ed. X. Li and R. Xu), Chapter 3, p. 45.
#

library(rms)
library(splines)
set.seed(101)
f <- function(x) sin(sqrt(2*pi*x))
n <- 1000
x <- runif(n, 0, 2*pi)
sigma <- rnorm(n, 0, 0.25)
y <- f(x) + sigma
plot(x, y, cex=.4)
curve(f, 0, 6, lty=2, add=TRUE)
# restricted cubic spline, 3 knots (2 Df)
lm0 <- lm(y~rcs(x,3))
lines(seq(0,6,length=1000), 
      predict(lm0,data.frame(x=seq(0,6,length=1000))),
      col="red")
# use B-spline and a single knot at x=1.13 (4 Df)
lm1 <- lm(y~bs(x, knots=1.13))
lines(seq(0,6,length=1000),
      predict(lm1,data.frame(x=seq(0,6,length=1000))), 
      col="green")
# cross-validated smoothed spline (approx. 20 Df)
xy.spl <- smooth.spline(x, y, cv=TRUE)
lines(xy.spl, col="blue")
legend("bottomleft", c("f(x)","RCS {rms}","BS {splines}","SS {stats}"), 
       col=1:4, lty=c(2,rep(1,3)),bty="n", cex=.6)