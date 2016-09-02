open Sig;
open TyCon;

let module Tuple = {
  let module Def = Def.Bifunctor.Tuple;
  include Def;
};

let module Variant = {
  let module Def = Def.Bifunctor.Variant;
  include Def;
};
