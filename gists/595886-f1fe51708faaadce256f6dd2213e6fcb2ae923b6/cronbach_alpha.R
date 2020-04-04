cronbach.alpha <- function(data, na.action="omit", signif.level=.05) {
  # computes Cronbach's Alpha
  # * Input *
  #    data         : a n*k matrix, where each column hold one item responses'
  #                   vector
  #    na.action    : if "omit", then handle missing value in cov/var
  #                   calculation [default]
  #    signif.level : type I error
  # * Output *
  #    a list with statistic and confidence interval
  # * Test *
  #    a <- matrix(c(1,2,1,
  #                  7,4,6,
  #                  3,1,1,
  #                  3,2,5,
  #                  7,4,4,
  #                  7,4,6,
  #                  5,3,4,
  #                  3,2,2,
  #                  2,1,1,
  #                  0,1,2),ncol=3,byrow=T)
  #    cronbach.alpha(a)
  # Exemple taken from Thompson, B. (2003). Score Reliability, Sage Publications
  #   (p. 72)
  # 11/12/06, chl (updated, 23/01/07) 
  n.var <- ncol(data)
  n.suj <- nrow(data)
  data.var <- var(data, na.rm=ifelse(na.action=="omit",T,F))
  alpha <- ( n.var/(n.var-1) ) * ( 1 - sum(apply(data,2,var,na.rm=ifelse(na.action=="omit",T,F))) / var(apply(data,1,sum),na.rm=ifelse(na.action=="omit",T,F)) )
  # compute confidence interval using "central" approach
  # Feldt, L.S. (1990). The sampling theory for the intraclass reliability
  #   coefficient. Applied Measurement in Education, 3, 361-367.
  # Feldt, L.S., Woodruff, D.J. & Salih, F.A. (1987). Statistical inference
  #   for coefficient alpha. Applied Psychological Measurement, 11, 93-103.
  df1 <- n.suj-1
  df2 <- (n.suj-1) * (n.var-1)
  ci.upper <- 1 - ((1-alpha)*qf(signif.level/2,df1,df2))
  ci.lower <- 1 - ((1-alpha)*qf(1-signif.level/2,df1,df2))
  ci <- c(ci.lower,ci.upper)
  names(ci) <- c(signif.level/2,1-signif.level/2)
  names(alpha) <- "Cronbach Alpha"
  out <- list(statistic=alpha,conf.int=ci,df=c(df1,df2))
  return(out)
}

cronbach.alpha.boot <- function(data, n.samples=1000) {
  # compute confidence interval for Cronbach alpha using library boot
  # and BCA correction
  # requires function cronbach.alpha()
  # * Input *
  #    data       : a n*k matrix, where each column hold one item responses'
  #                 vector
  #    na.samples : number of replicates' sample
  # * Output *
  #    a list with statistic and both non-adjusted confidence interval and
  #    BCA-corrected confidence interval
  # 23/01/07, chl
  if (!exists("cronbach.alpha"))
    stop("function 'cronbach.alpha()' cannot be found")
  alpha <- cronbach.alpha(data)[[1]] # by default, remove missing value
                                     # and use conf.level of 95 %
  require(boot)
  alpha.boot <- function(m,x) {cronbach.alpha(m[x,])[[1]]}
  tmp <- boot(data,alpha.boot,n.samples)
  tmp2 <- boot.ci(tmp,type="bca")
  ci.raw <- quantile(tmp$t,c(0.025,0.975))
  ci.adj <- c(tmp2$bca[1,4],tmp2$bca[1,5])
  names(ci.adj) <- c("2.5%","97.5%")
  out <- list(statistic=alpha,raw.conf.int=ci.raw,adj.conf.int=ci.adj)
  return(out)
}

cronbach.alpha.test <- function(data,x=.7) {
  # test the significance of an estimated Cronbach alpha against an
  # hypothesized population reliability parameter
  # * Input *
  #    data : a n*k matrix, where each column hold one item responses'
  #           vector
  #    x    : population alpha coefficient
  # * Output *
  #    a list with statistic and associated p-value
  # * Reference *
  #    Charter, R.A. & Feldt, L.S. (1996). Testing the equality of two alpha
  #      coefficients. Perceptual and Motor Skills, 82, 763-738.
  # 23/01/07, chl
  if (!exists("cronbach.alpha"))
    stop("function 'cronbach.alpha()' cannot be found")
  tmp <- cronbach.alpha(data) # by default, remove missing value
                              # and use conf.level of 95 %
  alpha <- as.numeric(tmp[[1]])
  f.obs <- (1-x) / (1-alpha)
  df1 <- tmp[[3]][1]
  df2 <- tmp[[3]][2]
  pval <- 1-pf(f.obs,df1,df2)
  names(f.obs) <- "F obs."
  out <- list(statistic=f.obs,df=c(df1,df2),p.value=pval)
  return(out)
}