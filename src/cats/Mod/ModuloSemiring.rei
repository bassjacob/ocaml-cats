open Sig;
open TyCon;

let module Unit: {
  let module Def = Def.ModuloSemiring.Unit;
  let module Ext: {
    include module type Semiring.Unit.Ext;
    include module type Ext.ModuloSemiring.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module Int: {
  let module Def = Def.ModuloSemiring.Int;
  let module Ext: {
    include module type Semiring.Int.Ext;
    include module type Ext.ModuloSemiring.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module Float: {
  let module Def = Def.ModuloSemiring.Float;
  let module Ext: {
    include module type Semiring.Float.Ext;
    include module type Ext.ModuloSemiring.Make Def;
  };
  include module type Def;
  include module type Ext;
};
