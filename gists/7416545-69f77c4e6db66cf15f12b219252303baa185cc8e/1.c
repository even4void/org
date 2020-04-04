// Time-stamp: <2013-11-11 17:58:52 chl>

// gcc -Wall 1.c -lgsl -lgslcblas -lm

#include <stdio.h>
#include <gsl/gsl_cdf.h>

int main(void) {

  double p;
  double x = 2.0;
  int nu = 6;

  p = gsl_cdf_tdist_P(x, nu);
  printf ("prob(x < %5.2f) = %10.8f\n", x, p);

  return 0;
}