open Sig;
open TyCon;

let module Make (E: TC1) => {
  let module Def = Def.Forall.Make E;
  include Def;
};
