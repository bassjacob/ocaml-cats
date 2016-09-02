open Sig;
open TyCon;

let module Cofree (F: FUNCTOR) => {
  let module Def = Def.Functor.Cofree F;
  let module Ext = Ext.Functor.Make Def;
  include Def;
  include Ext;
};

let module Identity = {
  let module Def = Def.Functor.Identity;
  let module Ext = Ext.Functor.Make Def;
  include Def;
  include Ext;
};

let module Option = {
  let module Def = Def.Functor.Option;
  let module Ext = Ext.Functor.Make Def;
  include Def;
  include Ext;
};

let module List = {
  let module Def = Def.Functor.List;
  let module Ext = Ext.Functor.Make Def;
  include Def;
  include Ext;
};
