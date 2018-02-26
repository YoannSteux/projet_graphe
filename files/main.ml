(* TESTS DES FONCTIONS DE PROJET.ML *)

(***** Section 1 *****)

(* associate *)
#use "skeltest.ml";;

let test_associate = "********** TESTS ASSOCIATE **********";;

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

(*let obj1_1 = copie_obj1_1;;
let obj1_2 = copie_obj1_2;;
let obj1_3 = copie_obj1_3;;*)

(* separate *)
#use "skeltest.ml";;

let test_separate = "********** TESTS SEPARATE **********";;

separate obj1_1v1 obj1_1v2;;
let test_separate_1 = Mark.get obj1_1v1 = 0;;
let test_separate_2 = Mark.get obj1_1v2 = 0;;

separate obj1_2v3 obj1_3v4;;
let test_separate_3 = Mark.get obj1_2v3 = 0;;
let test_separate_4 = Mark.get obj1_3v4 = 0;;

(*let obj1_1 = copie_obj1_1;;
let obj1_2 = copie_obj1_2;;
let obj1_3 = copie_obj1_3;;*)

(* contract *)
#use "skeltest.ml";;

let test_contract = "********** TESTS CONTRACT **********";;

let voisins_obj1_1v1 = succ obj1_1 obj1_1v1;;

let res_contract = contract obj1_1 obj1_1v2 obj1_1v1;;
let test_contract_1 = not(mem_vertex obj1_1 obj1_1v1);;
let test_contract_2 = not(mem_edge obj1_1 obj1_1v1 obj1_1v2);;
let voisins_obj1_1v2 = succ obj1_1 obj1_1v2;;
let test_contract_3 = List.for_all (fun elt -> List.mem elt voisins_obj1_1v2) voisins_obj1_1v1;;
let test_contract_4 = res_contract = (List.filter (fun elt -> not(elt = obj1_1v2)) voisins_obj1_1v1);;

(*let obj1_1 = copie_obj1_1;;*)

(* insert *)
#use "skeltest.ml";;

let test_insert = "********** TESTS INSERT **********";;

let voisins_obj1_1v3 = succ obj1_1 obj1_1v3;;

let obj1_1v11 = createv (11, (140.204, 257.4), 60.0);;

insert obj1_1 obj1_1v3 obj1_1v11 [obj1_1v7];;
let test_insert_1 = mem_vertex obj1_1 obj1_1v11;;
let test_insert_2 = mem_edge obj1_1 obj1_1v3 obj1_1v11;;
let test_insert_3 = not (mem_edge obj1_1 obj1_1v3 obj1_1v7);;
let test_insert_4 = mem_edge obj1_1 obj1_1v3 obj1_1v4;;
let test_insert_5 = mem_edge obj1_1 obj1_1v11 obj1_1v7;;
let test_insert_6 = not (mem_edge obj1_1 obj1_1v11 obj1_1v4);;

(*let obj1_1 = copie_obj1_1;;*)



(******************************************************************************)

(***** Section 2 *****)

(* equals *)
#use "skeltest.ml";;

let test_equals = "********** TESTS EQUALS **********";;

let test_equals_1 = fst (equals obj1_1 obj1_1v5 obj1_2 obj1_2v4) = true;;
let liste_noeuds_correspondance = [(obj1_1v8, obj1_2v8); (obj1_1v10, obj1_2v9); (obj1_1v5, obj1_2v4); (obj1_1v2, obj1_2v3); (obj1_1v1, obj1_2v1); (obj1_1v9, obj1_2v10); (obj1_1v6, obj1_2v5); (obj1_1v3, obj1_2v2); (obj1_1v4, obj1_2v6); (obj1_1v7, obj1_2v7)];;
let test_equals_2 = List.for_all (fun elt -> List.mem elt (snd (equals obj1_1 obj1_1v5 obj1_2 obj1_2v4))) liste_noeuds_correspondance;;

(*let obj1_1 = copie_obj1_1;;
let obj1_3 = copie_obj1_4;;*)



(******************************************************************************)

(***** Section 3 *****)

(* distance *)
#use "skeltest.ml";;

let test_distance = "********** TESTS DISTANCE **********";;

let test_distance = distance obj1_1 obj1_1v5 obj1_3 obj1_3v3 = (0,[],[],[]);;

(******************************************************************************)

(***** Section 4 *****)

(* distance_opti *)


