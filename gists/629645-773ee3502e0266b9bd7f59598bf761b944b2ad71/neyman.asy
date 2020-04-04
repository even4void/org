import graph;
import patterns;

size(300,200,IgnoreAspect);

real xmin=-4,xmax=4;
real ymin=0,ymax=1;
real PI=3.141593;
real sd=.6;
real a=1, b=-.5;

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

draw((a,0)--(a,g(a)),dashed);
draw((b,0)--(b,f(b)),dashed);
draw((0.4,0)--(0.4,f(0.4)),linewidth(2bp));

label("\small $H_1$",(a,.6));
label("\small $(\mu_0+\delta;\sigma^2)$",(a,.55));
label("\small $H_0$",(b,.6));
label("\small $(\mu_0;\sigma^2)$",(b,.55));
arrow(minipage("\centering\footnotesize $\Pr(-\mid H_0\, \textrm{true})$\\ \bf Correct decision (TN)"),(-1.05,.35),NW);
arrow(minipage("\centering\footnotesize $\Pr(+\mid H_0\, \textrm{true})$\\ \bf Type I error risk ($\alpha$)"),(0.75,.1),NE);

//xaxis("Internal Response (a.u.)",Bottom);
//yaxis("Probability",Left);

path q0=(0.4,0)--(0.25,1);
path q1=(xmin,0)--(xmin,1);
path q2=(xmin,0)--(xmax,0);
path q3=(xmax,0)--(xmax,1);
add("hachure",hatch(8,NW));
add("hachure2",hatch(4,NE));

fill(buildcycle(q1,graph(f,xmin,xmax),q0,q2),pattern("hachure")); 
fill(buildcycle(q0,graph(f,xmin,xmax),q3,q2),pattern("hachure2")); 
