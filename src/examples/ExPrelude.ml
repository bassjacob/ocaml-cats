open Prelude
open Ambient
open Semigroupoid.Fun

(* Existentials for list functor *)
let ex0 () : int = let module E = Exists.Make(Functor.List.T) in
  let pkg = E.into [0; 1; 2; 3; 4] in (* pack *)
  E.from pkg { E.ap = List.length }   (* elim *)

(* Bifunctor for tuple *)
let ex1 () : int * string =
  Bifunctor.Tuple.bimap (fun x -> x * 2) string_of_float
    (42, 3.14159)

(* Semigroupoid for (->) *)
let ex2 () : int = (fun x -> x + 1) %> (fun x -> x * 2) @@ 10

(* Monoid for list *)
let ex3 () : int list =
  let module M = Monoid.List(struct type el = int end) in
  M.op [0; 1; 2; 3] [4; 5; 6; 7]

(* Foldable for list *)
let ex4 () : int =
  let module F = Foldable.List in
  let module Add = Monoid.Additive.Int in
  let module Mul = Monoid.Multiplicative.Int in
  let input = [1; 2; 3; 4; 5] in
  let lhs = F.fold_map (module Add) id input in
  let rhs = F.fold_map (module Mul) id input in
    Add.op lhs rhs

(* Applicative for list *)
let ex5 () : int list =
  let module A = Applicative.List in
  A.apply [(fun x -> x * 2); (fun x -> x * 4); (fun x -> x * 8)] [1; 2; 3]

(* Traversable for list *)
let ex6 () : int list list =
  let module A = Applicative.List in
  let module T = Traversable.List in
  (* not very interesting but it works … *)
  let res = T.traverse (module A) (A.T.co %> A.pure) [0; 1; 2; 3; 4] in
  A.T.el res (* = [[0; 1; 2; 3; 4]] *)

(* Natural transformations *)
let ex7 () : int list =
  let open Functor in let module N = Natural.Make(Option)(List) in
  { N.ap = fun x -> match x with
    | None -> []
    | Some x -> [x]
  }.N.ap (Some 10)

let () =
  bang @@ ex0 ();
  bang @@ ex1 ();
  bang @@ ex2 ();
  bang @@ ex3 ();
  bang @@ ex4 ();
  bang @@ ex5 ();
  bang @@ ex6 ();
  bang @@ ex7 ()
