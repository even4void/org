#include <stdio.h>
#include <stdlib.h>
#include <math.h>

float EPS = 10E-9;

int main(void)
{
   float a, b = 0.0;
   printf("valeurs de a = \n");
   scanf("%g",&a);
   printf("valeurs de b = \n");
   scanf("%g",&b);
   if (fabs(a-b) <= EPS) printf("test no fabs: ok...\n");
   if (fabs(a-b) <= EPS*fabs(a)) printf("test fabs: ok...\n");
   
   return EXIT_SUCCESS;
}
