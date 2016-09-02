open Sig;
open TyCon;

let module Tuple = {
  open Amb.Product;
  include Biapply.Tuple;
  let bipure = pair;
};
