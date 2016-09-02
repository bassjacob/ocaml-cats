open Sig;
open TyCon;

let module Tuple = {
  open Amb.Product;
  let module Def = Def.Bifoldable.Tuple;
  let module Ext = {
    include Ext.Bifoldable.Make Def;
  };
  include Def;
  include Ext;
};

let module Variant = {
  open Amb.Coproduct;
  let module Def = Def.Bifoldable.Variant;
  let module Ext = {
    include Ext.Bifoldable.Make Def;
  };
  include Def;
  include Ext;
};
