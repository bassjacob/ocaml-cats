open Sig;
open TyCon;

let module Make (E: TC1): {
  let module Def: module type Def.Exists.Make E;
  include module type Def;
};
