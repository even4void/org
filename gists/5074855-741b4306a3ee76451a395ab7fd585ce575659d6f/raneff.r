library(lme4)
data(sleepstudy)

## Fit individual regression lines for each subject
dfrm <- coef(lmList(Reaction ~ Days | Subject, sleepstudy))

## Estimate parameters of a random intercept and random intercept and slope model
m1 <- lmer(Reaction ~ Days + (1 | Subject), data=sleepstudy)
m2 <- lmer(Reaction ~ Days + (Days | Subject), data=sleepstudy)

## Put all estimates (intercept + slope for each model) into the same data.frame
dfrm <- cbind.data.frame(dfrm,
                         as.data.frame(coef(m1)[["Subject"]]),
                         as.data.frame(coef(m2)[["Subject"]]))

## Kernel density estimates for the distribution of individual intercepts
intcpt.dens <- list()
idx <- seq(1, ncol(dfrm), by=2)
for (i in seq_along(idx))
  intcpt.dens[[i]] <- density(as.numeric(dfrm[,idx[i]]), adj=1.4)
len <- length(intcpt.dens[[1]]$x)

## Show all
cols <- c("grey30", "#D95F02", "#669999")
xyplot(Reaction ~ Days, data=sleepstudy,
       xlim=c(0, 8), ylim=c(150, 450), ylab="Fitted reaction time",
       scales=list(x=list(at=seq(0, 8, by=1))),
       key=list(corner=c(0,1), text=list(c("within-group",
                                 "random intercept",
                                 "random intercept and slope"),
                                 col=cols, cex=0.8)),
       panel=function(...) {
         apply(dfrm[,1:2], 1, panel.abline, col=cols[1], alpha=.5, lwd=1.2)
         apply(dfrm[,3:4], 1, panel.abline, col=cols[2], alpha=.5, lwd=1.2)
         for (i in seq_along(idx))
         panel.lines(x=c(intcpt.dens[[i]]$y*100, rep(0, len)),
                     y=c(intcpt.dens[[i]]$x, rev(intcpt.dens[[i]]$x)), col=cols[i], lwd=1.8)
       })