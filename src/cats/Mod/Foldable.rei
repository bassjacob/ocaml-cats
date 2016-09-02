open Sig;
open TyCon;

let module Cofree (FFol: FOLDABLE) (FFun: FUNCTOR with module T = FFol.T): {
    let module Def: module type Def.Foldable.Cofree FFun FFol;
    let module Ext: module type Ext.Foldable.Make Def;
    include module type Def;
    include module type Ext;
  };

let module List: {
  let module Def = Def.Foldable.List;
  let module Ext: module type Ext.Foldable.Make Def;
  include module type Def;
  include module type Ext;
};

let module Option: {
  let module Def = Def.Foldable.Option;
  let module Ext: module type Ext.Foldable.Make Def;
  include module type Def;
  include module type Ext;
};
