open Sig;
open TyCon;

let module Cofree (FFun: FUNCTOR) (FTra: TRAVERSABLE with module T = FFun.T) => {
  let module Def = Def.Traversable.Cofree FFun FTra;
  let module Ext = {
    include Ext.Foldable.Make Def;
    include Ext.Traversable.Make Def;
  };
  include Def;
  include Ext;
};

let module List = {
  let module Def = Def.Traversable.List;
  let module Ext = {
    include Ext.Foldable.Make Def;
    include Ext.Traversable.Make Def;
  };
  include Def;
  include Ext;
};
