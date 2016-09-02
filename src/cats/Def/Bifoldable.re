open Sig;
open TyCon;

let module Tuple = {
  open Amb.Product;
  let module T = TC.Tuple;
  let bifold_map (type m) (m: monoid m) f g p => {
    let module M = (val m);
    M.op (f (fst p)) (g (snd p))
  };
};

let module Variant = {
  open Amb.Coproduct;
  let module T = TC.Variant;
  let bifold_map _ => from;
};
