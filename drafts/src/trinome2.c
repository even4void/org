/* trinome2.c
   un programme simple de calcul des racines d'un trinôme

   gcc -o trinome2 -lm trinome2.c

   Time-stamp: <2006-03-28 22:36:10 chl> */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

static double EPS = 1E-10;

int main(void)
{
  float a, b, c = 0.0;
  float delta = 0.0;
  float r1, r2, i1, i2 = 0.0;

  printf("a = ");
  scanf("%g",&a);
  printf("b = ");
  scanf("%g",&b);
  printf("c = ");
  scanf("%g",&c);

  delta = b*b - 4*a*c;
  if (delta >= 0) {
    if (b > 0)
      r1 = -(b+sqrt(delta))/(2*a);
    else
      r1 = (-b+sqrt(delta))/(2*a);
    r2 = abs(r1) < EPS ? 0 : c/(a*r1);
    i1 = i2 = 0;
  }
  else {
    r1 = r2 = -b/(2*a);
    i1 = sqrt(-delta)/(2*a);
    i2 = -i1;
  }

  //printf("delta = %g\n", delta);
  printf("\nx1 = %g + %g*i\n", r1, i1);
  printf("x2 = %g + %g*i\n", r2, i2);

  return EXIT_SUCCESS;
}

