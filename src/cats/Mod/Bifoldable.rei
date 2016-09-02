open Sig;
open TyCon;

let module Tuple: {
  let module Def = Def.Bifoldable.Tuple;
  let module Ext: {
    include module type Ext.Bifoldable.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module Variant: {
  let module Def = Def.Bifoldable.Variant;
  let module Ext: {
    include module type Ext.Bifoldable.Make Def;
  };
  include module type Def;
  include module type Ext;
};
