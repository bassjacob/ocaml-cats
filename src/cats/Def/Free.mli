open Sig
open TyCon

module Make (F : FUNCTOR) : sig
  type 'a t =
    | Leaf of 'a
    | Fork of 'a t F.T.el
  module T : TC1 with type 'a el = 'a t
end
