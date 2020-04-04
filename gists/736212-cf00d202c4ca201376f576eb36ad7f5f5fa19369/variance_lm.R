# Time-stamp: <2010-12-10 14:28:19 chl>

#
# A toy example to illustrate SS idea in the Linear Model.
#

do.it <- function(x, g) {
  stopifnot(is.factor(g))
  stripchart(x ~ g, method="jitter", pch=19, col="darkgrey",
                        vertical=TRUE, ylab="")
  points(1:nlevels(g), tapply(x, g, mean), pch="x", cex=1.2, col=4)
  lines(1:nlevels(g), tapply(x, g, mean), col=4)
  arrows(1:nlevels(g), tapply(x, g, mean)-tapply(x, g, sd)/sqrt(n),
         1:nlevels(g), tapply(x, g, mean)+tapply(x, g, sd)/sqrt(n),
         angle=90, length=.1, code=3, col=4)
}

pdf("1.pdf", width=8, height=5)
op <- par(mfrow=c(1,3), las=1)

set.seed(58)

# Case 1: Two-sample t-test
n <- c(20, 20)
x <- c(rnorm(n[1], mean=7.5, sd=2), rnorm(n[2], mean=10, sd=2))
g <- factor(rep(letters[1:2], each=n))

do.it(x, g)
# total variation
arrows(1.5, min(x), 1.5, max(x), code=3, angle=30, lwd=2,
       length=.2, col="darkgrey")
# group-specific variation
for (i in seq_along(levels(g)))
  arrows(abs(i+1.5)/2, min(x[as.numeric(g)==i]),
         abs(i+1.5)/2, max(x[as.numeric(g)==i]),
         code=3, angle=30, lwd=1.5, length=.1)


# Case 2: One-way ANOVA
n <- 10
k <- 3
es <- c(70,-80,0) # deviation /mean
g <- gl(3, n, , n*k, labels=letters[1:3])
x <- NULL
for (i in seq_along(levels(g)))
  x <- append(x, rnorm(n, mean=200+es[i], sd=75))

do.it(x, g)
# total variation
arrows(2.5, min(x), 2.5, max(x), code=3, angle=30, lwd=2,
       length=.2, col="darkgrey")
# variation between means (BSS)
arrows(1.5, min(tapply(x, g, mean)), 1.5, max(tapply(x, g, mean)),
       code=3, angle=30, lwd=2, length=.2, col="darkgrey")
# group-specific total variation (WSS)
for (i in seq_along(levels(g)))
  arrows(i+.15, min(x[as.numeric(g)==i]),
         i+.15, max(x[as.numeric(g)==i]),
         code=3, angle=30, lwd=1.5, length=.1)


# Case 3: Simple linear regression
n <- 30
# x <- runif(n, 5, 20)
x <- sample(seq(5, 20), n, replace=TRUE)
y <- 2*x/10 + rnorm(n)

mod.lm <- lm(y ~ x)
new <- data.frame(x = seq(5, 20, by=.5))
cb <- predict(lm(y ~ x), new, interval="confidence")

plot(y ~ x, xlab="", ylab="", cex=.7, pch=19, col="darkgrey")
abline(mod.lm, col=4)
lines(new$x, cb[,"lwr"], lty=3, col=4)
lines(new$x, cb[,"upr"], lty=3, col=4)
# total variation
arrows((5+20)/2, min(y), (5+20)/2, max(y), code=3, angle=30, lwd=2,
              length=.2, col="darkgrey")
# x-specific variation
x0 <- as.numeric(names(table(x)[table(x)>1][1]))
arrows(x0, min(y[x==x0]), x0, max(y[x==x0]),
       code=3, angle=30, lwd=1.5, length=.1)
       
par(op)
dev.off()