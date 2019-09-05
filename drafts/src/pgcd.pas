program pgcd;

type entier = real;

var
   x : entier;
   y : entier;
   
function ent(x: entier): entier;
var s : entier;

begin
   s := int(x);
   if (x < 0) and (s <> x) then
      s := s-1;
   ent := s
end; { ent }

function div_e(x, y : entier) : entier;
var q : entier;

begin
   q := x/y;
   div_e := ent(q)
end; { div_e }

function mod_e(x, y : entier) : entier;
begin
   mod_e := x - div_e(x, y)*y
end; { mod_e }

procedure write_e(x : entier);
var long : integer;

begin
   if x <> 0 then
   begin
      long := trunc(ln(abs(x))/ln(10))+1;
      write(x:long:0)
   end
   else
      write(0:1)
end; { write_e }

function pgcd(x, y: entier) : entier;
var r : entier;

begin
   x := abs(x);
   y := abs(y);
   if x < y then
   begin
      r := x;
      x := y;
      y := r
   end;
   while y <> 0 do
   begin
      r := mod_e(x, y);
      x := y;
      y := r
   end;
   pgcd := x
end; { pgcd }

{-- bloc principal --}
begin
   write('x = ? ');
   readln(x);
   write('y = ? ');
   readln(y);
   write('pgcd = ');
   write_e(pgcd(x, y));
   writeln
end.
   