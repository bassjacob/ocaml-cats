open Sig
open TyCon

module Cofree (F : FUNCTOR) : sig
  include module type of Functor.Cofree(F)
  include EXTEND with module T := T
end
