import graph;
import patterns;

size(300,200,IgnoreAspect);

real xmin=-4,xmax=4;
real ymin=0,ymax=1;
real PI=3.141593;
real sd=.6;
int a=-1, b=1;

// Definition of fonctions f and g :
real f(real x) {return 1/sqrt(2*PI*sd)*exp(-(x+.5)^2/(2*sd));}
real g(real x) {return 1/sqrt(2*PI*sd)*exp(-(x-1)^2/(2*sd));}

// Trace the curves :
path Cf=graph(f,xmin,xmax,n=400);
path Cg=graph(g,xmin,xmax,n=400);
draw(Cf,linewidth(1bp));
draw(Cg,linewidth(1bp));
xlimits(xmin,xmax,Crop);
ylimits(ymin,ymax,Crop);

draw((0,0)--(0,.8),linewidth(2bp));

label("\small criterion response",(0,.85));
arrow("\footnotesize Miss",(-.3,.1),NW);
arrow("\footnotesize Hit",(1.45,.4),NE);

xaxis("Internal Response (a.u.)",Bottom);
yaxis("Probability",Left);

path q0=(0,0)--(0,1);
path q1=(xmin,0)--(xmin,1);
path q2=(xmin,0)--(xmax,0);
path q3=(xmax,0)--(xmax,1);
add("hachure",hatch(8,NW));
add("hachure2",hatch(4,NE));

fill(buildcycle(q0,graph(g,xmin,xmax),q1,q2),pattern("hachure")); 
fill(buildcycle(q0,graph(g,xmin,xmax),q3,q2),pattern("hachure2")); 
