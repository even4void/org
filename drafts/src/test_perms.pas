{------- calcul du rang lexicographique d'une permutation -------}

{$i perms.pas}

var
   s1, s2 : permutation;
   k	  : entier;

begin
   Entre_Permutation_Courte(s1);
   k := Rang_Permutation(s1);
   writeln;
   writeln('permutation n°: ', k:15:0);
   Nieme_Permutation(k, s1[0], s2);
   writeln;
   writeln(' VERIFICATION: calcul de la permutation ');
   Ecrit_Permutation(s2);
   writeln
end.