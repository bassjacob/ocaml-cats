open Sig
open TyCon

module Make (F : FUNCTOR) : sig
  type 'a t =
    | Fork of 'a * 'a t F.T.el
  module T : TC1 with type 'a el = 'a t
end
