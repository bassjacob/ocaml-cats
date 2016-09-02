open Sig;
open TyCon;

let module Make (P: PROFUNCTOR): module type Def.Coend.Make P;
