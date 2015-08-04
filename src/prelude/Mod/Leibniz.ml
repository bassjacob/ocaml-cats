open Sig
open Ty.Sig.Unary

type ('a, 'b) t = Refl : ('a, 'a) t
let refl = Refl
let subst (type f) (module T : Invariant.CO with type co = f) (type a) (type b)
  : (a, b) t -> ((a, f) Ty.ap -> (b, f) Ty.ap)
  = fun Refl -> Amb.id
