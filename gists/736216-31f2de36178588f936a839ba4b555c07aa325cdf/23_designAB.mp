prologues := 2;

input geometriesyr16;

figure(-u,-u,6.5u,6u);

pair A,B,C,D,E,F,G,H,I,J,K,L,M,N;
picture depart;
numeric i,j,r,v;
r:=.5;
v:=40;

A=(0,0);
B=(4u,0);
C-B=r*((B-A) rotated v);
D-C=A-B;
E=(0,4u);
F-E=B-A;
G-F=C-B;
H-G=E-F;

I=.5*(H+F);
J=.5*(D+B);

depart=image(
trace 5coinbg--5coinbd--5coinhd;
trace G--H--E--F--G--C--B--F;
trace B--A--E;
trace A--D--H dashed evenly;
trace D--C dashed evenly;
marque_p:="creux";
pointe(A,B,C,D,E,F,G,H);
);

trace depart;

pair M;
path plana;
trace A--E--G--C withcolor blue withpen pencircle scaled 1bp;
trace A--C dashed evenly withcolor blue withpen pencircle scaled 1bp;
plana=A--E--G--C--cycle;
fillcolor:=.5white+.5blue;
transparence(plana);

pair N;
path planb;
trace A--E--G--C withcolor blue withpen pencircle scaled 1bp;
trace A--C dashed evenly withcolor blue withpen pencircle scaled 1bp;

trace H--F--B withcolor red withpen pencircle scaled 1bp;
trace B--D--H dashed evenly withcolor red withpen pencircle scaled 1bp;
planb=H--F--B--D--cycle;
fillcolor:=.5white+.5red;
transparence(planb);

fin;

end