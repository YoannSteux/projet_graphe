
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
   let liste_sans_o = succ g a in
   (* retirer les arretes s-a , s voisins de a *)
   retirer_arrete g a liste;
   (* ajouter les arretes s-o , s voisins de a *)
   creer_arrete g o liste;
   (* retirer sommet a *)
   remove_vertex g a;
   liste_sans_o
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

let unmarked_aux sommet l_non_marques =
   if (Mark.get sommet = 0) then
      [sommet]@l_non_marques
   else
      l_non_marques
;;

let unmarked l =
  List.fold_right unmarked_aux l [] 
;;

let rec equals_aux g1 v1 g2 v2 = 
  let s1 = unmarked (ordered_succ g1 v1)  
    and s2 = unmarked (ordered_succ g2 v2)  
  in
  if ((s1=[]) && (s2=[])) then
    (true, [])
  else 
    if ((s1=[]) || (s2=[])) then
      (false, [])
    else
    
      let (h1,h2) = (List.hd s1 , List.hd s2)
      in
      associate h1 h2;
      let (bh,lh) = equals_aux g1 h1 g2 h2
        and
          (bq,lq) = equals_aux g1 v1 g2 v2
      in
      separate h1 h2;
      let lf = lh@lq
      in
      ((bh && bq), [(h1,h2)]@lf)
    
and equals g1 v1 g2 v2 = 

  associate v1 v2;
  let (b, lr) = equals_aux g1 v1 g2 v2
  in
  let l = [(v1,v2)]@lr
  in
  separate v1 v2;
  (b,l)

;;


(*Section 3*)

let rec distance_aux g1 v1 g2 v2 = 
let s1 = unmarked (ordered_succ g1 v1)  
    and s2 = unmarked (ordered_succ g2 v2)  
  in    
match (s1,s2) with
|([],[]) ->((0, [],[],[]))
|(h1::q1,[]) ->  (* contracter g1 jusqu'à egalité *)
  (let l_ = contract g1 v1 h1 in
  let (c,l0,l1,l2) = distance_aux g1 v1 g2 v2 in
  insert g1 v1 h1 l_;
  (c+1, l0, (v1,h1)::l1, l2))

|([],h2::q2) -> (* contracter g2 jusqu'à egalité *)
  (let l_ = contract g2 v2 h2 in
  let (c,l0,l1,l2) = distance_aux g1 v1 g2 v2 in
  insert g2 v2 h2 l_;
  (c+1 , l0, l1, (v2,h2)::l2))

|(h1::q1, h2::q2) -> (* contracter g1 et g2 jusqu'à égalité *)
  (* marquage des sommets h1 et h2  *)
    let (cm, l0m, l1m, l2m) =
    begin
    associate h1 h2;
    let (c1,l01,l11,l21) = distance_aux g1 h1 g2 h2 in
    let (c2,l02,l12,l22) = distance_aux g1 v1 g2 v2
    in
    (separate h1 h2;
    (c1+c2 , (h1,h2)::l01@l02 , l11@l12 , l21@l22);)
    end
    in
  (* contracter arete de gauche (v1, h1) de g2 *)
     let (cc2, l0c2, l1c2, l2c2) =
     begin
     let l_ = contract g2 v2 h2 in
     let (c,l0,l1,l2) = distance_aux g1 v1 g2 v2 in
     (insert g2 v2 h2 l_;
     (c+1,l0,l1, (v2,h2)::l2);)
     end
     in
  (* contracter arete de gauche (v1,h1) de g1 *)
     let (cc1, l0c1, l1c1, l2c1) = 
     begin
     let l_ = contract g1 v1 h1 in
     let (c,l0,l1,l2) = distance_aux g1 v1 g2 v2 in
     (insert g1 v1 h1 l_;
     (c+1,l0, (v1,h1)::l1, l2);)
     end
     in
  (* choix *)
  if (cm <= cc1)&&(cm <= cc2) then
    (cm,l0m,l1m,l2m)
  else(
    if (cc2 <= cm)&&(cc2 <= cc1) then
      (cc2,l0c2, l1c2, l2c2)
    else 
       (cc1, l0c1, l1c1, l2c1))

and distance g1 v1 g2 v2 =
  associate v1 v2;
  let (c,l0,l1,l2) = distance_aux g1 v1 g2 v2
  in
  let l = (v1,v2)::l0
  in
  separate v1 v2;
  (c,l,l1,l2)
;;


(*Section 4*)

let distance_opti g1 v1 g2 v2 = (0,[],[],[]);;
