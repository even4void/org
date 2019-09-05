#include <math.h>
#define NMAX 5
#define N2MAX 6

int sl_gauss_aff(double a[NMAX][NMAX],double b[NMAX],int n);

main()
{
 double a[NMAX][NMAX],b[NMAX];
 int i,j,n,err;
 n=4;
 printf("Méthode de Gauss\n");
 a[1][1]=8;a[1][2]=-4;a[1][3]=3;a[1][4]=7;b[1]=12;
 a[2][1]=4;a[2][2]=2;a[2][3]=-6;a[2][4]=4;b[2]=1;
 a[3][1]=-16;a[3][2]=6;a[3][3]=-2;a[3][4]=-15;b[3]=-19;
 a[4][1]=6;a[4][2]=10;a[4][3]=-15;a[4][4]=10;b[4]=1;
 printf("                          A(1)                                 b(1)\n");
 for(i=1;i<=n;i++)
 {
  for(j=1;j<=n;j++)
  printf("%12.5e  ",a[i][j]);
  printf("I  %12.5e  \n",b[i]);
 }
 err=sl_gauss_aff(a,b,n);
 if(err==1)
 {
  printf("Solution:\n");
  for(i=1;i<=n;i++)
  printf("x%d =%23.15e  \n",i,b[i]);
 }
 else printf("Erreur, matrice singulière\n");
}

int sl_gauss_aff(double a[NMAX][NMAX],double b[NMAX],int n)
{
 int i,j,k,l,err;
 double pivot,coef,s;
 double t[NMAX][N2MAX];
 for(i=1;i<=n;i++)
 {
  for(j=1;j<=n;j++)
  t[i][j]=a[i][j];
  t[i][n+1]=b[i];
 }
 err=1;
 k=1;
 while (err==1 && k<n)
 {
  pivot=fabs(t[k][k]);
  l=k;
  while(pivot==0 && l<n)
  {
   l++;
   pivot=fabs(t[l][k]);
  }
  if(pivot!=0)
  {
   if(l!=k)
   for(j=k;j<=n+1;j++)
   {
    pivot=t[k][j];
    t[k][j]=t[l][j];
    t[l][j]=pivot;
   }
   pivot=t[k][k];
   for(i=k+1;i<=n;i++)
   {
    coef=t[i][k]/pivot;
    for(j=1;j<=n+1;j++)
    t[i][j] -= coef*t[k][j];
   }
   printf("                          A(%d)                                 b(%d)\n",k+1,k+1);
   for(i=1;i<=n;i++)
   {
    for(j=1;j<=n;j++)
    printf("%12.5e  ",t[i][j]);
    printf("I  %12.5e  \n",t[i][n+1]);
   }
  }
  else err=0;
  k++;
 }
 if(t[n][n]==0) err=0;
 if(err==1)
 {
  b[n]=t[n][n+1]/t[n][n];
  for(i=n-1;i>=1;i--)
  {
   s=t[i][n+1];
   for(j=i+1;j<=n;j++)
   s-=t[i][j]*b[j];
   b[i]=s/t[i][i];
  }
 }
 return(err);
}
