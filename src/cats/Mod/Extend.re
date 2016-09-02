open Sig;

let module Cofree (F: FUNCTOR) => {
  let module Def = Def.Extend.Cofree F;
  let module Ext = {
    include Ext.Functor.Make Def;
    include Ext.Extend.Make Def;
  };
  include Def;
  include Ext;
};
