open Sig;
open TyCon;

let module Tuple = {
  let module Def = Def.Bitraversable.Tuple;
  let module Ext = {
    include Ext.Bitraversable.Make Def;
  };
  include Def;
  include Ext;
};
