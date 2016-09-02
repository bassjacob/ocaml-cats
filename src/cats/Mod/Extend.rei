open Sig;

let module Cofree (F: FUNCTOR): {
  let module Def: module type Def.Extend.Cofree F;
  let module Ext: {
    include module type Ext.Functor.Make Def;
    include module type Ext.Extend.Make Def;
  };
  include module type Def;
  include module type Ext;
};
