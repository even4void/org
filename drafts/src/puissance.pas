program puissance;
{ calcul de puissance par la m�thode classique et par
 la m�thode de la cha�ne chinoise -- cf. D. Knuth, The
 Art of Computer Programming, Addison Wesley, 2�me �d.,
 1981 }

var
   x : real;
   n : integer;

function puissance(x : real; n : integer): real;
{m�thode classique
 N.B.: traite les cas n<0, n=0 et n>0}
var
   i   : integer;

begin
   if n = 0 then
      puissance := 1.0
   else if n > 0 then
   begin
      puissance := x;
      for i:=2 to n do
	 puissance := puissance * x
   end
   else
   begin
      puissance := 1/x;
      for i:=2 to abs(n) do
	 puissance := puissance * 1/x
   end
end; { puissance }

function puissance2(x : real; n : integer): real;
{m�thode r�cursive
 N.B.: impl�ment�e pour les puissances positives}
var
   moitie : real;

begin
   if n = 0 then
      puissance2 := 1.0
   else
   begin
      moitie := puissance2(x, n div 2);
      puissance2 := sqr(moitie);
      if (n mod 2 = 1) then
	 puissance2 := puissance2 * x
   end;
end; { puissance2 }

{-- bloc principal --}
begin
   write('x = ? ');
   readln(x);
   write('n = ? ');
   readln(n);
   writeln('x^n = ', puissance(x, n):10:4, ' (m�thode classique)');
   writeln('x^n = ', puissance2(x, n):10:4, ' (m�thode cha�ne chinoise)');
   if n < 0 then
      writeln('N.B.: la m�thode de la cha�ne chinoise ne traite pas les puissances n�gatives (dans ce programme)')
end.


