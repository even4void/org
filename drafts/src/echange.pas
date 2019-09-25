program echange;

var
   x, y	: integer;
   u, v	: real;

procedure echange;
begin

end; { echange }


begin
   write('x = ');
   readln(x);
   write('y = ');
   readln(y);
   x := x + y;
   y := x - y;
   x := x - y;
   writeln('après échange, x = ', x, ', y = ', y)
end.