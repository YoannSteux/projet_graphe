
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

let distance_aux g1 v1 g2 v2 = 
let s1 = unmarked (ordered_succ g1 v1)  
    and s2 = unmarked (ordered_succ g2 v2)  
  in
  if ((s1=[]) && (s2=[])) then
    (0, [],[],[])
  else 
    if ((s1=[]) || (s2=[])) then
      (0, [],[],[])
    else
    
      let (h1,h2) = (List.hd s1 , List.hd s2)
      in
      associate h1 h2;
      let (ch,l0h, l1h,l2h) = distance_aux g1 h1 g2 h2
        and
          (cq,l0q,l1q,l2q) = distance_aux g1 v1 g2 v2
      in
      separate h1 h2;
      let l0 = l0h@l0q
       and c = 
       and l1 = 
       and l2 =
      in
      (c, [(h1,h2)]@l0, l1, l2)


and distance g1 v1 g2 v2 =
  associate v1 v2;
  let (c,l0,l1,l2) = distance_aux g1 v1 g2 v2
  in
  let l = [(v1,v2)]@l0
  in
  separate v1 v2;
  (c,l,l1,l2)
;;


(*Section 4*)

let distance_opti g1 v1 g2 v2 = (0,[],[],[]);;
