open Sig;
open TyCon;

let module Unit: {
  let module Def = Def.Ring.Unit;
  let module Ext: {
    include module type Semiring.Unit.Ext;
    include module type Ext.Ring.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module Int: {
  let module Def = Def.Ring.Int;
  let module Ext: {
    include module type Semiring.Int.Ext;
    include module type Ext.Ring.Make Def;
  };
  include module type Def;
  include module type Ext;
};

let module Float: {
  let module Def = Def.Ring.Float;
  let module Ext: {
    include module type Semiring.Float.Ext;
    include module type Ext.Ring.Make Def;
  };
  include module type Def;
  include module type Ext;
};
