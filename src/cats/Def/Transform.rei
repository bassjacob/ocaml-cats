open Sig;
open TyCon;

let module Make (F: FUNCTOR) (G: FUNCTOR): TRANSFORM
  with module F := F
  with module G := G;
