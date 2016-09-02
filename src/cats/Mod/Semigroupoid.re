open Sig;

let module Fun = {
  let module Def = Def.Semigroupoid.Fun;
  let module Ext = {
    include Profunctor.Fun.Ext;
    include Ext.Semigroupoid.Make Def;
  };
  include Def;
  include Ext;
};
