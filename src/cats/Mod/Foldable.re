open Sig;
open TyCon;

let module Cofree (FFol: FOLDABLE) (FFun: FUNCTOR with module T = FFol.T) => {
  let module Def = Def.Foldable.Cofree FFun FFol;
  let module Ext = Ext.Foldable.Make Def;
  include Def;
  include Ext;
};

let module List = {
  let module Def = Def.Foldable.List;
  let module Ext = Ext.Foldable.Make Def;
  include Def;
  include Ext;
};

let module Option = {
  let module Def = Def.Foldable.Option;
  let module Ext = Ext.Foldable.Make Def;
  include Def;
  include Ext;
};
