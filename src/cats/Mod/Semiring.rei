open Sig;
open TyCon;

let module Unit: {
  let module Def = Def.Semiring.Unit;
  let module Ext: {
    include module type Ext.Semiring.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module Int: {
  let module Def = Def.Semiring.Int;
  let module Ext: {
    include module type Ext.Semiring.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module Float: {
  let module Def = Def.Semiring.Float;
  let module Ext: {
    include module type Ext.Semiring.Make Def;
  };
  include module type Def;
  include module type Ext;
};
