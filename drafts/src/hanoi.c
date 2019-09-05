/* Les tours de Hanoï                     */
/* Time-stamp: <2006-02-14 22:28:31 chl>  */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void hanoi(int num, char *p1, char *p2, char *p3)
{
  if (num == 1)
    printf("De %s à %s\n", p1, p3);
  else
    {
      hanoi(num-1, p1, p3, p2);
      printf("De %s à %s\n", p1, p3);
      hanoi(num-1, p2, p1, p3);
    }
}

int main(int argc, char* argv[])
{
  int nb, tmp;
  char number[100];

#define USAGE "usage : %s n\n\tn : nombre d'anneaux\n\tLes piquets sont numérotés, de gauche à droite, A, B et C\n"

  if ((argc > 1) && (!strcasecmp("-h",argv[1]))){
    fprintf(stderr,USAGE,argv[0]);
    return -1;
  }
  //printf("How many ring/s: ");
  //scanf("%c", &number);

  nb = atoi(argv[1]);

  if (nb <= 0)
    {
      printf("Il doit y avoir au minimum un anneau !\n");
      exit(1);
    }
  else
    {
      tmp = pow(2, nb) - 1;
      printf("Au total, il y a eu %d déplacement(s).\n", tmp);
      hanoi(nb, "A", "B", "C");
    }

  return EXIT_SUCCESS;
}
