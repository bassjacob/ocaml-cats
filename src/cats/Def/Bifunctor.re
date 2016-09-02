open Sig;
open TyCon;

let module Tuple = {
  open Amb.Product;
  let module T = TC.Tuple;
  let bimap f g => {
    let (%>) = Amb.compose;
    into (f %> fst) (g %> snd)
  };
};

let module Variant = {
  open Amb.Coproduct;
  let module T = TC.Variant;
  let bimap f g => {
    let (%>) = Amb.compose;
    from (inl %> f) (inr %> g)
  };
};
