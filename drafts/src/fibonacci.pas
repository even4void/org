program fibonacci;

uses dos;

const
   MAX =  100;

var
   N	       : integer;
   resultat    : longint;
   hh,mm,ss,cc : word;

function fibo_rec(n:integer):longint; {Les résultats obtenus sont grands!}
begin
   if n=0 then fibo_rec:=1
   else if n=1 then fibo_rec:=1
   else
      fibo_rec:=fibo_rec(n-1)+fibo_rec(n-2)
end; { fibo_rec }

function fibo_iter(n:integer):longint;
var tab	: array[0..MAX] of longint;
   i	: integer;
begin	
   tab[0]:=1;
   tab[1]:=1;
   for i:=2 to n do
   begin
      tab[i]:=tab[i-1]+tab[i-2]
   end;
   fibo_iter:=tab[n];
end; { fibo_iter }

begin
   write('n ? ');
   readln(N);
   writeln('F(N) = ', fibo_iter(N));
   writeln('F(N) = ', fibo_rec(N) );
   { version chronométrée }
   (*t0 = gettime(hh,mm,ss,cc);
   tmp1 = fibo_iter(N);
   t1 = gettime(hh,mm,ss,cc);
   writeln('F(N) = ', tmp1, ' (temps = ', t1-t0, ')');
   tmp2 = fibo_rec(N);
   t2 = gettime(hh,mm,ss,cc);
   writeln('F(N) = ', tmp2, ' (temps = ', t2-t1, ')');*)
end.
   