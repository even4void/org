program trinome;

const EPS = 1E-10;

var
   a, b, c : real;
   delta   : real;
   x1, x2  : real;

function sign(D : real): integer;
begin
   if D > 0.0 then
      sign := +1
   else if D < 0.0 then
      sign := -1
   else
      sign := 0
end; {sign}

begin
   write('a = ');
   readln(a);
   write('b = ');
   readln(b);
   write('c = ');
   readln(c);
   delta := b*b - 4*a*c;
   if delta >= 0 then
   begin
      x1 := (-b - sign(b) * sqr(delta))/(2.0*a);
      x2 := c/(a*x1);
      if delta < EPS then
	 writeln('la racine double est : x = ', x1:8:4)
      else
	 writeln('les racines réelles sont x1 = ', x1:8:4, ' et x2 = ', x2:8:4)
   end
   else
      writeln('pas de racines réelles.')
end.

      