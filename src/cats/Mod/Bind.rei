open Sig;

let module Free (F: FUNCTOR): {
  let module Def: module type Def.Bind.Free F;
  let module Ext: {
    include module type Ext.Functor.Make Def;
    include module type Ext.Apply.Make Def;
    include module type Ext.Bind.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module Identity: {
  let module Def = Def.Bind.Identity;
  let module Ext: {
    include module type Apply.Identity.Ext;
    include module type Ext.Bind.Make Def;
  };
  include module type Def;
  include module type Ext;
};
