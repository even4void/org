program ackerman;

var
   a, b	: integer;

function func(x, y : integer) : integer;
begin
   if x = 0 then
      func := y+1
   else
      if y = 0 then
	 func := func(x-1, 1)
      else
	 func := func(x-1, func(x, y-1))
end; { func }

{-- bloc principal --}
begin
   repeat
      write('a = ');
      readln(a);
   until 0 <= a;
   repeat
      write('b = ');
      readln(b);
   until 0 <= b;
   writeln('F(',a,',',b,') = ', func(a, b))
end.
