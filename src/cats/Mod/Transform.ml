open Sig
open TyCon

module Make (F : FUNCTOR) (G : FUNCTOR) =
  Def.Transform.Make(F)(G)
