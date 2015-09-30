open Sig
open TyCon

module Make : functor (E : TC1) -> sig
  module Def : EXISTENTIAL with module T := E
  include (module type of Def)
end
