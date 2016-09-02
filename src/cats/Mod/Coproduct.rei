open Sig;
open TyCon;

let module Variant: {
  let module Def = Def.Coproduct.Variant;
  include module type Def;
};
