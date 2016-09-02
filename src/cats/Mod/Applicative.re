open Sig;
open TyCon;

let module Free (F: FUNCTOR) => {
  let module Def = Def.Applicative.Free F;
  let module Ext = {
    include Ext.Functor.Make Def;
    include Ext.Apply.Make Def;
  };
  include Def;
  include Ext;
};

let module Identity = {
  let module Def = Def.Applicative.Identity;
  let module Ext = {
    include Apply.Identity.Ext;
  };
  include Def;
  include Ext;
};

let module Option = {
  let module Def = Def.Applicative.Option;
  let module Ext = {
    include Apply.Option.Ext;
  };
  include Def;
  include Ext;
};

let module List = {
  let module Def = Def.Applicative.List;
  let module Ext = {
    include Apply.List.Ext;
  };
  include Def;
  include Ext;
};
