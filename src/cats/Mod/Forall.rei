open Sig;
open TyCon;

let module Make (E: TC1): {
  let module Def: module type Def.Forall.Make E;
  include module type Def;
};
