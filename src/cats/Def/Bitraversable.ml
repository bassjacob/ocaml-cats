open Sig
open TyCon

module Tuple = struct
  open Amb.Product

  include Bifunctor.Tuple
  include (Bifoldable.Tuple : module type of Bifoldable.Tuple
    with module T := T)

  let bitraverse (type m) (m : m applicative) f g p =
    let module A = (val m) in
    A.T.co @@ A.apply
      (A.map pair (A.T.el @@ f @@ fst @@ p))
      (A.T.el @@ g @@ snd @@ p)
end
