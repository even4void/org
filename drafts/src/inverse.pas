program inverse;

const
   NMAX = 100;
   
type
   Vecteur = array[1..NMAX] of real;
   Matrice = array[1..NMAX,1..NMAX] of real;

{------------------------------------------------}
function norme(X : Vecteur; dim : integer) :real;
var
   i : integer;
   s : real;
   
begin
   s := 0.0;
   for i:=1 to dim do
      s := s+sqr(X[i]);
   norme := sqrt(s);
end; { norme }

{------------------------------------------------}
procedure produit_mat_vect(A : Matrice; X : Vecteur; var Y : Vecteur; m, n : integer);
begin

end; { produit_mat_vect }

{------------------------------------------------}
procedure inverse_greville(nl : integer; A : Matrice; var B : Matrice);
var
   r	       : real;
   i, j, k, nc : integer;
   V, D, C, X  : Vecteur;

begin
   nc := nl;
   for i:=1 to nl do
      V[i] := A[i,1];
   r := norme(V, nl);
   if r > EPS then begin
      for i:=1 to nl do
	 B[1,i] := A[i,1]/sqr(r)
   end
   else begin
      for i:=1 to nl do
         B[1,i] := 0;
   end;
   for k:=2 to nc do
   begin
      for i:=1 to nl do
	 V[i] := A[i,k];
      produit_mat_vect(B, V, D, k-1, nl);
      produit_mat_vect(A, D, X, nl, k-1);
      for i:=1 to nl do
	 C[i] := V[i]-X[i];
      r := norme(C, nl);
      if r > EPS then begin
	 for i:=1 to nl do
	    V[i] := C[i]/sqr(r);
      end
      else begin
	 r := 1 + norme(D, k-1);
	 for i:=1 to nl do
	    V[i] := X[i]/r;
      end;
      for i:=1 to nl do begin
	for j:=1 to k-1 do
	   B[j,i] := B[j,i]-D[j]*V[i];
	 B[k] := V;
      end;
   end;
end;
	 
      
	    
   
      