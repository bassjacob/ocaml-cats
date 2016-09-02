open Sig;
open TyCon;

let module Tuple = {
  open Amb.Product;
  let module Def = Def.Biapply.Tuple;
  include Def;
};
