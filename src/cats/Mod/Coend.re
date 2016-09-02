open Sig;
open TyCon;

let module Make (P: PROFUNCTOR) => Def.Coend.Make P;
