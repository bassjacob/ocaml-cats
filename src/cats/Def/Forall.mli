open Sig
open TyCon

module Make : functor (E : TC1) -> sig
  include UNIVERSAL with module T := E
end
