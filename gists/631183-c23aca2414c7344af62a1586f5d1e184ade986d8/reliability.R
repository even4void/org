# Some illustrations of reliability analysis.
# Time-stamp: <2010-10-17 21:35:51 chl>
x <- c(12,8,22,10,10,6,8,4,14,6,2,22,12,7,24,14,8,4,5,6,14,5,5,16)
GHQ <- data.frame(subject=gl(12,1,24), time=gl(2,12), score=x)

# ----------------------------------------------------
# Computing reliability (Rx) by hand from ANOVA tables 
# ----------------------------------------------------
# one-way ANOVA (assuming no time trends)
summary(aov(score ~ subject, data=GHQ))
# Rx is
(73.758-3.667)/(73.758+3.667)                      ## 0.905

# two-way ANOVA
summary(aov(score ~ subject + time, data=GHQ))
# Assuming raters are sampled from a larger pool of raters, Rx is
12*(73.758-3.939)/(12*73.758+2*0.667+10*3.939)     ## 0.905
# If a single rater is to be used for all subjects, Rx becomes
(73.758-3.939)/(73.758+3.939)                      ## 0.899

# ------------------------------------
# Computing ICC with the `psy` package
# ------------------------------------
library(psy)
with(GHQ, icc(cbind(score[time=="1"],score[time=="2"])))

# 'consistency' is the same as Rx computed from two-way ANVOA ## 0.899
# 'agreement' is the same as Rx computed from one-way ANOVA   ## 0.905

# ----------------------
# Computing ICC from LMM
# ----------------------
library(lme4)

# a random-intercept model (equivalent to the one-way ANOVA)
summary(lmer(score ~ 1 + (1|subject), data=GHQ)) 
# ICC is computed as
5.9199^2/(5.9199^2+1.9149^2)                       ## 0.905

# a mixed-effects model (equivalent to the two-way ANOVA)
summary(lmer(score ~ time + (1|subject), data=GHQ)) 
# ICC is computed as
5.9084^2/(5.9084^2+1.9848^2)                       ## 0.899

detach(package:lme4)

# the same models as above with the `nlme` package
library(nlme)

intervals(lme(score ~ 1, random= ~1|subject, data=GHQ))
# ICC is computed as
5.919918^2/(5.919918^2+1.914855^2)                 ## 0.905

intervals(lme(score ~ time, random= ~1|subject, data=GHQ))
# ICC is computed as
5.908387^2/(5.908387^2+1.984792^2)                 ## 0.899