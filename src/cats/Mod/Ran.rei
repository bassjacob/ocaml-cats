open Sig;
open TyCon;

let module Make (J: TC1) (G: TC1): {
  let module Def: module type Def.Ran.Make J G;
  let module Ext: {
    include module type Ext.Ran.Make Def;
  };
  include module type Def;
};
