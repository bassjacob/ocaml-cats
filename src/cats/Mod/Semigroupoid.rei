open Sig;

let module Fun: {
  let module Def = Def.Semigroupoid.Fun;
  let module Ext: {
    include module type Profunctor.Fun.Ext;
    include module type Ext.Semigroupoid.Make Def;
  };
  include module type Def;
  include module type Ext;
};
