open Sig;
open TyCon;

let module Unit = {
  let module Def = Def.DivisionRing.Unit;
  include Def;
};

let module Float = {
  let module Def = Def.DivisionRing.Float;
  include Def;
};
