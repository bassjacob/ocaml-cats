open Sig;
open TyCon;

let module Unit = {
  let module Def = Def.Semiring.Unit;
  let module Ext = {
    include Ext.Semiring.Make Def;
  };
  include Def;
  include Ext;
};

let module Int = {
  let module Def = Def.Semiring.Int;
  let module Ext = {
    include Ext.Semiring.Make Def;
  };
  include Def;
  include Ext;
};

let module Float = {
  let module Def = Def.Semiring.Float;
  let module Ext = {
    include Ext.Semiring.Make Def;
  };
  include Def;
  include Ext;
};
