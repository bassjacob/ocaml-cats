open Sig
open TyCon

module Tuple = struct
  open Amb.Product
  module Def = struct
    include Bifunctor.Tuple.Def
    include (Bifoldable.Tuple.Def : module type of Bifoldable.Tuple.Def
      with module T := T)

    let bitraverse (type m) (m : m applicative) f g p =
      let module A = (val m) in
      A.T.co @@ A.apply
        (A.map pair (A.T.el @@ f @@ fst @@ p))
                    (A.T.el @@ g @@ snd @@ p)

    let bisequence m = bitraverse m Amb.id Amb.id

  end
  include Def
end
