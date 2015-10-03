open Sig
open TyCon

module Make (F : FUNCTOR) = struct
  type 'a t =
    | Leaf of 'a
    | Fork of 'a t F.T.el
  module T = TC1(struct type nonrec 'a t = 'a t end)

  let pure x = Leaf x

  let rec bind t k = match t with
    | Leaf x -> k x
    | Fork xs -> Fork (F.map (fun x -> bind x k) xs)
end
