open Sig
open TyCon

module Make : functor (P : PROFUNCTOR) ->
  module type of Def.Coend.Make(P)
