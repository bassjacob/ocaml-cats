open Sig
open TyCon

module Make : functor (E : TC1) -> sig
  module Def : module type of Def.Forall.Make(E)
  include module type of Def
end
