open Sig;
open TyCon;

let module Free (F: FUNCTOR): {
  let module Def: module type Def.Applicative.Free F;
  let module Ext: {
    include module type Ext.Functor.Make Def;
    include module type Ext.Apply.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module Identity: {
  let module Def = Def.Applicative.Identity;
  let module Ext: {include module type Apply.Identity.Ext;};
  include module type Def;
  include module type Ext;
};

let module Option: {
  let module Def = Def.Applicative.Option;
  let module Ext: {include module type Apply.Option.Ext;};
  include module type Def;
};

let module List: {
  let module Def = Def.Applicative.List;
  let module Ext: {include module type Apply.List.Ext;};
  include module type Def;
  include module type Ext;
};
