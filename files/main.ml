(* TESTS DES FONCTIONS DE PROJET.ML *)

(***** Section 1 *****)

(* associate *)
#use "skeltest.ml";;

let fonction_testee = "********** TESTS ASSOCIATE **********";;

let v1 = Vertex.indice (V.label obj1_1v1);;
let v2 = Vertex.indice (V.label obj1_1v2);;
let v3 = Vertex.indice (V.label obj1_2v3);;
let v4 = Vertex.indice (V.label obj1_3v4);;

associate obj1_1v1 obj1_1v2;;
associate obj1_2v3 obj1_3v4;;

(* Tests *)
let test_associate_1 = Mark.get obj1_1v1 = v2;;
let test_associate_2 = Mark.get obj1_1v2 = v1;;
let test_associate_3 = Mark.get obj1_2v3 = v4;;
let test_associate_4 = Mark.get obj1_3v4 = v3;;


(* separate *)
#use "skeltest.ml";;

let fonction_testee = "********** TESTS SEPARATE **********";;

separate obj1_1v1 obj1_1v2;;
separate obj1_2v3 obj1_3v4;;

(* Tests *)
let test_separate_1 = Mark.get obj1_1v1 = 0;;
let test_separate_2 = Mark.get obj1_1v2 = 0;;
let test_separate_3 = Mark.get obj1_2v3 = 0;;
let test_separate_4 = Mark.get obj1_3v4 = 0;;


(* contract *)
#use "skeltest.ml";;

let fonction_testee = "********** TESTS CONTRACT **********";;

let voisins_obj1_1v1 = succ obj1_1 obj1_1v1;;

let res_contract = contract obj1_1 obj1_1v2 obj1_1v1;;
let voisins_obj1_1v2_apres_contract = succ obj1_1 obj1_1v2;;

(* Tests *)
let test_contract_1 = not(mem_vertex obj1_1 obj1_1v1);;
let test_contract_2 = not(mem_edge obj1_1 obj1_1v1 obj1_1v2);;
let test_contract_3 = List.for_all (fun elt -> List.mem elt voisins_obj1_1v2_apres_contract) voisins_obj1_1v1;;
let test_contract_4 = res_contract = (List.filter (fun elt -> not(elt = obj1_1v2)) voisins_obj1_1v1);;


(* insert *)
#use "skeltest.ml";;

let fonction_testee = "********** TESTS INSERT **********";;

let voisins_obj1_1v3 = succ obj1_1 obj1_1v3;;
let obj1_1v11 = createv (11, (140.204, 257.4), 60.0);;

insert obj1_1 obj1_1v3 obj1_1v11 [obj1_1v7];;

(* Tests *)
let test_insert_1 = mem_vertex obj1_1 obj1_1v11;;
let test_insert_2 = mem_edge obj1_1 obj1_1v3 obj1_1v11;;
let test_insert_3 = not (mem_edge obj1_1 obj1_1v3 obj1_1v7);;
let test_insert_4 = mem_edge obj1_1 obj1_1v3 obj1_1v4;;
let test_insert_5 = mem_edge obj1_1 obj1_1v11 obj1_1v7;;
let test_insert_6 = not (mem_edge obj1_1 obj1_1v11 obj1_1v4);;



(******************************************************************************)

(***** Section 2 *****)

(* equals *)
#use "skeltest.ml";;

let fonction_testee = "********** TESTS EQUALS **********";;

let liste_noeuds_correspondance = [(obj1_1v8, obj1_2v8); (obj1_1v10, obj1_2v9); (obj1_1v5, obj1_2v4); (obj1_1v2, obj1_2v3); (obj1_1v1, obj1_2v1); (obj1_1v9, obj1_2v10); (obj1_1v6, obj1_2v5); (obj1_1v3, obj1_2v2); (obj1_1v4, obj1_2v6); (obj1_1v7, obj1_2v7)];;

let res_equals = equals obj1_1 obj1_1v5 obj1_2 obj1_2v4;;

(* Tests *)
let test_equals_1 = fst res_equals = true;;
let test_equals_2 = List.for_all (fun elt -> List.mem elt (snd res_equals)) liste_noeuds_correspondance;;
let test_equals_3 = List.length liste_noeuds_correspondance = List.length (snd res_equals);;



(******************************************************************************)

(***** Section 3 *****)

(* distance *)
#use "skeltest.ml";;

let fonction_testee = "********** TESTS DISTANCE **********";;

let (c_res, l0_res, l1_res, l2_res) = distance obj1_1 obj1_1v5 obj1_3 obj1_3v3;;
let c = 2;;
let l0 = [(obj1_1v5, obj1_3v3); (obj1_1v10, obj1_3v10); (obj1_1v8, obj1_3v8); (obj1_1v2, obj1_3v1); (obj1_1v9, obj1_3v7); (obj1_1v3, obj1_3v4); (obj1_1v4, obj1_3v9); (obj1_1v7, obj1_3v6); (obj1_1v6, obj1_3v5)];;
let l1 = [(obj1_1v2, obj1_1v1)];;
let l2 = [(obj1_3v1, obj1_3v2)];;

(* Tests *)
let test_distance_1 = c = c_res;;
let test_distance_2 = l0 = l0_res;;
let test_distance_3 = l1 = l1_res;;
let test_distance_4 = l2 = l2_res;;



(******************************************************************************)

(***** Section 4 *****)

(* distance_opti *)
(*
#use "skeltest.ml";;

let fonction_testee = "********** TESTS DISTANCE_OPTI **********";;

let (c_res, l0_res, l1_res, l2_res) = distance_opti obj1_1 obj1_1v5 obj1_3 obj1_3v3;;
let c = 2;;
let l0 = [(obj1_1v5, obj1_3v3); (obj1_1v10, obj1_3v10); (obj1_1v8, obj1_3v8); (obj1_1v2, obj1_3v1); (obj1_1v9, obj1_3v7); (obj1_1v3, obj1_3v4); (obj1_1v4, obj1_3v9); (obj1_1v7, obj1_3v6); (obj1_1v6, obj1_3v5)];;
let l1 = [(obj1_1v2, obj1_1v1)];;
let l2 = [(obj1_3v1, obj1_3v2)];;

(* Tests *)
let test_distance_1 = c = c_res;;
let test_distance_2 = l0 = l0_res;;
let test_distance_3 = l1 = l1_res;;
let test_distance_4 = l2 = l2_res;;
*)
