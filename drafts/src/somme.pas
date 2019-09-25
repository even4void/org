program somme;
{ce programme illustre le calcul d'une somme sans faux d�passements.
 Il s'inspire de :
 [1] Boug�, L., Kenyon, C., Muller, J.-M., Robert, Y. (1993). Algorithmique - Exercices corrig�s, Oral du cocnours d'entr�e � l'Ecole Normale Sup�rieure de Lyon. (Ellipses)
}

const
   N	= 3;
   
type tab =  array[1..N] of integer;

var
   A		  : tab;
   total1, total2 : integer;

function somme(A : tab): integer;
{calcul de somme par la m�thode it�rative classique}
var
   i, accu : integer;

begin
   accu := A[1];
   for i:=2 to N do
      accu := accu + A[i];
   somme := accu
end;
   
function somme2(A : tab): integer;
{calcul de somme avec correction pour les faux d�passements}
var
   pos, neg: tab;
   npos, nneg, accu, i: integer;

begin
   npos := 0;
   nneg := 0;
   {-- �tape 1 : tri en termes positifs et n�gatifs --}
   for i:=1 to N do
      if A[i] >= 0 then
      begin
	 npos := npos + 1;
	 pos[npos] := A[i];
      end
      else
      begin
	 nneg := nneg + 1;
	 neg[nneg] := A[i];
      end;
   {-- �tape 2 : calcul de la somme --}
   accu := 0;
   while (npos > 0) and (nneg > 0) do
   begin
      if accu >= 0 then
      begin
	 accu := accu + neg[nneg];
	 nneg := nneg - 1;
      end
      else
      begin
	 accu := accu + pos[npos];
	 npos := npos - 1;
      end
   end;
   {-- �tape 3 : ajout des derniers termes de m�me signe --}
   if npos > 0 then
      for i:=1 to npos do
      begin
	 accu := accu + pos[i];
      end
      else
	 for i:=1 to nneg do
	    accu := accu + neg[i];
   somme2 := accu
end;

{-- bloc principal --}
begin
   {le plus grand entier repr�sentable �tant 32767, une somme classique
    (i.e. accumulation it�rative) donnerait un r�sultat erron� pour les
    valeurs suivantes : 32000 + 768 -1}
   A[1] := 32000;
   A[2] := 768;
   A[3] := -1;
   total1 := somme(A);
   total2 := somme2(A);
   writeln('la somme classique est : ', total1:10);
   writeln('la somme contr�l�e est : ', total2:10)
end.
   