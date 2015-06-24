open Sig
open Ty.Sig

module Make : functor (E : Unary.Invariant.CO) -> sig
  module Def : EXISTENTIAL with module T := E
  include (module type of Def)
end
