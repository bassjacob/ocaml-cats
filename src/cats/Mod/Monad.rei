open Sig;
open TyCon;

let module Free (F: FUNCTOR): {
    let module Def: module type Def.Monad.Free F;
    let module Ext: {
      include module type Ext.Apply.Make Def;
      include module type Ext.Bind.Make Def;
      include module type Ext.Functor.Make Def;
      include module type Ext.Monad.Make Def;
    };
    include module type Def;
    include module type Ext;
  };

let module Identity: {
  let module Def = Def.Monad.Identity;
  let module Ext: {
    include module type Apply.Identity.Ext;
    include module type Bind.Identity.Ext;
    include module type Ext.Monad.Make Def;
  };
  include module type Def;
  include module type Ext;
};
