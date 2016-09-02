open Sig;
open TyCon;

let module Tuple: {
  let module Def = Def.Biapply.Tuple;
  include module type Def;
};
