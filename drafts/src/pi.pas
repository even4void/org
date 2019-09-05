program calcul_pi;
{ calcul de pi par la méthode de Monte Carlo }

var
   x, y	      : real;
   d2	      : real;
   pi	      : real;
   np, nc, nr : integer; (* nb points tirés, nb points ok, nb répétitions *)
   i, j	      : integer;

function aleat: real;
begin
   aleat := random(32766)/32767;
end; { aleat }

{-- bloc principal --}
begin
   write('Combien de points ? ');
   readln(np);
   write('Combien de répétitions ? ');
   readln(nr);
   randomize;
   for i:=1 to nr do
   begin
      pi := 0.0;
      nc := 0;
      for j:=1 to np do
      begin
	 x := aleat;
	 y := aleat;
	 d2 := (x-0.5)*(x-0.5) + (y-0.5)*(y-0.5);
	 if d2 <= 0.25 then
	    nc := nc + 1;
      end;
      pi := (4.0*nc)/np;
      writeln('estimation de pi avec ', np, ' points : ', pi);
   end;
end.
   
   