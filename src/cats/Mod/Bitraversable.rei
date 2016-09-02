open Sig;

let module Tuple: {
  let module Def = Def.Bitraversable.Tuple;
  let module Ext: {
    include module type Ext.Bitraversable.Make Def;
  };
  include module type Def;
  include module type Ext;
};
