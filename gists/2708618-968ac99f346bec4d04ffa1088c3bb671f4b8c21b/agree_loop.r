# Compute % agreement between any two columns in a data.frame
dfrm <- data.frame(replicate(18, sample(letters[1:3], 30, replace=TRUE)))

agree <- function(df, i, j) {
  tab <- table(df[,c(i,j)])   
  sum(diag(tab))/sum(tab)
}

# Solution 1
vagree <- Vectorize(agree, vectorize.args=list("i","j"))
res <- outer(1:18, 1:18, vagree, df=dfrm)

# Solution 2
cb <- combn(18, 2)
res <- numeric(ncol(cb))
for (i in 1:ncol(cb))
  res[i] <- agree(dfrm, cb[1,i], cb[2,i])
res.df <- data.frame(res, t(cb))
xtabs(res ~ X1 + X2, res.df)
