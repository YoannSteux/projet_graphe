(* TESTS DES FONCTIONS DE PROJET.ML *)
#use "skeltest.ml";;

(*Section 1*)

(* associate *)

let v1 = Vertex.indice (V.label obj1_1v1);;
let v2 = Vertex.indice (V.label obj1_1v2);;
let v3 = Vertex.indice (V.label obj1_2v3);;
let v4 = Vertex.indice (V.label obj1_3v4);;

associate obj1_1v1 obj1_1v2;;
let test_associate_1 = Mark.get obj1_1v1 = v2;;
let test_associate_2 = Mark.get obj1_1v2 = v1;;

associate obj1_2v3 obj1_3v4;;
let test_associate_3 = Mark.get obj1_2v3 = v4;;
let test_associate_4 = Mark.get obj1_3v4 = v3;;

(* separate *)

separate obj1_1v1 obj1_1v2;;
let test_separate_1 = Mark.get obj1_1v1 = 0;;
let test_separate_2 = Mark.get obj1_1v2 = 0;;

separate obj1_2v3 obj1_3v4;;
let test_separate_3 = Mark.get obj1_2v3 = 0;;
let test_separate_4 = Mark.get obj1_3v4 = 0;;

(* contract *)

let voisins_obj1_1v1 = succ obj1_1 obj1_1v1;;

contract obj1_1v2 obj1_1v1;;
let test_contract_1 = not(mem_vertex obj1_1 obj1_1v1);;
let test_contract_2 = not(mem_edge obj1_1 obj1_1v1 obj1_1v2);;
let voisins_obj1_1v2 = succ obj1_1 obj1_1v2;;
let test_contract_3 = List.for_all (fun elt -> List.mem elt voisins_obj1_1v2) voisins_obj1_1v1;;

(* insert *)




(*Section 2*)

(* equals_aux *)



(* equals *)




(*Section 3*)

(* distance_aux *)



(* distance *)




(*Section 4*)

(* distance_opti *)


