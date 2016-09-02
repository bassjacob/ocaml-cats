open Sig;
open TyCon;

let module Make (F: FUNCTOR) (G: FUNCTOR) => Def.Transform.Make F G;
