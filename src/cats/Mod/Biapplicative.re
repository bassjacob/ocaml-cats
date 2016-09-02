open Sig;
open TyCon;

let module Tuple = {
  let module Def = Def.Biapplicative.Tuple;
  include Def;
};
