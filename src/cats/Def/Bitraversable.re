open Sig;

open TyCon;

let module Tuple = {
  open Amb.Product;
  include Bifunctor.Tuple;
  include (Bifoldable.Tuple: module type Bifoldable.Tuple with module T := T);
  let bitraverse (type m) (m: applicative m) f g p => {
    let module A = (val m);
    A.T.co @@ A.apply (A.map pair (A.T.el @@ f @@ fst @@ p)) (A.T.el @@ g @@ snd @@ p)
  };
};
