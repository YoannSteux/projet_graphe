
(*Section 1*)


let associate v1 v2 =
  let label1 = Vertex.indice (V.label v1)
  in
  begin
    Mark.set v1 (Vertex.indice (V.label v2));
    Mark.set v2 (label1);
  end
;;

let separate v1 v2 = 
  begin
    Mark.set v1 0;
    Mark.set v2 0;
  end
;;

let rec retirer_arrete g a liste =
  match liste with
  |[] -> ()
  |t::q -> begin 
             (remove_edge g a t);
             retirer_arrete g a q;
           end
;;

let rec creer_arrete g o liste =
  match liste with
  |[] -> ()
  |t::q -> begin 
             (add_edge g o t);
             creer_arrete g o q;
           end
;;


let contract g o a = 
begin
   let liste = succ g a in
   (* retirer arrete o-a *)
   remove_edge g a o;
   (* retirer les arretes s-a , s voisins de a *)
   retirer_arrete g a liste;
   (* ajouter les arretes s-o , s voisins de a *)
   creer_arrete g o liste;
   (* retirer sommet a *)
   remove_vertex g a;
end
;;

let insert g o a la = 
begin
  (* ajouter sommet a *)
  add_vertex g a;
  (* retirer les arretes s-o , s voisins de a *)
  retirer_arrete g o la;
  (* ajouter les arretes s-a , s voisins de a *)
  creer_arrete g a la;
  (* ajouter arrete o-a *)
  add_edge g a o;
end
;;


(*Section 2*)

let equals_aux g1 v1 g2 v2 = (true,[]);;

let equals g1 v1 g2 v2 = (true,[]);;


(*Section 3*)

let distance_aux g1 v1 g2 v2 = (0,[],[],[]);;

let distance g1 v1 g2 v2 = (0,[],[],[]);;


(*Section 4*)

let distance_opti g1 v1 g2 v2 = (0,[],[],[]);;
