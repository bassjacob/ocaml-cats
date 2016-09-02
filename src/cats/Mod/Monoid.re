open Sig;
open TyCon;

let module Endo (A: TC0) => {
  let module Def = Def.Monoid.Endo A;
  let module Ext = {
    let module Super = Semigroup.Endo A;
    include Super.Ext;
  };
  include Def;
  include Ext;
};

let module Flip (M: MONOID) => {
  let module Def = Def.Monoid.Flip M;
  let module Ext = {
    let module Super = Semigroup.Flip M;
    include Super.Ext;
  };
  include Def;
  include Ext;
};

let module Any = {
  let module Def = Def.Monoid.Any;
  let module Ext = {
    include Semigroup.Any.Ext;
  };
  include Def;
  include Ext;
};

let module All = {
  let module Def = Def.Monoid.All;
  let module Ext = {
    include Semigroup.All.Ext;
  };
  include Def;
  include Ext;
};

let module Unit = {
  let module Def = Def.Monoid.Unit;
  let module Ext = {
    include Semigroup.Unit.Ext;
  };
  include Def;
  include Ext;
};

let module String = {
  let module Def = Def.Monoid.String;
  let module Ext = {
    include Semigroup.String.Ext;
  };
  include Def;
  include Ext;
};

let module Additive = {
  let module Int = {
    let module Def = Def.Monoid.Additive.Int;
    let module Ext = {
      include Semigroup.Additive.Int.Ext;
    };
    include Def;
    include Ext;
  };
  let module Float = {
    let module Def = Def.Monoid.Additive.Float;
    let module Ext = {
      include Semigroup.Additive.Float.Ext;
    };
    include Def;
    include Ext;
  };
};

let module Multiplicative = {
  let module Int = {
    let module Def = Def.Monoid.Multiplicative.Int;
    let module Ext = {
      include Semigroup.Multiplicative.Int.Ext;
    };
    include Def;
    include Ext;
  };
  let module Float = {
    let module Def = Def.Monoid.Multiplicative.Float;
    let module Ext = {
      include Semigroup.Multiplicative.Float.Ext;
    };
    include Def;
    include Ext;
  };
};

let module List (T: TC0) => {
  let module Def = Def.Monoid.List T;
  let module Ext = {
    let module Super = Semigroup.List T;
    include Super.Ext;
  };
  include Def;
  include Ext;
};
