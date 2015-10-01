open Sig
open TyCon

module Make : functor (E : TC1) -> sig
  include EXISTENTIAL with module T := E
end
