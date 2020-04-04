# simulate some data
set.seed(88)
n <- 30
x <- runif(n)
y <- 1.2 + 0.8*x + rnorm(n)
g <- sample(letters[1:2], n, replace=TRUE)
my.df <- data.frame(x=x, y=y, grp=factor(g))

# show data structure
dput(my.df)

# save results from a linear as plain text in home directory
capture.output(summary(lm(y ~ x + grp, data=my.df)), file="~/my_df_lm.txt")

# save a PNG graphic in home directory
library(lattice)
png("~/my_df_xyplot.png")
xyplot(y ~ x | grp, data=my.df, type=c("p","smooth"))
dev.off()
