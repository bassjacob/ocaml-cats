open Sig
open TyCon

module List = struct
  include Functor.List
  include (Foldable.List : module type of Foldable.List
    with module T := T)

  let traverse (type m) (m : m applicative) f =
    let module A = (val m) in
    let rec go xs = match xs with
      | [] -> A.pure []
      | (x :: xs) -> A.apply (A.map Amb.cons (A.T.el @@ f @@ x)) (go xs) in
    fun x -> A.T.co @@ go @@ x
end
