# A toy example to illustrate @chi-square question
# http://stats.stackexchange.com/questions/604/discriminant-analysis

#
# The basic idea is to fit a given model and then reuse the fitted values
# as new values to predict to check if: (1) parameters estimates remain
# identical, and (2) rough measure of goodness-of-fit increase.
#

set.seed(101)
x <- rnorm(100)
y <- 1.5*x + rnorm(100)

### Regression approach ###
lm0 <- lm(y ~ x)
coef(lm0)
y.hat <- predict(lm0)

# Show a scatterplot of the observed and fitted values
plot(x,y)
points(x, y.hat, col="red")

lm1 <- lm(y.hat ~ x)
coef(lm1)
# Testing near-equality
all.equal(coef(lm0), coef(lm1))
# Check that R^2≃1
summary(lm1)

### DA approach ###
library(MASS)
y.bin <- ifelse(y>median(y), 1, 0) # approx. half-split
table(y.bin)

( lda0 <- lda(y.bin ~ x) )
y.bin.hat <- predict(lda0)$class
( lda1 <- lda(y.bin.hat ~ x) )

# Check for agreement between observed and predicted class membership
sum(diag(table(predict(lda1)$class, y.bin)))

