open Sig
open TyCon

module Make (F : FUNCTOR) = struct
  type 'a t =
    | Fork of 'a * 'a t F.T.el
  module T = TC1(struct type nonrec 'a t = 'a t end)
end
