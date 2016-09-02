open Sig;
open TyCon;

let module Tuple: {
  let module Def = Def.Product.Tuple;
  include module type Def;
};
