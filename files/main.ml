(* TESTS DES FONCTIONS DE PROJET.ML *)
#use "skeltest.ml";;

(*Section 1*)

(* associate *)

let v1 = (Vertex.indice (V.label obj1_1v1))
and v2 = (Vertex.indice (V.label obj1_1v2)) in
begin
   associate obj1_1v1 obj1_1v2;
   ((Vertex.indice (V.label obj1_1v1)) = v2) && ((Vertex.indice (V.label obj1_1v2)) = v1);
end
;;



(* separate *)

separate v1 v2 = ();;

(* contract *)

contract g o a = [];;

(* insert *)

insert g o a la = ();;


(*Section 2*)

(* equals_aux *)

equals_aux g1 v1 g2 v2 = (true,[]);;

(* equals *)

equals g1 v1 g2 v2 = (true,[]);;


(*Section 3*)

(* distance_aux *)

distance_aux g1 v1 g2 v2 = (0,[],[],[]);;

(* distance *)

distance g1 v1 g2 v2 = (0,[],[],[]);;


(*Section 4*)

(* distance_opti *)

distance_opti g1 v1 g2 v2 = (0,[],[],[]);;
