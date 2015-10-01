open Sig
open TyCon

module Make : functor (F : FUNCTOR) (G : FUNCTOR) ->
  module type of Def.Transform.Make(F)(G)
