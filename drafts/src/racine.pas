program suite1;

const Precision = 1E-9;

var
   n	: integer;
   u, v	: real;

begin
   n := 1;
   write('u0 = ');
   readln(u);
   repeat
      v := u;
      u := (u+2)/(u+1);
      writeln('u', n, ' = ', u:16:15);
      n := n+1
   until abs(u-v) < Precision
end.