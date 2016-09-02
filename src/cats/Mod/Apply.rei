open Sig;
open TyCon;

let module Free (F: FUNCTOR): {
  let module Def: module type Def.Apply.Free F;
  let module Ext: {
    include module type Ext.Functor.Make Def;
    include module type Ext.Apply.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module Identity: {
  let module Def = Def.Apply.Identity;
  let module Ext: {
    include module type Functor.Identity.Ext;
    include module type Ext.Apply.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module Option: {
  let module Def = Def.Apply.Option;
  let module Ext: {
    include module type Functor.Option.Ext;
    include module type Ext.Apply.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module List: {
  let module Def = Def.Apply.List;
  let module Ext: {
    include module type Functor.List.Ext;
    include module type Ext.Apply.Make Def;
  };
  include module type Def;
  include module type Ext;
};
