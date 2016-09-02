open Sig;
open TyCon;

let module Make (E: TC1) => {
  let module Def = Def.Exists.Make E;
  include Def;
};
