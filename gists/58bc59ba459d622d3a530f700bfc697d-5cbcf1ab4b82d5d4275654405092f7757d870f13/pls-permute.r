## Time-stamp: <2016-05-27 13:18:56 chl>

##
## General purpose script to illustrate the estimation of path coefficients
## in a Partial Least Squares Path Model (PLS-PM) and multi-group comparison
## using resampling (permutation test).
##

library(plspm)
library(simsem)

set.seed(101)


k <- 1000      ## no. resamples
n <- 200       ## sample size
p <- 6         ## no. variables per block
s <- 3         ## no. blocks (aka factors)
delta <- .03   ## group difference

loading <- matrix(0, p*s, s)
start <- 1
end <- p
for (j in 1:s) {
  loading[start:end, j] <- NA
  start <- start+p
  end <- end+p
}

## pattern matrix, latent correlations and errors
LY <- bind(loading, 0.7)
RPS <- binds(diag(s), 0)
RTE <- binds(diag(p*s))

## inner model
##
##     F1
##     / \      
##    /   \
##   /     \
##  v       v
##  F2 --> F3
##
path <- matrix(0, 3, 3)
path[2, 1] <- NA
path[3, 1] <- NA
path[3, 2] <- NA
BE.1 <- bind(path, 0.5)
BE.2 <- bind(path, 0.5-delta)

## base model
M0 <- model(LY = LY, BE = list(BE.1, BE.2), RPS = RPS, RTE = RTE, ngroups = 2, modelType = "SEM")

## generate dataset
dat <- generate(M0, n = n)

## path matrix
pm <- matrix(0, s, s)
pm[lower.tri(pm)] <- 1
colnames(pm) <- rownames(pm) <- paste0("F", 1:s)

## outer model
blocks <- as.list(data.frame(apply(loading, 2, function(x) which(is.na(x)))))

## reflexive model
smod <- rep("A", s)

## PLS-PM model estimates
r <- plspm(dat, pm, blocks, modes = smod)

## parameters estimated on the full sample
## F1 -> F2, F1 -> F3, F2 -> F3
param <- r$path_coefs[r$path_coefs > 0]

## group-specific estimates
r1 <- plspm(subset(dat, group == 1), pm, blocks, modes = smod)
r2 <- plspm(subset(dat, group == 2), pm, blocks, modes = smod)

param1 <- r1$path_coefs[r1$path_coefs > 0]
param2 <- r2$path_coefs[r2$path_coefs > 0]

## geometric mean
f <- function(x1, x2) prod(x1)^(1/length(x1)) - prod(x2)^(1/length(x2))
## total effect = F1 -> F3 + (F1 -> F2 x F2 -> F3)
g <- function(x1, x2) (x1[1]*x2[3] + x1[2]) - (x2[1]*x2[3] + x2[2] )

rr1 <- rr2 <- numeric(k)
dd <- dat

pb <- txtProgressBar(min = 0, max = k, style = 3)
for (i in 1:k) {
  dd$group <- sample(dat$group)
  m1 <- plspm(subset(dd, group == 1), pm, blocks, modes = smod)
  m2 <- plspm(subset(dd, group == 2), pm, blocks, modes = smod)
  rr1[i] <- f(m1$path_coefs[m1$path_coefs > 0], m2$path_coefs[m2$path_coefs > 0])
  rr2[i] <- g(m1$path_coefs[m1$path_coefs > 0], m2$path_coefs[m2$path_coefs > 0])
  setTxtProgressBar(pb, i)
}
close(pb)

obs1 <- f(param1, param2)
obs2 <- g(param1, param2)

pl <- function(r, o, ...) {
  hist(r, col = "cornflowerblue", border = "white", main = "", las = 1, ylab = "", ...)
  abline(v = o, col = "orange", lwd = 2)
  mtext("1000 replicates", side = 3, line = -2, at = min(r), adj = 0, col = "cornflowerblue")
  mtext(paste0("p=", sum(r >= o)/k), side = 3, line = -2, at = max(r), col = "orange")
  mtext("F1-F2, F1-F3, F2-F3", side = 3, line = -4, at = min(r), adj = 0, col = "darkgrey", cex = .7)
  mtext(paste(round(param1, 3), collapse = ", "), side = 3, line = -5, at = min(r), adj = 0, col = "darkgrey", cex = .7)
  mtext(paste(round(param2, 3), collapse = ", "), side = 3, line = -6, at = min(r), adj = 0, col = "lightgrey", cex = .7)
  box()
}


opar <- par(mfrow = c(2,1))
## geometric mean
pl(rr1, obs1, xlab = "Difference (geometric mean of path coefficients)")
## total effect
pl(rr2, obs2, xlab = "Difference (indirect + direct effect F1-F3)")
par(opar)