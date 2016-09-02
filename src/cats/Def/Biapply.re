open Sig;
open TyCon;

let module Tuple = {
  open Amb.Product;
  include Bifunctor.Tuple;
  let biapply f => {
    let (%>) = Amb.compose;
    into (fst f %> fst) (snd f %> snd);
  };
};
