open Sig;
open TyCon;

let module Make (F: FUNCTOR) (G: FUNCTOR): module type Def.Transform.Make F G;
