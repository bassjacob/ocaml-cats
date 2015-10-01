open Sig
open TyCon

module Make (P : PROFUNCTOR) = Def.Coend.Make(P)
