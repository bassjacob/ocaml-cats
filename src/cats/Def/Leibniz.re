open Sig;

open TyCon;

type t 'a 'b =
  | Refl: t 'a 'a;

let refl = Refl;
let subst (type f) (m: tc1 f) (type a) (type b): (t a b => ap f a => ap f b) =>
  fun Refl => Amb.id;
