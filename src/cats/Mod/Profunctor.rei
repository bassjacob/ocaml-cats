open Sig;
open TyCon;

let module Diagonal (P: PROFUNCTOR): module type Def.Profunctor.Diagonal P;

let module Fun: {
  let module Def = Def.Profunctor.Fun;
  let module Ext: module type Ext.Profunctor.Make Def;
  include module type Def;
  include module type Ext;
};
