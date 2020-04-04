# Time-stamp: <2010-08-10 11:51:15 chl>

#
# Illustration of LASSO penalization in multiple regression.
#
# The exemple is largely inspired from Harezlak, Tchetgen
# and Li, Variable selection in regression -- Estimation,
# Prediction, Sparsity, Inference,
# in _High-Dimensional Data Analysis in Cancer Research_
# (Ed. X. Li and R. Xu), Chapter 2, pp. 13--33.
#

library(MASS)
library(lars)
library(lasso2)

n <- 50         # No. subjects
p <- 100        # No. predictors
s <- 20         # No. predictors in the active set
rho <- 0.3      # introduce some colinearity among predictors
mu <- rep(0,p)  # all predictors are centred
noise <- rnorm(n, 0, 2)
# compound symmetry Sigma matrix (whole set of predictors)
# Sigma <- rho*matrix(rep(1, p^2), p) + diag(rep(1-rho, p))

# restrict colinearity to active set, e.g.
#
#           s   
#         +---+---+
#         | Q | 0 |
#         +---+---+
#     p-s | 0 | P |
#         +---+---+
Q <- rho*matrix(rep(1,s^2),s)+diag(rep(1-rho,s))
P <- 0*matrix(rep(1,(p-s)^2),p-s)+diag(rep(1,p-s))
Sigma <- rbind(cbind(Q,matrix(0,nr=s,nc=p-s)),
               cbind(matrix(0,nr=p-s,nc=s),P))

X <- mvrnorm(n, mu, Sigma)
beta <- numeric(p)
beta[1:s] <- runif(s, 0, 3)
beta[(s+1):p] <- 0
Y <- X%*%beta + noise

# graphically check the structure of the <Y,X> block
if (require(lattice)) {
  my.labs <- c("y",paste("x",seq(5,p+1,by=5),sep=""))
  levelplot(cor(cbind(Y,X)), xlab="", ylab="",
            scales=list(x=list(at=seq(1,p+1,by=5), labels=my.labs),
              y=list(at=seq(1,p+1,by=5), labels=my.labs)))
}

# mass univariate tests to screen interesting predictors
beta.fit <- matrix(nr=p, nc=2, dimnames=list(NULL,c("est.","se")))
for (i in 1:p)
  beta.fit[i,] <- summary(lm(Y~X[,i]-1))$coefficients[c(1,2)]

# LARS solution
xy.lars <- lars(X, Y, intercept=FALSE, use.Gram=FALSE)
plot(xy.lars, breaks=FALSE)
# use 10-fold CV to find optimal L1 parameter
xy.lars.cv <- cv.lars(X, Y, trace=TRUE)
xy.lars.frc <- lars.cv$fraction[xy.lars.cv$cv.error==min(xy.lars.cv$cv.error)]
xy.lars.coef <- coef(xy.lars, mode="fraction", s=lars.frc)

# plot LM against LASSO estimates
plot(beta.fit[,1], xy.lars.coef, cex=beta.fit[,2]/3,
     xlab=expression(paste("LM ",hat(beta))), ylab="LASSO coefficient",
     col=ifelse(abs(beta.fit[,1]/beta.fit[,2])>2, "red", "black"))
text(beta.fit[1:s], xy.lars.coef[1:s], paste("x", 1:s, sep=""), cex=.5, pos=3)
abline(v=0, h=0, col="gray")
legend("topleft", c("p<.05 (LM)"), pch=1, col="red", bty="n", cex=.6)