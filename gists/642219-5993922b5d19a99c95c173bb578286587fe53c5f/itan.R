itan <- function(x, keys=NULL, digits=3, no.resp=4) {
  # x is an n subjects by k items matrix
  # keys is a vector with the correct keys (A, B, C, D)
  stopifnot(ncol(x)>1)
  if (is.null(keys)) keys <- rep("A", ncol(x))
  require(ltm)
  raw.resp <- matrix(nr=ncol(x), nc=no.resp)
  colnames(raw.resp) <- LETTERS[1:no.resp]
  for (i in 1:ncol(x)) {
    tmp <- table(x[,i])
    raw.resp[i,names(tmp)] <- tmp
  }
  freq.resp <- raw.resp/apply(raw.resp, 1, sum, na.rm=T)
  na.resp <- apply(x, 2, function(x) sum(is.na(x)))
  correct.resp <- t(apply(x, 1, function(x) x==keys))
  total.score <- apply(correct.resp, 1, sum, na.rm=T)
  pbis <- apply(correct.resp, 2, 
	        function(x) biserial.cor(total.score, as.numeric(x),
                                         use="complete.obs"))
  nb.correct <- apply(correct.resp, 2, sum, na.rm=T)
  p.obs <- nb.correct/nrow(x)
  MC <- MI <- numeric(ncol(x))
  for (i in 1:ncol(x))
    MC[i] <- mean(total.score[correct.resp[,i]], na.rm=T)
  for (i in 1:ncol(x))
    MI[i] <- mean(total.score[!correct.resp[,i]], na.rm=T)
	
  out <- cbind(P=p.obs,R=round(pbis, digits),
               MC=round(MC, digits),MI=round(MI, digits),
               NC=nb.correct,OMIT=na.resp,raw.resp)	
  return(out)
}


dat <- replicate(10, sample(LETTERS[1:4], 100, rep=TRUE))
dat[3,2] <- dat[67,5] <- NA
itan(dat)
itan(dat, keys=sample(LETTERS[1:4],10,rep=T))

# check for imbalanced case (i.e. add one item with missing response category)
dat <- cbind(dat, sample(LETTERS[1:3], 100, rep=TRUE))
itan(dat)

# should work with dichotomous items too (but not the mixed case!)
dat <- replicate(5, sample(LETTERS[1:2], 100, rep=TRUE))
itan(dat, no.resp=2)