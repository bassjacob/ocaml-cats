open Sig;
open TyCon;

let module Cofree (F: FUNCTOR): {
  let module Def: module type Def.Comonad.Cofree F;
  let module Ext: {
    include module type Ext.Functor.Make Def;
    include module type Ext.Extend.Make Def;
    include module type Ext.Comonad.Make Def;
  };
  include module type Def;
  include module type Ext;
};
