open Sig;
open TyCon;

let module Cofree (F: FUNCTOR): {
    let module Def: module type Def.Functor.Cofree F;
    let module Ext: module type Ext.Functor.Make Def;
    include module type Def;
    include module type Ext;
  };

let module Identity: {
  let module Def = Def.Functor.Identity;
  let module Ext: module type Ext.Functor.Make Def;
  include module type Def;
  include module type Ext;
};

let module Option: {
  let module Def = Def.Functor.Option;
  let module Ext: module type Ext.Functor.Make Def;
  include module type Def;
  include module type Ext;
};

let module List: {
  let module Def = Def.Functor.List;
  let module Ext: module type Ext.Functor.Make Def;
  include module type Def;
  include module type Ext;
};
