open Sig
open TyCon

type ('a, 'b) t = Refl : ('a, 'a) t

let refl = Refl

let subst (type f) (m : f tc1) (type a) (type b)
  : (a, b) t -> ((a, f) ap -> (b, f) ap)
  = fun Refl -> Amb.id
