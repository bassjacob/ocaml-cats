open Sig;
open TyCon;

let module Cofree (F: FUNCTOR) => {
  let module Def = Def.Comonad.Cofree F;
  let module Ext = {
    include Ext.Functor.Make Def;
    include Ext.Extend.Make Def;
    include Ext.Comonad.Make Def;
  };
  include Def;
  include Ext;
};
