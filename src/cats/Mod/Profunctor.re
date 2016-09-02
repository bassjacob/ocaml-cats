open Sig;
open TyCon;

let module Diagonal (P: PROFUNCTOR) => Def.Profunctor.Diagonal P;

let module Fun = {
  let module Def = Def.Profunctor.Fun;
  let module Ext = Ext.Profunctor.Make Def;
  include Def;
  include Ext;
};
