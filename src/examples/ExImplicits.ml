open Prelude
open Ambient

(* TODO: port full set of prelude examples to implicits style *)

module I = Implicits
open implicit I.Bifunctor
open implicit I.Foldable
open implicit I.Semigroup

(* Bifunctor for tuple, variant, etc. *)
let ex1 () : _ =
  let module M = I.Bifunctor in
  let _ = M.bimap (fun x -> x * 2) string_of_float (42, 3.14159) in
  let _ = M.bimap (fun x -> x ^ "bar") (fun y -> y +  1) (Coproduct.inl "foo") in
  let _ = M.bimap (fun x -> "foo" ^ x) (fun y -> y *. 2.0) (Coproduct.inr 1.0) in
  ()

(* Foldable for option, list, etc. *)
let ex4 () : _ =
  let module M = I.Foldable in
  let module Add = Monoid.Additive.Int in
  let module Mul = Monoid.Multiplicative.Int in
  let _ = M.fold_map (module Add) id [1; 2; 3; 4; 5] in
  let _ = M.fold_map (module Mul) id [1; 2; 3; 4; 5] in
  let _ = M.fold_map (module Add) id None in
  let _ = M.fold_map (module Mul) id (Some 5) in
  ()

let exx () : bool =
  let module M = I.Semigroup in
  let p0 : bool = M.op "foo" "bar" = "foobar" in
  let p1 : bool = (let open implicit M.Additive in M.op 3 4) = 7 in
  let p2 : bool = (let open implicit M.Multiplicative in M.op 3 4) = 12 in
  p0 && p1 && p2
