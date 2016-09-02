open Sig;
open TyCon;

let module Unit = {
  let module Def = Def.Ring.Unit;
  let module Ext = {
    include Semiring.Unit.Ext;
    include Ext.Ring.Make Def;
  };
  include Def;
  include Ext;
};

let module Int = {
  let module Def = Def.Ring.Int;
  let module Ext = {
    include Semiring.Int.Ext;
    include Ext.Ring.Make Def;
  };
  include Def;
  include Ext;
};

let module Float = {
  let module Def = Def.Ring.Float;
  let module Ext = {
    include Semiring.Float.Ext;
    include Ext.Ring.Make Def;
  };
  include Def;
  include Ext;
};
