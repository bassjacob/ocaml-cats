open Sig;
open TyCon;

let module Unit = {
  let module Def = Def.ModuloSemiring.Unit;
  let module Ext = {
    include Semiring.Unit.Ext;
    include Ext.ModuloSemiring.Make Def;
  };
  include Def;
  include Ext;
};

let module Int = {
  let module Def = Def.ModuloSemiring.Int;
  let module Ext = {
    include Semiring.Int.Ext;
    include Ext.ModuloSemiring.Make Def;
  };
  include Def;
  include Ext;
};

let module Float = {
  let module Def = Def.ModuloSemiring.Float;
  let module Ext = {
    include Semiring.Float.Ext;
    include Ext.ModuloSemiring.Make Def;
  };
  include Def;
  include Ext;
};
