open Sig
open TyCon

type ('a, 'b) t = Refl : ('a, 'a) t
let refl = Refl
let subst (type f) (module T : TC1 with type co = f) (type a) (type b)
  : (a, b) t -> ((a, f) ap -> (b, f) ap)
  = fun Refl -> Amb.id
