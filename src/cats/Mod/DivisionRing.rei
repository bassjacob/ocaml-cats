open Sig;
open TyCon;

let module Unit: {
  let module Def = Def.DivisionRing.Unit;
  include module type Def;
};

let module Float: {
  let module Def = Def.DivisionRing.Float;
  include module type Def;
};
