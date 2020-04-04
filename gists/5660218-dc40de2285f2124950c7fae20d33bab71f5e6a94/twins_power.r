## ESTIMATE SAMPLE SIZE NEEDED to achieve a given power in univariate twin studies.
##
## Input:
##   pmz: sampling fraction MZ/DZ
##   tmz: intraclass correlation for MZ twins
##   tdz: intraclass correlation for DZ twins
##   alpha: level I risk level
##   beta: level II risk level (power = 1 - beta)
##
## Output:
##   N: total sample size
##   h2: genetic component
##   c2: common environmental component
##
## Exemple:
##
##   # h2 = 0.4 and c2 = 0.5 (Falconer's formula), 95% power, same number of DZs and MZs
##   twin.power(pmz=1/2, tmz=.9, tdz=.7, beta=.05)
##
## Reference: Visscher, PM. Twin Research (2004) 7(5):505.
## Time-stamp: <2013-05-23 15:19:10 chl>
twin.power <- function(pmz, tmz, tdz, alpha=0.05, beta=0.20) {
    tave <- pmz * tmz + (1-pmz) * tdz
    res <- (qnorm(1-alpha) + qnorm(1-beta))^2 / log((1-tave^2) / ((1-tmz^2)^pmz * (1-tdz^2)^(1-pmz)))
    h2 <- 2 * (tmz - tdz)
    c2 <- 2*tdz - tmz
    return(list(N=res, h2=h2, c2=c2))
}