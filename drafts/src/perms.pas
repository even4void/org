(* perms.pas                                             *)
(* Moisan & Debeaumarché, 1989 (Ed. Ellipses), pp. 37-39 *)
(* Time-stamp: <2006-04-06 12:08:50 chl>                 *)

const
   LongMaxPerm = 1000;
   IndiceMax   = 13;

type
   entier	  = real;
   CoefFactoriels = array[0..IndiceMax] of integer;
   permutation	  = array[0..LongMaxPerm] of integer;

procedure Decomposition_Factorielle(n : entier; var l : CoefFactoriels);
var
   i : integer;
   m : entier;

begin
   for i:=1 to l[0] do
   begin
      m := int(n/(i+1));
      l[i] := round(n-(i+1)*m);
      n := m;
   end
end; { Decomposition_Factorielle }

function Recomposition_Factorielle(l : CoefFactoriels) : entier;
var
   i	  : integer;
   valeur : entier;

begin
   valeur := 0;
   for i:=l[0] downto 1 do
      valeur := (valeur+l[i])*i;
   Recomposition_Factorielle := valeur;
end; { Recomposition_Factorielle }

function Vraie_Permutation(s : permutation) : boolean;
var
   i, j	   : integer;
   bon	   : boolean;
   Deja_Vu : array[1..LongMaxPerm] of boolean;

begin
   if (s[0] > LongMaxPerm) or (s[0] < 1) then
      Vraie_Permutation := false
   else begin
      for i:=1 to s[0] do
	 Deja_Vu[i] := false;
      i := 0;
      bon := true;
      while (i < s[0]) and bon do
      begin
	 i := i+1;
	 j := s[i];
	 bon := (j >= 1) and (j <= s[0]) and (not(Deja_Vu[j]));
	 Deja_Vu[j] := true;
      end;
      Vraie_Permutation := bon;
   end
end; { Vraie_Permutation }

function Vraie_Permutation_Courte(s : permutation) : boolean;
begin
   Vraie_Permutation_Courte := (Vraie_Permutation(s)) and (s[0] <= IndiceMax-1)
end; { Vraie_Permutation_Courte }

procedure Entre_Permutation(var s : permutation);
var
   i : integer;

begin
   repeat
      write('entrer le nombre d''éléments ');
      readln(s[0]);
      writeln('entrer les éléments l''un après l''autre dans l''ordre voulu');
      writeln;
      for i:=1 to s[0] do
      begin
	 write('  ');
	 read(s[i]);
      end;
   until Vraie_Permutation(s)
end; { Entre_Permutation }

procedure Permutation_Aleatoire(var s : permutation; p : integer);
var
   u	   : permutation;
   i, j, k : integer;

begin
   randomize;
   s[0] := p;
   for i:=1 to p do
      u[i] := i;
   for i:=1 to p-1 do
   begin
      j := random(p-i+1)+1;
      s[i] := u[j];
      for k:=j to p-i do
	 u[k] := u[k+1];
   end;
   s[p] := u[1]
end; { Permutation_Aleatoire }

procedure Entre_Permutation_Courte(var s : permutation);
var
   i : integer;

begin
   repeat
      write('entrer le nombre d''éléments ');
      readln(s[0]);
      writeln('entrer les éléments d''un après l''autre dans l''ordre voulu');
      writeln;
      for i:=1 to s[0] do
      begin
	 write('  ');
	 read(s[i]);
      end;
   until Vraie_Permutation(s)
end; { Entre_Permutation_Courte }

procedure Ecrit_Permutation(s : permutation);
var
   i : integer;

begin
   for i:=1 to s[0] do
      write(s[i]:4);
   writeln
end; { Ecrit_Permutation }

procedure Nieme_Permutation(n : entier; p : integer; var s : permutation);
var
   i, j, k : integer;
   u	   : permutation;
   l	   : CoefFactoriels;

begin
   s[0] := p;
   l[0] := p-1;
   Decomposition_Factorielle(n-1, l);
   for i:=1 to p do
      u[i] := i;
   for i:=1 to p-1 do
   begin
      j := l[p-i]+1;
      s[i] := u[j];
      for k:=j to p-i do
	 u[k] := u[k+1];
   end;
   s[p] := u[1];
end; { Nieme_Permutation }

function Rang_Permutation(s : permutation) : entier;
var
   u	      : permutation;
   l	      : CoefFactoriels;
   i, j, k, p : integer;

begin
   p := s[0];
   l[0] := p-1;
   u[1] := s[p];
   for i:=p-1 downto 1 do
   begin
      j := 1;
      while (j <= p-i) and (u[j] < s[i]) do
	 j := j+1;
      for k:=p-i+1 downto j+1 do
	 u[k] := u[k-1];
      u[j] := s[i];
      l[p-i] := j-1;
   end;
   Rang_Permutation := Recomposition_Factorielle(l)+1
end; { Rang_Permutation }