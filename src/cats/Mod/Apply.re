open Sig;
open TyCon;

let module Free (F: FUNCTOR) => {
  let module Def = Def.Apply.Free F;
  let module Ext = {
    include Ext.Functor.Make Def;
    include Ext.Apply.Make Def;
  };
  include Def;
  include Ext;
};

let module Identity = {
  let module Def = Def.Apply.Identity;
  let module Ext = {
    include Functor.Identity.Ext;
    include Ext.Apply.Make Def;
  };
  include Def;
  include Ext;
};

let module Option = {
  let module Def = Def.Apply.Option;
  let module Ext = {
    include Functor.Option.Ext;
    include Ext.Apply.Make Def;
  };
  include Def;
  include Ext;
};

let module List = {
  let module Def = Def.Apply.List;
  let module Ext = {
    include Functor.List.Ext;
    include Ext.Apply.Make Def;
  };
  include Def;
  include Ext;
};
