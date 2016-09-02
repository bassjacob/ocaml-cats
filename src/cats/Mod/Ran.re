open Sig;
open TyCon;

let module Make (J: TC1) (G: TC1) => {
  let module Def = Def.Ran.Make J G;
  let module Ext = {
    include Ext.Ran.Make Def;
  };
  include Def;
  include Ext;
};
