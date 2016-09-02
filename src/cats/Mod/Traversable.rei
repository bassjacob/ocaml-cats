open Sig;
open TyCon;

let module Cofree (FFun: FUNCTOR) (FTra: TRAVERSABLE with module T = FFun.T): {
  let module Def: module type Def.Traversable.Cofree FFun FTra;
  let module Ext: {
    include module type Ext.Foldable.Make Def;
    include module type Ext.Traversable.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module List: {
  let module Def = Def.Traversable.List;
  let module Ext: {
    include module type Ext.Foldable.Make Def;
    include module type Ext.Traversable.Make Def;
  };
  include module type Def;
  include module type Ext;
};
