open Sig;
open TyCon;

let module Tuple: {
  let module Def = Def.Bifunctor.Tuple;
  include module type Def;
};

let module Variant: {
  let module Def = Def.Bifunctor.Variant;
  include module type Def;
};
