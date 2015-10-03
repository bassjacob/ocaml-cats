open Sig
open TyCon

module Cofree (F : FUNCTOR) : sig
  include module type of Extend.Cofree(F)
  include COMONAD with module T := T
end
